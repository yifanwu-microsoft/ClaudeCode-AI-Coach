#!/usr/bin/env bash
# assess.sh — Weighted multi-signal project scanner
# Scans project environment for objective AI engineering signals
# and outputs a level assessment with confidence score.
#
# Usage: ./assess.sh [project_dir]
# Output: JSON-like assessment to stdout

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/progress-parser.sh"

PROJECT_DIR="${1:-.}"

# ─── Signal Scoring (Bash 3 compatible) ──────────────────

TOTAL_SCORE=0
TOTAL_POSSIBLE=0
SIGNALS_FOUND=0
TOTAL_SIGNALS=0
SIGNAL_LOG=""

add_signal() {
  local name="$1"
  local score="$2"
  local max="$3"
  local level="$4"
  local detail="${5:-}"

  SIGNAL_LOG="${SIGNAL_LOG}${name}|${score}/${max} (L${level}) ${detail}\n"
  TOTAL_SCORE=$((TOTAL_SCORE + score))
  TOTAL_POSSIBLE=$((TOTAL_POSSIBLE + max))
  TOTAL_SIGNALS=$((TOTAL_SIGNALS + 1))
  if [ "$score" -gt 0 ]; then
    SIGNALS_FOUND=$((SIGNALS_FOUND + 1))
  fi
}

# ─── L3-4 Signals: Project Configuration ────────────────

