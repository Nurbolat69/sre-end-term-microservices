# SRE End Term — Team Report (Visual Edition)

**Git:** https://github.com/Nurbolat69/sre-end-term-microservices  
**Team:** SRE Team Alpha | **Lead:** Nurbolat69  
**Submit:** Export this file to **REPORT.pdf**

---

> **How to use:** Replace every `[SCREENSHOT-XX]` with a real image.  
> **How to capture:** See **Part 2 (Russian)** at the bottom of this file.

---

## 1. Title

**End-to-End SRE in Microservices with Team CI/CD**

Sock Shop · Docker · Kubernetes · Terraform · Ansible · Prometheus · Grafana · GitHub Actions

**[SCREENSHOT-01: Title page — VS Code with project open + browser tab GitHub repo]**

---

## 2. Team

| Role | Name |
|------|------|
| Team Lead / CI/CD | Nurbolat69 |
| DevOps (Terraform, Ansible) | _[Name]_ |
| Platform (Compose, K8s) | _[Name]_ |
| Observability (SLI/SLO) | _[Name]_ |
| Reliability (Incident) | _[Name]_ |

**[SCREENSHOT-02: `docs/TEAM.md` open in VS Code]**

---

## 3. Repository

GitHub: https://github.com/Nurbolat69/sre-end-term-microservices

**[SCREENSHOT-03: GitHub repo main page — files + README visible]**

**[SCREENSHOT-04: GitHub → Actions → workflow “SRE Team CI/CD” — all green checks]**

---

## 4. Project structure

Code layout: `sre-end-term/` — compose, terraform, ansible, monitoring, scripts, docs.

**[SCREENSHOT-05: VS Code Explorer — folder `sre-end-term` expanded (all subfolders)]**

**[SCREENSHOT-06: File `STRUCTURE.md` open in VS Code]**

---

## 5. Architecture

User → API Gateway → microservices → databases → Prometheus → Grafana → CI/CD.

**[SCREENSHOT-07: `docs/architecture.md` — Mermaid diagram visible (Preview or exported image)]**

**[SCREENSHOT-08: Optional — draw.io / PowerPoint architecture (same as diagram)]**

---

## 6. Microservices (Assignment 1)

Six+ services: Auth, Product, Order, Payment, Notification, Profile.

**[SCREENSHOT-09: `docker-compose/docker-compose.full.yml` — lines 1–90 (services list)]**

**[SCREENSHOT-10: Same file — labels `sre.service` on orders, user, catalogue]**

**[SCREENSHOT-11: `docker ps` or `docker compose ps` — many `sre-end-term-*` containers UP]**

---

## 7. Deploy (how to run)

One command starts the full stack.

**[SCREENSHOT-12: VS Code terminal — command `.\scripts\deploy-compose.ps1` + output “Deployment complete”]**

**[SCREENSHOT-13: Terminal — URLs printed (Shop, Prometheus, Grafana ports)]**

