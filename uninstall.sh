#!/usr/bin/env bash

# dotfilesディレクトリの絶対パスを取得
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Uninstalling dotfiles configuration..."

# 1. .zshrc から追記行を削除
if [ -f ~/.zshrc ] && grep -Fq "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc; then
  # バックアップを作成
  cp ~/.zshrc ~/.zshrc.bak
  # 該当する行を取り除いて上書き
  grep -vF "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc | grep -v "# Load dotfiles config" > ~/.zshrc.tmp
  mv ~/.zshrc.tmp ~/.zshrc
  echo "Removed dotfiles setting from ~/.zshrc (Backup: ~/.zshrc.bak)"
else
  echo "No dotfiles setting found in ~/.zshrc"
fi

# 2. .bashrc から追記行を削除
if [ -f ~/.bashrc ] && grep -Fq "$DOTFILES_DIR/bash/.bashrc" ~/.bashrc; then
  cp ~/.bashrc ~/.bashrc.bak
  grep -vF "$DOTFILES_DIR/bash/.bashrc" ~/.bashrc | grep -v "# Load dotfiles config" > ~/.bashrc.tmp
  mv ~/.bashrc.tmp ~/.bashrc
  echo "Removed dotfiles setting from ~/.bashrc (Backup: ~/.bashrc.bak)"
else
  echo "No dotfiles setting found in ~/.bashrc"
fi

# 3. .gitconfig から include 設定を削除
if git config --global --get-all include.path | grep -q "$DOTFILES_DIR/git/.gitconfig"; then
  git config --global --unset-all include.path "$DOTFILES_DIR/git/.gitconfig"
  echo "Removed include path from ~/.gitconfig"
else
  echo "No dotfiles include found in ~/.gitconfig"
fi

echo "Uninstallation completed successfully!"