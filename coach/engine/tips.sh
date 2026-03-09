#!/usr/bin/env bash
# tips.sh — Smart tip selector with activity awareness and spaced repetition
# Selects the most appropriate coaching tip based on context.
#
# Usage: ./tips.sh [--level N] [--activity TYPE] [--stack STACK]
# Output: Formatted coaching tip to stdout

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/progress-parser.sh"

# ─── Arguments ───────────────────────────────────────────

LEVEL=""
ACTIVITY="general"
TECH_STACK="generic"
TARGET_LEVEL=""
OUTPUT_FORMAT="text"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --level)    LEVEL="$2"; shift 2 ;;
    --target)   TARGET_LEVEL="$2"; shift 2 ;;
    --activity) ACTIVITY="$2"; shift 2 ;;
    --stack)    TECH_STACK="$2"; shift 2 ;;
    --json)     OUTPUT_FORMAT="json"; shift ;;
    *)          shift ;;
  esac
done

# Fallback: read from PROGRESS.md
if [ -z "$LEVEL" ]; then
  LEVEL=$(progress_get_level)
  [ -z "$LEVEL" ] && LEVEL="3"
fi

if [ -z "$TARGET_LEVEL" ]; then
  TARGET_LEVEL=$(progress_get_target)
  [ -z "$TARGET_LEVEL" ] && TARGET_LEVEL=$((LEVEL + 1))
fi

# ─── State Management (Spaced Repetition) ────────────────

STATE_FILE="$STATE_DIR/tip-history.json"

load_shown_tips() {
  if [ -f "$STATE_FILE" ] && command -v jq &>/dev/null; then
    jq -r '.shown_tips[]? // empty' "$STATE_FILE" 2>/dev/null || echo ""
  else
    echo ""
  fi
}

save_shown_tip() {
  local tip_id="$1"
  local today
  today=$(today_iso)

  mkdir -p "$STATE_DIR"

  if [ -f "$STATE_FILE" ] && command -v jq &>/dev/null; then
    local updated
    updated=$(jq \
      --arg id "$tip_id" \
      --arg date "$today" \
      '.shown_tips = ((.shown_tips // []) + [$id] | unique) | .last_tip_date = $date | .tip_count_today = ((.tip_count_today // 0) + 1)' \
      "$STATE_FILE" 2>/dev/null)
    echo "$updated" > "$STATE_FILE"
  else
    cat > "$STATE_FILE" << EOF
{
  "shown_tips": ["$tip_id"],
  "last_tip_date": "$today",
  "tip_count_today": 1
}
EOF
  fi
}

should_reset_daily_count() {
  if [ -f "$STATE_FILE" ] && command -v jq &>/dev/null; then
    local last_date
    last_date=$(jq -r '.last_tip_date // ""' "$STATE_FILE" 2>/dev/null || echo "")
    local today
    today=$(today_iso)
    if [ "$last_date" != "$today" ]; then
      # Reset daily count
      jq --arg date "$today" '.tip_count_today = 0 | .last_tip_date = $date' "$STATE_FILE" > "$STATE_FILE.tmp" 2>/dev/null && mv "$STATE_FILE.tmp" "$STATE_FILE"
    fi
  fi
}

# ─── Tip Selection ───────────────────────────────────────

