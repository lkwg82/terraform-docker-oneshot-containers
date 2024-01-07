resource "docker_container" "short_live" {
  image = var.image
  name  = var.name
  env   = var.env

  dynamic "networks_advanced" {
    for_each = var.network_name == "" ? [] : [var.network_name]
    content {
      name = var.network_name
    }
  }

  memory      = var.memory
  memory_swap = var.memory_swap == -1 ? var.memory+1 : var.memory_swap

  command  = var.command
  must_run = false # needed for short lived containers
}

data "docker_logs" "short_live_stderr" {
  count = var.fetch_logs ? 1 :0
  depends_on = [docker_container.short_live]
  name       = docker_container.short_live.name

  show_stderr = true
  show_stdout = false
  timestamps = var.show_timestamps_in_logs
}

data "docker_logs" "short_live_stdout" {
  count = var.fetch_logs ? 1 :0
  depends_on = [docker_container.short_live]
  name       = docker_container.short_live.name

  show_stderr = false
  show_stdout = true
  timestamps = var.show_timestamps_in_logs
}
locals {
  # for_tests
  stdout_lines = var.fetch_logs ? data.docker_logs.short_live_stdout[0].logs_list_string : []
}