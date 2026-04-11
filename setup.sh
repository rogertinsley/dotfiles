#!/usr/bin/env bash

stow .

# Install tmux plugins via TPM
if [ -d ~/.config/tmux/plugins/tpm ]; then
  ~/.config/tmux/plugins/tpm/bin/install_plugins
fi
