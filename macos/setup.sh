#! /usr/bin/env bash
################################################################################
# setup.sh
# -----------------
# This script installs my basic setup for macOS
################################################################################
set -eo pipefail

echo "Starting to configure mac"
./setup_system.sh
./setup_apps.sh
echo "Configured mac successfuly"