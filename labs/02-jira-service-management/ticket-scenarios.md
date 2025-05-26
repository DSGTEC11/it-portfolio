# Jira Service Management practice scenarios

These are fictional training cases. No real customer, account lockout, VPN outage, or access change is represented. Creating and managing the Jira records is the hands-on lab; troubleshooting actions below are proposed or simulated, not executed on live systems.

## SIM-001 — Account locked after repeated sign-in attempts

**Request type:** Account/sign-in assistance.

**Fictional report:** Lab User A cannot sign in after several attempts. The displayed message says the account is locked. One user is affected; no wider outage is reported.

**Impact and urgency:** The user cannot start ordinary work. Medium priority under this lab's illustrative rules: one blocked user, no demonstrated critical-service outage. Real organizations may use different priority matrices.

**Triage questions:** When did this begin? Which application? Exact error? Recent password change? Other devices using saved credentials? Never request the user's password or MFA code.

**Proposed investigation:** Verify identity using the organization's approved process. Check lockout state and relevant authentication events if authorized. Investigate stale saved credentials or repeated attempts; do not assume user error. Escalate suspicious activity through the security process.

**Simulated resolution:** For this fictional scenario, assume a stale saved credential is identified. An authorized administrator unlocks the account, and the user updates their saved credential. These actions were not performed in this lab.

**Verification criteria:** User completes the original sign-in task and no recurrence is observed during an agreed check. No live verification is claimed.

**Jira exercise:** Assign the record to the lab owner, move it into progress, add an internal triage note, and close it only as a completed simulation with the limitation explicit.

## SIM-002 — VPN connects but an internal resource is unavailable

**Request type:** VPN/network assistance.

**Fictional report:** Lab User B can browse public websites and the VPN client reports connected, but a fictional internal resource cannot be opened. One user is affected. No actual internal address is used.

**Impact and urgency:** One task blocked; public internet remains available. Medium priority for this illustrative exercise, pending clarification of business impact and workaround.

**Triage questions:** Exact error and start time? One or all internal resources? Recent changes? Same issue for other users? Approved VPN profile? Does reconnecting change the result?

**Proposed investigation:** Check adapter state, approved DNS configuration, name resolution, and routes using sanitized outputs. A connected VPN badge does not establish end-to-end resource access. Do not disable security controls or substitute public DNS for internal DNS.

**Escalation:** If evidence points to VPN-delivered DNS or routing, escalate with time, scope, error, and selected outputs to the network team. No root cause or repair is established in this case.

**Verification criteria:** Reopen the original resource and complete the intended task after an authorized fix. Pending; no live test performed.

**Jira exercise:** Add an internal investigation note and leave the ticket open/in progress with a clearly documented next action. Do not mark an unverified issue resolved.

## SIM-003 — Request access to a departmental folder

**Request type:** Access request.

**Fictional report:** Lab User C requests read access to the fictional Training Reports folder. There is no existing entitlement or approval evidence in the scenario.

**Impact and urgency:** Planned work rather than an outage. Low priority under illustrative lab rules.

**Triage questions:** Which resource? Read or edit access? Business purpose? Duration? Who owns the data? Is there an approved access group?

**Proposed handling:** Verify identity and collect approval from the designated data owner. Grant only the required access through an approved group, if authorized. Do not assume a manager's name is evidence of approval; do not grant administrative permissions for a folder request.

**Current simulated state:** Waiting for approval. No approval was requested from a real person, and no permissions were changed.

**Verification criteria:** After actual authorization, verify the required read operation and confirm write operations remain restricted where appropriate. Not performed in this scenario.

**Jira exercise:** Record the approval dependency in an internal note and keep the request open. If a waiting status is available, use it; otherwise record the dependency explicitly without claiming approval.
