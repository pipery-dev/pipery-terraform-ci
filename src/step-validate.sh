#!/usr/bin/env psh
# Pipery Terraform CI — validate step
# Structured logging via psh: every command is captured to $INPUT_LOG_FILE

set -euo pipefail

echo "::group::Validate"
echo "project_path=$INPUT_PROJECT_PATH"
echo "::endgroup::"
