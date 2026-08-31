## aliases

# force tmux to use colors
alias tmux='tmux -2'

# Allow for forward search with C^s in reverse history search (C^r)
stty -ixon

# open android studio
alias android-studio=~/android-studio/bin/studio.sh

# nvim alias
alias nvim=/usr/local/bin/nvim

# Ensure I can use fzf.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Deno (js runtime, used for yt-dlp).
# Sources Deno's env script, which adds ~/.deno/bin to PATH
. "/home/rprs/.deno/env"

# Deno (js runtime, used for yt-dlp).
# Registers the bash tab-completion function.
source /home/rprs/.local/share/bash-completion/completions/deno.bash
