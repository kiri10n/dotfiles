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
git clone <repository-url>
cd dotfiles
chmod +x install.sh
./install.sh
```

## アンインストール方法

```bash
chmod +x uninstall.sh
./uninstall.sh
```
