# 優先度順（先頭が最優先）。新しいツールを追加する場合はここに追記する。
typeset -ga AI_CLI_PRIORITY=(claude codex)

# インストール済みの最優先ツール名を標準出力に返す。見つからなければ非ゼロで終了。
ai_cli_bin() {
  local tool
  for tool in "${AI_CLI_PRIORITY[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
      echo "$tool"
      return 0
    fi
  done
  return 1
}

# ツールが1つも見つからない場合に共通エラーメッセージを出して失敗する。
ai_cli_require() {
  local bin
  if ! bin=$(ai_cli_bin); then
    echo "AIツールが見つかりません（確認対象: ${AI_CLI_PRIORITY[*]}）。いずれかをインストールしてください。" >&2
    return 1
  fi
  echo "$bin"
}

# プロンプト全文(+文脈)を標準入力として渡し、検出したツールで実行する。
# Usage: ai_cli_run <prompt_text> [--model MODEL]
ai_cli_run() {
  local text="$1"
  shift
  local model=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --model) model="$2"; shift 2 ;;
      *) shift ;;
    esac
  done

  local bin
  bin=$(ai_cli_require) || return 1

  case "$bin" in
    claude)
      if [[ -n "$model" ]]; then
        printf '%s' "$text" | claude -p --model "$model"
      else
        printf '%s' "$text" | claude -p
      fi
      ;;
    codex)
      if [[ -n "$model" ]]; then
        printf '%s' "$text" | codex exec --model "$model" -
      else
        printf '%s' "$text" | codex exec -
      fi
      ;;
    *)
      echo "未対応のAIツールです: $bin" >&2
      return 1
      ;;
  esac
}
