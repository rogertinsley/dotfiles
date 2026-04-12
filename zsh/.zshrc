export HOMEBREW_PREFIX="/opt/homebrew"

# Shell options
setopt AUTO_CD               # `foo/bar` -> cd foo/bar
setopt AUTO_PUSHD            # cd pushes to dir stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt EXTENDED_GLOB         # **/*, ^pattern, *(.), etc.
setopt INTERACTIVE_COMMENTS  # allow # comments at interactive prompt
setopt NO_BEEP
setopt NO_CLOBBER            # > won't overwrite; use >| to force
bindkey -v                   # vi mode

# Treat / and . as word boundaries so Ctrl-W deletes path segments
WORDCHARS='*?_-[]~&;!#$%^(){}<>'

# Completion system
# Only do the slow security check once per day
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' menu select                          # arrow-key menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Environment
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export USE_GKE_GCLOUD_AUTH_PLUGIN=true
export GOOGLE_GENAI_USE_VERTEXAI=true
export PATH="$HOME/.local/bin:$PATH:$HOME/.lmstudio/bin"

# Safety nets
alias rm="$HOMEBREW_PREFIX/opt/trash/bin/trash"
alias cp='cp -i'
alias mv='mv -i'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias o='open .'
alias cpwd='pwd | pbcopy'

# Modern replacements
alias ls='eza -lh --group-directories-first --icons'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias bcat='bat'
alias du='dust'
alias df='duf'
alias ps='procs'
alias grep='grep --color=auto'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

# Shortcuts
alias n='nvim'
alias g='git'
alias d='docker'
alias y='yarn'

# Git
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate -20'
alias gp='git push'
alias gpl='git pull'
alias ga='git add'
alias gaa='git add -A'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git commit -m'
alias aliro='zellij --layout ~/.config/zellij/layout.kdl'

# tmux helpers
tn() {
  tmux new-session -s "${1:?session name required}"
}
ta() {
  tmux a
}

# kubectl completion (cached for faster startup)
if [[ $+commands[kubectl] == 1 ]]; then
  _kubectl_cache=~/.cache/zsh/kubectl_completion
  if [[ ! -f $_kubectl_cache || $_kubectl_cache -ot $commands[kubectl] ]]; then
    mkdir -p ${_kubectl_cache:h}
    kubectl completion zsh > $_kubectl_cache
  fi
  source $_kubectl_cache
  unset _kubectl_cache
fi

# Tool inits
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"

# fzf key bindings + completion (static sources, no subshell at startup)
source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"

# Plugins (must be sourced last; syntax-highlighting must be last of the two)
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^[[A' history-substring-search-up    # Up arrow
bindkey '^[[B' history-substring-search-down  # Down arrow
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
