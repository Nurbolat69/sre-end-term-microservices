# Provision monitoring infrastructure via Terraform
$ErrorActionPreference = "Stop"
$TfDir = Join-Path (Split-Path -Parent $PSScriptRoot) "terraform"

Push-Location $TfDir
terraform init
if (-not (Test-Path "terraform.tfvars")) {
    Write-Host "Tip: copy terraform.tfvars.example to terraform.tfvars" -ForegroundColor Yellow
}
terraform apply -auto-approve
Pop-Location

Write-Host "Terraform outputs:" -ForegroundColor Green
terraform -chdir=$TfDir output
