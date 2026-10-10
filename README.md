# dotfiles

設定ファイルを管理するリポジトリ。

## 構成

```
.
├── install.sh
├── uninstall.sh
├── git/
│   ├── .gitconfig
│   └── bin/
├── bash/
│   ├── .bash_profile
│   └── functions/
└── zsh/
    ├── .zshrc
    └── functions/
```

## インストール方法

```sh
git clone <repository-url> <repository-path>
cd <repository-path>
chmod +x install.sh
./install.sh
```

`bash/.bash_profile` は Bash のログインシェル向け設定です。`bash/functions/` の関数もこの設定から読み込みます。`install.sh` は既存の `~/.bash_profile` がある場合に dotfiles の設定を追加します。

`git/bin/` のカスタム Git コマンドは Bash スクリプトとして実行されるため、Zsh と Bash のどちらからでも `git ps` などとして呼び出せます（Bash が必要です）。

## アンインストール方法

```bash
chmod +x uninstall.sh
./uninstall.sh
```
