# dotfiles

![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=flat&logo=neovim&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=flat&logo=zsh&logoColor=white)
![Tmux](https://img.shields.io/badge/Tmux-1BB91F?style=flat&logo=tmux&logoColor=white)
![Starship](https://img.shields.io/badge/Starship-DD0B78?style=flat&logo=starship&logoColor=white)
![Homebrew](https://img.shields.io/badge/Homebrew-FBB040?style=flat&logo=homebrew&logoColor=black)
![GNU Stow](https://img.shields.io/badge/GNU%20Stow-managed-blue?style=flat)

Personal dotfiles for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/). Configs are symlinked into `~/.config` via `.stowrc`.

## Install

Clone the repo and run the setup script — it handles everything:

```bash
git clone https://github.com/rogertinsley/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

This will:
1. Install Homebrew (if not already installed)
2. Install all packages from `Brewfile`
3. Symlink configs into `~/.config` (and `~/.zshrc` into `$HOME`) via `stow`
4. Install tmux plugins via TPM

After that, open a new shell and you're done. Neovim plugins install automatically on first launch.

## What's included

| Tool | Config |
|---|---|
| [Zsh](https://zsh.sourceforge.io) | `zsh/` |
| [Git](https://git-scm.com) (with [delta](https://github.com/dandavison/delta)) | `git/` |
| [Neovim](https://neovim.io) (LazyVim) | `nvim/` |
| [Tmux](https://github.com/tmux/tmux) | `tmux/` |
| [Zellij](https://zellij.dev) | `zellij/` |
| [Starship](https://starship.rs) | `starship/` |
| [Ghostty](https://ghostty.org) | `ghostty/` |
| [Alacritty](https://alacritty.org) | `alacritty/` |
| [k9s](https://k9scli.io) | `k9s/` |

Linux-only configs (Hyprland, etc.) live under `linux/` and are ignored by Stow on macOS.

## Local overrides

Machine-specific config (work credentials, tool paths, etc.) goes in `~/.zshrc.local`, which is sourced at the end of `.zshrc` but not tracked by this repo. For example:

```bash
# ~/.zshrc.local
export USE_GKE_GCLOUD_AUTH_PLUGIN=true
export PATH="$PATH:$HOME/.lmstudio/bin"
```

## Homebrew

```bash
# Back up current packages
brew bundle dump --force

# Install from Brewfile on a fresh machine
brew bundle
```
