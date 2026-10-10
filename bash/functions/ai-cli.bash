# 優先度順（先頭が最優先）。新しいツールを追加する場合はここに追記する。
AI_CLI_PRIORITY=(claude codex)

# インストール済みの最優先ツール名を標準出力に返す。見つからなければ非ゼロで終了。
ai_cli_bin() {
  local tool
  for tool in "${AI_CLI_PRIORITY[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
      printf '%s\n' "$tool"
      return 0
    fi
  done
  return 1
}

# ツールが1つも見つからない場合に共通エラーメッセージを出して失敗する。
ai_cli_require() {
  local bin
  if ! bin=$(ai_cli_bin); then
    printf 'AIツールが見つかりません（確認対象: %s）。いずれかをインストールしてください。\n' "${AI_CLI_PRIORITY[*]}" >&2
    return 1
  fi
  printf '%s\n' "$bin"
}

# プロンプト全文(+文脈)を標準入力として渡し、検出したツールで実行する。
# Usage: ai_cli_run <prompt_text> [--model MODEL]
ai_cli_run() {
  local text="${1-}"
  if [[ $# -gt 0 ]]; then
    shift
  fi

  local model=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --model)
        if [[ $# -lt 2 ]]; then
          printf '%s\n' "--model にはモデル名が必要です。" >&2
          return 2
        fi
        model="$2"
        shift 2
        ;;
      *)
        shift
        ;;
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
      printf '未対応のAIツールです: %s\n' "$bin" >&2
      return 1
      ;;
  esac
}