select_tip() {
  local shown_tips
  shown_tips=$(load_shown_tips)

  # Determine which tip file to use (target one level above current)
  local tip_level="$TARGET_LEVEL"
  local tip_file=""

  case "$tip_level" in
    1|2) tip_file="$SCRIPT_DIR/tips/level-1-2.json" ;;
    3|4) tip_file="$SCRIPT_DIR/tips/level-3-4.json" ;;
    5)   tip_file="$SCRIPT_DIR/tips/level-5.json" ;;
    6)   tip_file="$SCRIPT_DIR/tips/level-6.json" ;;
    7)   tip_file="$SCRIPT_DIR/tips/level-7.json" ;;
    8)   tip_file="$SCRIPT_DIR/tips/level-8.json" ;;
    *)   tip_file="$SCRIPT_DIR/tips/level-5.json" ;;
  esac

  if [ ! -f "$tip_file" ]; then
    echo ""
    return
  fi

  if ! command -v jq &>/dev/null; then
    # Fallback without jq: pick a random line with "tip" in it
    grep '"tip"' "$tip_file" | shuf -n 1 | sed 's/.*"tip": "\(.*\)".*/\1/' 2>/dev/null || echo ""
    return
  fi

  # Build jq filter for activity-aware selection
  local selected
  selected=$(jq -r \
    --arg activity "$ACTIVITY" \
    --argjson shown "$(echo "$shown_tips" | jq -R -s 'split("\n") | map(select(. != ""))' 2>/dev/null || echo '[]')" \
    '
    .tips
    | map(select(
        (.activity_tags | index($activity)) or
        (.activity_tags | index("general"))
      ))
    | map(select(.id as $id | ($shown | index($id)) | not))
    | if length == 0 then null
      else .[0]
      end
    ' "$tip_file" 2>/dev/null)

  # If all tips shown, reset and pick from full list
  if [ "$selected" = "null" ] || [ -z "$selected" ]; then
    selected=$(jq -r \
      --arg activity "$ACTIVITY" \
      '
      .tips
      | map(select(
          (.activity_tags | index($activity)) or
          (.activity_tags | index("general"))
        ))
      | if length == 0 then .tips[0]
        else .[0]
        end
      ' "$tip_file" 2>/dev/null)
  fi

  echo "$selected"
}

# ─── Anti-Pattern Check ─────────────────────────────────

check_anti_patterns() {
  local anti_file="$SCRIPT_DIR/tips/anti-patterns.json"
  if [ ! -f "$anti_file" ] || ! command -v jq &>/dev/null; then
    return
  fi

  # Check specific triggers
  local warnings=""

  # Check CLAUDE.md line count
  if [ -f "CLAUDE.md" ]; then
    local lines
    lines=$(wc -l < "CLAUDE.md" | tr -d ' ')
    if [ "$lines" -gt 200 ]; then
      local tip
      tip=$(jq -r '.tips[] | select(.id == "anti-l7-claudemd-too-long") | .tip' "$anti_file" 2>/dev/null || echo "")
      if [ -n "$tip" ]; then
        warnings+="$tip\n"
      fi
    fi
  fi

  # Check worktree count
  if git rev-parse --git-dir &>/dev/null 2>&1; then
    local wt_count
    wt_count=$(git worktree list 2>/dev/null | wc -l | tr -d ' ')
    if [ "$wt_count" -gt 5 ]; then
      local tip
      tip=$(jq -r '.tips[] | select(.id == "anti-l6-too-many-agents") | .tip' "$anti_file" 2>/dev/null || echo "")
      if [ -n "$tip" ]; then
        warnings+="$tip\n"
      fi
    fi
  fi

  if [ -n "$warnings" ]; then
    echo -e "$warnings"
  fi
}

# ─── Format Output ───────────────────────────────────────

format_tip() {
  local tip_json="$1"
  local level_display="$LEVEL"

  if [ -z "$tip_json" ] || [ "$tip_json" = "null" ]; then
    # Tier 4 fallback: static tip by level
    echo ""
    echo -e "📊 ${BOLD}AI Coach${NC} · Level $level_display"
    echo ""
    case "$LEVEL" in
      1|2) echo -e "💡 Try describing your task to Claude Code instead of just pasting error messages." ;;
      3|4) echo -e "💡 Add acceptance criteria and constraints to your next prompt — it dramatically improves first-attempt quality." ;;
      5)   echo -e "💡 Describe WHY this feature matters and WHAT it should do — let AI figure out HOW." ;;
      6)   echo -e "💡 Which parts of your current task could run in separate parallel Claude sessions?" ;;
      7)   echo -e "💡 If you've typed a similar prompt 3+ times, it's time to make it a Custom Command." ;;
      8)   echo -e "💡 Could this repetitive manual step become a CI/CD automation trigger?" ;;
      *)   echo -e "💡 Keep practicing — each interaction with AI is an opportunity to level up your skills." ;;
    esac
    return
  fi

  if ! command -v jq &>/dev/null; then
    echo -e "📊 ${BOLD}AI Coach${NC} · Level $level_display"
    echo ""
    echo "$tip_json" | grep -o '"tip": "[^"]*"' | head -1 | sed 's/"tip": "\(.*\)"/💡 \1/'
    return
  fi

  local tip_text
  tip_text=$(echo "$tip_json" | jq -r '.tip // empty' 2>/dev/null)
  local tip_id
  tip_id=$(echo "$tip_json" | jq -r '.id // empty' 2>/dev/null)
  local example_before
  example_before=$(echo "$tip_json" | jq -r '.example_before // empty' 2>/dev/null)
  local example_after
  example_after=$(echo "$tip_json" | jq -r ".tech_variants.$TECH_STACK // .example_after // empty" 2>/dev/null)

  # Save shown tip for spaced repetition
  if [ -n "$tip_id" ]; then
    save_shown_tip "$tip_id"
  fi

  # Output
  echo ""
  echo -e "📊 ${BOLD}AI Coach${NC} · Level $level_display"
  echo ""
  echo -e "💡 $tip_text"

  if [ -n "$example_before" ] && [ -n "$example_after" ]; then
    echo ""
    echo -e "  ${DIM}Before:${NC} $example_before"
    echo -e "  ${GREEN}After:${NC}  $example_after"
  fi
}

# ─── Main ────────────────────────────────────────────────

main() {
  should_reset_daily_count

  # Check anti-patterns first
  local warnings
  warnings=$(check_anti_patterns)

  # Select and display tip
  local tip_json
  tip_json=$(select_tip)

  if [ "$OUTPUT_FORMAT" = "json" ]; then
    echo "$tip_json"
  else
    format_tip "$tip_json"

    # Show anti-pattern warnings if any
    if [ -n "$warnings" ]; then
      echo ""
      echo -e "$warnings"
    fi
  fi
}

main
