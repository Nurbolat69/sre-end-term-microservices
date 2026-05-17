# Shared helpers for SRE scripts (ports + compose files)
function Get-SreRoot {
    return Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
}

function Get-SrePorts {
    $root = Get-SreRoot
    $ports = @{
        Shop      = '80'
        Prom      = '9090'
        Grafana   = '3000'
        Alert     = '9093'
        Cadvisor  = '8081'
        UseAlt    = $false
    }
    $envFile = Join-Path $root '.deploy-ports.env'
    if (Test-Path $envFile) {
        Get-Content $envFile | ForEach-Object {
            if ($_ -match '^SHOP_PORT=(.+)$')     { $ports.Shop = $matches[1].Trim() }
            if ($_ -match '^PROM_PORT=(.+)$')     { $ports.Prom = $matches[1].Trim() }
            if ($_ -match '^GRAFANA_PORT=(.+)$')  { $ports.Grafana = $matches[1].Trim() }
            if ($_ -match '^ALERT_PORT=(.+)$')    { $ports.Alert = $matches[1].Trim() }
            if ($_ -match '^CADVISOR_PORT=(.+)$') { $ports.Cadvisor = $matches[1].Trim() }
            if ($_ -match '^USE_ALT_PORTS=(.+)$') { $ports.UseAlt = $matches[1].Trim() -eq 'true' }
        }
    }
    return $ports
}

function Get-SreComposeArgs {
    $composeDir = Join-Path (Get-SreRoot) 'docker-compose'
    $args = @('-f', 'docker-compose.full.yml')
    $busy = @(80, 3000, 9090, 5432, 6379)
    $useAlt = $false
    foreach ($p in $busy) {
        if (Get-NetTCPConnection -LocalPort $p -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1) {
            $useAlt = $true
            break
        }
    }
    if ($useAlt) {
        $args += @('-f', 'docker-compose.ports-local.yml')
    } else {
        $args += @('-f', 'docker-compose.ports-default.yml')
    }
    return @{ Directory = $composeDir; Args = $args; UseAlt = $useAlt }
}

function Save-SrePorts {
    param($UseAlt)
    $root = Get-SreRoot
    $shop = if ($UseAlt) { '8888' } else { '80' }
    $prom = if ($UseAlt) { '9091' } else { '9090' }
    $graf = if ($UseAlt) { '3001' } else { '3000' }
    $alert = if ($UseAlt) { '9094' } else { '9093' }
    $cad = if ($UseAlt) { '8082' } else { '8081' }
    @"
SHOP_PORT=$shop
PROM_PORT=$prom
GRAFANA_PORT=$graf
ALERT_PORT=$alert
CADVISOR_PORT=$cad
USE_ALT_PORTS=$($UseAlt.ToString().ToLower())
"@ | Set-Content (Join-Path $root '.deploy-ports.env') -Encoding ASCII
}
