# LAB-001 — Record a Windows system baseline

- **Type:** Real learning lab; not a production incident.
- **Date/environment:** May 13, 2025, 11:35 CDT; Windows 11 Home, 64-bit, locally reported build 26300.9711; non-elevated session.
- **Request:** Establish and document a read-only starting state for future Windows support practice.
- **Reported symptom/error:** None. No performance fault reported.
- **Scope/impact:** One personal computer. No business outage established.
- **Priority:** Routine learning task; no organizational priority policy applies.
- **Recent changes:** Not investigated; not needed to document this snapshot.
- **Actions and results:** Queried OS and cross-checked the build; recorded i7-14700F / 20 cores / 28 logical processors, 32 GiB installed RAM, and 1,364.20 GiB free system-volume space (73.29%). Selected firewall profiles reported enabled; current connection category Public; Defender service, antivirus, and real-time protection reported enabled.
- **Notable observation:** Legacy ProductName says Windows 10 Home while OS caption says Windows 11 Home. Preserved both; did not infer a fault or release channel.
- **Cause:** Not applicable; no incident diagnosed.
- **Outcome:** Baseline collected and documented. No repair or configuration change made.
- **Verification:** Collector succeeded; saved JSON reviewed; OS/registry build agreement and disk arithmetic checked. No end-user resolution confirmation claimed.
- **Rollback/cleanup:** None required for system settings. Lab files retained.
- **Follow-up:** Independently practice locating and explaining these readings; perform account and permissions exercises separately with dummy data in an isolated lab.
- **Lesson:** Separate observations from conclusions and omit identifiers before saving public evidence.
- **Evidence:** [Actual selected output](evidence.json), [method and interpretation](README.md), [collector](Collect-Baseline.ps1).