**[SCREENSHOT-14: Browser — Sock Shop homepage http://localhost or :8888]**

**[SCREENSHOT-15: Browser — cart / catalogue page (shop works)]**

---

## 8. PostgreSQL & Redis (PDF supporting components)

**[SCREENSHOT-16: `docker-compose.full.yml` — section `postgres-sre` and `redis`]**

**[SCREENSHOT-17: Terminal — `docker ps` showing postgres-sre and redis containers]**

---

## 9. SLI / SLO (Assignment 2)

Targets: Availability ≥99%, Latency ≤200ms, Errors ≤1%.

**[SCREENSHOT-18: `docs/SLI-SLO.md` in VS Code]**

**[SCREENSHOT-19: `monitoring/recording.rules` — full file]**

**[SCREENSHOT-20: `monitoring/alert.rules` — alerts `SLO_*` visible]**

---

## 10. Prometheus (Assignment 3)

**[SCREENSHOT-21: Browser http://localhost:9090 — Status → Targets — all UP (green)]**

**[SCREENSHOT-22: Prometheus → Status → Configuration — loaded]**

**[SCREENSHOT-23: Prometheus → Status → Rules — group `sre_sli_recording`]**

**[SCREENSHOT-24: Prometheus → Graph — query `up` — graph visible]**

**[SCREENSHOT-25: Prometheus → Graph — query `sre:request_rate:5m` (after load test)]**

---

## 11. Grafana (Assignment 3)

Login: admin / foobar

**[SCREENSHOT-26: Browser http://localhost:3000 — login page]**

**[SCREENSHOT-27: Grafana — folder SRE — dashboard list]**

**[SCREENSHOT-28: Dashboard “SRE End Term — SLI Overview” — full screen all panels]**

**[SCREENSHOT-29: Same dashboard — zoom “Request success rate” panel]**

**[SCREENSHOT-30: Same dashboard — zoom “Error rate” panel]**

**[SCREENSHOT-31: Dashboard “SRE End Term — Capacity & Resources” — full screen]**

**[SCREENSHOT-32: Grafana → Connections → Data sources — Prometheus OK]**

---

## 12. Alertmanager

**[SCREENSHOT-33: Browser http://localhost:9093 — Alertmanager UI]**

**[SCREENSHOT-34: `docker-compose/alertmanager.yml` in VS Code]**

---

## 13. Incident — BEFORE (Assignment 4)

Order Service — wrong MongoDB host.

**[SCREENSHOT-35: Terminal — `.\scripts\simulate-incident.ps1` output]**

**[SCREENSHOT-36: `docker-compose.incident.yml` — `MONGO_HOST=orders-db-broken`]**

**[SCREENSHOT-37: Terminal — `docker logs sre-end-term-orders-1` — Mongo connection errors]**

**[SCREENSHOT-38: Prometheus → Alerts — RED/firing alerts]**

**[SCREENSHOT-39: Grafana SLI dashboard — error rate spike]**

**[SCREENSHOT-40: Browser — checkout/order fails (optional error page)]**

---

## 14. Incident — RECOVERY

**[SCREENSHOT-41: Terminal — `.\scripts\recover-incident.ps1` output]**

**[SCREENSHOT-42: Prometheus → Alerts — empty / green (resolved)]**

**[SCREENSHOT-43: Grafana — error rate back to normal]**

**[SCREENSHOT-44: Shop — order/checkout works again]**

---

## 15. Postmortem

**[SCREENSHOT-45: `docs/postmortem.md` open in VS Code (timeline section)]**

**[SCREENSHOT-46: `docs/incident-report.md` — summary table]**

---

## 16. Terraform (Assignment 5)

**[SCREENSHOT-47: VS Code — `terraform/main.tf` visible]**

**[SCREENSHOT-48: VS Code — `terraform/aws/main.tf` (EC2 resources)]**

**[SCREENSHOT-49: Terminal — `cd terraform` → `terraform validate` success]**

---

## 17. Ansible (Assignment 6)

**[SCREENSHOT-50: VS Code — `ansible/playbooks/site.yml`]**

**[SCREENSHOT-51: VS Code — `ansible/roles/` tree expanded]**

**[SCREENSHOT-52: Terminal — `ansible-playbook --syntax-check ...` success (optional)]**

---

## 18. Docker Swarm

**[SCREENSHOT-53: `docker-swarm/docker-stack.yml` — `deploy.replicas` on orders]**

**[SCREENSHOT-54: Terminal — `docker stack services sre-sock-shop` (if deployed)]**

---

## 19. Kubernetes

**[SCREENSHOT-55: VS Code — `kubernetes/01-hpa-orders-payment.yaml`]**

**[SCREENSHOT-56: VS Code — `kubernetes/03-pdb-orders.yaml`]**

**[SCREENSHOT-57: Terminal — `kubectl get pods -n sock-shop` (if cluster available)]**

**[SCREENSHOT-58: Terminal — `kubectl get hpa -n sock-shop`]**

---

## 20. CI/CD — Team pipeline

**[SCREENSHOT-59: `.github/workflows/sre-team-ci-cd.yml` in VS Code (jobs list)]**

**[SCREENSHOT-60: GitHub Actions — workflow run — all jobs green (full page)]**

**[SCREENSHOT-61: GitHub Actions — job “CI - Integration smoke” — log tail success]**

**[SCREENSHOT-62: GitHub Actions — CD artifact `sre-end-term-bundle` uploaded]**

---

## 21. CI scripts & local validate

**[SCREENSHOT-63: VS Code — `ci/smoke.sh` + `ci/validate.sh`]**

**[SCREENSHOT-64: Terminal — `bash ci/validate.sh` — “All local CI checks passed” (Git Bash/WSL)]**

---

## 22. Monitoring code

**[SCREENSHOT-65: `monitoring/prometheus.yml` — scrape_configs jobs]**

**[SCREENSHOT-66: `monitoring/grafana/dashboards/sre-overview.json` — panels section]**

**[SCREENSHOT-67: `monitoring/grafana/provisioning/` folder in Explorer]**

---

## 23. Scripts automation

**[SCREENSHOT-68: VS Code — `scripts/_lib/SrePorts.ps1`]**

**[SCREENSHOT-69: VS Code — `scripts/deploy-all.ps1`]**

**[SCREENSHOT-70: Terminal — `.\scripts\verify-health.ps1` — all OK green]**

**[SCREENSHOT-71: Terminal — `.\scripts\verify-slo.ps1` — PASS]**

---

## 24. Load test & capacity

**[SCREENSHOT-72: Terminal — `.\scripts\load-test.ps1` running]**

**[SCREENSHOT-73: Grafana Capacity dashboard during/after load test]**

**[SCREENSHOT-74: `docs/capacity-planning.md` in VS Code]**

---

## 25. Evidence folder (optional)

**[SCREENSHOT-75: VS Code — `evidence/` folder with exported logs after `demo-incident-full.ps1`]**

---

## 26. Results

Multi-orchestration, IaC, SLI/SLO monitoring, incident handling, **CI/CD on every push** — complete.

**[SCREENSHOT-76: Collage OR single slide — GitHub green + Grafana + Shop (3-in-1 summary)]**

---

## 27. Conclusion

SRE lifecycle implemented as a team with automated quality gates.

**Git:** https://github.com/Nurbolat69/sre-end-term-microservices

---

# PART 2 — ИНСТРУКЦИЯ: КАК СДЕЛАТЬ КАЖДЫЙ СКРИНШОТ (РУССКИЙ)

**Сколько всего:** 76 скриншотов (можно объединять 2–3 в один коллаж — минимум **40–50** уникальных кадров для отчёта).

**Инструмент:** `Win + Shift + S` → выделить область → вставить в Word под меткой `[SCREENSHOT-XX]`.

**Перед началом:**

```powershell
cd C:\Users\nurbo\Downloads\microservices-demo-master\microservices-demo-master\sre-end-term
.\scripts\deploy-compose.ps1
```

Если порты заняты — смотри вывод скрипта (часто **8888**, **9091**, **3001**).

---

### SCREENSHOT-01 — Титул
| | |
|---|---|
| **Где** | VS Code + браузер |
| **Действия** | 1) Открой папку `microservices-demo-master` в VS Code. 2) В браузере открой GitHub repo. 3) Скрин: слева дерево `sre-end-term`, справа GitHub. |
| **Папка** | `...\microservices-demo-master` |

---

### SCREENSHOT-02 — Команда
| | |
|---|---|
| **Файл** | `sre-end-term\docs\TEAM.md` |
| **Действия** | Открой файл → вставь имена команды → скрин всего редактора |

---

### SCREENSHOT-03 — GitHub репозиторий
| | |
|---|---|
| **URL** | https://github.com/Nurbolat69/sre-end-term-microservices |
| **Действия** | Главная страница repo: видны папки `sre-end-term`, `.github`, README |

---

### SCREENSHOT-04 — CI/CD зелёный
| | |
|---|---|
| **URL** | https://github.com/Nurbolat69/sre-end-term-microservices/actions |
| **Действия** | 1) Вкладка **Actions**. 2) Workflow **SRE Team CI/CD**. 3) Последний run со **зелёными галочками**. 4) Скрин всей страницы run. |
| **Если красный** | Подожди 5 мин или открой failed job → скрин ошибки + исправь позже |

