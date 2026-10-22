# IT-2: Internal triage and escalation note

Saved to Jira on [date withheld for privacy]. This is a proposed plan for a fictional case, not diagnostic output.

SIMULATION — proposed triage and escalation plan; no live diagnostic results.

Questions: What exact resource and error? When did it last work and when did failure start? One resource or all internal resources? One user or coworkers too? Any recent password, VPN-client, or network changes? Is the approved VPN profile selected? What business task is blocked and is there a workaround? Never request passwords or MFA codes.

Before changes: confirm the reported scope and approved VPN connection; inspect adapter state, assigned DNS servers and routes; test the approved internal hostname with the configured resolver; compare another approved internal resource. Record timestamps and exact outputs. VPN connected does not prove DNS, routing, authorization, or application availability. Do not disable the firewall or switch to public DNS.

Escalation package: affected user/device count, business impact, start time/time zone, exact error, VPN client/profile version, tests attempted and actual results, relevant redacted DNS/route observations, recent changes and available workaround. Root cause remains unknown; the tests above have NOT been run. Keep Medium priority provisional until business impact is clarified.

Next owner action: gather evidence, then route to the authorized network team if indicated; current Jira owner remains the lab owner. Verify the original resource and task after an authorized fix before closure. No real team was contacted.
