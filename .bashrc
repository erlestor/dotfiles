[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Enable hashing again. (future: i guess omarchy turns it off)
set -h

alias e="exit"
alias c="clear"
alias p="pnpm"
alias lg="lazygit"

function wssh() {
  wezterm connect SSHMUX:"$1"
}

set -o vi
export POSH_VI_MODE="INSERT"

function _update_vi_mode() {
  case $READLINE_MARK in
    *) ;;
  esac
}
# Use bind to detect mode switch (bash 5+)
bind 'set show-mode-in-prompt on'   # optional: shows a built-in indicator too

# Hyprmcsr
export PATH="$PATH:/home/erlen/Programs/hyprmcsr/bin"
source /home/erlen/Programs/hyprmcsr/tab-completions/hyprmcsr.bash-completion

# Mise - not needec because omarchy defaults
# eval "$(mise activate bash)"

# Prompt. Keep at the bottom
eval "$(oh-my-posh init bash --config "$HOME/.config/amro.omp.json")"
