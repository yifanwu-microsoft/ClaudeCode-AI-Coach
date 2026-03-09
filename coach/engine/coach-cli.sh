#!/usr/bin/env bash
# coach-cli.sh — AI Engineering Coach CLI
# Standalone coaching tool with no LLM dependency.
#
# Usage:
#   coach-cli assess    — Scan project and detect level
#   coach-cli tip       — Get a coaching tip for your level
#   coach-cli progress  — Show/update progress
#   coach-cli practice  — Get practice suggestions
#   coach-cli version   — Show version info

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

VERSION="1.0.0"

# ─── Commands ────────────────────────────────────────────

cmd_assess() {
  bash "$SCRIPT_DIR/assess.sh" "${1:-.}" "${2:-}"
}

cmd_tip() {
  local project_dir="${1:-.}"

  # Auto-detect context
  local tech_stack
  tech_stack=$(detect_tech_stack "$project_dir")
  local activity
  activity=$(detect_recent_activity "$project_dir")

  bash "$SCRIPT_DIR/tips.sh" \
    --stack "$tech_stack" \
    --activity "$activity" \
    "$@"
}

cmd_progress() {
  bash "$SCRIPT_DIR/progress.sh" "${1:-.}" "${2:-check}"
}

cmd_practice() {
  source "$SCRIPT_DIR/lib/progress-parser.sh"

  local current_level
  current_level=$(progress_get_level)
  local target_level
  target_level=$(progress_get_target)

  echo ""
  coach_info "${BOLD}Practice Suggestions${NC} (Level $current_level → $target_level)"
  echo ""

  case "$target_level" in
    1|2)
      echo "  1. Start 3 conversations with Claude Code today about your current work"
      echo "  2. For each AI-generated code, try to find one edge case it missed"
      echo "  3. Practice: accept, modify, or reject each AI suggestion with a reason"
      ;;
    3|4)
      echo "  1. Write a CLAUDE.md for your project with tech stack + conventions"
      echo "  2. Rewrite your last 3 prompts using the CRATE format"
      echo "  3. Use Plan Mode for your next multi-file task"
      echo "  4. Goal: get AI to produce acceptable code in ≤3 prompt rounds"
      ;;
    5)
      echo "  1. Rewrite a prompt replacing HOW with WHY/WHAT"
      echo "     Before: 'Add a useState for search filtering'"
      echo "     After:  'Users need to find items quickly in a 5000+ item list'"
      echo "  2. Delegate a complete feature (frontend + API + tests) to AI"
      echo "  3. Review AI's architecture choices — ask 'why this approach?'"
      echo "  4. Decompose a complex task into 3+ sub-tasks with dependencies"
      ;;
    6)
      echo "  1. Identify 2 tasks in your current work that have no data dependency"
      echo "  2. Try git worktree: create 2 worktrees and run Claude in each"
      echo "     git worktree add ../project-api feature/api"
      echo "     git worktree add ../project-ui feature/ui"
      echo "  3. Before parallel work, define the shared interface contract"
      echo "  4. Goal: complete a feature 2x faster with 2-3 parallel agents"
      ;;
    7)
      echo "  1. Create your first Custom Command in .claude/commands/"
      echo "  2. Add a PostToolUse hook for type-checking after file edits"
      echo "  3. Target: 5+ commands covering your daily workflows"
      echo "  4. Graduation test: Can a fresh Claude complete a CRUD page"
      echo "     using only your CLAUDE.md + Commands?"
      ;;
    8)
      echo "  1. Write a script using 'claude -p' to batch-generate test files"
      echo "  2. Set up a GitHub Action for AI-powered PR review"
      echo "  3. Configure auto-fix pipeline for CI failures"
      echo "  4. Set up cost monitoring and billing alerts"
      echo "  5. ⚠️ Remember: AI PRs must ALWAYS require human review"
      ;;
    *)
      echo "  Run 'coach-cli assess' first to determine your level."
      ;;
  esac

  echo ""
  echo -e "  ${DIM}For interactive practice, use /coach:practice in Claude Code${NC}"
  echo ""
}

cmd_version() {
  echo "AI Engineering Coach CLI v$VERSION"
  echo "Part of the ClaudeCode-AI-Coach system"
}

cmd_help() {
  echo ""
  echo "  AI Engineering Coach CLI v$VERSION"
  echo ""
  echo "  Usage: coach-cli <command> [options]"
  echo ""
  echo "  Commands:"
  echo "    assess    Scan project and detect AI engineering level"
  echo "    tip       Get a coaching tip for your level"
  echo "    progress  Show progress and suggest updates"
  echo "    practice  Get practice suggestions for your target level"
  echo "    version   Show version info"
  echo "    help      Show this help message"
  echo ""
  echo "  Examples:"
  echo "    coach-cli assess              # Scan current directory"
  echo "    coach-cli assess /path/to/project"
  echo "    coach-cli tip                 # Get a context-aware tip"
  echo "    coach-cli progress            # Check mode (dry run)"
  echo "    coach-cli progress . apply    # Apply assessment date update"
  echo ""
}

# ─── Main ────────────────────────────────────────────────

main() {
  local command="${1:-help}"
  shift || true

  case "$command" in
    assess)   cmd_assess "$@" ;;
    tip)      cmd_tip "$@" ;;
    progress) cmd_progress "$@" ;;
    practice) cmd_practice "$@" ;;
    version)  cmd_version ;;
    help|-h|--help) cmd_help ;;
    *)
      coach_error "Unknown command: $command"
      cmd_help
      exit 1
      ;;
  esac
}

main "$@"
