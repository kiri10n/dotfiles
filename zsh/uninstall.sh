#!/usr/bin/env bash

# dotfilesディレクトリの絶対パスを取得
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Uninstalling dotfiles configuration..."

# 1. .zshrc から追記行を削除
if [ -f ~/.zshrc ] && grep -Fq "$DOTFILES_DIR/.zshrc" ~/.zshrc; then
  # バックアップを作成
  cp ~/.zshrc ~/.zshrc.bak
  # 該当する行を取り除いて上書き
  grep -vF "$DOTFILES_DIR/.zshrc" ~/.zshrc | grep -v "# Load dotfiles config" > ~/.zshrc.tmp
  mv ~/.zshrc.tmp ~/.zshrc
  echo "Removed dotfiles setting from ~/.zshrc (Backup: ~/.zshrc.bak)"
else
  echo "No dotfiles setting found in ~/.zshrc"
fi

# 2. .bash_profile から追記行を削除
if [ -f ~/.bash_profile ] && grep -Fq "$DOTFILES_DIR/.bash_profile" ~/.bash_profile; then
  cp ~/.bash_profile ~/.bash_profile.bak
  grep -vF "$DOTFILES_DIR/.bash_profile" ~/.bash_profile | grep -v "# Load dotfiles config" > ~/.bash_profile.tmp
  mv ~/.bash_profile.tmp ~/.bash_profile
  echo "Removed dotfiles setting from ~/.bash_profile (Backup: ~/.bash_profile.bak)"
else
  echo "No dotfiles setting found in ~/.bash_profile"
fi

# 3. .gitconfig から include 設定を削除
if git config --global --get-all include.path | grep -q "$DOTFILES_DIR/.gitconfig"; then
  git config --global --unset-all include.path "$DOTFILES_DIR/.gitconfig"
  echo "Removed include path from ~/.gitconfig"
else
  echo "No dotfiles include found in ~/.gitconfig"
fi

echo "Uninstallation completed successfully!"