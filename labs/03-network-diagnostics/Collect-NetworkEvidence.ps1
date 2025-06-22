# Read-only checks. Output intentionally omits network and device identifiers.
param([string]$OutputPath = (Join-Path $PSScriptRoot 'evidence.json'))
$ErrorActionPreference = 'Stop'
$adapters = @(Get-NetAdapter)
$active = @($adapters | Where-Object Status -eq 'Up')
$results = foreach ($adapter in $active) {
    $ips = @(Get-NetIPAddress -InterfaceIndex $adapter.ifIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue)
    $gateways = @(Get-NetRoute -InterfaceIndex $adapter.ifIndex -DestinationPrefix '0.0.0.0/0' -ErrorAction SilentlyContinue)
    $dns = @(Get-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ErrorAction SilentlyContinue | ForEach-Object ServerAddresses)
    $profile = Get-NetConnectionProfile -InterfaceIndex $adapter.ifIndex -ErrorAction SilentlyContinue
    $gatewayReply = $null
    if ($gateways.Count -gt 0) {
        $gateway = $gateways | Sort-Object RouteMetric | Select-Object -First 1
        $gatewayReply = [bool](Test-Connection -ComputerName $gateway.NextHop -Count 2 -Quiet -ErrorAction SilentlyContinue)
    }
    [ordered]@{
        adapter_label = 'Active adapter ' + ($active.IndexOf($adapter) + 1)
        media_type = [string]$adapter.MediaType
        status = [string]$adapter.Status
        negotiated_link_speed = [string]$adapter.LinkSpeed
        ipv4_address_count = $ips.Count
        has_apipa_address = [bool](@($ips | Where-Object IPAddress -like '169.254.*').Count)
        ipv4_prefix_origins = @($ips | ForEach-Object { [string]$_.PrefixOrigin } | Select-Object -Unique)
        default_ipv4_route_present = ($gateways.Count -gt 0)
        dns_server_count = $dns.Count
        network_category = [string]$profile.NetworkCategory
        windows_ipv4_connectivity = [string]$profile.IPv4Connectivity
        windows_ipv6_connectivity = [string]$profile.IPv6Connectivity
        gateway_icmp_any_reply_two_probes = $gatewayReply
    }
}
$dnsSuccess = $false
$answerCount = 0
try {
    $answers = @(Resolve-DnsName -Name 'example.com' -Type A -DnsOnly -ErrorAction Stop | Where-Object Type -eq 'A')
    $answerCount = $answers.Count
    $dnsSuccess = $answerCount -gt 0
} catch { }
$tcp = Test-NetConnection -ComputerName 'example.com' -Port 443 -InformationLevel Detailed -WarningAction SilentlyContinue
$httpsStatus = $null
$httpsSuccess = $false
try {
    $response = Invoke-WebRequest -Uri 'https://example.com/' -Method Head -UseBasicParsing -TimeoutSec 30
    $httpsStatus = [int]$response.StatusCode
    $httpsSuccess = $httpsStatus -ge 200 -and $httpsStatus -lt 400
} catch { }
$evidence = [ordered]@{
    lab_id = 'LAB-003'
    captured_at = (Get-Date).ToString('o')
    purpose = 'Read-only network baseline; no outage injected or repair claimed'
    active_adapters = @($results)
    disconnected_adapter_count = @($adapters | Where-Object Status -eq 'Disconnected').Count
    test_target = 'example.com'
    dns_a_lookup_succeeded = $dnsSuccess
    dns_a_answer_count = $answerCount
    tcp_443_succeeded = [bool]$tcp.TcpTestSucceeded
    https_head_succeeded = $httpsSuccess
    https_status_code = $httpsStatus
    sanitization = 'No hostnames, usernames, SSIDs, MAC addresses, IP addresses, gateway addresses, DNS server addresses, adapter descriptions or raw exception messages retained'
    configuration_changed = $false
}
$evidence | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $OutputPath -Encoding UTF8
$evidence | ConvertTo-Json -Depth 6
