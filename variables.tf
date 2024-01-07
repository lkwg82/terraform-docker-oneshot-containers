variable "command" {
  type = list(string)
}

variable "name" {
  type = string
  description = "container name"
}

# optional vars following

variable "image" {
  type = string
  default = "alpine"
}

variable "network_name" {
  type=string
  default = ""
}

variable "env" {
  type = list(string)
  default = []
}

variable "memory" {
  type = number
  default = 100
}

variable "memory_swap" {
  type = number
  default = 100+1
}

variable "fetch_logs" {
  type = bool
  default = false
  description = "should fetch logs from container run"
}

variable "show_timestamps_in_logs" {
  type = bool
  default = false
}