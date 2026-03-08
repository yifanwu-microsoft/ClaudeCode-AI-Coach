#!/usr/bin/env bash
# install.sh — Install AI Coach System to ~/.claude/
# Usage: ./scripts/install.sh [--lang en|zh]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CLAUDE_HOME="$HOME/.claude"

MARKER_START="<!-- AI-COACH-START -->"
MARKER_END="<!-- AI-COACH-END -->"

# Default language: zh (Chinese)
LANG_CHOICE="zh"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --lang)
            LANG_CHOICE="$2"
            shift 2
            ;;
        --lang=*)
            LANG_CHOICE="${1#*=}"
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: ./scripts/install.sh [--lang en|zh]"
            exit 1
            ;;
    esac
done

# Validate language
if [[ "$LANG_CHOICE" != "en" && "$LANG_CHOICE" != "zh" ]]; then
    echo "Invalid language: $LANG_CHOICE (valid: en, zh)"
    exit 1
fi

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }

# Set source paths based on language
set_source_paths() {
    if [[ "$LANG_CHOICE" == "en" ]]; then
        CLAUDE_MD_SOURCE="$REPO_ROOT/en/CLAUDE.md"
        PROGRESS_SOURCE="$REPO_ROOT/en/PROGRESS.md"
        GUIDE_SOURCE="$REPO_ROOT/en/ai-engineering-leveling-guide.md"
        COMMANDS_SOURCE="$REPO_ROOT/en/commands"
    else
        CLAUDE_MD_SOURCE="$REPO_ROOT/CLAUDE.md"
        PROGRESS_SOURCE="$REPO_ROOT/PROGRESS.md"
        GUIDE_SOURCE="$REPO_ROOT/ai-engineering-leveling-guide.md"
        COMMANDS_SOURCE="$REPO_ROOT/.claude/commands"
    fi
}

main() {
    set_source_paths

    if [[ "$LANG_CHOICE" == "en" ]]; then
        info "Installing AI Coach System (English) to $CLAUDE_HOME ..."
    else
        info "开始安装 AI 教练系统到 $CLAUDE_HOME ..."
    fi

    # Create directories
    mkdir -p "$CLAUDE_HOME/commands"

    # 1. Sync commands/
    if [ -d "$COMMANDS_SOURCE" ]; then
        cp -f "$COMMANDS_SOURCE/"*.md "$CLAUDE_HOME/commands/" 2>/dev/null || true
        info "Commands installed"
    fi

    # 2. Sync CLAUDE.md (marker block merge)
    if [ ! -f "$CLAUDE_MD_SOURCE" ]; then
        warn "CLAUDE.md source not found at $CLAUDE_MD_SOURCE"
        warn "Falling back to default (Chinese) CLAUDE.md"
        CLAUDE_MD_SOURCE="$REPO_ROOT/CLAUDE.md"
    fi

    local source_content
    source_content=$(cat "$CLAUDE_MD_SOURCE")

    local target_file="$CLAUDE_HOME/CLAUDE.md"
    local tmp_block
    tmp_block=$(mktemp)
    printf '%s\n%s\n%s\n' "$MARKER_START" "$source_content" "$MARKER_END" > "$tmp_block"

    if [ -f "$target_file" ]; then
        local target_content
        target_content=$(cat "$target_file")
        if echo "$target_content" | grep -qF "$MARKER_START"; then
            awk -v start="$MARKER_START" -v end="$MARKER_END" -v blockfile="$tmp_block" '
                $0 == start { skip=1; while ((getline line < blockfile) > 0) print line; close(blockfile); next }
                $0 == end { skip=0; next }
                !skip { print }
            ' "$target_file" > "$target_file.tmp"
            mv "$target_file.tmp" "$target_file"
            info "CLAUDE.md coach block updated (preserving existing rules)"
        else
            printf '\n\n' >> "$target_file"
            cat "$tmp_block" >> "$target_file"
            info "CLAUDE.md coach block appended (existing rules unaffected)"
        fi
    else
        cp "$tmp_block" "$target_file"
        info "CLAUDE.md created"
    fi
    rm -f "$tmp_block"

    # 3. Sync PROGRESS.md (only create if not exists — protect local progress)
    if [ -f "$CLAUDE_HOME/PROGRESS.md" ]; then
        if [[ "$LANG_CHOICE" == "en" ]]; then
            warn "PROGRESS.md already exists, skipping (protecting local progress)"
            warn "To reset, manually delete ~/.claude/PROGRESS.md and re-run install"
        else
            warn "PROGRESS.md 已存在，跳过（保护本机进度）"
            warn "如需重置，请手动删除 ~/.claude/PROGRESS.md 后重新安装"
        fi
    else
        if [ -f "$PROGRESS_SOURCE" ]; then
            cp -f "$PROGRESS_SOURCE" "$CLAUDE_HOME/PROGRESS.md"
        else
            cp -f "$REPO_ROOT/PROGRESS.md" "$CLAUDE_HOME/PROGRESS.md"
        fi
        info "PROGRESS.md created"
    fi

    # 4. Sync guide
    if [ -f "$GUIDE_SOURCE" ]; then
        cp -f "$GUIDE_SOURCE" "$CLAUDE_HOME/ai-engineering-leveling-guide.md"
        info "Guide installed"
    elif [ -f "$REPO_ROOT/ai-engineering-leveling-guide.md" ]; then
        cp -f "$REPO_ROOT/ai-engineering-leveling-guide.md" "$CLAUDE_HOME/ai-engineering-leveling-guide.md"
        info "Guide installed (fallback to Chinese)"
    fi

    echo ""
    if [[ "$LANG_CHOICE" == "en" ]]; then
        info "✅ Installation complete! AI Coach is now globally active."
        info "Open Claude Code in any project and run /assess for initial evaluation."
    else
        info "✅ 安装完成！教练系统已在本机全局生效。"
        info "在任何项目中打开 Claude Code，执行 /assess 进行首次评估。"
    fi
}

main
