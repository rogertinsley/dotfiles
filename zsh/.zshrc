# Custom functions (autoloaded from ~/.zsh/functions)
fpath=(~/.zsh/functions $fpath)
autoload -Uz ~/.zsh/functions/*(.:t)

# Source configs
for config (~/.zsh/configs/*.zsh(N)) source "$config"

# Source post configs (order-dependent, loaded last)
for config (~/.zsh/configs/post/*.zsh(N)) source "$config"

# Local overrides (machine-specific, not checked in)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
