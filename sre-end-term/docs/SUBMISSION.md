# Submission — REPORT PDF + PRESENTATION PDF only

## What to submit

| File | Source | Points |
|------|--------|--------|
| **REPORT.pdf** | `docs/REPORT_FOR_PDF.md` (visual, many screenshots) **or** `docs/TEAM_REPORT.md` (text) | 40 |
| **PRESENTATION.pdf** | `docs/PRESENTATION.md` | (presentation grade) |

**Do NOT submit** repository ZIP unless instructor asks — Git URL is **inside REPORT**.

---

## How to create PDF (Windows)

### Option 1 — VS Code / Cursor

1. Open `TEAM_REPORT.md`  
2. Extension: **Markdown PDF** → Export  
3. Repeat for `PRESENTATION.md`  

### Option 2 — Word

1. Copy markdown into Word  
2. Fix headings → File → Save as PDF  

### Option 3 — Browser

1. Push to GitHub  
2. View rendered markdown → Print → Save as PDF  

---

## Before export — checklist

- [ ] Replace `Member 2–5` names in `TEAM_REPORT.md` and `TEAM.md`  
- [ ] Screenshot: GitHub Actions **SRE Team CI/CD** green — insert in REPORT Appendix or Presentation  
- [ ] Screenshot: Grafana SLI dashboard  
- [ ] Screenshot: Incident alerts (optional)  
- [ ] Git URL in report: https://github.com/Nurbolat69/sre-end-term-microservices  

---

## CI/CD evidence for report

1. Open https://github.com/Nurbolat69/sre-end-term-microservices/actions  
2. Click latest **SRE Team CI/CD** run  
3. Screenshot all jobs green  
4. Paste into REPORT section 7.6 or Presentation slide 10–11  

---

## Push latest code (triggers CI)

```powershell
cd c:\Users\nurbo\Downloads\microservices-demo-master\microservices-demo-master
git add -A
git commit -m "Add team CI/CD pipeline, report and presentation"
git push origin main
```
