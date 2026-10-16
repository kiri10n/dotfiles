#!/usr/bin/env bash

# dotfilesディレクトリの絶対パスを取得
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. .zshrc への追記処理
ZSHRC_LOAD_CMD="[ -f \"$DOTFILES_DIR/zsh/.zshrc\" ] && source \"$DOTFILES_DIR/zsh/.zshrc\""
if [ -f ~/.zshrc ]; then
  if ! grep -Fq "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc; then
    echo -e "\n# Load dotfiles config\n$ZSHRC_LOAD_CMD" >> ~/.zshrc
    echo "Added dotfiles source to ~/.zshrc"
  else
    echo "~/.zshrc is already configured."
  fi
else
  # .zshrc が存在しない場合は何もしない
  echo "~/.zshrc not found."
fi

# 2. .bashrc への追記処理
BASH_LOAD_CMD="[ -f \"$DOTFILES_DIR/bash/.bashrc\" ] && source \"$DOTFILES_DIR/bash/.bashrc\""
if [ -f ~/.bashrc ]; then
  if ! grep -Fq "$DOTFILES_DIR/bash/.bashrc" ~/.bashrc; then
    echo -e "\n# Load dotfiles config\n$BASH_LOAD_CMD" >> ~/.bashrc
    echo "Added dotfiles source to ~/.bashrc"
  else
    echo "~/.bashrc is already configured."
  fi
else
  # .bashrc が存在しない場合は何もしない
  echo "~/.bashrc not found."
fi

# 3. Git コマンドに実行権限を付与
GIT_BIN_DIR="$DOTFILES_DIR/git/bin"
if [ -d "$GIT_BIN_DIR" ]; then
  for git_command in "$GIT_BIN_DIR"/git-*; do
    [ -f "$git_command" ] || continue
    if ! chmod +x "$git_command"; then
      echo "Failed to make executable: $git_command" >&2
      exit 1
    fi
  done
else
  echo "Git command directory not found: $GIT_BIN_DIR" >&2
  exit 1
fi

echo "Git commands in $GIT_BIN_DIR are now executable."

# 4. .gitconfig への include 追加
# git config コマンドを使うことで既存設定を壊さず安全に追加できます
if ! git config --global --get-all include.path | grep -q "$DOTFILES_DIR/git/.gitconfig"; then
  git config --global --add include.path "$DOTFILES_DIR/git/.gitconfig"
  echo "Added include path to ~/.gitconfig"
else
  echo "~/.gitconfig is already configured."
fi

echo "Setup completed successfully!"