# Safety nets
# alias rm="$HOMEBREW_PREFIX/opt/trash/bin/trash"
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
