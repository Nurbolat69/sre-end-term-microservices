# Midterm Project

## Требования PDF

1. Initial microservices implementation  
2. Functional system deployment  

## Реализация

Используется production-grade demo **Weaveworks Sock Shop** (8+ сервисов). Исходники upstream: см. `docs/SERVICES.md`.

## Критерии «functional»

| # | Проверка | Команда / URL |
|---|----------|---------------|
| 1 | UI загружается | http://localhost |
| 2 | Каталог товаров | Browse socks |
| 3 | Регистрация пользователя | Register |
| 4 | Логин | Login |
| 5 | Корзина | Add to cart |
| 6 | Заказ | Checkout (до payment) |

```powershell
.\scripts\verify-health.ps1
.\scripts\smoke-test-ui.ps1
```

## Deploy

```powershell
.\scripts\deploy-compose.ps1
```

Ожидайте 2–5 минут на первый pull образов.
