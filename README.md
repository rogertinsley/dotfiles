# dotfiles

![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=flat&logo=neovim&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=flat&logo=zsh&logoColor=white)
![Tmux](https://img.shields.io/badge/Tmux-1BB91F?style=flat&logo=tmux&logoColor=white)
![Starship](https://img.shields.io/badge/Starship-DD0B78?style=flat&logo=starship&logoColor=white)
![Homebrew](https://img.shields.io/badge/Homebrew-FBB040?style=flat&logo=homebrew&logoColor=black)
![GNU Stow](https://img.shields.io/badge/GNU%20Stow-managed-blue?style=flat)

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
