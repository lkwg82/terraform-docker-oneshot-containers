output "for_tests" {
  # will be changed without notice
  value = {
    container = docker_container.short_live
  }
}

output "exit_code" {
  value = docker_container.short_live.exit_code
}