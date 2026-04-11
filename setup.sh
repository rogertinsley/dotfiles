#!/usr/bin/env bash

set -e

echo "==> Checking for Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for the rest of this script (Apple Silicon)
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo "==> Installing Homebrew packages..."
brew bundle

echo "==> Symlinking dotfiles..."
stow .

echo "==> Installing tmux plugins..."
if [ -d ~/.config/tmux/plugins/tpm ]; then
  ~/.config/tmux/plugins/tpm/bin/install_plugins
else
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
  ~/.config/tmux/plugins/tpm/bin/install_plugins
fi

echo "==> Done. Open a new shell to apply zsh changes."
