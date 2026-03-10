#!/usr/bin/env bash
# common.sh — Shared utilities for the coaching engine
# Sourced by other engine scripts, not run directly.

set -euo pipefail

# ─── Colors ──────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

coach_info()  { echo -e "${GREEN}📊${NC} $1"; }
coach_tip()   { echo -e "${CYAN}💡${NC} $1"; }
coach_warn()  { echo -e "${YELLOW}⚠️${NC}  $1"; }
coach_error() { echo -e "${RED}❌${NC} $1"; }
coach_good()  { echo -e "${GREEN}✅${NC} $1"; }

# ─── Path Resolution ────────────────────────────────────
# Resolve the engine root directory (where this script lives)
resolve_engine_root() {
  local source="${BASH_SOURCE[1]:-${BASH_SOURCE[0]}}"
  local dir
  dir="$(cd "$(dirname "$source")" && pwd)"
  # If called from lib/, go up one level
  if [[ "$dir" == */lib ]]; then
    echo "$(dirname "$dir")"
  else
    echo "$dir"
  fi
}

ENGINE_ROOT="${ENGINE_ROOT:-$(resolve_engine_root)}"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
PROGRESS_FILE="${PROGRESS_FILE:-$CLAUDE_HOME/PROGRESS.md}"
STATE_DIR="${STATE_DIR:-$CLAUDE_HOME/coach-engine/state}"
COACH_CONFIG="${COACH_CONFIG:-$CLAUDE_HOME/coach-engine/config.json}"

# Ensure state directory exists
mkdir -p "$STATE_DIR" 2>/dev/null || true

# ─── Tech Stack Detection ───────────────────────────────
detect_tech_stack() {
  local project_dir="${1:-.}"
  local stack="generic"

  if [ -f "$project_dir/package.json" ]; then
    local pkg
    pkg=$(cat "$project_dir/package.json" 2>/dev/null || echo "{}")
    if echo "$pkg" | grep -q '"next"'; then stack="nextjs"
    elif echo "$pkg" | grep -q '"react"'; then stack="react"
    elif echo "$pkg" | grep -q '"vue"'; then stack="vue"
    elif echo "$pkg" | grep -q '"angular"'; then stack="angular"
    elif echo "$pkg" | grep -q '"svelte"'; then stack="svelte"
    else stack="node"; fi
  elif [ -f "$project_dir/requirements.txt" ] || [ -f "$project_dir/pyproject.toml" ] || [ -f "$project_dir/setup.py" ]; then
    if [ -f "$project_dir/manage.py" ]; then stack="django"
    elif grep -rq "fastapi\|FastAPI" "$project_dir"/*.txt "$project_dir"/*.toml 2>/dev/null; then stack="fastapi"
    elif grep -rq "flask\|Flask" "$project_dir"/*.txt "$project_dir"/*.toml 2>/dev/null; then stack="flask"
    else stack="python"; fi
  elif [ -f "$project_dir/go.mod" ]; then stack="go"
  elif [ -f "$project_dir/Cargo.toml" ]; then stack="rust"
  elif [ -f "$project_dir/build.gradle" ] || [ -f "$project_dir/pom.xml" ]; then stack="java"
  elif [ -f "$project_dir/Package.swift" ]; then stack="swift"
  fi

  echo "$stack"
}

# ─── Activity Detection ─────────────────────────────────
detect_recent_activity() {
  local project_dir="${1:-.}"
  local activity="general"

  # Check recent git changes
  local recent_files
  recent_files=$(cd "$project_dir" && git diff --name-only HEAD~1 2>/dev/null || echo "")

  if [ -z "$recent_files" ]; then
    recent_files=$(cd "$project_dir" && git diff --name-only 2>/dev/null || echo "")
  fi

  if echo "$recent_files" | grep -qi "test\|spec\|__test__"; then
    activity="test"
  elif echo "$recent_files" | grep -qi "\.yml\|\.yaml\|\.json\|config\|\.env"; then
    activity="config"
  elif echo "$recent_files" | grep -qi "\.md\|\.txt\|doc\|readme"; then
    activity="docs"
  elif cd "$project_dir" && git log -1 --oneline 2>/dev/null | grep -qi "fix\|bug\|hotfix\|patch"; then
    activity="bugfix"
  elif cd "$project_dir" && git log -1 --oneline 2>/dev/null | grep -qi "refactor\|cleanup\|rename"; then
    activity="refactor"
  elif [ -n "$recent_files" ]; then
    activity="feature"
  fi

  echo "$activity"
}

# ─── Config Reading ──────────────────────────────────────
read_coach_config() {
  local key="$1"
  local default="${2:-}"

  if [ -f "$COACH_CONFIG" ] && command -v jq &>/dev/null; then
    local value
    value=$(jq -r ".$key // empty" "$COACH_CONFIG" 2>/dev/null || echo "")
    if [ -n "$value" ]; then
      echo "$value"
      return
    fi
  fi

  echo "$default"
}

# ─── JSON Helpers ────────────────────────────────────────
# Simple JSON value extraction (no jq dependency for basic cases)
json_get() {
  local json="$1"
  local key="$2"

  if command -v jq &>/dev/null; then
    echo "$json" | jq -r ".$key // empty" 2>/dev/null
  else
    # Fallback: basic regex extraction for simple string values
    echo "$json" | grep -o "\"$key\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" | sed 's/.*: *"\([^"]*\)"/\1/' | head -1
  fi
}

# ─── Date Helpers ────────────────────────────────────────
today_iso() {
  date +%Y-%m-%d
}

days_since() {
  local past_date="$1"
  local today
  today=$(date +%s)
  local past
  past=$(date -j -f "%Y-%m-%d" "$past_date" +%s 2>/dev/null || date -d "$past_date" +%s 2>/dev/null || echo "$today")
  echo $(( (today - past) / 86400 ))
}

# ─── Cross-platform Timeout ─────────────────────────────
# GNU timeout is not available in Git Bash on Windows.
# Fallback: background process + kill.
run_with_timeout() {
  local seconds="$1"
  shift

  if command -v timeout &>/dev/null; then
    timeout "$seconds" "$@"
    return $?
  fi

  # Fallback for Git Bash / environments without timeout
  "$@" &
  local pid=$!
  ( sleep "$seconds"; kill "$pid" 2>/dev/null ) &
  local watchdog=$!
  wait "$pid" 2>/dev/null
  local exit_code=$?
  kill "$watchdog" 2>/dev/null
  wait "$watchdog" 2>/dev/null
  return $exit_code
}
