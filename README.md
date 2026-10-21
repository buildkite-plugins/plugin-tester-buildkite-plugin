# Plugin Tester BuildKite Plugin [![Build status](https://badge.buildkite.com/fdf6cc0ba3636d07ab477c6380331afe798cb20f4ad5ef2be6.svg)](https://buildkite.com/buildkite/plugins-plugin-tester)

A Buildkite plugin that runs plugin tests (using the [specially-built docker image](https://github.com/buildkite-plugins/buildkite-plugin-tester))

## Options

These are all the options available to configure this plugin's behaviour.

### Required

There are no mandatory options.

### Optional

#### `folders` (string or array)

The folders that contain the tests to run. You will need to use this option if you have more than one folder with tests. Default: `tests`.

#### `pull` (boolean)

Whether to force pulling the image before running or not. Default:  `false`.

#### `version` (string)

The version of the [plugin tester Docker image](https://github.com/buildkite-plugins/buildkite-plugin-tester) to run. Default: `v5.0.0`.

The v5.0.0 image upgrades Alpine from 3.12 to 3.24 and removes the legacy
`no-faccessat2` workaround. Older container runtime or libseccomp configurations
that block `faccessat2` may fail with `BATS_TMPDIR (/tmp) is not writable`.
Upgrade the host runtime and libseccomp rather than disabling seccomp or using
privileged mode. For Docker-in-Docker, check both the outer and inner runtimes.
See the [v5.0.0 release notes](https://github.com/buildkite-plugins/buildkite-plugin-tester/releases/tag/v5.0.0).

## Examples

99% of the time you will have to use the following step verbatim:

```yaml
steps:
  - label: "🔨 Tests"
    plugins:
      - plugin-tester#v2.0.0: ~
```

## Multiple folders

If you have a sub-folder with tests, you will need to specify both folders (unfortunately):

```yaml
steps:
  - label: "🔨 Running tests"
    plugins:
      - plugin-tester#v2.0.0:
          folders:
            - tests
            - tests/v2
```

## Upgrading existing installations

Update pipeline references to `plugin-tester#v2.0.0`. Remove any older `version`
override to use the default tester image, or explicitly set `version: v5.0.0`.
The plugin version and tester image version are separate.

The plugin does not pull images by default. On each agent host (or Docker daemon
used by the tests), explicitly pull the new image to refresh the local cache:

```bash
docker pull buildkite/plugin-tester:v5.0.0
```

Pulling an unchanged older tag does not guarantee remediation. Updating the
wrapper does not replace an explicit older image override, and existing pipelines
pinned to older plugin releases must be updated separately.

## 👩‍💻 Contributing

Feel free to open PRs with functionality or report issues here in GitHub :)

## 📜 License

The package is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
