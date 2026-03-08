#!/usr/bin/env bash
# uninstall.sh — Remove AI Coach System from ~/.claude/
# Usage: ./scripts/uninstall.sh [--keep-progress] [--lang en|zh]

set -euo pipefail

CLAUDE_HOME="$HOME/.claude"

MARKER_START="<!-- AI-COACH-START -->"
MARKER_END="<!-- AI-COACH-END -->"

# Coach command files installed by install.sh
COACH_COMMANDS=(
    "assess.md"
    "install.md"
    "uninstall.md"
    "practice.md"
    "progress-report.md"
    "review-prompt.md"
    "i18n.md"
)

# Default options
KEEP_PROGRESS=0
LANG_CHOICE="zh"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --keep-progress)
            KEEP_PROGRESS=1
            shift
            ;;
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
            echo "Usage: ./scripts/uninstall.sh [--keep-progress] [--lang en|zh]"
            exit 1
            ;;
    esac
done

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
err()   { echo -e "${RED}[ERROR]${NC} $1"; }

# Remove coach command files from ~/.claude/commands/
remove_commands() {
    local commands_dir="$CLAUDE_HOME/commands"
    local removed=0

    if [ ! -d "$commands_dir" ]; then
        info "No commands directory found, skipping"
        return
    fi

    for cmd in "${COACH_COMMANDS[@]}"; do
        local cmd_path="$commands_dir/$cmd"
        if [ -f "$cmd_path" ]; then
            rm -f "$cmd_path"
            removed=$((removed + 1))
        fi
    done

    info "Removed $removed command file(s)"

    # Remove commands/ dir if empty
    if [ -d "$commands_dir" ] && [ -z "$(ls -A "$commands_dir" 2>/dev/null)" ]; then
        rmdir "$commands_dir"
        info "Removed empty commands/ directory"
    fi
}

# Remove AI-COACH marker block from CLAUDE.md
remove_claude_block() {
    local target_file="$CLAUDE_HOME/CLAUDE.md"

    if [ ! -f "$target_file" ]; then
        info "No CLAUDE.md found, skipping"
        return
    fi

    if ! grep -q "AI-COACH-START" "$target_file"; then
        info "No AI Coach block found in CLAUDE.md, skipping"
        return
    fi

    # Backup before modifying
    cp "$target_file" "$target_file.bak"
    info "Backed up CLAUDE.md to CLAUDE.md.bak"

    # Remove the marker block and trim blank lines
    # Use index() for substring matching instead of exact $0 == to handle
    # trailing whitespace, BOM, or encoding variations
    awk -v start="AI-COACH-START" -v end="AI-COACH-END" '
        index($0, start) > 0 { skip=1; next }
        index($0, end) > 0   { skip=0; next }
        !skip                 { print }
    ' "$target_file.bak" | awk '
        # Trim leading and trailing blank lines
        NF { found=1 }
        found { lines[++n] = $0 }
        END {
            # Remove trailing blank lines
            while (n > 0 && lines[n] == "") n--
            for (i = 1; i <= n; i++) print lines[i]
        }
    ' > "$target_file.tmp"

    # Secondary check: verify no coach content leaked through
    if grep -qF "AI Coach Assessment" "$target_file.tmp" 2>/dev/null && \
       grep -qF "PROGRESS.md" "$target_file.tmp" 2>/dev/null && \
       grep -qF "sub-skill" "$target_file.tmp" 2>/dev/null; then
        warn "Residual coach content detected after marker removal, performing fallback cleanup"
        # Fallback: use sed to remove everything between markers (inclusive)
        sed -n '/AI-COACH-START/,/AI-COACH-END/!p' "$target_file.bak" > "$target_file.tmp"
    fi

    # Check if file is empty after removing the block
    if [ ! -s "$target_file.tmp" ] || ! grep -q '[^[:space:]]' "$target_file.tmp"; then
        rm -f "$target_file" "$target_file.tmp"
        info "CLAUDE.md was coach-only, removed entirely"
    else
        mv "$target_file.tmp" "$target_file"
        info "AI Coach block removed from CLAUDE.md (user rules preserved)"
    fi
}

