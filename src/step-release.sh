#!/usr/bin/env psh
# Pipery Terraform CI — release step
# Structured logging via psh: every command is captured to $INPUT_LOG_FILE

set -euo pipefail

echo "::group::Release"
echo "project_path=$INPUT_PROJECT_PATH"
echo "::endgroup::"
