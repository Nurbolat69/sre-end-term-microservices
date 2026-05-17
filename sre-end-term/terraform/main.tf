provider "docker" {}

# Reproducible local "infrastructure" for SRE demo (works on Windows/macOS/Linux).
# For cloud VM provisioning, see terraform/aws/ (optional).

resource "docker_network" "sre_app" {
  name = "${var.project_name}-network"
  labels {
    label = "project"
    value = var.project_name
  }
  labels {
    label = "managed_by"
    value = "terraform"
  }
}

resource "docker_volume" "prometheus_data" {
  name = "${var.project_name}-prometheus-data"
}

resource "docker_volume" "grafana_data" {
  name = "${var.project_name}-grafana-data"
}

resource "docker_image" "prometheus" {
  name         = "prom/prometheus:v2.47.0"
  keep_locally = true
}

resource "docker_image" "grafana" {
  name         = "grafana/grafana:10.1.0"
  keep_locally = true
}

resource "docker_container" "prometheus" {
  name  = "${var.project_name}-prometheus"
  image = docker_image.prometheus.image_id

  networks_advanced {
    name = docker_network.sre_app.name
  }

  ports {
    internal = 9090
    external = var.prometheus_port
  }

  volumes {
    host_path      = abspath("${path.module}/../monitoring/prometheus.yml")
    container_path = "/etc/prometheus/prometheus.yml"
    read_only      = true
  }

  volumes {
    host_path      = abspath("${path.module}/../monitoring/alert.rules")
    container_path = "/etc/prometheus/alert.rules"
    read_only      = true
  }

  volumes {
    host_path      = abspath("${path.module}/../monitoring/recording.rules")
    container_path = "/etc/prometheus/recording.rules"
    read_only      = true
  }

  volumes {
    volume_name    = docker_volume.prometheus_data.name
    container_path = "/prometheus"
  }

  command = [
    "--config.file=/etc/prometheus/prometheus.yml",
    "--storage.tsdb.path=/prometheus",
    "--web.enable-lifecycle",
  ]

  labels {
    label = "component"
    value = "monitoring"
  }
}

resource "docker_container" "grafana" {
  name  = "${var.project_name}-grafana"
  image = docker_image.grafana.image_id

  networks_advanced {
    name = docker_network.sre_app.name
  }

  ports {
    internal = 3000
    external = var.grafana_port
  }

  env = [
    "GF_SECURITY_ADMIN_PASSWORD=${var.grafana_admin_password}",
    "GF_USERS_ALLOW_SIGN_UP=false",
  ]

  volumes {
    volume_name    = docker_volume.grafana_data.name
    container_path = "/var/lib/grafana"
  }

  labels {
    label = "component"
    value = "monitoring"
  }

  depends_on = [docker_container.prometheus]
}
