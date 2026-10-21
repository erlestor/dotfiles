# not in my bashrc (or hidden in omarchy config)
eval "$(/Users/erlen/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"
alias n="nvim"
alias cd="z"

# shared with bash
alias e="exit"
alias c="clear"
alias p="pnpm"
alias lg="lazygit"

function cdn() {
  cd "$1" && nvim .
}

function sd() {
  cd $home && cd $(find . | fzf)
}

function lfcd() {
  cd "$(command lf --print-last-dir)"
}
alias lf="lfcd"

# better ls, file listing, with eza. copied from omarchy
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi
