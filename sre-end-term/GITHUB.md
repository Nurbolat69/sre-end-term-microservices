# GitHub — последний шаг (push)

Локальный git уже создан и закоммичен в:

`c:\Users\nurbo\Downloads\microservices-demo-master\microservices-demo-master`

## Вариант A — скрипт (рекомендуется)

1. Создай **пустой** репозиторий на https://github.com/new  
   - Имя: `sre-end-term-microservices`  
   - **Без** README / .gitignore  

2. В PowerShell:

```powershell
cd c:\Users\nurbo\Downloads\microservices-demo-master\microservices-demo-master\sre-end-term
.\scripts\push-github.ps1 -GitHubUsername ТВОЙ_ЛОГИН_GITHUB
```

3. Войди в GitHub в браузере, если спросит логин/токен.

4. Ссылка для PDF:

`https://github.com/ТВОЙ_ЛОГИН_GITHUB/sre-end-term-microservices`

## Вариант B — вручную

```powershell
cd c:\Users\nurbo\Downloads\microservices-demo-master\microservices-demo-master
git remote add origin https://github.com/ТВОЙ_ЛОГИН/sre-end-term-microservices.git
git push -u origin main
```

Вставь URL в `docs/PROJECT_REPORT.md` → экспорт в PDF.
