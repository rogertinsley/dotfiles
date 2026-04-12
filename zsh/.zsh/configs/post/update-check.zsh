# Dotfiles update check (once per day)
() {
  local dotfiles=~/dotfiles
  local stamp=~/.cache/zsh/dotfiles-update
  local days=1

  [[ -d "$dotfiles/.git" ]] || return
  mkdir -p "${stamp:h}"

  if [[ -f "$stamp" ]]; then
    local last=$(<"$stamp")
    local now=$(( EPOCHSECONDS / 86400 ))
    (( now - last < days )) && return
  fi

  echo $(( EPOCHSECONDS / 86400 )) > "$stamp"
  git -C "$dotfiles" fetch --quiet 2>/dev/null

  local local_sha=$(git -C "$dotfiles" rev-parse HEAD)
  local remote_sha=$(git -C "$dotfiles" rev-parse @{u} 2>/dev/null)
  [[ "$local_sha" == "$remote_sha" ]] && return

  echo "\n[dotfiles] Updates available."
  read -q "reply?Update now? [y/N] " && echo
  if [[ "$reply" == "y" ]]; then
    git -C "$dotfiles" pull --rebase --quiet && \
    echo "[dotfiles] Updated." && exec zsh
  fi
  echo
}