---

### SCREENSHOT-05 — Структура проекта
| | |
|---|---|
| **Где** | VS Code → Explorer (Ctrl+Shift+E) |
| **Действия** | Разверни `sre-end-term`: `ci`, `docker-compose`, `terraform`, `ansible`, `monitoring`, `scripts`, `docs`, `kubernetes` |

---

### SCREENSHOT-06 — STRUCTURE.md
| | |
|---|---|
| **Файл** | `sre-end-term\STRUCTURE.md` |
| **Действия** | Открой → скрин дерева каталогов в документе |

---

### SCREENSHOT-07 — Архитектура (Mermaid)
| | |
|---|---|
| **Файл** | `sre-end-term\docs\architecture.md` |
| **Действия** | 1) Открой файл. 2) `Ctrl+Shift+V` — Markdown Preview. 3) Скрин схемы. **Или** экспорт диаграммы как PNG |

---

### SCREENSHOT-08 — Архитектура (опционально)
Нарисуй в PowerPoint блок-схему как в `architecture.md` — 1 слайд.

---

### SCREENSHOT-09–10 — Docker Compose код
| | |
|---|---|
| **Файл** | `sre-end-term\docker-compose\docker-compose.full.yml` |
| **09** | Скрин строк 1–90: `edge-router`, `catalogue`, `orders`, `payment`, `user` |
| **10** | Прокрути к `orders` — видно `sre.service: order-service` и `MONGO_HOST` |

