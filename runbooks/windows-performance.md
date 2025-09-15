# Windows performance runbook

**Type:** Draft runbook; not yet validated in a lab.

1. Clarify whether the slowdown affects startup, one app, or the entire system. Ask when it began and whether work is saved.
2. Check Task Manager for CPU, memory, and disk use. Record the process and time; high use is a clue, not proof of a root cause.
3. Check available disk space in Settings or File Explorer. Do not delete user files or unfamiliar folders.
4. Review recent changes and relevant Event Viewer entries around the reported time. Redact account and device identifiers before publishing evidence.
5. If authorized, close an unresponsive app after discussing unsaved work, or schedule a restart with the user.
6. Escalate repeated crashes, suspected malware, disk health concerns, or issues requiring administrator changes. Follow the security incident process for suspicious activity.
7. Verify the original workload and document before/after observations. Avoid unsupported claims that a restart permanently fixed the root cause.
