# Pipery Terraform CI

CI pipeline for Terraform: SAST (tfsec) → SCA → lint (tflint) → validate → plan → version → release

## Status

- Owner: `pipery-dev`
- Repository: `pipery-terraform-ci`
- Marketplace category: `continuous-integration`
- Current version: `3.0.0`

## Usage

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
          config_file: .pipery/config.yaml
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

## GitLab CI

This repository also includes a GitLab CI equivalent at `.gitlab-ci.yml`. Copy it into a GitLab project or use it as the reference implementation when you want to run the same Pipery pipeline outside GitHub Actions.

The GitLab pipeline maps the action inputs to CI/CD variables, publishes `pipery.jsonl` as an artifact, and keeps the same skip controls where the GitHub Action exposes them. Store credentials such as deploy tokens, registry passwords, and cloud provider keys as protected GitLab CI/CD variables.

```yaml
include:
  - remote: https://raw.githubusercontent.com/pipery-dev/pipery-terraform-ci/v3/.gitlab-ci.yml
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `project_path` | no | `.` | Path to the Terraform root module. |
| `config_file` | no | `.pipery/config.yaml` | Path to the pipery config file. |
| `terraform_version` | no | `latest` | Terraform CLI version to use. |
| `backend_config` | no | `` | Comma-separated backend config vars (key=val). |
| `var_file` | no | `` | Path to a .tfvars file. |
| `working_directory` | no | `.` | Working directory for Terraform commands. |
| `skip_sast` | no | `false` | Skip tfsec SAST scan. |
| `skip_sca` | no | `false` | Skip SCA dependency scan. |
| `skip_lint` | no | `false` | Skip tflint lint. |
| `skip_validate` | no | `false` | Skip terraform validate. |
| `skip_plan` | no | `false` | Skip terraform plan. |
| `skip_version` | no | `false` | Skip version step. |
| `skip_release` | no | `false` | Skip release step. |
| `log_file` | no | `pipery.jsonl` | Path to write the JSONL log file. |

## Outputs

No outputs.

## Bitbucket Pipelines

Bitbucket Cloud pipelines provide an alternative to GitHub Actions for this CI workflow. The equivalent pipeline configuration is provided in `bitbucket-pipelines.yml`.

### Quick Start

1. Copy `bitbucket-pipelines.yml` to your Bitbucket repository root
2. Configure Protected Variables in Bitbucket (Repository Settings > Pipelines > Repository Variables):
   - `GITHUB_TOKEN` - GitHub API access (for reintegration)
3. Commit and push to trigger the pipeline

### Pipeline Stages

The Bitbucket Pipelines equivalent follows the same structure as the GitHub Actions:
- checkout → setup → SAST (tfsec) → SCA → lint (tflint) → validate → plan → version → release → reintegration → logs

### Skip Flags

Disable any stage using environment variables:
- SKIP_SAST, SKIP_SCA, SKIP_LINT, SKIP_VALIDATE, SKIP_PLAN, SKIP_VERSION, SKIP_RELEASE

Example: Set `SKIP_SAST=true` in pipeline variables to skip security scanning.

### Features

- Same security scanning tools as GitHub Actions (tfsec, tflint)
- SAST and SCA scanning stages
- Terraform plan and validation
- Automatic versioning and tagging
- GitHub Release publishing
- JSONL-based pipeline logging
- 30-90 day artifact retention

### Documentation

- See `bitbucket-pipelines.yml` for complete customization options
- Refer to [Bitbucket Pipelines Documentation](https://support.atlassian.com/bitbucket-cloud/docs/get-started-with-bitbucket-pipelines/) for detailed reference

## Development

This repository is managed with `pipery-tooling`.

```bash
pipery-actions test --repo .
pipery-actions docs --repo .
pipery-actions release --repo . --dry-run
```

By default, `pipery-actions test --repo .` executes the action against `test-project` and validates `pipery.jsonl`.

## Marketplace Release Flow

1. Update the implementation and changelog.
2. Run `pipery-actions release --repo .`.
3. Push the created git tag and major tag alias.
4. Publish the GitHub release.
