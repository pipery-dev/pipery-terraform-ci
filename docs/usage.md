# Using Pipery Terraform CI

CI pipeline for Terraform: SAST (tfsec) → SCA → lint (tflint) → validate → plan → version → release

## Recommended workflow

1. Pin the action to a major tag in production workflows.
2. Keep a representative test project in the repository and point `test_project_path` at it.
3. Emit a `pipery.jsonl` build log during the action run and keep `test_log_path` pointed at it.
4. Make the action consume that path via the configured test input.
5. Keep changelog entries under `## [Unreleased]` until you cut a release.
6. Regenerate docs before publishing a new version.

## Example

```yaml
name: Example
on: [push]

jobs:
  run-action:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pipery-dev/pipery-terraform-ci@v3
        with:
          project_path: .
          config_file: .github/pipery/config.yaml
          terraform_version: latest
          backend_config: 
          var_file: 
          working_directory: .
          skip_sast: false
          skip_sca: false
          skip_lint: false
          skip_validate: false
          skip_plan: false
          skip_version: false
          skip_release: false
          log_file: pipery.jsonl
```
