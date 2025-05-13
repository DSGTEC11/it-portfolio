# Read-only system queries. Only explicitly selected fields enter the evidence.
# Run from Windows PowerShell: & .\Collect-Baseline.ps1
$ErrorActionPreference = 'Stop'
$os = Get-CimInstance Win32_OperatingSystem
$cv = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
$cpu = @(Get-CimInstance Win32_Processor | Select-Object Name,NumberOfCores,NumberOfLogicalProcessors)
$ram = (Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum).Sum
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='$($env:SystemDrive)'"
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
$result = [ordered]@{
    Lab = 'LAB-001'
    CollectionTimeChicago = [TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTimeOffset]::UtcNow,'Central Standard Time').ToString('yyyy-MM-dd HH:mm:ss zzz')
    Method = 'PowerShell collection on the actual Windows computer; selected read-only fields'
    ElevatedSession = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    OS = [ordered]@{ Caption=$os.Caption; Version=$os.Version; Build=$os.BuildNumber; Architecture=$os.OSArchitecture; DisplayVersion=$cv.DisplayVersion; RegistryBuild=$cv.CurrentBuild; UpdateBuildRevision=$cv.UBR; LegacyProductName=$cv.ProductName }
    CPU = $cpu
    Memory = [ordered]@{ InstalledGiB=[math]::Round($ram/1GB,2); OSVisibleGiB=[math]::Round($os.TotalVisibleMemorySize/1MB,2); FreeAtCollectionGiB=[math]::Round($os.FreePhysicalMemory/1MB,2) }
    SystemVolume = [ordered]@{ Label='System volume (identifier omitted)'; FileSystem=$disk.FileSystem; SizeGiB=[math]::Round($disk.Size/1GB,2); FreeGiB=[math]::Round($disk.FreeSpace/1GB,2); FreePercent=[math]::Round(100*$disk.FreeSpace/$disk.Size,2) }
}
try { $result.Firewall = @(Get-NetFirewallProfile -PolicyStore ActiveStore | Select-Object Name,@{n='Enabled';e={[string]$_.Enabled}}) } catch { $result.Firewall = 'Unavailable in this session; error details omitted for privacy' }
try { $result.NetworkCategories = @(Get-NetConnectionProfile | Select-Object @{n='Category';e={[string]$_.NetworkCategory}}) } catch { $result.NetworkCategories = 'Unavailable in this session; error details omitted for privacy' }
try { $result.Defender = Get-MpComputerStatus | Select-Object AMServiceEnabled,AntivirusEnabled,RealTimeProtectionEnabled,AntivirusSignatureAge } catch { $result.Defender = 'Unavailable in this session; error details omitted for privacy' }
$result | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $PSScriptRoot 'evidence.json') -Encoding UTF8
Write-Output 'Selected baseline fields saved to evidence.json. Review before publishing.'
