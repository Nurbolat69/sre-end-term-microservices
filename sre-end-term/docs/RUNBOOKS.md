# SRE Runbooks Index

| ID | Runbook | When to use |
|----|---------|-------------|
| RB-001 | [incident-response.md](incident-response.md) | Order service / DB failure |
| RB-002 | [capacity-planning.md](capacity-planning.md) | High CPU/memory, load test follow-up |
| RB-003 | [SLI-SLO.md](SLI-SLO.md) | SLO breach investigation |
| RB-004 | [ERROR_BUDGET.md](ERROR_BUDGET.md) | Release freeze decisions |

## Quick commands

```powershell
.\scripts\verify-health.ps1      # RB-000 health
.\scripts\verify-slo.ps1         # RB-003 SLO check
.\scripts\simulate-incident.ps1  # RB-001 drill
.\scripts\recover-incident.ps1   # RB-001 recovery
.\scripts\load-test.ps1          # RB-002 load
.\scripts\destroy.ps1            # teardown lab
```

## Escalation

| Severity | Condition | Contact |
|----------|-----------|---------|
| SEV-1 | Full shop down | All engineers |
| SEV-2 | Orders/payment path down | Team lead |
| SEV-3 | Elevated errors < SLO | On-call rotation |