---

### SCREENSHOT-11 — Контейнеры
```powershell
docker ps --filter "name=sre-end-term" --format "table {{.Names}}\t{{.Status}}"
```
Скрин терминала VS Code — много контейнеров **Up**.

---

### SCREENSHOT-12–13 — Деплой
```powershell
cd sre-end-term
.\scripts\deploy-compose.ps1
```
| **12** | Скрин команды + процесс pull/up |
| **13** | Скрин строк `Deployment complete` с URL |

---

### SCREENSHOT-14–15 — Магазин в браузере
| | |
|---|---|
| **URL** | http://localhost **или** http://localhost:8888 |
| **14** | Главная — носки, логотип Sock Shop |
| **15** | Открой каталог / корзину — товары видны |

---

### SCREENSHOT-16–17 — PostgreSQL и Redis
| **16** | VS Code: `docker-compose.full.yml` → блоки `postgres-sre`, `redis` |
| **17** | `docker ps` — контейнеры `postgres-sre`, `redis` |

---

### SCREENSHOT-18–20 — SLI/SLO файлы
| Скрин | Файл |
|-------|------|
| 18 | `docs\SLI-SLO.md` |
| 19 | `monitoring\recording.rules` |
| 20 | `monitoring\alert.rules` (алерты `SLO_`) |

---

### SCREENSHOT-21–25 — Prometheus
**URL:** http://localhost:9090 **или** :9091

| # | Куда нажать | Что должно быть |
|---|-------------|-----------------|
| 21 | **Status → Targets** | Targets **UP** (зелёные) |
| 22 | **Status → Configuration** | Config loaded |
| 23 | **Status → Rules** | Groups: `sre_sli_recording`, `sre_slo_alerts` |
| 24 | **Graph** | Query: `up` → Execute → график |
| 25 | **Graph** | Query: `sre:request_rate:5m` (после load test) |

**PowerShell перед 25:**
```powershell
.\scripts\load-test.ps1
```

---

### SCREENSHOT-26–32 — Grafana
**URL:** http://localhost:3000 **или** :3001  
**Логин:** `admin` / `foobar`

| # | Действия |
|---|----------|
| 26 | Страница логина |
| 27 | Меню ☰ → **Dashboards** → папка **SRE** |
| 28 | Открой **SRE End Term — SLI Overview** — скрин **весь дашборд** |
| 29 | Крупно панель **Request success rate** |
| 30 | Крупно панель **Error rate** |
| 31 | Дашборд **SRE End Term — Capacity & Resources** — полный экран |
| 32 | **Connections → Data sources** → Prometheus — зелёный/OK |

---

### SCREENSHOT-33–34 — Alertmanager
| **33** | http://localhost:9093 или :9094 — главная UI |
| **34** | VS Code: `docker-compose\alertmanager.yml` |

---

### SCREENSHOT-35–40 — Инцидент ДО восстановления
```powershell
.\scripts\simulate-incident.ps1
```
Подожди 30–60 сек.

| # | Что скринить |
|---|--------------|
| 35 | Вывод simulate в терминале |
| 36 | `docker-compose.incident.yml` — `orders-db-broken` |
| 37 | `docker logs sre-end-term-orders-1 --tail 40` — ошибки Mongo |
| 38 | Prometheus → **Alerts** — firing (красные) |
| 39 | Grafana SLI — всплеск Error rate |
| 40 | Сайт — ошибка при заказе (если видна) |

---

### SCREENSHOT-41–44 — Восстановление
```powershell
.\scripts\recover-incident.ps1
```
Подожди 1–2 мин.

