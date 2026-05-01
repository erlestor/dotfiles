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

# more goddamn padding fuckery
# printf '\x1b]1337;SetUserVar=NVIM=%s\x07' "$(printf '0' | base64)"
#
# # trying to fix padding in bash and no padding in neovim
# n() {
#   printf '\x1b]1337;SetUserVar=NVIM=%s\x07' "$(printf '1' | base64)"
#   command nvim "$@"
#   printf '\x1b]1337;SetUserVar=NVIM=%s\x07' "$(printf '0' | base64)"
# }
# nvim() {
#   printf '\x1b]1337;SetUserVar=NVIM=%s\x07' "$(printf '1' | base64)"
#   command nvim "$@"
#   printf '\x1b]1337;SetUserVar=NVIM=%s\x07' "$(printf '0' | base64)"
# }

function wssh() {
  wezterm connect SSHMUX:"$1"
}

# Hyprmcsr
export PATH="$PATH:/home/erlen/Programs/hyprmcsr/bin"
source /home/erlen/Programs/hyprmcsr/tab-completions/hyprmcsr.bash-completion

# Mise
eval "$(mise activate bash)"

# Prompt. Keep at the bottom
eval "$(oh-my-posh init bash --config "$HOME/.config/amro.omp.json")"
