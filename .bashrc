# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Enable hashing again
set -h

alias e="exit"
alias c="clear"
alias p="pnpm"
alias lg="lazygit"

function wssh() {
  wezterm connect SSHMUX:"$1"
}

# Hyprmcsr
export PATH="$PATH:/home/erlen/Programs/hyprmcsr/bin"
source /home/erlen/Programs/hyprmcsr/tab-completions/hyprmcsr.bash-completion

# PROMPT
eval "$(oh-my-posh init bash --config "$HOME/.config/amro.omp.json")"
