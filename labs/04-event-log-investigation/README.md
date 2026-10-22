# LAB-004: Windows event-log investigation

**Date:** [date withheld for privacy]. **Method:** Actual Windows event logs queried with PowerShell `Get-WinEvent`; the Event Viewer GUI was not used.

**Result:** A time-service DNS warning was followed by valid-time-data and synchronization events. The initial DNS failure's cause remains unknown. Current synchronization could not be confirmed because the time service was stopped. No repair or configuration change was performed.

## Objective and scope

Practice identifying an event by log, provider, event ID, severity and time; read its message locally; correlate nearby events; distinguish a historical warning from current system health. Initial discovery sampled up to 30 recent Warning/Error events from each of Application and System in the preceding seven days. This was not a comprehensive health audit. The focused investigation then queried all matching Time-Service 134 events within the script's recorded seven-day window and found four.

## Actual timeline

The elapsed times below describe the observed sequence in the **System** log from **Microsoft-Windows-Time-Service**. Message descriptions are selected paraphrases of locally inspected events, not full exported messages.

| Elapsed time | ID / severity | Message finding | Interpretation |
| --- | --- | --- | --- |
| 0 seconds | 134 / Warning | NtpClient could not resolve its configured time source, time.windows.com; error 0x80072AF9. | A DNS lookup failed at that time. It does not identify the underlying cause. |
| +0.260 seconds | 158 / Information | VM time provider stopped because its environment was unsupported; message notes this can be expected outside a Hyper-V guest. | Context only; no causal connection to the DNS failure was established. |
| +44.045 seconds | 37 / Information | NtpClient reported valid time data from the time source. | About 44 seconds later, valid data was received. |
| +60.010 seconds | 35 / Information | Time service reported synchronizing with the time source. | About 60 seconds later, synchronization was reported. |

This sequence supports recovery of the historical time-source operation. It does not prove the clock's exact offset, why the warning occurred, or continued synchronization afterward. Network readiness is a possible explanation, not a confirmed cause.

## Current follow-up and limitations

At approximately 17:45 Central:

- `Resolve-DnsName time.windows.com -Type A -DnsOnly` returned one A record. The address was omitted from public evidence. This later success does not explain the earlier failure.
- `w32tm /query /status` returned **The service has not been started (0x80070426)**.
- `Get-Service W32Time` reported **Stopped**, startup type **Manual**. No start/restart or configuration change was attempted.

Current synchronization and actual clock accuracy remain unverified. A stopped service with Manual startup alone does not establish a fault; trigger configuration and system context were not investigated. If time-related symptoms occur, the next authorized investigation should examine service/trigger configuration, time offset, repeat events, and user impact. This lab's closure means the investigation was documented, not that a time problem was repaired.

## Reproduction and evidence

- [Collect-EventEvidence.ps1](Collect-EventEvidence.ps1) selects the newest matching warning in a bounded seven-day window, counts matching warnings, and exports nearby same-provider metadata from five minutes before through fifteen minutes after it.
- [evidence.json](evidence.json) contains event IDs, severities, relative event timing, and the query-window duration. Exact timestamps are withheld for privacy.
- [follow-up.json](follow-up.json) records the separately observed current DNS and service checks; it is a manually transcribed observation, not raw command output.

Run the collector from PowerShell in this folder:

```powershell
& .\Collect-EventEvidence.ps1 -OutputPath .\new-evidence.json
```

The collector intentionally stops if no matching event is available. It does not invent a sample, export rendered messages or XML, clear logs, alter services, or repeat the separate DNS/status checks. Re-running later can select a different warning. Read-only messages were inspected locally for this report; their selected meaning was paraphrased in the table.

Screenshots retained privately because they contain timestamps.

The screenshot is a direct crop of Jira. Public evidence excludes computer names, user/account IDs, SIDs, IP addresses, event record IDs and raw XML/messages. The professional portfolio name remains visible in Jira. No rollback was needed because no system settings were changed.

## Interview explanation

“I investigated a real Windows Time-Service warning by checking the provider, event ID, timestamp and message, then looking at nearby events from the same provider. The log showed valid time data and synchronization within about a minute, so I did not treat the warning alone as proof of an ongoing outage. A later status query found the service stopped, which I documented as a limit on current verification. I preserved sanitized evidence and separated observed facts from possible causes.”

## Jira result

IT-5 was assigned to the lab owner with Low priority, closed as **Resolved / Lab completed**, and checked after reload. The ticket contains the historical sequence, current verification limitation, and an internal closure note. No customer repair is claimed.

## Reference

[Microsoft's time-service troubleshooting article](https://learn.microsoft.com/en-us/troubleshoot/windows-server/active-directory/error-message-run-w32tm-resync-no-time-data-available) includes Event 134 as a time-peer DNS-resolution failure. It is Windows Server guidance used to corroborate the message meaning, not evidence that this personal Windows computer needs the article's domain or configuration remedies. No suggested repairs from that article were applied.
