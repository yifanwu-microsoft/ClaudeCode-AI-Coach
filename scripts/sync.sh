#!/usr/bin/env bash
# sync.sh — 将 AI 教练系统同步到/从全局 ~/.claude/ 目录
# 用法：
#   ./scripts/sync.sh push   — 部署 repo 配置到本机 ~/.claude/
#   ./scripts/sync.sh pull   — 拉取本机 ~/.claude/PROGRESS.md 回 repo

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CLAUDE_HOME="$HOME/.claude"

MARKER_START="<!-- AI-COACH-START -->"
MARKER_END="<!-- AI-COACH-END -->"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

push_to_global() {
    info "开始部署到 $CLAUDE_HOME ..."

    # 创建目录
    mkdir -p "$CLAUDE_HOME/commands"

    # 1. 同步 commands/（直接覆盖我们的文件）
    if [ -d "$REPO_ROOT/.claude/commands" ]; then
        cp -f "$REPO_ROOT/.claude/commands/"*.md "$CLAUDE_HOME/commands/" 2>/dev/null || true
        info "Commands 已同步"
    fi

    # 2. 同步 CLAUDE.md（标记块合并）
    local source_content
    source_content=$(cat "$REPO_ROOT/CLAUDE.md")
    local coach_block
    coach_block=$(printf '%s\n%s\n%s' "$MARKER_START" "$source_content" "$MARKER_END")

    local target_file="$CLAUDE_HOME/CLAUDE.md"
    if [ -f "$target_file" ]; then
        local target_content
        target_content=$(cat "$target_file")
        if echo "$target_content" | grep -qF "$MARKER_START"; then
            # 替换已有的教练块
            # 使用 awk 精确替换标记块之间的内容
            awk -v start="$MARKER_START" -v end="$MARKER_END" -v new="$coach_block" '
                $0 == start { skip=1; print new; next }
                $0 == end { skip=0; next }
                !skip { print }
            ' "$target_file" > "$target_file.tmp"
            mv "$target_file.tmp" "$target_file"
            info "CLAUDE.md 教练块已更新（保留原有规则）"
        else
            # 追加教练块
            printf '\n\n%s\n' "$coach_block" >> "$target_file"
            info "CLAUDE.md 教练块已追加（原有规则不受影响）"
        fi
    else
        echo "$coach_block" > "$target_file"
        info "CLAUDE.md 已创建"
    fi

    # 3. 同步 PROGRESS.md（直接覆盖）
    cp -f "$REPO_ROOT/PROGRESS.md" "$CLAUDE_HOME/PROGRESS.md"
    info "PROGRESS.md 已同步"

    # 4. 同步参考文档
    if [ -f "$REPO_ROOT/ai-engineering-leveling-guide.md" ]; then
        cp -f "$REPO_ROOT/ai-engineering-leveling-guide.md" "$CLAUDE_HOME/ai-engineering-leveling-guide.md"
        info "参考文档已同步"
    fi

    echo ""
    info "✅ 部署完成！教练系统已在本机全局生效。"
    info "在任何项目中打开 Claude Code 即可使用。"
}

pull_from_global() {
    info "从 $CLAUDE_HOME 拉取进度 ..."

    # 拉取 PROGRESS.md
    local global_progress="$CLAUDE_HOME/PROGRESS.md"
    if [ -f "$global_progress" ]; then
        cp -f "$global_progress" "$REPO_ROOT/PROGRESS.md"
        info "✅ PROGRESS.md 已拉取到 repo"
        echo ""
        info "下一步：git add PROGRESS.md && git commit -m 'chore: sync progress' && git push"
    else
        warn "未找到 $global_progress，无需拉取"
    fi
}

# 主逻辑
case "${1:-}" in
    push)
        push_to_global
        ;;
    pull)
        pull_from_global
        ;;
    *)
        echo "AI 工程能力教练系统 — 同步工具"
        echo ""
        echo "用法："
        echo "  $0 push   将 repo 配置部署到本机 ~/.claude/"
        echo "  $0 pull   将本机 ~/.claude/PROGRESS.md 拉回 repo"
        echo ""
        echo "典型工作流："
        echo "  练完后：$0 pull && git add -A && git commit -m 'sync' && git push"
        echo "  换电脑：git pull && $0 push"
        exit 1
        ;;
esac
