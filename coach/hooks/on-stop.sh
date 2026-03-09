#!/usr/bin/env bash
# on-stop.sh — Post-interaction coaching hook (Stop hook)
# Runs after each Claude Code interaction ends.
# Implements 4-tier fallback: Tier 2 (LLM) → Tier 3 (rules) → Tier 4 (static)
#
# Configured in .claude/settings.json under hooks.Stop

set -euo pipefail

# Resolve paths
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENGINE_DIR="$(dirname "$SCRIPT_DIR")"
export ENGINE_ROOT="$ENGINE_DIR"

source "$ENGINE_DIR/lib/common.sh"
source "$ENGINE_DIR/lib/progress-parser.sh"

# Read coach mode config
COACH_MODE=$(read_coach_config "coach_mode" "auto")

if [ "$COACH_MODE" = "off" ]; then
  exit 0
fi

# ─── Tier 2: Dedicated LLM Coaching Call ─────────────────

tier2_llm_coaching() {
  if [ "$COACH_MODE" = "rules-only" ]; then
    return 1
  fi

  # Check if claude CLI is available
  if ! command -v claude &>/dev/null; then
    return 1
  fi

  # Gather context for the coaching prompt
  local current_level
  current_level=$(progress_get_level 2>/dev/null || echo "3")
  local target_level
  target_level=$(progress_get_target 2>/dev/null || echo "4")
  local tech_stack
  tech_stack=$(detect_tech_stack "." 2>/dev/null || echo "generic")
  local activity
  activity=$(detect_recent_activity "." 2>/dev/null || echo "general")

  # Read and fill the prompt template
  local prompt_template="$ENGINE_DIR/tier2-prompt.md"
  if [ ! -f "$prompt_template" ]; then
    return 1
  fi

  local prompt
  prompt=$(cat "$prompt_template")
  prompt="${prompt//\{\{CURRENT_LEVEL\}\}/$current_level}"
  prompt="${prompt//\{\{TARGET_LEVEL\}\}/$target_level}"
  prompt="${prompt//\{\{TECH_STACK\}\}/$tech_stack}"
  prompt="${prompt//\{\{ACTIVITY_TYPE\}\}/$activity}"

  # Make the dedicated coaching call with timeout
  local result
  result=$(timeout 15 claude -p "$prompt" --max-turns 1 2>/dev/null) || return 1

  if [ -n "$result" ]; then
    echo ""
    echo "$result"
    return 0
  fi

  return 1
}

# ─── Tier 3: Context-Aware Rules Engine ──────────────────

tier3_rules_coaching() {
  if [ "$COACH_MODE" = "llm-only" ]; then
    return 1
  fi

  local tech_stack
  tech_stack=$(detect_tech_stack "." 2>/dev/null || echo "generic")
  local activity
  activity=$(detect_recent_activity "." 2>/dev/null || echo "general")

  bash "$ENGINE_DIR/tips.sh" \
    --stack "$tech_stack" \
    --activity "$activity" 2>/dev/null

  return $?
}

# ─── Tier 4: Static Fallback ────────────────────────────

tier4_static_coaching() {
  local level
  level=$(progress_get_level 2>/dev/null || echo "3")

  echo ""
  echo -e "📊 \033[1mAI Coach\033[0m · Level $level"
  echo ""
  case "$level" in
    1|2) echo "💡 Try describing your task to Claude instead of just pasting errors." ;;
    3|4) echo "💡 Add acceptance criteria to your next prompt for better first-attempt quality." ;;
    5)   echo "💡 Describe WHY this feature matters, let AI decide HOW to implement it." ;;
    6)   echo "💡 Which parts of your current task could run in parallel AI sessions?" ;;
    7)   echo "💡 If you've typed a similar prompt 3+ times, make it a Custom Command." ;;
    8)   echo "💡 Could this manual step become a CI/CD automation trigger?" ;;
    *)   echo "💡 Every interaction with AI is a chance to improve your AI engineering skills." ;;
  esac
}

# ─── Main: Cascading Fallback ────────────────────────────

main() {
  # Try Tier 2 → Tier 3 → Tier 4
  if tier2_llm_coaching 2>/dev/null; then
    exit 0
  fi

  if tier3_rules_coaching 2>/dev/null; then
    exit 0
  fi

  # Tier 4 always succeeds
  tier4_static_coaching
}

main
