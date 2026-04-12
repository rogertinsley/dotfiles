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
