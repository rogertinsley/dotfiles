eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
eval "$(tv init zsh)"

# fzf completion only (atuin + tv handle keybindings)
source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
