# CI/CD Scripts

Used by `.github/workflows/sre-team-ci-cd.yml`.

| Script | Stage | Purpose |
|--------|-------|---------|
| `smoke.sh` | CI integration | Prometheus health, rules API |

Local run:

```bash
cd sre-end-term/docker-compose
docker compose -f docker-compose.full.yml up -d prometheus alertmanager
bash ../ci/smoke.sh
```
