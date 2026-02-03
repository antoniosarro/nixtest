#! /usr/bin/env bash
set -euo pipefail

rg -g "*.nix" "builtins" | rg -v '(toString|toFile|readDir|currentTime|getFlake|getEnv|isNull)'
