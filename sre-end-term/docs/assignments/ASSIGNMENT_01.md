# Assignment 1 — Environment Setup

## Требования PDF

1. Docker environment setup  
2. Containerized services  
3. Docker Compose orchestration  

## Реализация

| Требование | Как выполнено |
|------------|---------------|
| Docker | Docker Desktop / Engine + проверка в `scripts/verify-health.ps1` |
| Контейнеры | 6+ микросервисов + БД + broker + monitoring в `docker-compose.full.yml` |
| Compose | `docker compose -f docker-compose.full.yml up -d` |

## Команды

```powershell
.\scripts\deploy-compose.ps1
.\scripts\verify-health.ps1
docker compose -f docker-compose/docker-compose.full.yml ps
```

## Компоненты стека

- **API Gateway:** `edge-router`  
- **Frontend (Nginx):** `front-end`  
- **6 assignment services:** user, catalogue, orders, payment, queue-master (+ shipping, carts)  
- **PostgreSQL (assignment spec):** `postgres-sre` — reference/metadata DB  
- **Redis (optional broker):** `redis`  
- **RabbitMQ:** `rabbitmq`  

## Health checks & restart

Все критичные сервисы: `restart: unless-stopped` + `healthcheck` (см. compose file).

## Доказательства для отчёта

- Скриншот `docker ps`  
- Скриншот http://localhost (магазин)  
- Скриншот `docker compose ps` со статусом `healthy`
