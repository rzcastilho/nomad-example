job "test" {
  datacenters = ["dc1"]
  type = "service"
  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    auto_revert = false
    canary = 0
  }

  group "john" {
    count = 1
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }

    ephemeral_disk {
      size = 300
    }

    task "jdk8-application-john" {
      driver = "docker"
      config {
        image = "rodrigozc/jdk8-application:latest"
        volumes = ["local/application.yml:/app/application.yml"]
        port_map {
          http = 8080
        }
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 1024 # 256MB
        network {
          mbits = 1
          port "http" {}
        }
      }

      service {
        name = "jdk8-application-john"
        tags = ["sample","jdk8-application", "john"]
        port = "http"
        check {
          type     = "http"
          port     = "http"
          path     = "/info"
          interval = "10s"
          timeout  = "2s"
        }
      }

      artifact {
        source = "https://raw.githubusercontent.com/rodrigozc/jdk8-application/master/application.ctmpl"
        destination = "local"
      }

      template {
        source        = "local/application.ctmpl"
        destination   = "local/application.yml"
        change_mode   = "restart"
      }

    }

  }

  group "due" {
    count = 1
    restart {
      attempts = 10
      interval = "5m"
      delay = "25s"
      mode = "delay"
    }

    ephemeral_disk {
      size = 300
    }

    task "jdk8-application-due" {
      driver = "docker"
      config {
        image = "rodrigozc/jdk8-application:latest"
        volumes = ["local/application.yml:/app/application.yml"]
        port_map {
          http = 8080
        }
      }

      resources {
        cpu    = 500 # 500 MHz
        memory = 1024 # 256MB
        network {
          mbits = 1
          port "http" {}
        }
      }

      service {
        name = "jdk8-application-due"
        tags = ["sample","jdk8-application", "due"]
        port = "http"
        check {
          type     = "http"
          port     = "http"
          path     = "/info"
          interval = "10s"
          timeout  = "2s"
        }
      }

      artifact {
        source = "https://raw.githubusercontent.com/rodrigozc/jdk8-application/master/application.ctmpl"
        destination = "local"
      }

      template {
        source        = "local/application.ctmpl"
        destination   = "local/application.yml"
        change_mode   = "restart"
      }

    }
  }
}
