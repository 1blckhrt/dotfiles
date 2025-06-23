#!/usr/bin/env bash

set -euo pipefail

REPO_URL="https://github.com/1blckhrt/dotfiles.git"
DOT_DIR="$HOME/dot"
HM_SRC="$DOT_DIR/nix"
HM_DEST="$HOME/.config/home-manager"

# 1. Clone or update dotfiles repo
if [[ -d "$DOT_DIR/.git" ]]; then
  echo "› Pulling latest changes in $DOT_DIR"
  git -C "$DOT_DIR" pull --ff-only
else
  echo "› Cloning dotfiles from $REPO_URL to $DOT_DIR"
  git clone "$REPO_URL" "$DOT_DIR"
fi

# 2. Check if home-manager dir exists
if [[ ! -d "$HM_SRC" ]]; then
  echo "❌  Expected $HM_SRC to exist but it doesn't."
  exit 1
fi

# 3. Create symlink
echo "› Linking $HM_DEST → $HM_SRC"
rm -rf "$HM_DEST"
ln -sT "$HM_SRC" "$HM_DEST"  

# 4. Rebuild Home Manager config if available
if command -v home-manager >/dev/null 2>&1; then
  echo "› Running home-manager switch"
  home-manager switch -b backup
else
  echo "ℹ️  'home-manager' not found on PATH; skipping switch."
fi

echo "✅ Done!"