check_claudemd() {
  local score=0
  local detail=""

  if [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
    score=1
    detail="exists"

    # Check quality: how many sections?
    local sections
    sections=$(grep -c "^##" "$PROJECT_DIR/CLAUDE.md" 2>/dev/null || echo "0")
    if [ "$sections" -ge 3 ]; then
      score=2
      detail="$sections sections"
    fi

    # Check for key content
    if grep -qi "tech stack\|stack:\|## Stack\|## Technology" "$PROJECT_DIR/CLAUDE.md" 2>/dev/null; then
      score=3
      detail="$sections sections, has tech stack"
    fi
  fi

  add_signal "claudemd_quality" "$score" 3 "3-4" "$detail"
}

check_claudemd_freshness() {
  local score=0
  local detail=""

  if [ -f "$PROJECT_DIR/CLAUDE.md" ]; then
    local mod_date
    if stat --version &>/dev/null 2>&1; then
      mod_date=$(stat -c %Y "$PROJECT_DIR/CLAUDE.md" 2>/dev/null || echo "0")
    else
      mod_date=$(stat -f %m "$PROJECT_DIR/CLAUDE.md" 2>/dev/null || echo "0")
    fi
    local now
    now=$(date +%s)
    local age_days=$(( (now - mod_date) / 86400 ))

    if [ "$age_days" -le 7 ]; then
      score=2
      detail="updated ${age_days}d ago"
    elif [ "$age_days" -le 30 ]; then
      score=1
      detail="updated ${age_days}d ago"
    else
      detail="stale (${age_days}d)"
    fi
  fi

  add_signal "claudemd_freshness" "$score" 2 "3-4" "$detail"
}

# ─── L5 Signals: Development Maturity ───────────────────

check_test_coverage() {
  local score=0
  local detail=""

  local test_files=0
  local src_files=0

  test_files=$(find "$PROJECT_DIR" -maxdepth 4 \( -name "*.test.*" -o -name "*.spec.*" -o -name "test_*.py" -o -name "*_test.go" -o -name "*_test.rs" \) ! -path "*/node_modules/*" ! -path "*/vendor/*" 2>/dev/null | wc -l | tr -d ' ')
  src_files=$(find "$PROJECT_DIR" -maxdepth 4 \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" -o -name "*.py" -o -name "*.go" -o -name "*.rs" -o -name "*.java" \) ! -name "*.test.*" ! -name "*.spec.*" ! -name "test_*" ! -name "*_test.*" ! -path "*/node_modules/*" ! -path "*/vendor/*" 2>/dev/null | wc -l | tr -d ' ')

  if [ "$src_files" -gt 0 ]; then
    local ratio
    ratio=$(echo "scale=2; $test_files * 100 / $src_files" | bc 2>/dev/null || echo "0")
    detail="${test_files}t/${src_files}s (${ratio}%)"

    if [ "$test_files" -ge "$((src_files / 2))" ]; then
      score=2
    elif [ "$test_files" -gt 0 ]; then
      score=1
    fi
  else
    detail="no source files found"
  fi

  add_signal "test_coverage" "$score" 2 "5" "$detail"
}

check_commit_quality() {
  local score=0
  local detail=""

  if (cd "$PROJECT_DIR" && git rev-parse --git-dir &>/dev/null); then
    local commits
    commits=$(cd "$PROJECT_DIR" && git log --oneline -20 2>/dev/null || echo "")
    local total
    total=$(echo "$commits" | grep -c "." || echo "0")

    if [ "$total" -gt 0 ]; then
      # Check for conventional commits pattern
      local conventional
      conventional=$(echo "$commits" | grep -cE "^[a-f0-9]+ (feat|fix|chore|docs|style|refactor|test|ci|perf|build)" || echo "0")
      local ratio=$((conventional * 100 / total))
      detail="${conventional}/${total} conventional (${ratio}%)"

      if [ "$ratio" -ge 70 ]; then
        score=2
      elif [ "$ratio" -ge 30 ]; then
        score=1
      fi
    fi
  fi

  add_signal "commit_quality" "$score" 2 "5" "$detail"
}

# ─── L6 Signals: Parallelism ────────────────────────────

check_worktrees() {
  local score=0
  local detail=""

  if (cd "$PROJECT_DIR" && git rev-parse --git-dir &>/dev/null); then
    local count
    count=$(cd "$PROJECT_DIR" && git worktree list 2>/dev/null | wc -l | tr -d ' ')
    detail="${count} worktree(s)"

    if [ "$count" -ge 3 ]; then
      score=3
    elif [ "$count" -ge 2 ]; then
      score=2
    elif [ "$count" -ge 1 ]; then
      score=1
    fi
  fi

  add_signal "worktrees" "$score" 3 "6" "$detail"
}

check_branch_patterns() {
  local score=0
  local detail=""

  if (cd "$PROJECT_DIR" && git rev-parse --git-dir &>/dev/null); then
    local recent_branches
    recent_branches=$(cd "$PROJECT_DIR" && git branch --sort=-committerdate --format='%(refname:short)' 2>/dev/null | head -10)
    local branch_count=0
    if [ -n "$recent_branches" ]; then
      branch_count=$(printf '%s\n' "$recent_branches" | wc -l | tr -d ' ')
    fi

    # Check for parallel feature branches (feature/*, feat/*)
    local feature_branches=0
    if [ -n "$recent_branches" ]; then
      feature_branches=$(printf '%s\n' "$recent_branches" | grep -cE "^(feature|feat|fix|hotfix)/" 2>/dev/null || true)
      feature_branches=${feature_branches:-0}
    fi
    detail="${branch_count} branches, ${feature_branches} feature branches"

    if [ "$feature_branches" -ge 3 ]; then
      score=2
    elif [ "$feature_branches" -ge 1 ]; then
      score=1
    fi
  fi

  add_signal "branch_patterns" "$score" 2 "6" "$detail"
}

# ─── L7 Signals: Workflow Orchestration ──────────────────

check_custom_commands() {
  local score=0
  local detail=""
  local count=0

  # Check project-level commands
  if [ -d "$PROJECT_DIR/.claude/commands" ]; then
    count=$(find "$PROJECT_DIR/.claude/commands" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
  fi

  # Also check global commands (excluding coach commands)
  if [ -d "$HOME/.claude/commands" ]; then
    local global_count
    global_count=$(find "$HOME/.claude/commands" -name "*.md" ! -path "*/coach/*" 2>/dev/null | wc -l | tr -d ' ')
    count=$((count + global_count))
  fi

  detail="${count} command(s)"

  if [ "$count" -ge 5 ]; then
    score=3
  elif [ "$count" -ge 3 ]; then
    score=2
  elif [ "$count" -ge 1 ]; then
    score=1
  fi

  add_signal "custom_commands" "$score" 3 "7" "$detail"
}

check_hooks_config() {
  local score=0
  local detail=""

  local settings_files=(
    "$PROJECT_DIR/.claude/settings.json"
    "$PROJECT_DIR/.claude/settings.local.json"
    "$HOME/.claude/settings.json"
    "$HOME/.claude/settings.local.json"
  )

  for sf in "${settings_files[@]}"; do
    if [ -f "$sf" ] && command -v jq &>/dev/null; then
      local hooks
      hooks=$(jq -r '.hooks // empty' "$sf" 2>/dev/null || echo "")
      if [ -n "$hooks" ] && [ "$hooks" != "null" ] && [ "$hooks" != "{}" ]; then
        local hook_count
        hook_count=$(echo "$hooks" | jq 'keys | length' 2>/dev/null || echo "0")
        if [ "$hook_count" -gt 0 ]; then
          score=3
          detail="${hook_count} hook type(s) in $(basename "$sf")"
          break
        fi
      fi
    fi
  done

  if [ "$score" -eq 0 ]; then
    detail="none configured"
  fi

  add_signal "hooks_config" "$score" 3 "7" "$detail"
}

# ─── L8 Signals: Automation ─────────────────────────────

check_cicd_ai() {
  local score=0
  local detail=""

  if [ -d "$PROJECT_DIR/.github/workflows" ]; then
    local ai_workflows
    ai_workflows=$(grep -rlE "claude|anthropic|openai|copilot|ai-review|ai-fix" "$PROJECT_DIR/.github/workflows/" 2>/dev/null | wc -l | tr -d ' ')
    detail="${ai_workflows} AI workflow(s)"

    if [ "$ai_workflows" -ge 2 ]; then
      score=3
    elif [ "$ai_workflows" -ge 1 ]; then
      score=2
    fi
  else
    detail="no .github/workflows/"
  fi

  add_signal "cicd_ai" "$score" 3 "8" "$detail"
}

# ─── Level Calculation ───────────────────────────────────

calculate_level() {
  if [ "$TOTAL_SCORE" -le 6 ]; then echo "1-2"
  elif [ "$TOTAL_SCORE" -le 12 ]; then echo "3-4"
  elif [ "$TOTAL_SCORE" -le 17 ]; then echo "5"
  elif [ "$TOTAL_SCORE" -le 24 ]; then echo "6"
  elif [ "$TOTAL_SCORE" -le 30 ]; then echo "7"
  else echo "8"
  fi
}

calculate_confidence() {
  if [ "$TOTAL_SIGNALS" -eq 0 ]; then
    echo "low"
    return
  fi

  local pct=$((SIGNALS_FOUND * 100 / TOTAL_SIGNALS))
  if [ "$pct" -ge 70 ]; then echo "high"
  elif [ "$pct" -ge 40 ]; then echo "medium"
  else echo "low"
  fi
}

# ─── Main ────────────────────────────────────────────────

main() {
  local output_format="${2:-text}"

  # Run all signal checks
  check_claudemd
  check_claudemd_freshness
  check_test_coverage
  check_commit_quality
  check_worktrees
  check_branch_patterns
  check_custom_commands
  check_hooks_config
  check_cicd_ai

  local level
  level=$(calculate_level)
  local confidence
  confidence=$(calculate_confidence)
  local tech_stack
  tech_stack=$(detect_tech_stack "$PROJECT_DIR")
  local activity
  activity=$(detect_recent_activity "$PROJECT_DIR")

  if [ "$output_format" = "--json" ]; then
    # JSON output for programmatic use
    echo "{"
    echo "  \"detected_level\": \"$level\","
    echo "  \"score\": $TOTAL_SCORE,"
    echo "  \"max_score\": $TOTAL_POSSIBLE,"
    echo "  \"confidence\": \"$confidence\","
    echo "  \"tech_stack\": \"$tech_stack\","
    echo "  \"activity_type\": \"$activity\","
    echo "  \"signals_found\": $SIGNALS_FOUND,"
    echo "  \"total_signals\": $TOTAL_SIGNALS"
    echo "}"
  else
    # Human-readable output
    echo ""
    coach_info "${BOLD}AI Engineering Level Assessment${NC}"
    echo ""
    echo -e "  ${BOLD}Detected Level${NC}: $level"
    echo -e "  ${BOLD}Score${NC}: $TOTAL_SCORE / $TOTAL_POSSIBLE"
    echo -e "  ${BOLD}Confidence${NC}: $confidence ($SIGNALS_FOUND/$TOTAL_SIGNALS signals)"
    echo -e "  ${BOLD}Tech Stack${NC}: $tech_stack"
    echo -e "  ${BOLD}Recent Activity${NC}: $activity"
    echo ""
    echo -e "  ${DIM}Signals:${NC}"
    echo -e "$SIGNAL_LOG" | while IFS='|' read -r key val; do
      if [ -n "$key" ]; then
        echo -e "    ${DIM}$key${NC}: $val"
      fi
    done
    echo ""
  fi
}

main "$@"
