output "for_tests" {
  # will be changed without notice
  value = {
    container = docker_container.short_live
  }
}

output "exit_code" {
  value = docker_container.short_live.exit_code
}

output "stdout_lines" {
  value = var.fetch_logs ? data.docker_logs.short_live_stdout[0].logs_list_string : []
}

output "stderr_lines" {
  value = var.fetch_logs ? data.docker_logs.short_live_stderr[0].logs_list_string : []
}