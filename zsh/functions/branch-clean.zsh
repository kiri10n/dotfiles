branch-clean() {
    # https://qiita.com/hiranuma/items/59069a7f4f39309bda8b
    git branch --merged | grep -v '*' | grep -vE '^\s*(main|master)$' | xargs git branch -d
}