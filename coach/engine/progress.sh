#!/usr/bin/env bash
# progress.sh — Automatic PROGRESS.md updater based on objective signals
# Compares assess.sh scan results with current PROGRESS.md state
# and updates sub-skill statuses + milestone log.
#
# Usage: ./progress.sh [project_dir]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/progress-parser.sh"

PROJECT_DIR="${1:-.}"

# ─── Signal-Based Sub-Skill Updates ──────────────────────

check_and_suggest_updates() {
  if [ ! -f "$PROGRESS_FILE" ]; then
    return
  fi

  local updates=""
  local current_level
  current_level=$(progress_get_level)

  # L3-4: Check CLAUDE.md Maintenance
  if [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
    local sections
    sections=$(grep -c "^##" "$PROJECT_DIR/CLAUDE.md" 2>/dev/null || echo "0")
    local status
    status=$(progress_get_subskills "4" | grep -i "CLAUDE.md\|Configuration" | head -1)

    if echo "$status" | grep -q "🔴" && [ "$sections" -ge 2 ]; then
      updates+="  L3-4 CLAUDE.md Maintenance: 🔴→🟡 (CLAUDE.md exists with $sections sections)\n"
    fi
  fi

  # L7: Check Custom Commands
  local cmd_count=0
  if [ -d "$PROJECT_DIR/.claude/commands" ]; then
    cmd_count=$(find "$PROJECT_DIR/.claude/commands" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
  fi
  if [ -d "$HOME/.claude/commands" ]; then
    local global_count
    global_count=$(find "$HOME/.claude/commands" -name "*.md" ! -path "*/coach/*" 2>/dev/null | wc -l | tr -d ' ')
    cmd_count=$((cmd_count + global_count))
  fi

  if [ "$cmd_count" -ge 5 ]; then
    local status
    status=$(progress_get_subskills "7" | grep -i "Custom.*Command\|Slash.*Command" | head -1)
    if echo "$status" | grep -q "🟡"; then
      updates+="  L7 Custom Commands: 🟡→🟢 ($cmd_count commands, ≥5 threshold met)\n"
    fi
  elif [ "$cmd_count" -ge 1 ]; then
    local status
    status=$(progress_get_subskills "7" | grep -i "Custom.*Command\|Slash.*Command" | head -1)
    if echo "$status" | grep -q "🔴"; then
      updates+="  L7 Custom Commands: 🔴→🟡 ($cmd_count command(s) found)\n"
    fi
  fi

  # L7: Check Hooks
  local has_hooks=0
  for sf in "$PROJECT_DIR/.claude/settings.json" "$PROJECT_DIR/.claude/settings.local.json" "$HOME/.claude/settings.json" "$HOME/.claude/settings.local.json"; do
    if [ -f "$sf" ] && command -v jq &>/dev/null; then
      local hooks
      hooks=$(jq -r '.hooks // empty' "$sf" 2>/dev/null || echo "")
      if [ -n "$hooks" ] && [ "$hooks" != "null" ] && [ "$hooks" != "{}" ]; then
        has_hooks=1
        break
      fi
    fi
  done

  if [ "$has_hooks" -eq 1 ]; then
    local status
    status=$(progress_get_subskills "7" | grep -i "Hook" | head -1)
    if echo "$status" | grep -q "🔴"; then
      updates+="  L7 Hooks: 🔴→🟡 (Hooks configuration detected)\n"
    fi
  fi

  # L6: Check Git Worktree
  if (cd "$PROJECT_DIR" && git rev-parse --git-dir &>/dev/null 2>&1); then
    local wt_count
    wt_count=$(cd "$PROJECT_DIR" && git worktree list 2>/dev/null | wc -l | tr -d ' ')
    if [ "$wt_count" -ge 2 ]; then
      local status
      status=$(progress_get_subskills "6" | grep -i "Worktree\|Git Worktree" | head -1)
      if echo "$status" | grep -q "🔴"; then
        updates+="  L6 Git Worktree: 🔴→🟡 ($wt_count worktrees detected)\n"
      fi
    fi
  fi

  echo -e "$updates"
}

# ─── Auto-Update Assessment Date ─────────────────────────

update_assessment_date() {
  if [ -f "$PROGRESS_FILE" ]; then
    progress_update_date "$PROGRESS_FILE"
  fi
}

# ─── Main ────────────────────────────────────────────────

main() {
  local mode="${2:-check}"  # "check" = dry run, "apply" = actually update

  if [ ! -f "$PROGRESS_FILE" ]; then
    coach_warn "PROGRESS.md not found at $PROGRESS_FILE"
    echo "Run the coach install script first: ./scripts/install.sh"
    return 1
  fi

  local current_level
  current_level=$(progress_get_level)
  local target_level
  target_level=$(progress_get_target)

  echo ""
  coach_info "${BOLD}Progress Check${NC}"
  echo -e "  Current Level: $current_level | Target: $target_level"
  echo ""

  # Check for suggested updates
  local updates
  updates=$(check_and_suggest_updates)

  if [ -n "$updates" ] && [ "$updates" != "" ]; then
    echo -e "  ${BOLD}Suggested updates based on objective signals:${NC}"
    echo -e "$updates"

    if [ "$mode" = "apply" ]; then
      update_assessment_date
      echo -e "  ${GREEN}Assessment date updated.${NC}"
      echo -e "  ${DIM}Note: Sub-skill status changes require confirmation via /coach:assess${NC}"
    else
      echo -e "  ${DIM}Run with 'apply' to update assessment date.${NC}"
      echo -e "  ${DIM}Sub-skill changes require confirmation via /coach:assess${NC}"
    fi
  else
    echo -e "  ${DIM}No signal-based updates detected.${NC}"
  fi

  # Show current sub-skill summary
  echo ""
  echo -e "  ${BOLD}Sub-skill Summary:${NC}"
  for lvl in 2 4 5 6 7 8; do
    local green
    green=$(progress_count_status "$lvl" "🟢")
    local yellow
    yellow=$(progress_count_status "$lvl" "🟡")
    local red
    red=$(progress_count_status "$lvl" "🔴")
    local total=$((green + yellow + red))
    if [ "$total" -gt 0 ]; then
      local lvl_label
      case "$lvl" in
        2) lvl_label="L1-2" ;;
        4) lvl_label="L3-4" ;;
        *) lvl_label="L$lvl" ;;
      esac
      echo -e "    $lvl_label: 🟢${green} 🟡${yellow} 🔴${red}"
    fi
  done
  echo ""
}

main "$@"
