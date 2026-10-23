# LAB-002: Jira Service Management ticket workflow

- **Investigated:** How to manage three fictional support requests and why a Jira ticket would not stay resolved.
- **Did:** Assigned priorities and ownership, recorded internal notes, tested ticket transitions, and added a training resolution after finding an empty resolution list.
- **Found:** IT-1 remained Resolved after reload; IT-2 remained Escalated and IT-3 Pending. The Jira closure issue was addressed; the fictional technical incidents were not repaired.

**Date:** [date withheld for privacy]

**Environment:** Jira Service Management Cloud, Service Collection Free signup, IT Service Project (IT).

**Result:** Three fictional support cases created, assigned, prioritized, documented with internal notes, and moved through actual Jira workflows. The closure demonstration is complete: an empty resolution list was identified, a training-specific resolution was added, and IT-1 was verified Resolved after reload.

This is a hands-on ticket-management exercise. Account troubleshooting, VPN diagnostics, and access provisioning in the scenarios are hypothetical; no live account, network, or folder permissions were changed. No professional support experience or successful real incident resolution is claimed.

## Objective and starting condition

Practice recording symptoms, assessing impact, assigning ownership, distinguishing internal notes from customer replies, and selecting an appropriate ticket state. Start with the newly provisioned IT support service space and three fictional cases. The Free signup was selected; no payment details, paid upgrade, or paid add-on was used in this exercise.

## Actual work and results

1. Created three requests through Jira using the existing **Get IT help** request type and **[System] Service request** work type. Each summary begins with **[SIMULATION]**, and each description identifies the scenario as fictional.
2. Included symptoms, impact/urgency, triage questions, proposed investigation, and verification criteria. The scenario categories are descriptive text; custom request types were not configured.
3. Assigned each record to the lab owner with **Assign to me**. The lab owner is also the reporter; fictional users are only characters in the descriptions.
4. Kept IT-1 and IT-2 at Medium priority and changed IT-3 to Low. These choices use illustrative lab assumptions, not a universal priority matrix.
5. Added internal notes and submitted the transition forms. No customer replies, real team handoffs, or approval requests were sent.
6. Reopened the All open queue and verified all three saved statuses and assignments. The first reload confirmed the initial closure had not persisted. After correcting the resolution configuration, another reload confirmed Resolved with resolution Simulation completed; the All open queue then contained only IT-2 and IT-3.

| Jira key | Scenario | Priority | Verified final state | Meaning |
| --- | --- | --- | --- | --- |
| IT-1 | Account locked after repeated sign-in attempts | Medium | Resolved | Resolution: Simulation completed. Closure verified after reload. |
| IT-2 | VPN connects but an internal resource is unavailable | Medium | Escalated | Open simulation with proposed next steps; cause unknown and no real network team contacted. |
| IT-3 | Request access to a departmental folder | Low | Pending | Pending reason: Awaiting approval. No authorization or permission change occurred. |

IT-1 is resolved as a completed training exercise; IT-2 and IT-3 remain unresolved. Moving IT-2 to Escalated did not transfer ownership to another person. Setting IT-3 to Pending did not implement an approval automation.

## Observed closure issue

For IT-1, the successful transition was **Waiting for support → In Progress**. Next, **Resolve this issue** opened a form whose Resolution selector displayed **No matches found**, including when searching for **Done**. An attempted update did not save a resolved state. Reloading the ticket showed **In Progress**. A separate internal note records that result.

Follow-up investigation: Jira admin settings → Work items → Resolutions showed an empty table. Added one global resolution, **Simulation completed**, with the description: “Training workflow completed. Does not indicate a real customer incident was repaired or live system access was verified.” It then appeared in the ticket transition selector. Selected it and submitted an internal closure note. Reloading IT-1 verified **Resolved / Simulation completed**, and the ticket disappeared from All open. No workflow definitions or default-resolution setting were changed. Why the new site initially had no resolutions was not established.

This is a site-wide resolution value, not a custom field limited to one ticket. It was intentionally named for training use. An optimistic status display while a transition dialog is open is not evidence that the change saved.

## Evidence

Original Jira screenshots, including the initial and verified closure states, are retained privately because they contain timestamps. Public evidence is linked below.

- [Selected observed results](evidence.json): manually recorded from the visible Jira interface; not a Jira API export.
- [Fictional ticket descriptions and proposed troubleshooting](ticket-scenarios.md).
- [Detailed VPN triage and escalation note saved to IT-2](vpn-triage-note.md).

Public JSON omits account IDs, email addresses, site addresses, organization identifiers, and exact timestamps. The ticket scenarios contain no real customer data.

## Interview explanation

“I used a free Jira Service Management space to practice handling three fictional support requests. I documented impact, triage questions, ownership, internal notes, and next steps. I left the VPN case unresolved because a connected VPN indicator does not prove access to the requested resource. For the access request, I recorded the approval dependency and used least-privilege reasoning without granting access. I also caught a Jira resolution attempt that did not persist, found an empty resolution list, added a training-specific resolution, and verified the ticket stayed resolved after reloading.”

Useful points to explain:

- **Priority:** Determine scope, business impact, urgency, and available workarounds; apply the employer's matrix.
- **Ownership:** Assignment identifies who is responsible for follow-up, even while a request is waiting or escalated.
- **Internal notes:** Record investigation and handoff context. Customer replies are a separate communication channel.
- **Escalation:** Include symptoms, scope, time, exact error, tests and their results, and what is still unknown. Proposed tests are not actual results.
- **Access requests:** Verify identity, business need, data-owner approval, duration, and the minimum required access before provisioning.
- **Verification:** Reopen the original task after an authorized fix and confirm the actual result. For this lab, verification covered saved Jira fields, not successful account, VPN, or folder access.

## Retention and follow-up

The three practice records remain in Jira for review. No account, VPN, or permission changes need rollback. No SLA targets, automation rules, custom forms, approval workflow, or knowledge-base integration were configured or validated. The closure demonstration is now verified. The added global resolution remains available for future training tickets; do not treat it as evidence of real technical remediation.
