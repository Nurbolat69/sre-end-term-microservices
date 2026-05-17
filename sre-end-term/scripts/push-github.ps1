# Initialize git and push to GitHub (run once)
param(
    [Parameter(Mandatory = $true)]
    [string]$GitHubUsername,
    [string]$RepoName = "sre-end-term-microservices"
)
$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$remoteUrl = "https://github.com/$GitHubUsername/$RepoName.git"

Set-Location $RepoRoot

if (-not (Test-Path .git)) {
    git init
    git branch -M main
}

git add -A
$status = git status --porcelain
if ($status) {
    git commit -m "SRE End Term Project: Sock Shop, Terraform, Ansible, monitoring, incident runbooks"
} else {
    Write-Host "Nothing to commit." -ForegroundColor Yellow
}

$remotes = git remote 2>$null
if ($remotes -notcontains "origin") {
    git remote add origin $remoteUrl
} else {
    git remote set-url origin $remoteUrl
}

Write-Host ""
Write-Host "Before push:" -ForegroundColor Cyan
Write-Host "1. Create EMPTY repo at: https://github.com/new?name=$RepoName"
Write-Host "2. Do NOT add README/license (avoid conflicts)"
Write-Host ""
Write-Host "Remote: $remoteUrl"
Write-Host "Pushing..."
git push -u origin main

Write-Host ""
Write-Host "Git URL for PDF:" -ForegroundColor Green
Write-Host "https://github.com/$GitHubUsername/$RepoName"