| # | Что скринить |
|---|--------------|
| 41 | Вывод recover |
| 42 | Prometheus Alerts — пусто/зелёно |
| 43 | Grafana — ошибки упали |
| 44 | Сайт — заказ снова работает |

---

### SCREENSHOT-45–46 — Документы инцидента
| 45 | `docs\postmortem.md` — таблица Timeline |
| 46 | `docs\incident-report.md` — Impact |

---

### SCREENSHOT-47–49 — Terraform
| 47 | `terraform\main.tf` |
| 48 | `terraform\aws\main.tf` |
| 49 | Терминал: |
```powershell
cd sre-end-term\terraform
terraform init -backend=false
terraform validate
```

---

### SCREENSHOT-50–52 — Ansible
| 50 | `ansible\playbooks\site.yml` |
| 51 | Папка `ansible\roles\` развёрнута |
| 52 | (опционально) `ansible-playbook --syntax-check -i inventory/hosts.yml playbooks/site.yml` |

---

### SCREENSHOT-53–54 — Swarm
| 53 | `docker-swarm\docker-stack.yml` — replicas |
| 54 | Если деплоил: `docker swarm init` + `.\scripts\deploy-swarm.ps1` → `docker stack services sre-sock-shop` |

---

### SCREENSHOT-55–58 — Kubernetes
| 55 | `kubernetes\01-hpa-orders-payment.yaml` |
| 56 | `kubernetes\03-pdb-orders.yaml` |
| 57–58 | Если есть kubectl: `kubectl get pods -n sock-shop` и `kubectl get hpa -n sock-shop` |

---

### SCREENSHOT-59–62 — CI/CD код и GitHub
| 59 | VS Code: `.github\workflows\sre-team-ci-cd.yml` |
| 60 | GitHub Actions — полный зелёный pipeline |
| 61 | Клик на job **CI - Integration smoke** — лог внизу “CI smoke passed” |
| 62 | Job **CD - Release bundle** — artifact uploaded |

---

### SCREENSHOT-63–64 — CI скрипты
| 63 | VS Code: `ci\smoke.sh` и `ci\validate.sh` |
| 64 | Git Bash: `bash ci/validate.sh` — success |

---

### SCREENSHOT-65–67 — Monitoring код
| 65 | `monitoring\prometheus.yml` |
| 66 | `monitoring\grafana\dashboards\sre-overview.json` |
| 67 | Папка `monitoring\grafana\provisioning\` |

---

### SCREENSHOT-68–71 — Scripts
| 68 | `scripts\_lib\SrePorts.ps1` |
| 69 | `scripts\deploy-all.ps1` |
| 70 | `.\scripts\verify-health.ps1` — OK |
| 71 | `.\scripts\verify-slo.ps1` — PASS |

---

### SCREENSHOT-72–74 — Нагрузка
```powershell
.\scripts\load-test.ps1
```
| 72 | Терминал — load test |
| 73 | Grafana Capacity — пики CPU/RPS |
| 74 | `docs\capacity-planning.md` |

---

### SCREENSHOT-75 — Evidence
```powershell
.\scripts\demo-incident-full.ps1
```
Скрин папки `evidence\` с `.txt` / `.json` файлами.

---

### SCREENSHOT-76 — Итоговый коллаж
Один слайд: **3 картинки** — GitHub Actions green + Grafana SLI + Shop homepage.

---

## Как собрать PDF (Word)

1. Открой Word → вставь **Part 1** (английский текст) по разделам.  
2. Под каждым `[SCREENSHOT-XX]` — **Вставка → Рисунки** → твой скрин.  
3. Подпись под рисунком: `Figure XX: ...` (на английском).  
4. **Part 2** (русская инструкция) в PDF **не включай** — только для себя.  
5. Сохрани как **REPORT.pdf**.

**Рекомендуемый минимум для сдачи:** скрины **01–04, 05, 09, 11–15, 21–32, 35–44, 47, 50, 59–61, 70, 76** (~35 штук).

---

## Шпаргалка URL (если стандартные порты заняты)

| Сервис | Обычно | Альтернатива |
|--------|--------|--------------|
| Shop | :80 | :8888 |
| Prometheus | :9090 | :9091 |
| Grafana | :3000 | :3001 |
| Alertmanager | :9093 | :9094 |

Смотри файл `sre-end-term\.deploy-ports.env` после деплоя.

---

*End of document*
