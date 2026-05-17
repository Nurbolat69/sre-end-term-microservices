# Midterm functional checks — HTTP smoke test
$ErrorActionPreference = "Continue"
$base = "http://localhost"
$tests = @(
    @{ Name = "Homepage"; Url = "$base/" },
    @{ Name = "Catalogue API"; Url = "$base/catalogue" },
    @{ Name = "Cart page"; Url = "$base/cart" }
)

Write-Host "=== UI / API Smoke Test (Midterm) ===" -ForegroundColor Cyan
$ok = 0
foreach ($t in $tests) {
    try {
        $r = Invoke-WebRequest -Uri $t.Url -UseBasicParsing -TimeoutSec 15
        if ($r.StatusCode -lt 500) {
            Write-Host "[OK]   $($t.Name) — $($r.StatusCode)" -ForegroundColor Green
            $ok++
        } else {
            Write-Host "[FAIL] $($t.Name) — $($r.StatusCode)" -ForegroundColor Red
        }
    } catch {
        Write-Host "[FAIL] $($t.Name) — $($_.Exception.Message)" -ForegroundColor Red
    }
}
Write-Host ""
Write-Host "Passed $ok / $($tests.Count) automated checks." -ForegroundColor Cyan
Write-Host "Manual: register, login, add to cart, checkout — see docs/assignments/MIDTERM.md"
