#!/usr/bin/env bash
# test-worktree.sh — Set up a git worktree for testing the installed AI Coach experience
# Usage: ./scripts/test-worktree.sh [--setup|--cleanup|--help]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
WORKTREE_PATH="${WORKTREE_PATH:-$REPO_ROOT/../coach-test-worktree}"
WORKTREE_BRANCH="${WORKTREE_BRANCH:-test-worktree}"

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
err()   { echo -e "${RED}[ERROR]${NC} $1"; }

usage() {
    cat <<EOF
Usage: ./scripts/test-worktree.sh [OPTION]

Set up or tear down a git worktree for testing the AI Coach installation
in an isolated project that has no coach files of its own.

Options:
  --setup      Create the test worktree (default if no args)
  --cleanup    Remove the test worktree and its branch
  --help       Show this help message

Environment variables:
  WORKTREE_PATH    Path for the worktree (default: ../coach-test-worktree)
  WORKTREE_BRANCH  Branch name to use  (default: test-worktree)
EOF
}

# --- Setup flow -----------------------------------------------------------

setup_worktree() {
    info "Setting up test worktree..."

    # Guard: worktree already exists
    if [ -d "$WORKTREE_PATH" ]; then
        err "Test worktree already exists at $WORKTREE_PATH"
        err "Run './scripts/test-worktree.sh --cleanup' first, or set WORKTREE_PATH to a different location."
        exit 1
    fi

    # Create an orphan branch so it starts with no coach files
    if git -C "$REPO_ROOT" rev-parse --verify "$WORKTREE_BRANCH" >/dev/null 2>&1; then
        warn "Branch '$WORKTREE_BRANCH' already exists, reusing it"
    else
        info "Creating orphan branch '$WORKTREE_BRANCH'..."
        git -C "$REPO_ROOT" checkout --orphan "$WORKTREE_BRANCH" >/dev/null 2>&1
        git -C "$REPO_ROOT" rm -rf . >/dev/null 2>&1
        git -C "$REPO_ROOT" commit --allow-empty -m "Initial empty commit for test worktree" >/dev/null 2>&1
        # Return to the previous branch
        git -C "$REPO_ROOT" checkout - >/dev/null 2>&1
        info "Orphan branch '$WORKTREE_BRANCH' created"
    fi

    # Create the worktree
    info "Creating worktree at $WORKTREE_PATH..."
    git -C "$REPO_ROOT" worktree add "$WORKTREE_PATH" "$WORKTREE_BRANCH" >/dev/null 2>&1
    info "Worktree created"

    # Populate a minimal test project
    info "Creating minimal test project files..."

    cat > "$WORKTREE_PATH/README.md" <<'PROJECT_README'
# Test Project
This is a test project for verifying the AI Coach installation.
PROJECT_README

    cat > "$WORKTREE_PATH/package.json" <<'PROJECT_PKG'
{
  "name": "coach-test-project",
  "version": "1.0.0"
}
PROJECT_PKG

    mkdir -p "$WORKTREE_PATH/src"
    cat > "$WORKTREE_PATH/src/index.js" <<'PROJECT_SRC'
console.log("Hello from the test project!");
PROJECT_SRC

    # Commit the test files so the worktree is clean
    git -C "$WORKTREE_PATH" add -A >/dev/null 2>&1
    git -C "$WORKTREE_PATH" commit -m "Add minimal test project files" >/dev/null 2>&1
    info "Test project files committed"

    echo ""
    info "✅ Test worktree created at: $WORKTREE_PATH"
    echo ""
    echo "Next steps:"
    echo "  1. Install the coach:  cd $REPO_ROOT && ./scripts/install.sh"
    echo "  2. Open the test worktree in Claude Code:  cd $WORKTREE_PATH && claude"
    echo "  3. Verify: project scope has NO coach instructions, user scope has coach active"
    echo "  4. Test commands: /coach:assess, /coach:practice, etc."
    echo "  5. When done:  ./scripts/test-worktree.sh --cleanup"
}

# --- Cleanup flow ----------------------------------------------------------

cleanup_worktree() {
    info "Cleaning up test worktree..."

    # Remove the worktree
    if [ -d "$WORKTREE_PATH" ]; then
        info "Removing worktree at $WORKTREE_PATH..."
        git -C "$REPO_ROOT" worktree remove "$WORKTREE_PATH" --force >/dev/null 2>&1
        info "Worktree removed"
    else
        warn "No worktree found at $WORKTREE_PATH, skipping removal"
    fi

    # Prune stale worktree references
    git -C "$REPO_ROOT" worktree prune >/dev/null 2>&1

    # Delete the orphan branch
    if git -C "$REPO_ROOT" rev-parse --verify "$WORKTREE_BRANCH" >/dev/null 2>&1; then
        info "Deleting branch '$WORKTREE_BRANCH'..."
        git -C "$REPO_ROOT" branch -D "$WORKTREE_BRANCH" >/dev/null 2>&1
        info "Branch deleted"
    else
        warn "Branch '$WORKTREE_BRANCH' not found, skipping"
    fi

    echo ""
    info "✅ Cleanup complete!"
}

# --- Argument parsing ------------------------------------------------------

ACTION="setup"

if [[ $# -gt 0 ]]; then
    case "$1" in
        --setup)
            ACTION="setup"
            ;;
        --cleanup)
            ACTION="cleanup"
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            err "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
fi

case "$ACTION" in
    setup)   setup_worktree  ;;
    cleanup) cleanup_worktree ;;
esac
