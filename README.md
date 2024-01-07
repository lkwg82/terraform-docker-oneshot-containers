Lets run tasks in containers managed by terraform 


a very simple example
```terraform
module "run_date" {
  source  = "lkwg82/oneshot-containers/docker"
  version = "0.0.1"

  image   = "alpine"
  name    = "simple-example"
  command = ["date"]

  fetch_logs = true
}

output "debug" {
  value = module.run_date.stdout_lines
}
```

a more complex example (incomplete context)
```terraform
module "run_change_credentials" {
  source  = "lkwg82/oneshot-containers/docker"
  version = "0.0.1"

  depends_on = [docker_container.influxdb]

  image = docker_image.influxdb.image_id
  name  = "monitoring_server_influxdb_change_credentials"

  env = [
    "trigger=${sha512("${var.influx_admin_pass_previous}${var.influx_admin_pass_current}")}"
  ]
  network_name = docker_network.private_network.name
  command      = [
    "influx",
    "-host", docker_container.influxdb.name,
    "-username", var.influx_admin_user,
    "-password", var.influx_admin_pass_previous,
    "-execute", "SET PASSWORD FOR ${var.influx_admin_user} = '${var.influx_admin_pass_current}'"
  ]
}
```


uses internally the docker provider of kreuzwerker

```terraform
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">=3.0.2"
    }
  }
}
```