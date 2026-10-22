# LAB-001: Windows system baseline

**Status:** Completed read-only collection on [date withheld for privacy]. Real results from the portfolio owner's Windows computer. This is a learning exercise, not professional support experience.

## Objective and starting condition

Record the OS, CPU, memory, system-drive capacity, and selected security settings before making changes. No fault or slowdown was reported. The existing computer was running normally enough to execute the queries; no controlled performance workload was used. The session was not elevated. This was the actual computer, not an isolated VM.

## Evidence and reproduction

- [Selected actual output](evidence.json): machine-collected values, not sample data.
- [Read-only collection script](Collect-Baseline.ps1): exact queries and field selection.
- [Lab ticket](ticket.md).

Open PowerShell in this lab folder, inspect the script, then run:

```powershell
& .\Collect-Baseline.ps1
Get-Content .\evidence.json
```

The script writes only `evidence.json` in its own folder and overwrites that file on a repeat run. Preserve the original evidence first if you want a separate comparison. If execution policy blocks it, record the limitation and run the reviewed read-only queries individually; do not weaken policy for this exercise. Results such as free memory, disk space, and signature age change over time.

## Steps, expected results, and actual observations

| Step / query | Expected evidence | Actual result | Help desk interpretation |
| --- | --- | --- | --- |
| `Get-CimInstance Win32_OperatingSystem`; selected CurrentVersion registry fields | Edition, architecture, version, build | Windows 11 Home, 64-bit; version 10.0.26300; display version 26H2; build 26300.9711 | Helps choose compatible instructions. These are locally reported values; release channel, support status, and patch currency were not established. |
| Cross-check OS caption and registry build | Consistent build across sources | Both report build 26300. Legacy ProductName reports Windows 10 Home | Do not silently replace conflicting evidence. Record the Windows 11 caption and the conflicting legacy label. The cause of the label discrepancy was not independently established. |
| `Get-CimInstance Win32_Processor` | CPU model, physical cores, logical processors | Intel Core i7-14700F; 20 cores; 28 logical processors | Hardware inventory helps scope workload expectations; it is not a CPU performance test. |
| Sum `Win32_PhysicalMemory.Capacity`; compare OS memory | Installed, OS-visible, and currently free memory | 32.00 GiB installed; 31.84 GiB visible; 20.85 GiB free at collection | Installed capacity differs from current availability. The small installed/visible difference alone does not establish a fault. |
| `Win32_LogicalDisk`, filtered to the system volume | File system, size, free space | NTFS; 1,861.37 GiB total; 1,364.20 GiB free (73.29%) | The system volume was not close to full at collection. This does not prove disk health or speed. |
| `Get-NetFirewallProfile -PolicyStore ActiveStore` | Enabled state for each profile | Domain, Private, Public: True | These are profile settings, not proof that all three profiles are active or that traffic is blocked as intended. |
| `Get-NetConnectionProfile`, category only | Current network category | One returned profile: Public | Relates the current connection to the Public firewall profile without exposing network identifiers. No connectivity test was performed. |
| Selected `Get-MpComputerStatus` fields | Defender service, antivirus, real-time status, signature age | All three status flags True; signature age 0 days | Protection reports enabled; no malware scan or security certification was performed. |

Units: GiB means bytes divided by 1,073,741,824. This avoids confusing binary units with advertised decimal drive capacity.

## Verification, limits, and cleanup

The collector completed successfully and produced parseable JSON. OS and registry build agree; installed memory was compared with OS-visible memory. Disk free space and percentage were checked for consistent arithmetic. The published report uses the saved snapshot, not later changing readings.

No accounts, permissions, services, firewall rules, or security settings were changed. No restart, update installation, scan, repair, or deletion was performed. Cleanup requires no system rollback; the script and selected evidence are intentionally retained. Windows Update, encryption, Secure Boot, device health, event logs, and release-channel status were not assessed. No issue was diagnosed or resolved.

## Privacy review

Evidence is sanitized by selecting fields before saving. It excludes hostnames, usernames, email addresses, IP/MAC addresses, SSIDs, serial numbers, product IDs/keys, file listings, process command lines, and employer/customer data. The published CPU model, OS build, capacity figures, and security flags are the technical evidence for this lab. No raw transcript or desktop screenshot is included. A field allowlist reduces exposure but the JSON must still be reviewed before each future publication.

## Explain it in an interview

“I collected a read-only baseline of my Windows computer and reviewed the results. I recorded the OS build, CPU, installed and available memory, system-drive space, and selected protection settings. I cross-checked the OS because a legacy field said Windows 10 while the OS caption said Windows 11. I published only selected technical fields. The lab established a reference point; it did not diagnose a performance issue or prove the device was secure.”

- **Why baseline first?** It captures the starting state so later observations can be compared against it.
- **Why not call this a fix?** There was no reported fault, corrective change, or before/after functional test.
- **Why is free RAM different from installed RAM?** Installed RAM is capacity; free RAM is a changing snapshot of unused memory. OS-visible capacity is a separate measure.
- **What would come next for a slowdown?** Ask about scope and timing, reproduce the workload, and observe CPU/memory/disk activity before choosing a hypothesis.

Optional learning follow-through, **not recorded as performed**: open Settings > System > About and Task Manager > Performance to locate the same facts yourself. Avoid sharing those windows without checking for identifiers. Practice explaining the table in your own words before claiming independent familiarity.

## Reference

Microsoft documents [Get-NetFirewallProfile](https://learn.microsoft.com/en-us/powershell/module/netsecurity/get-netfirewallprofile) as a query of configured firewall profile options; this is why enabled profiles are distinguished from the connection category above.
