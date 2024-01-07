# variables for propagation
 variable "command" {}
# variable "env" {}
# variable "image" {}
# variable "memory" {}
# variable "memory_swap" {}
 variable "name" {}
 variable "network_name" {}

module "sut" {
  depends_on = [ docker_network.test ]
  source = "../.."
   command = var.command
  # env = var.env
  # image = var.image
  # memory = var.memory
  # memory_swap = var.memory_swap
   name = var.name
   network_name = var.network_name
}

# add what you need for your tests

resource "docker_network" "test" {
  name = var.network_name
}

output "debug" {
  value = module.sut
}