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

The version of the [plugin tester docker image](https://github.com/buildkite-plugins/buildkite-plugin-tester) to run. Default: `v4.1.1`.

## Examples

99% of the time you will have to use the following step verbatim:

```yaml
steps:
  - label: "🔨 Tests"
    plugins:
      - plugin-tester#v1.1.1: ~
```

## Multiple folders

If you have a sub-folder with tests, you will need to specify both folders (unfortunately):

```yaml
steps:
  - label: "🔨 Running tests"
    plugins:
      - plugin-tester#v1.1.1:
          folders:
            - tests
            - tests/v2
```

## ⚒ Developing

You can use the [bk cli](https://github.com/buildkite/cli) to run the [pipeline](.buildkite/pipeline.yml) locally:

```bash
bk local run
```

## 👩‍💻 Contributing

Feel free to open PRs with functionality or report issues here in GitHub :)

## 📜 License

The package is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
