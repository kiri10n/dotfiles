export PATH="$HOME/.local/bin:$PATH"
export PATH="${${(%):-%x}:A:h:h}/git/bin:$PATH"

# ---------------------------------------------------------
# alias
# ---------------------------------------------------------
# Ref: https://github.com/monda00/dotfiles/blob/main/shell/zsh/zshrc

# ls
alias l='ls -l'
alias lts='ls -l --total-size'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# git
alias g='git'

# python
alias python="python3"
alias pip="pip3"

# k8s
alias kc="kubecolor"
alias k="kubectl"
alias kx="switch"
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

# tmuxinator
alias mux="tmuxinator"


_DOTFILES_ZSH_DIR="${${(%):-%x}:A:h}"
for f in "$_DOTFILES_ZSH_DIR"/functions/**/*.zsh(N) "$_DOTFILES_ZSH_DIR"/functions/*.zsh(N); do source "$f"; done
unset _DOTFILES_ZSH_DIR
