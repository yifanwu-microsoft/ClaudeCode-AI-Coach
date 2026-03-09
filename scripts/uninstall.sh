#!/usr/bin/env bash
# uninstall.sh — Remove AI Coach System from ~/.claude/
# Usage: ./scripts/uninstall.sh

set -euo pipefail

# Parse flags
AUTO_YES=false
for arg in "$@"; do
    case "$arg" in
        -y|--yes) AUTO_YES=true ;;
    esac
done

CLAUDE_HOME="$HOME/.claude"

MARKER_START="<!-- AI-COACH-START -->"
MARKER_END="<!-- AI-COACH-END -->"

# Coach command files installed by install.sh
COACH_COMMANDS=(
    "coach/assess.md"
    "coach/uninstall.md"
    "coach/practice.md"
    "coach/progress-report.md"
    "coach/review-prompt.md"
    "coach/i18n.md"
)

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

    # Remove coach directory if empty
    rmdir "$commands_dir/coach" 2>/dev/null || true

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

    rm -f "$progress_file"
    info "PROGRESS.md removed"
}

# Remove guide file
remove_guide() {
    local guide_file="$CLAUDE_HOME/ai-engineering-leveling-guide.md"
    local achievement_file="$CLAUDE_HOME/achievement-triggers.md"

    if [ -f "$guide_file" ]; then
        rm -f "$guide_file"
        info "ai-engineering-leveling-guide.md removed"
    else
        info "No guide file found, skipping"
    fi

    if [ -f "$achievement_file" ]; then
        rm -f "$achievement_file"
        info "achievement-triggers.md removed"
    fi
}

# Remove coaching engine
remove_engine() {
    local engine_dir="$CLAUDE_HOME/coach-engine"

    if [ -d "$engine_dir" ]; then
        rm -rf "$engine_dir"
        info "Coaching engine removed"
    else
        info "No coaching engine found, skipping"
    fi
}

# Remove coach hook from settings.json
remove_hooks() {
    local settings_file="$CLAUDE_HOME/settings.json"

    if [ ! -f "$settings_file" ]; then
        info "No settings.json found, skipping hook removal"
        return
    fi

    if ! command -v jq &>/dev/null; then
        warn "jq not found — cannot auto-remove hook from settings.json"
        warn "Manually remove the on-stop.sh hook entry from $settings_file"
        return
    fi

    # Remove our hook entries (supports both old and new format)
    if jq -e '(.hooks.Stop[]?.hooks[]? | select(.command | contains("on-stop.sh"))) // (.hooks.Stop[]? | select(.command? | contains("on-stop.sh")))' "$settings_file" &>/dev/null; then
        local tmp_settings
        tmp_settings=$(mktemp)
        jq '.hooks.Stop = [.hooks.Stop[]? | select(
                ((.hooks // [])[] | .command | contains("on-stop.sh")) | not
            ) | select(
                (.command? // "" | contains("on-stop.sh")) | not
            )]
            | if (.hooks.Stop | length) == 0 then del(.hooks.Stop) else . end
            | if (.hooks | length) == 0 then del(.hooks) else . end' \
            "$settings_file" > "$tmp_settings"

        # Check if settings is now empty
        local remaining
        remaining=$(jq 'keys | length' "$tmp_settings" 2>/dev/null || echo "0")
        if [ "$remaining" -eq 0 ]; then
            rm -f "$settings_file" "$tmp_settings"
            info "settings.json was coach-only, removed entirely"
        else
            mv "$tmp_settings" "$settings_file"
            info "Coach hook removed from settings.json"
        fi
    else
        info "No coach hook found in settings.json, skipping"
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
        else
            # CHECK: Verify CLAUDE.md still has content after removal
            if [ -s "$CLAUDE_HOME/CLAUDE.md" ]; then
                info "CLAUDE.md cleaned successfully (user content preserved)"
            else
                err "Verification failed: CLAUDE.md is empty after cleanup"
                has_error=1
            fi
        fi
    fi

    # Check guide is gone
    if [ -f "$CLAUDE_HOME/ai-engineering-leveling-guide.md" ]; then
        err "Verification failed: ai-engineering-leveling-guide.md still exists"
        has_error=1
    fi

    # Check engine is gone
    if [ -d "$CLAUDE_HOME/coach-engine" ]; then
        err "Verification failed: coach-engine/ directory still exists"
        has_error=1
    fi

    # Check PROGRESS.md
    if [ -f "$CLAUDE_HOME/PROGRESS.md" ]; then
        err "Verification failed: PROGRESS.md still exists"
        has_error=1
    fi

    # CHECK: Verify settings.json is valid JSON after hook removal (if it exists)
    if [ -f "$CLAUDE_HOME/settings.json" ]; then
        if command -v jq &>/dev/null; then
            if jq empty "$CLAUDE_HOME/settings.json" 2>/dev/null; then
                info "settings.json is valid JSON after hook removal"
            else
                err "Verification failed: settings.json is not valid JSON after cleanup"
                has_error=1
            fi
        fi
    fi

    if [ "$has_error" -eq 1 ]; then
        err "Post-uninstall verification failed. Some files may remain."
        return 1
    fi

    info "Post-uninstall verification passed ✅"
}

main() {
    info "Uninstalling AI Coach System from $CLAUDE_HOME ..."

    # Confirm uninstall (skip with --yes/-y)
    if [ "$AUTO_YES" = false ]; then
        printf "Are you sure you want to uninstall? [y/N]: "
        read -r confirm
        if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
            info "Uninstall cancelled."
            exit 0
        fi
    fi

    # Step 1: Remove commands
    remove_commands

    # Step 2: Remove coach block from CLAUDE.md
    remove_claude_block

    # Step 3: Remove PROGRESS.md
    remove_progress

    # Step 4: Remove guide
    remove_guide

    # Step 5: Remove coaching engine
    remove_engine

    # Step 6: Remove hooks from settings.json
    remove_hooks

    # Step 7: Clean up backups
    remove_backups

    # Step 8: Verify
    verify_uninstall

    echo ""
    info "✅ Uninstall complete! AI Coach has been removed."
}

main
