resource "docker_network" "service-network" {
  name   = "service-network"
  driver = "bridge"
}

resource "docker_image" "nginx" {
  name         = "docker.io/library/nginx-test:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "${var.service}"
  
  networks_advanced {
    name    = docker_network.service-network.name
    aliases = ["service-network"]
  }
  restart = "unless-stopped"
  destroy_grace_seconds = 30
  must_run = true
  memory = 256
  
  ports {
    internal = 80
    external = 8080
  }
}
