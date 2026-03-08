#!/usr/bin/env bash
# install.sh — 将 AI 教练系统安装到本机 ~/.claude/
# 用法：./scripts/install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CLAUDE_HOME="$HOME/.claude"

MARKER_START="<!-- AI-COACH-START -->"
MARKER_END="<!-- AI-COACH-END -->"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }

main() {
    info "开始安装 AI 教练系统到 $CLAUDE_HOME ..."

    # 创建目录
    mkdir -p "$CLAUDE_HOME/commands"

    # 1. 同步 commands/（直接覆盖教练系统的文件）
    if [ -d "$REPO_ROOT/.claude/commands" ]; then
        cp -f "$REPO_ROOT/.claude/commands/"*.md "$CLAUDE_HOME/commands/" 2>/dev/null || true
        info "Commands 已安装"
    fi

    # 2. 同步 CLAUDE.md（标记块合并，不覆盖用户自己的规则）
    local source_content
    source_content=$(cat "$REPO_ROOT/CLAUDE.md")
    local coach_block
    coach_block=$(printf '%s\n%s\n%s' "$MARKER_START" "$source_content" "$MARKER_END")

    local target_file="$CLAUDE_HOME/CLAUDE.md"
    if [ -f "$target_file" ]; then
        local target_content
        target_content=$(cat "$target_file")
        if echo "$target_content" | grep -qF "$MARKER_START"; then
            awk -v start="$MARKER_START" -v end="$MARKER_END" -v new="$coach_block" '
                $0 == start { skip=1; print new; next }
                $0 == end { skip=0; next }
                !skip { print }
            ' "$target_file" > "$target_file.tmp"
            mv "$target_file.tmp" "$target_file"
            info "CLAUDE.md 教练块已更新（保留原有规则）"
        else
            printf '\n\n%s\n' "$coach_block" >> "$target_file"
            info "CLAUDE.md 教练块已追加（原有规则不受影响）"
        fi
    else
        echo "$coach_block" > "$target_file"
        info "CLAUDE.md 已创建"
    fi

    # 3. 同步 PROGRESS.md（仅在不存在时创建，保护本机已有进度）
    if [ -f "$CLAUDE_HOME/PROGRESS.md" ]; then
        warn "PROGRESS.md 已存在，跳过（保护本机进度）"
        warn "如需重置，请手动删除 ~/.claude/PROGRESS.md 后重新安装"
    else
        cp -f "$REPO_ROOT/PROGRESS.md" "$CLAUDE_HOME/PROGRESS.md"
        info "PROGRESS.md 已创建（初始状态）"
    fi

    # 4. 同步参考文档
    if [ -f "$REPO_ROOT/ai-engineering-leveling-guide.md" ]; then
        cp -f "$REPO_ROOT/ai-engineering-leveling-guide.md" "$CLAUDE_HOME/ai-engineering-leveling-guide.md"
        info "参考文档已同步"
    fi

    echo ""
    info "✅ 安装完成！教练系统已在本机全局生效。"
    info "在任何项目中打开 Claude Code，执行 /assess 进行首次评估。"
}

main
