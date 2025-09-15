# Network troubleshooting runbook

**Type:** Draft troubleshooting runbook. Basic configuration, gateway, DNS and HTTPS checks exercised in [LAB-003](../labs/03-network-diagnostics/README.md); failure branches and remediation remain unvalidated.

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
