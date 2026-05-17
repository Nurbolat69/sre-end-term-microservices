# Databases & Message Brokers (PDF §4)

## Assignment specification vs implementation

| PDF component | Assignment example | This project |
|---------------|-------------------|--------------|
| Primary RDBMS | PostgreSQL | `postgres-sre` (reference DB per spec) |
| App catalog DB | — | `catalogue-db` (MySQL — Sock Shop) |
| App orders DB | — | `orders-db` (MongoDB) |
| Cache / broker | Redis / RabbitMQ | `redis` + `rabbitmq` |

Sock Shop predates the assignment schema; we **add PostgreSQL and Redis** alongside native stores to satisfy the PDF supporting-components list without breaking the demo.

## Service → database map

| Microservice | Database | Engine |
|--------------|----------|--------|
| Product (catalogue) | catalogue-db | MySQL |
| Order (orders) | orders-db | MongoDB |
| Auth/Profile (user) | user-db | MongoDB |
| Carts | carts-db | MongoDB |
| SRE metadata (reference) | postgres-sre | PostgreSQL 15 |
| Notifications | rabbitmq | AMQP |

## Connection strings (Compose)

| Service | Env / host |
|---------|------------|
| orders | Mongo at `orders-db:27017` (see `MONGO_HOST` in incident drill) |
| user | `MONGO_HOST=user-db:27017` |
| postgres-sre | `postgresql://sre:sre@postgres-sre:5432/sre_metadata` |

## Capacity note

**orders-db** is the checkout bottleneck — see `capacity-planning.md`. PostgreSQL container is for assignment compliance and future SRE audit tables.

## Verify PostgreSQL

```powershell
docker exec -it sre-end-term-postgres-sre-1 psql -U sre -d sre_metadata -c "\dt"
```
