#!/usr/bin/env bash
# progress-parser.sh — Read/write PROGRESS.md fields
# Sourced by other engine scripts, not run directly.

# ─── Read Fields ─────────────────────────────────────────

progress_get_level() {
  local file="${1:-$PROGRESS_FILE}"
  if [ -f "$file" ]; then
    grep "Current Level" "$file" | grep -o '[0-9]\+' | head -1
  else
    echo "0"
  fi
}

progress_get_target() {
  local file="${1:-$PROGRESS_FILE}"
  if [ -f "$file" ]; then
    grep "Target Level" "$file" | grep -o '[0-9]\+' | head -1
  else
    echo "0"
  fi
}

progress_get_date() {
  local file="${1:-$PROGRESS_FILE}"
  if [ -f "$file" ]; then
    grep "Assessment Date" "$file" | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}' | head -1
  else
    echo ""
  fi
}

# Get sub-skill status for a specific level
# Returns lines like: "Sub-skill Name | 🟢 Verified"
progress_get_subskills() {
  local level="$1"
  local file="${2:-$PROGRESS_FILE}"

  if [ ! -f "$file" ]; then
    return
  fi

  # Find the section for this level and extract sub-skill rows
  local in_section=0
  local level_pattern

  case "$level" in
    1|2) level_pattern="Level 1-2" ;;
    3|4) level_pattern="Level 3-4" ;;
    5)   level_pattern="Level 5 Sub" ;;
    6)   level_pattern="Level 6 Sub" ;;
    7)   level_pattern="Level 7 Sub" ;;
    8)   level_pattern="Level 8 Sub" ;;
    *)   return ;;
  esac

  while IFS= read -r line; do
    if echo "$line" | grep -q "$level_pattern"; then
      in_section=1
      continue
    fi
    if [ "$in_section" -eq 1 ]; then
      # Stop at next section header
      if echo "$line" | grep -q "^## "; then
        break
      fi
      # Extract table rows with status emoji
      if echo "$line" | grep -q "🟢\|🟡\|🔴"; then
        echo "$line"
      fi
    fi
  done < "$file"
}

# Count sub-skills by status for a level
progress_count_status() {
  local level="$1"
  local status_emoji="$2"  # 🟢, 🟡, or 🔴
  local file="${3:-$PROGRESS_FILE}"

  progress_get_subskills "$level" "$file" | grep -c "$status_emoji" || echo "0"
}

# Get all red (not started) sub-skills across all levels
progress_get_red_subskills() {
  local file="${1:-$PROGRESS_FILE}"
  local result=""

  for level in 2 4 5 6 7 8; do
    local skills
    skills=$(progress_get_subskills "$level" "$file")
    if [ -n "$skills" ]; then
      local red_skills
      red_skills=$(echo "$skills" | grep "🔴" || true)
      if [ -n "$red_skills" ]; then
        result+="$red_skills"$'\n'
      fi
    fi
  done

  echo "$result"
}

# ─── Write Fields ────────────────────────────────────────

# Update the assessment date in PROGRESS.md
progress_update_date() {
  local file="${1:-$PROGRESS_FILE}"
  local new_date
  new_date=$(today_iso)

  if [ -f "$file" ]; then
    sed -i.bak "s/\*\*Assessment Date\*\*: [0-9-]*/\*\*Assessment Date\*\*: $new_date/" "$file"
    rm -f "$file.bak"
  fi
}

# Append a milestone entry
progress_add_milestone() {
  local milestone="$1"
  local notes="${2:-}"
  local file="${3:-$PROGRESS_FILE}"
  local date
  date=$(today_iso)

  if [ -f "$file" ]; then
    # Find the milestone log table and append before the comment block
    local tmp
    tmp=$(mktemp)
    local inserted=0
    while IFS= read -r line; do
      if [ "$inserted" -eq 0 ] && echo "$line" | grep -q "^<!-- $\|^<!-- Update Guide"; then
        echo "| $date | $milestone | $notes |" >> "$tmp"
        inserted=1
      fi
      echo "$line" >> "$tmp"
    done < "$file"
    mv "$tmp" "$file"
  fi
}
