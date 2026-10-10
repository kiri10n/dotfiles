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

# 2. .bash_profile への追記処理
BASH_LOAD_CMD="[ -f \"$DOTFILES_DIR/bash/.bash_profile\" ] && source \"$DOTFILES_DIR/bash/.bash_profile\""
if [ -f ~/.bash_profile ]; then
  if ! grep -Fq "$DOTFILES_DIR/bash/.bash_profile" ~/.bash_profile; then
    echo -e "\n# Load dotfiles config\n$BASH_LOAD_CMD" >> ~/.bash_profile
    echo "Added dotfiles source to ~/.bash_profile"
  else
    echo "~/.bash_profile is already configured."
  fi
else
  # .bash_profile が存在しない場合は何もしない
  echo "~/.bash_profile not found."
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