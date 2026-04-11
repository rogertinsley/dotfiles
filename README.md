# dotfiles

Personal dotfiles for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/). Configs are symlinked into `~/.config` via `.stowrc`.

## Prerequisites

Install Homebrew, then use the Brewfile to get everything else:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle
```

## Install

```bash
./setup.sh
```

Or manually:

```bash
stow .
```

## What's included

| Tool | Config |
|---|---|
| [Zsh](https://zsh.sourceforge.io) | `zshrc/` |
| [Neovim](https://neovim.io) (LazyVim) | `nvim/` |
| [Tmux](https://github.com/tmux/tmux) | `tmux/` |
| [Zellij](https://zellij.dev) | `zellij/` |
| [Starship](https://starship.rs) | `starship/` |
| [Ghostty](https://ghostty.org) | `ghostty/` |
| [Alacritty](https://alacritty.org) | `alacritty/` |
| [k9s](https://k9scli.io) | `k9s/` |

## Homebrew

```bash
# Back up current packages
brew bundle dump --force

# Install from Brewfile on a fresh machine
brew bundle
```
