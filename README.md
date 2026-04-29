# Pipery Terraform CI

Reusable GitHub Action for Terraform CI with structured logging via [Pipery](https://pipery.dev).

[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-Pipery%20Terraform%20CI-blue?logo=github)](https://github.com/marketplace/actions/pipery-terraform-ci)
[![Version](https://img.shields.io/badge/version-1.0.0-blue)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Usage

```yaml
name: CI
on:
  push:
    branches: [main]

jobs:
  ci:
    uses: pipery-dev/pipery-terraform-ci@v1
    with:
      project_path: .
    secrets: inherit
```

## Pipeline steps

SAST (tfsec) → SCA → lint (tflint) → validate → plan → version → release

Every step is logged to `pipery.jsonl` via psh and uploaded as a GitHub Actions artifact.

## Inputs

| Input | Description | Default |
|---|---|---|
| `project_path` | Path to the Terraform root module. | `.` |
| `config_file` | Path to the pipery config file. | `.github/pipery/config.yaml` |
| `terraform_version` | Terraform CLI version to use. | `latest` |
| `backend_config` | Comma-separated backend config vars (key=val). | `` |
| `var_file` | Path to a .tfvars file. | `` |
| `working_directory` | Working directory for Terraform commands. | `.` |
| `skip_sast` | Skip tfsec SAST scan. | `false` |
| `skip_sca` | Skip SCA dependency scan. | `false` |
| `skip_lint` | Skip tflint lint. | `false` |
| `skip_validate` | Skip terraform validate. | `false` |
| `skip_plan` | Skip terraform plan. | `false` |
| `skip_version` | Skip version step. | `false` |
| `skip_release` | Skip release step. | `false` |
| `log_file` | Path to write the JSONL log file. | `pipery.jsonl` |

## Observability

Each run produces a `pipery.jsonl` file. Upload it as an artifact and inspect it with the [Pipery Dashboard](https://dash.pipery.dev).

## License

MIT — see [LICENSE](LICENSE).
