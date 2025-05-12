# IT Support Portfolio

A starter portfolio for entry-level help desk and IT support roles.

> **Status:** Documentation drafts and planned practice. These are not claims of professional experience or completed troubleshooting. Lab evidence will be added only after the exercises are performed.

## Contents

- [Support workflow](#support-workflow)
- [Network troubleshooting runbook](#network-troubleshooting-runbook)
- [Windows performance runbook](#windows-performance-runbook)
- [Support ticket template](#support-ticket-template)
- [Illustrative ticket](#illustrative-ticket)
- [Windows lab roadmap](#windows-lab-roadmap)

## Support workflow

1. Ask what the user expected, what happened, the exact error, when it started, and whether anything changed.
2. Establish affected users/devices, business impact, and urgency. Follow the organization’s priority rules.
3. Confirm permission before remote access or changes. Never ask for a password or MFA code.
4. Start with simple checks. Record the initial state, test one hypothesis at a time, and note each result.
5. Verify the original task works with the user. Document the fix and any follow-up.
6. Escalate with symptoms, scope, timing, tests, results, and relevant redacted evidence when outside authorization or expertise.

## Network troubleshooting runbook

**Type:** Draft runbook; not yet validated in a lab.

**Symptom:** A Windows user cannot access a website or network resource.

| Step | Check | What the result helps distinguish |
| --- | --- | --- |
| 1 | Ask whether one site, one device, or several users are affected. Capture the error. | Application-specific issue versus broader outage. |
| 2 | Confirm Wi-Fi is connected to the approved network, airplane mode is off, or Ethernet is connected. | Basic link/connection issues. |
| 3 | Run `ipconfig /all` locally. Inspect the active adapter, IPv4 address, gateway, DHCP, and DNS servers. | Missing configuration or an unexpected adapter. A 169.254.x.x address may indicate DHCP failure. |
| 4 | If policy permits, ping the configured default gateway. | Local gateway reachability. A timeout alone is inconclusive because ICMP can be filtered. |
| 5 | Run `nslookup example.com` using the configured DNS server. | Whether DNS resolves a known public name. Internal names may require approved VPN/internal DNS. |
| 6 | Test another approved site and compare with another device if available. | Single destination/browser issue versus network-wide issue. |
| 7 | Record evidence and escalate suspected DHCP, DNS, VPN, or wider outages. | Gives the next team actionable context. |

**Change control:** Do not switch corporate DNS, disable a firewall, reset networking, restart shared equipment, or change VPN settings without authorization.

**Verification:** Retry the original resource with the user and confirm the required task succeeds. Record the result; do not mark resolved based on a ping alone.

## Windows performance runbook

**Type:** Draft runbook; not yet validated in a lab.

1. Clarify whether the slowdown affects startup, one app, or the entire system. Ask when it began and whether work is saved.
2. Check Task Manager for CPU, memory, and disk use. Record the process and time; high use is a clue, not proof of a root cause.
3. Check available disk space in Settings or File Explorer. Do not delete user files or unfamiliar folders.
4. Review recent changes and relevant Event Viewer entries around the reported time. Redact account and device identifiers before publishing evidence.
5. If authorized, close an unresponsive app after discussing unsaved work, or schedule a restart with the user.
6. Escalate repeated crashes, suspected malware, disk health concerns, or issues requiring administrator changes. Follow the security incident process for suspicious activity.
7. Verify the original workload and document before/after observations. Avoid unsupported claims that a restart permanently fixed the root cause.

## Support ticket template

```text
Ticket ID: [lab ID]
Type: [lab / simulation / authorized support]
Date and environment: [OS version, relevant setup]
Summary: [one sentence]
User-reported symptom and exact error:
Scope and business impact:
Priority and reason: [use applicable policy]
Questions asked / recent changes:
Initial observations:
Troubleshooting:
  1. Action / expected result / actual result
  2. Action / expected result / actual result
Cause: [confirmed, suspected, or unknown; explain evidence]
Resolution or escalation:
Verification: [original task tested, actual result, user confirmation]
Rollback / follow-up:
Lessons learned:
Evidence: [redacted screenshots or outputs]
```

## Illustrative ticket

**SIM-001 — A website does not open**

**Type:** Fictional scenario for learning; no real user or test results.

- **Reported symptom:** One website fails to open on a Windows PC.
- **Questions to ask:** What is the exact error? Do other sites work? Does the problem occur in another approved browser? Are coworkers affected? Is VPN required?
- **Proposed tests:** Confirm connection, compare another approved site, inspect IP/DNS configuration, and test name resolution. Record actual outputs when performing a lab.
- **Decision:** If DNS resolves but only one destination fails, investigate the browser/application or escalate the destination issue. If multiple devices fail, check for a wider incident.
- **Resolution:** Not performed. Cause unknown.
- **Closure criteria:** Original site and task work, the user confirms, and the steps and observations are documented.

## Windows lab roadmap

All exercises below are **planned**, not completed. Use an isolated personal lab and dummy accounts/data.

- [ ] **System baseline:** Record Windows version, CPU, memory, free storage, and relevant settings. Explain what each tells a technician.
- [ ] **Standard user accounts:** Create a dummy standard account, test sign-in, and document standard versus administrator access.
- [ ] **Folder permissions:** Use dummy files to compare allowed and denied access. Record configuration, expected result, actual result, and cleanup.
- [ ] **Connectivity investigation:** Run the network runbook in the lab, capture redacted observations, and explain what each test does and does not prove.
- [ ] **Event Viewer investigation:** Find a harmless application event and explain the timestamp, source, event ID, and relevance without assuming every warning is a fault.
- [ ] **Ticket write-up:** Complete the template for one real lab exercise with evidence and verification.

### Evidence required for a completed lab

State the environment, objective, starting condition, steps, actual observations, verification, cleanup, and lessons learned. Remove passwords, tokens, email addresses, serial numbers, public IPs, and employer/customer data from public screenshots.
