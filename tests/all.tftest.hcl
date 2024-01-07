run "simple" {
  variables {
    fetch_logs = true
    name       = "test-docker"
    command    = ["date"]
  }

  assert {
    condition     = docker_container.short_live.exit_code == 0
    error_message = "command failed"
  }

  assert {
    condition     = docker_container.short_live.network_data[0].network_name == "bridge"
    error_message = "network name is not propagated"
  }

  assert {
    condition     = length(local.stdout_lines)>0
    error_message = "missing date"
  }
}

run "should_fail" {
  variables {
    name    = "test-docker-fail"
    command = ["sh", "-c", "exit 1"]
  }

  assert {
    # condition must contain a resource from module
    condition     = docker_container.short_live.exit_code == 1
    error_message = "command failed to fail"
  }
}

run "complex" {
  variables {
    # should be from setup-module (needs propation to original module)
    name         = "test-docker-complex"
    network_name = "test-network"
    command      = ["date"]
  }

  module {
    source = "./tests/setup"
  }

  assert {
    # condition must contain a resource from module
    # cannot access original module (only proxy module)
    condition     = module.sut.for_tests.container.network_data[0].network_name == "test-network"
    error_message = "network name is not propagated"
  }
}
