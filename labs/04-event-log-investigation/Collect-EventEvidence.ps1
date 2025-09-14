param([string]$OutputPath = (Join-Path $PSScriptRoot 'evidence.json'))
$ErrorActionPreference = 'Stop'
$end = Get-Date
$start = $end.AddDays(-7)
$filter = @{LogName='System';ProviderName='Microsoft-Windows-Time-Service';Id=134;StartTime=$start;EndTime=$end}
$warnings = @(Get-WinEvent -FilterHashtable $filter)
$selected = $warnings | Sort-Object TimeCreated -Descending | Select-Object -First 1
$nearby = @(Get-WinEvent -FilterHashtable @{LogName='System';ProviderName='Microsoft-Windows-Time-Service';StartTime=$selected.TimeCreated.AddMinutes(-5);EndTime=$selected.TimeCreated.AddMinutes(15)} | Sort-Object TimeCreated)
$timeline = foreach ($event in $nearby) {
    # Do not export rendered messages: they can contain addresses and identifiers.
    [ordered]@{time=$event.TimeCreated.ToString('o');provider=$event.ProviderName;event_id=$event.Id;level=$event.LevelDisplayName}
}
$evidence = [ordered]@{
    lab_id='LAB-004'; captured_at=$end.ToString('o'); method='Get-WinEvent: actual Windows System event log, read-only; Event Viewer GUI not used'
    query_start=$start.ToString('o'); query_end=$end.ToString('o'); matching_134_count=$warnings.Count
    selected_warning_time=$selected.TimeCreated.ToString('o'); correlation_window='5 minutes before through 15 minutes after selected event'
    timeline=@($timeline); configuration_changed=$false
    sanitization='Only selected time/provider/event ID/level retained; no computer names, account IDs, SIDs, addresses, record IDs or raw messages/XML'
}
$evidence | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $OutputPath -Encoding UTF8
$evidence | ConvertTo-Json -Depth 6
