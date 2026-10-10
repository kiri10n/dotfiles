_DOTFILES_BASH_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
_DOTFILES_DIR="$(cd -- "$_DOTFILES_BASH_DIR/.." && pwd)"
export PATH="$HOME/.local/bin:$_DOTFILES_DIR/git/bin:$PATH"

# ls
alias l='ls -l'
alias lts='ls -l --total-size'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# git
alias g='git'

# python
alias python='python3'
alias pip='pip3'

# k8s
alias kc='kubecolor'
alias k='kubectl'
alias kx='switch'
[[ -f "$HOME/.kubectl_aliases" ]] && source "$HOME/.kubectl_aliases"

# tmuxinator
alias mux='tmuxinator'

for _function_file in "$_DOTFILES_BASH_DIR"/functions/*.bash; do
  [[ -f "$_function_file" ]] && source "$_function_file"
done
unset _DOTFILES_BASH_DIR _DOTFILES_DIR _function_file
