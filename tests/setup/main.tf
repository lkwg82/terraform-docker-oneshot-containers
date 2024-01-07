# variables for propagation
variable "command" { type=list(string)}
# variable "env" {}
# variable "image" {}
# variable "memory" {}
# variable "memory_swap" {}
variable "name" {}
variable "network_name" {}
variable "fetch_logs" { default = false }

module "sut" {
  depends_on   = [docker_network.test]
  source       = "../.."
  command      = var.command
  # env = var.env
  # image = var.image
  # memory = var.memory
  # memory_swap = var.memory_swap
  name         = var.name
  network_name = var.network_name
  fetch_logs   = var.fetch_logs
}

# add what you need for your tests

resource "docker_network" "test" {
  name = var.network_name
}

output "debug" {
  value = module.sut.stdout_lines
}