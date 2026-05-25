#!/usr/bin/env bash
set -euo pipefail

CONF="$HOME/.config/tmux/dirs.conf"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

preview_cmd='
  item=$(echo {} | sed "s/\x1b\[[0-9;]*m//g; s/^��� //")
  if [ -d "$item" ]; then
    branch=$(git -C "$item" branch --show-current 2>/dev/null)
    echo "📂 $(basename "$item")${branch:+  $branch}"
    echo ""
    ls -1 --color=always "$item" 2>/dev/null | head -20
  elif tmux has-session -t="$item" 2>/dev/null; then
    tmux capture-pane -t="$item" -p -e 2>/dev/null | tail -20
  else
    echo "New session: $item"
  fi
'

kill_cmd='
  item=$(echo {} | sed "s/\x1b\[[0-9;]*m//g; s/^● //")
  current=$(tmux display-message -p "#S" 2>/dev/null)
  if [ "$item" = "$current" ]; then
    exit 0
  fi
  if tmux has-session -t="$item" 2>/dev/null; then
    tmux kill-session -t="$item"
  fi
'

dirs=""
if [[ -f "$CONF" ]]; then
  dirs=$(sed "s|^~|$HOME|" "$CONF")
fi

current_session=$(tmux display-message -p '#S' 2>/dev/null)
session_names=$(tmux list-sessions -F '#S' 2>/dev/null)

list_items() {
  if [[ -n "$session_names" ]]; then
    echo "$session_names" | while read -r name; do
      if [[ "$name" == "$current_session" ]]; then
        printf '\033[32m●\033[0m %s\n' "$name"
      else
        printf '● %s\n' "$name"
      fi
    done
  fi
  if [[ -n "$dirs" ]]; then
    echo "$dirs" | while read -r d; do
      [[ -d "$d" ]] || continue
      fd . "$d" --type d --max-depth 1
    done | while read -r dir; do
      name=$(basename "$dir" | tr . _)
      if ! echo "$session_names" | grep -qx "$name"; then
        echo "$dir"
      fi
    done
  fi
}

export ORBIT_CURRENT="$current_session"
export ORBIT_DIRS="$dirs"

reload_cmd='
  sessions=$(tmux list-sessions -F "#S" 2>/dev/null)
  current="$ORBIT_CURRENT"
  if [ -n "$sessions" ]; then
    echo "$sessions" | while read -r name; do
      if [ "$name" = "$current" ]; then
        printf "\033[32m●\033[0m %s\n" "$name"
      else
        printf "● %s\n" "$name"
      fi
    done
  fi
  if [ -n "$ORBIT_DIRS" ]; then
    echo "$ORBIT_DIRS" | while read -r d; do
      [ -d "$d" ] || continue
      fd . "$d" --type d --max-depth 1
    done | while read -r dir; do
      name=$(basename "$dir" | tr . _)
      if ! echo "$sessions" | grep -qx "$name"; then
        echo "$dir"
      fi
    done
  fi
'

selected=$(
  list_items | fzf \
    --ansi \
    --print-query \
    --prompt='  ' \
    --layout=reverse \
    --preview "$preview_cmd" \
    --preview-window=right,50% \
    --bind "ctrl-x:execute-silent($kill_cmd)+reload($reload_cmd)" \
    --header='ctrl-x: kill session' \
  | tail -1
) || true

[[ -z "$selected" ]] && exit 0

selected=$(echo "$selected" | sed $'s/\033\\[[0-9;]*m//g; s/^● //')

if [[ -d "$selected" ]]; then
  name=$(basename "$selected" | tr . _)
  if ! tmux has-session -t="$name" 2>/dev/null; then
    tmux new-session -d -s "$name" -c "$selected"
  fi
  tmux switch-client -t "$name"
elif tmux has-session -t="$selected" 2>/dev/null; then
  tmux switch-client -t "$selected"
else
  name=$(echo "$selected" | tr ' ./' '_')
  tmux new-session -d -s "$name"
  tmux switch-client -t "$name"
fi
