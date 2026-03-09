#!/usr/bin/env bash
# install.sh — Install AI Coach System to ~/.claude/
# Usage: ./scripts/install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CLAUDE_HOME="$HOME/.claude"

MARKER_START="<!-- AI-COACH-START -->"
MARKER_END="<!-- AI-COACH-END -->"

# Track temp files for cleanup
TEMP_FILES=()

# Track whether installation started (for rollback messaging)
INSTALL_STARTED=0

# Trap handler: clean up temp files on error or exit
cleanup() {
    for f in "${TEMP_FILES[@]}"; do
        rm -f "$f" 2>/dev/null || true
    done
    if [ "$INSTALL_STARTED" -eq 1 ] && [ "${EXIT_CODE:-1}" -ne 0 ]; then
        echo ""
        err "Installation failed partway through. To clean up, run:"
        err "  ./scripts/uninstall.sh"
    fi
}
trap 'EXIT_CODE=$?; cleanup' EXIT
trap 'EXIT_CODE=1; cleanup; exit 1' ERR INT TERM

# Parse arguments
if [[ $# -gt 0 ]]; then
    echo "Usage: ./scripts/install.sh"
    exit 1
fi

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
err()   { echo -e "${RED}[ERROR]${NC} $1"; }

# Pre-flight validation
preflight_check() {
    local has_error=0

    if [ ! -f "$REPO_ROOT/coach/CLAUDE.md" ]; then
        err "CLAUDE.md not found in repo root ($REPO_ROOT)"
        err "Are you running this script from the correct repository?"
        has_error=1
    fi

    if [ ! -f "$REPO_ROOT/coach/PROGRESS.template.md" ]; then
        err "PROGRESS.template.md not found in repo root ($REPO_ROOT)"
        has_error=1
    fi

    if [ ! -f "$REPO_ROOT/coach/ai-engineering-leveling-guide.md" ]; then
        err "ai-engineering-leveling-guide.md not found in repo root ($REPO_ROOT)"
        has_error=1
    fi

    if [ ! -d "$REPO_ROOT/coach/engine" ]; then
        err "coach/engine/ directory not found in repo root ($REPO_ROOT)"
        has_error=1
    fi

    if [ "$has_error" -eq 1 ]; then
        err "Pre-flight check failed. Aborting installation."
        exit 1
    fi

    info "Pre-flight check passed"
}

set_source_paths() {
    CLAUDE_MD_SOURCE="$REPO_ROOT/coach/CLAUDE.md"
    PROGRESS_SOURCE="$REPO_ROOT/coach/PROGRESS.template.md"
    GUIDE_SOURCE="$REPO_ROOT/coach/ai-engineering-leveling-guide.md"
    ACHIEVEMENT_SOURCE="$REPO_ROOT/coach/achievement-triggers.md"
    COMMANDS_SOURCE="$REPO_ROOT/coach/commands"
    ENGINE_SOURCE="$REPO_ROOT/coach/engine"
    HOOKS_SOURCE="$REPO_ROOT/coach/hooks"
}

# Post-install verification
verify_install() {
    local has_error=0

    info "Running post-install verification..."

    if [ ! -f "$CLAUDE_HOME/CLAUDE.md" ]; then
        err "Verification failed: CLAUDE.md not found in $CLAUDE_HOME"
        has_error=1
    fi

    if [ ! -f "$CLAUDE_HOME/PROGRESS.md" ]; then
        err "Verification failed: PROGRESS.md not found in $CLAUDE_HOME"
        has_error=1
    fi

    if [ ! -f "$CLAUDE_HOME/commands/coach/assess.md" ]; then
        err "Verification failed: commands/coach/assess.md not found in $CLAUDE_HOME"
        has_error=1
    fi

    if [ ! -x "$CLAUDE_HOME/coach-engine/coach-cli.sh" ]; then
        err "Verification failed: coach-engine/coach-cli.sh not found or not executable"
        has_error=1
    fi

    if [ ! -x "$CLAUDE_HOME/coach-engine/hooks/on-stop.sh" ]; then
        err "Verification failed: coach-engine/hooks/on-stop.sh not found or not executable"
        has_error=1
    fi

    if [ "$has_error" -eq 1 ]; then
        err "Post-install verification failed. Installation may be incomplete."
        return 1
    fi

    info "Post-install verification passed"
}

main() {
    # Pre-flight validation
    preflight_check

    set_source_paths

    info "Installing AI Coach System to $CLAUDE_HOME ..."

    INSTALL_STARTED=1

    # Create directories
    mkdir -p "$CLAUDE_HOME/commands"

    # 1. Sync commands/
    if [ -d "$COMMANDS_SOURCE" ]; then
        # Create coach subdirectory
        mkdir -p "$CLAUDE_HOME/commands/coach"
        # Copy coach namespace commands
        cp -f "$COMMANDS_SOURCE/coach/"*.md "$CLAUDE_HOME/commands/coach/" 2>/dev/null || true
        # Verify critical command files were copied
        local verify_failed=0
        for cmd in coach/assess.md coach/practice.md coach/progress-report.md coach/review-prompt.md; do
            if [ ! -f "$CLAUDE_HOME/commands/$cmd" ]; then
                err "Critical command file missing after copy: $cmd"
                verify_failed=1
            fi
        done
        if [ "$verify_failed" -eq 1 ]; then
            err "Command installation failed. Please check source directory: $COMMANDS_SOURCE"
            err "To clean up a partial install, run: ./scripts/uninstall.sh"
            exit 1
        fi
        info "Commands installed"
    fi

    # 2. Sync CLAUDE.md (marker block merge)
    if [ ! -f "$CLAUDE_MD_SOURCE" ]; then
        err "CLAUDE.md not found at $CLAUDE_MD_SOURCE"
        exit 1
    fi

    local source_content
    source_content=$(cat "$CLAUDE_MD_SOURCE")

    local target_file="$CLAUDE_HOME/CLAUDE.md"
    local tmp_block
    tmp_block=$(mktemp)
    TEMP_FILES+=("$tmp_block")
    printf '%s\n%s\n%s\n' "$MARKER_START" "$source_content" "$MARKER_END" > "$tmp_block"

    if [ -f "$target_file" ]; then
        # Backup before modifying
        cp "$target_file" "$target_file.bak"
        info "Backed up existing CLAUDE.md to CLAUDE.md.bak"

        local target_content
        target_content=$(cat "$target_file")
        if echo "$target_content" | grep -qF "$MARKER_START"; then
            # Use index() for robust substring matching (handles trailing whitespace, BOM, etc.)
            awk -v blockfile="$tmp_block" '
                index($0, "AI-COACH-START") > 0 { skip=1; while ((getline line < blockfile) > 0) print line; close(blockfile); next }
                index($0, "AI-COACH-END") > 0 { skip=0; next }
                !skip { print }
            ' "$target_file" > "$target_file.tmp"
            TEMP_FILES+=("$target_file.tmp")
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
        warn "PROGRESS.md already exists, skipping (protecting local progress)"
        warn "To reset, manually delete ~/.claude/PROGRESS.md and re-run install"
    else
        cp -f "$PROGRESS_SOURCE" "$CLAUDE_HOME/PROGRESS.md"
        info "PROGRESS.md created"
    fi

    # 4. Sync guide
    if [ -f "$GUIDE_SOURCE" ]; then
        cp -f "$GUIDE_SOURCE" "$CLAUDE_HOME/ai-engineering-leveling-guide.md"
        info "Guide installed"
    else
        err "Guide not found at $GUIDE_SOURCE"
        exit 1
    fi

    # 5. Sync achievement triggers
    if [ -f "$ACHIEVEMENT_SOURCE" ]; then
        cp -f "$ACHIEVEMENT_SOURCE" "$CLAUDE_HOME/achievement-triggers.md"
        info "Achievement triggers installed"
    fi

    # 6. Install coaching engine
    if [ -d "$ENGINE_SOURCE" ]; then
        local engine_dest="$CLAUDE_HOME/coach-engine"
        mkdir -p "$engine_dest/lib" "$engine_dest/tips" "$engine_dest/state"

        # Copy engine scripts
        for script in coach-cli.sh assess.sh tips.sh progress.sh tier2-prompt.md config.default.json; do
            if [ -f "$ENGINE_SOURCE/$script" ]; then
                cp -f "$ENGINE_SOURCE/$script" "$engine_dest/$script"
            fi
        done

        # Copy lib/
        cp -f "$ENGINE_SOURCE/lib/"*.sh "$engine_dest/lib/" 2>/dev/null || true

        # Copy tips database
        cp -f "$ENGINE_SOURCE/tips/"*.json "$engine_dest/tips/" 2>/dev/null || true

        # Set executable permissions
        chmod +x "$engine_dest/coach-cli.sh" "$engine_dest/assess.sh" "$engine_dest/tips.sh" "$engine_dest/progress.sh" 2>/dev/null || true

        # Create default config if not exists
        if [ ! -f "$engine_dest/config.json" ]; then
            cp -f "$ENGINE_SOURCE/config.default.json" "$engine_dest/config.json"
        fi

        info "Coaching engine installed"
    fi

    # 7. Install hooks
    if [ -d "$HOOKS_SOURCE" ]; then
        local hooks_dest="$CLAUDE_HOME/coach-engine/hooks"
        mkdir -p "$hooks_dest"

        cp -f "$HOOKS_SOURCE/on-stop.sh" "$hooks_dest/on-stop.sh"
        chmod +x "$hooks_dest/on-stop.sh"

        # Merge hooks config into settings.json
        local settings_file="$CLAUDE_HOME/settings.json"
        local hook_cmd="bash $CLAUDE_HOME/coach-engine/hooks/on-stop.sh"

        if [ -f "$settings_file" ] && command -v jq &>/dev/null; then
            # Check if our hook is already configured
            if ! jq -e '.hooks.Stop[]? | select(.command | contains("on-stop.sh"))' "$settings_file" &>/dev/null; then
                # Add our hook to existing config
                local tmp_settings
                tmp_settings=$(mktemp)
                TEMP_FILES+=("$tmp_settings")
                jq --arg cmd "$hook_cmd" '
                    .hooks = (.hooks // {}) |
                    .hooks.Stop = ((.hooks.Stop // []) + [{"matcher": "", "command": $cmd}])
                ' "$settings_file" > "$tmp_settings"
                mv "$tmp_settings" "$settings_file"
                info "Coach hook added to existing settings.json"
            else
                info "Coach hook already configured in settings.json"
            fi
        elif [ -f "$settings_file" ]; then
            warn "jq not found — cannot auto-merge hooks config into settings.json"
            warn "Manually add to $settings_file:"
            warn "  \"hooks\": { \"Stop\": [{ \"command\": \"$hook_cmd\" }] }"
        else
            # Create new settings.json with hook
            cat > "$settings_file" << EOF
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "command": "$hook_cmd"
      }
    ]
  }
}
EOF
            info "settings.json created with coach hook"
        fi

        info "Hooks installed"
    fi

    # Post-install verification
    verify_install

    echo ""
    info "✅ Installation complete! AI Coach is now globally active."
    if [ -f "$CLAUDE_HOME/PROGRESS.md" ] && grep -q "Pending Assessment" "$CLAUDE_HOME/PROGRESS.md"; then
        info "Initial assessment will begin automatically — stay in this session."
    else
        info "Configuration updated. Your progress has been preserved."
    fi
}

main
