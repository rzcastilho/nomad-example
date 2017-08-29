bind_addr = "0.0.0.0" # the default

data_dir  = "/tmp/var/lib/nomad"

server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled       = true
  network_speed = 10
  options {
    #"docker.auth.config"     = "~/.docker/config.json"
    "docker.cleanup.image"   = "0"
    "driver.raw_exec.enable" = "1"
  }
}

consul {
  address = "127.0.0.1:8500"
}
