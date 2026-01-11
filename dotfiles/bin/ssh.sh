#!/usr/bin/env bash
set -euo pipefail

# Read from SSH config
HOSTS=$(grep "^Host " ~/.ssh/config | awk '{print $2}' | grep -v "\*")

SELECTED=$(echo "$HOSTS" | gum filter --placeholder "Select host...")

if [ -n "$SELECTED" ]; then
  gum style \
    --foreground 212 \
    --border double \
    --padding "1 2" \
    "Connecting to: $SELECTED"

  ssh "$SELECTED"
fi
