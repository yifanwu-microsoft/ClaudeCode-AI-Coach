#!/usr/bin/env bash
# dev-worktree.sh — Git worktree manager for parallel development
# Usage: ./scripts/dev-worktree.sh --create <name> [--from <branch>]
#        ./scripts/dev-worktree.sh --list
#        ./scripts/dev-worktree.sh --remove <name>

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
WORKTREE_PREFIX="coach-wt"

# Color output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
err()   { echo -e "${RED}[ERROR]${NC} $1"; }

usage() {
    cat <<EOF
Usage: ./scripts/dev-worktree.sh <command> [options]

Git worktree manager for parallel AI Coach development.
Each worktree is an isolated workspace — no coach duplication with user scope.

Commands:
  --create <name> [--from <branch>]   Create a new development worktree
  --list                              List all active worktrees
  --remove <name>                     Remove a worktree and its branch
  --help                              Show this help

Examples:
  ./scripts/dev-worktree.sh --create fix-assess         # Branch from HEAD
  ./scripts/dev-worktree.sh --create new-level --from main
  ./scripts/dev-worktree.sh --list
  ./scripts/dev-worktree.sh --remove fix-assess

Worktrees are created at: ../${WORKTREE_PREFIX}-<name>/
Branches are named:        wt/<name>
EOF
}

# --- Create worktree -------------------------------------------------------

create_worktree() {
    local name="$1"
    local from_branch="${2:-HEAD}"
    local wt_path="$REPO_ROOT/../${WORKTREE_PREFIX}-${name}"
    local branch_name="wt/${name}"

    if [ -d "$wt_path" ]; then
        err "Worktree already exists at $wt_path"
        err "Use --remove $name first, or choose a different name."
        exit 1
    fi

    if git -C "$REPO_ROOT" rev-parse --verify "$branch_name" >/dev/null 2>&1; then
        warn "Branch '$branch_name' already exists, reusing it"
        info "Creating worktree at $wt_path..."
        git -C "$REPO_ROOT" worktree add "$wt_path" "$branch_name"
    else
        info "Creating worktree at $wt_path (branch: $branch_name from $from_branch)..."
        git -C "$REPO_ROOT" worktree add -b "$branch_name" "$wt_path" "$from_branch"
    fi

    echo ""
    info "✅ Worktree '${name}' ready!"
    echo ""
    echo -e "  ${CYAN}cd $wt_path${NC}"
    echo ""
    echo "  The worktree has no coach duplication with user scope:"
    echo "    • Root CLAUDE.md = dev config (not coach prompt)"
    echo "    • Coach source files are in coach/ (not auto-loaded)"
    echo "    • .claude/commands/coach/install.md = project-scope install only"
    echo ""
    echo "  Workflow:"
    echo "    1. Make changes in the worktree"
    echo "    2. Test: ./scripts/install.sh → open another project → verify coach"
    echo "    3. Commit & push, then create PR to merge into main"
    echo "    4. Clean up: ./scripts/dev-worktree.sh --remove ${name}"
}

# --- List worktrees --------------------------------------------------------

list_worktrees() {
    info "Active worktrees:"
    echo ""
    git -C "$REPO_ROOT" worktree list
    echo ""

    local wt_count
    wt_count=$(git -C "$REPO_ROOT" worktree list | wc -l)
    if [ "$wt_count" -le 1 ]; then
        echo "  No development worktrees. Create one with: --create <name>"
    fi
}

# --- Remove worktree -------------------------------------------------------

remove_worktree() {
    local name="$1"
    local wt_path="$REPO_ROOT/../${WORKTREE_PREFIX}-${name}"
    local branch_name="wt/${name}"

    if [ ! -d "$wt_path" ]; then
        err "No worktree found at $wt_path"
        exit 1
    fi

    # Check for uncommitted changes
    if ! git -C "$wt_path" diff --quiet 2>/dev/null || ! git -C "$wt_path" diff --cached --quiet 2>/dev/null; then
        warn "Worktree has uncommitted changes!"
        printf "Remove anyway? [y/N]: "
        read -r confirm
        if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
            info "Cancelled."
            exit 0
        fi
    fi

    info "Removing worktree at $wt_path..."
    git -C "$REPO_ROOT" worktree remove "$wt_path" --force
    info "Worktree removed"

    git -C "$REPO_ROOT" worktree prune >/dev/null 2>&1

    if git -C "$REPO_ROOT" rev-parse --verify "$branch_name" >/dev/null 2>&1; then
        info "Deleting branch '$branch_name'..."
        git -C "$REPO_ROOT" branch -D "$branch_name" 2>/dev/null || \
            warn "Could not delete branch '$branch_name' (may be merged or protected)"
    fi

    echo ""
    info "✅ Worktree '${name}' cleaned up!"
}

# --- Argument parsing -------------------------------------------------------

if [[ $# -eq 0 ]]; then
    usage
    exit 0
fi

case "$1" in
    --create)
        if [[ $# -lt 2 ]]; then
            err "Missing worktree name. Usage: --create <name> [--from <branch>]"
            exit 1
        fi
        NAME="$2"
        FROM="HEAD"
        if [[ $# -ge 4 ]] && [[ "$3" == "--from" ]]; then
            FROM="$4"
        fi
        create_worktree "$NAME" "$FROM"
        ;;
    --list|-l)
        list_worktrees
        ;;
    --remove)
        if [[ $# -lt 2 ]]; then
            err "Missing worktree name. Usage: --remove <name>"
            exit 1
        fi
        remove_worktree "$2"
        ;;
    --help|-h)
        usage
        ;;
    *)
        err "Unknown command: $1"
        usage
        exit 1
        ;;
esac