# Remove PROGRESS.md
remove_progress() {
    local progress_file="$CLAUDE_HOME/PROGRESS.md"

    if [ ! -f "$progress_file" ]; then
        info "No PROGRESS.md found, skipping"
        return
    fi

    if [ "$KEEP_PROGRESS" -eq 1 ]; then
        warn "Keeping PROGRESS.md (--keep-progress flag set)"
        return
    fi

    rm -f "$progress_file"
    info "PROGRESS.md removed"
}

# Remove guide file
remove_guide() {
    local guide_file="$CLAUDE_HOME/ai-engineering-leveling-guide.md"

    if [ -f "$guide_file" ]; then
        rm -f "$guide_file"
        info "ai-engineering-leveling-guide.md removed"
    else
        info "No guide file found, skipping"
    fi
}

# Remove backup files created during install
remove_backups() {
    local claude_bak="$CLAUDE_HOME/CLAUDE.md.bak"
    if [ -f "$claude_bak" ]; then
        rm -f "$claude_bak"
        info "Removed CLAUDE.md.bak"
    fi
}

# Verify uninstall
verify_uninstall() {
    local has_error=0

    info "Running post-uninstall verification..."

    # Check coach commands are gone
    for cmd in "${COACH_COMMANDS[@]}"; do
        if [ -f "$CLAUDE_HOME/commands/$cmd" ]; then
            err "Verification failed: $cmd still exists in $CLAUDE_HOME/commands/"
            has_error=1
        fi
    done

    # Check CLAUDE.md marker block is gone
    if [ -f "$CLAUDE_HOME/CLAUDE.md" ]; then
        if grep -q "AI-COACH-START" "$CLAUDE_HOME/CLAUDE.md"; then
            err "Verification failed: AI Coach block still present in CLAUDE.md"
            has_error=1
        fi
    fi

    # Check guide is gone
    if [ -f "$CLAUDE_HOME/ai-engineering-leveling-guide.md" ]; then
        err "Verification failed: ai-engineering-leveling-guide.md still exists"
        has_error=1
    fi

    # Check PROGRESS.md (only if not keeping)
    if [ "$KEEP_PROGRESS" -eq 0 ] && [ -f "$CLAUDE_HOME/PROGRESS.md" ]; then
        err "Verification failed: PROGRESS.md still exists"
        has_error=1
    fi

    if [ "$has_error" -eq 1 ]; then
        err "Post-uninstall verification failed. Some files may remain."
        return 1
    fi

    info "Post-uninstall verification passed ✅"
}

main() {
    if [[ "$LANG_CHOICE" == "en" ]]; then
        info "Uninstalling AI Coach System from $CLAUDE_HOME ..."
    else
        info "正在从 $CLAUDE_HOME 卸载 AI 教练系统 ..."
    fi

    # Confirm uninstall
    if [[ "$LANG_CHOICE" == "en" ]]; then
        printf "Are you sure you want to uninstall? [y/N]: "
    else
        printf "确定要卸载吗？[y/N]: "
    fi
    read -r confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        if [[ "$LANG_CHOICE" == "en" ]]; then
            info "Uninstall cancelled."
        else
            info "卸载已取消。"
        fi
        exit 0
    fi

    # Step 1: Remove commands
    remove_commands

    # Step 2: Remove coach block from CLAUDE.md
    remove_claude_block

    # Step 3: Remove PROGRESS.md (unless --keep-progress)
    remove_progress

    # Step 4: Remove guide
    remove_guide

    # Step 5: Clean up backups
    remove_backups

    # Step 6: Verify
    verify_uninstall

    echo ""
    if [[ "$LANG_CHOICE" == "en" ]]; then
        info "✅ Uninstall complete! AI Coach has been removed."
        if [ "$KEEP_PROGRESS" -eq 1 ]; then
            warn "PROGRESS.md was kept at $CLAUDE_HOME/PROGRESS.md"
        fi
    else
        info "✅ 卸载完成！AI 教练系统已移除。"
        if [ "$KEEP_PROGRESS" -eq 1 ]; then
            warn "PROGRESS.md 已保留在 $CLAUDE_HOME/PROGRESS.md"
        fi
    fi
}

main
