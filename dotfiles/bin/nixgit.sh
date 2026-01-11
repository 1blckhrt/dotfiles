#!/usr/bin/env bash
set -euo pipefail

REPO="/home/blckhrt/dot"

# Ensure the directory is a git repository
if [ ! -d "$REPO/.git" ]; then
  echo "Error: $REPO is not a git repository." >&2
  exit 1
fi

# Use a subshell to avoid changing the working directory
(
  cd "$REPO"
  git add -A

  if [ $# -gt 0 ]; then
    COMMIT_MSG="$*"
  else
    COMMIT_MSG="chore: backup on $(date +'%Y-%m-%d %H:%M:%S')"
  fi

  git commit -m "$COMMIT_MSG"
  git push
)

