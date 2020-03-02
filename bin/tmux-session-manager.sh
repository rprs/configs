#!/usr/bin/env bash
# Save and restore the state of tmux sessions and windows.
#
# Blatantly stolen from
# https://github.com/mislav/dotfiles/blob/master/bin/tmux-session

# Stop script if anything fails.
set -e

# Set ourselves in the correct directory
cd ~/

dump() {
  tmux list-windows -a -F "#S #{pane_current_path}"
}

save() {
  dump > ~/.tmux-session
}

session_exists() {
  tmux has-session -t "$1" 2>/dev/null
}

add_window() {
  tmux new-window -d -t "$1:" -c "$2"
}

new_session() {
  cd "$2" &&
  tmux new-session -d -s "$1"
}

restore() {
  tmux start-server
  local count=0

  while read session_name dir; do
    if [ -d "$dir" ]; then
      if session_exists "$session_name"; then
        add_window "$session_name" "$dir"
      else
        new_session "$session_name" "$dir"
        count=$(( count + 1 ))
      fi
    fi
  done < ~/.tmux-session

  echo "restored $count sessions"
}

case "$1" in
save | restore )
  $1
  ;;
* )
  echo "valid commands: save, restore" >&2
  exit 1
esac
