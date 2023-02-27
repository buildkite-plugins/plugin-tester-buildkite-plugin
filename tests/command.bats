#!/usr/bin/env bats

setup() {
  load "${BATS_PLUGIN_PATH}/load.bash"

  # Uncomment to enable stub debugging
  # export DOCKER_STUB_DEBUG=/dev/tty

  # to make all tests have a stable value
  export BUILDKITE_PLUGIN_PLUGIN_TESTER_VERSION='latest'
}

@test "Normal basic operations" {
  unset BUILDKITE_PLUGIN_PLUGIN_TESTER_VERSION

  stub docker 'echo docker ran with options $@'

  run "$PWD"/hooks/command

  assert_success
  assert_output --partial 'docker ran with'
  assert_output --partial " -v $PWD:/plugin "
  assert_output --partial ' buildkite/plugin-tester:v4.0.0 bats tests'

  unstub docker
}

@test "Can provide different version" {
  stub docker 'echo docker ran with options $@'

  run "$PWD"/hooks/command

  assert_success
  assert_output --partial 'docker ran with'
  assert_output --partial ' buildkite/plugin-tester:latest'
  refute_output --partial ' buildkite/plugin-tester:v4.0.0'

  unstub docker
}

@test "Can provide single folder as string" {
  export BUILDKITE_PLUGIN_PLUGIN_TESTER_FOLDERS='DIFFERENT'

  stub docker "echo docker ran with command \$7 \$8"

  run "$PWD"/hooks/command

  assert_success
  assert_output --partial 'docker ran with command bats DIFFERENT'
}

@test "Can provide single folder as array" {
  export BUILDKITE_PLUGIN_PLUGIN_TESTER_FOLDERS_0='NEW_FOLDER'

  stub docker "echo docker ran with command \$7 \$8"

  run "$PWD"/hooks/command

  assert_success
  assert_output --partial 'docker ran with command bats NEW_FOLDER'
}

@test "Can provide multiple folders as array" {
  export BUILDKITE_PLUGIN_PLUGIN_TESTER_FOLDERS_0='FOLDER_1'
  export BUILDKITE_PLUGIN_PLUGIN_TESTER_FOLDERS_1='FOLDER_2'

  stub docker "echo docker ran with command \$7 \$8 \$9"

  run "$PWD"/hooks/command

  assert_success
  assert_output --partial 'docker ran with command bats FOLDER_1 FOLDER_2'
}

@test "Force docker pull" {
  export BUILDKITE_PLUGIN_PLUGIN_TESTER_PULL='true'

  stub docker "echo docker ran with option \$6"

  run "$PWD"/hooks/command

  assert_success
  assert_output --partial 'docker ran with option --pull'
}