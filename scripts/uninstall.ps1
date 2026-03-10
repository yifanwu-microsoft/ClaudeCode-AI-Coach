# AI Coach System Uninstall Tool
# Usage: .\scripts\uninstall.ps1

$ErrorActionPreference = "Stop"

$ClaudeHome = Join-Path $env:USERPROFILE ".claude"

$MarkerStart = "<!-- AI-COACH-START -->"
$MarkerEnd = "<!-- AI-COACH-END -->"

# No hardcoded list - we delete dynamically like install.ps1 copies

function Write-Info { param($Msg) Write-Host "[INFO] $Msg" -ForegroundColor Green }
function Write-Warn { param($Msg) Write-Host "[WARN] $Msg" -ForegroundColor Yellow }
function Write-Err  { param($Msg) Write-Host "[ERROR] $Msg" -ForegroundColor Red }

function Remove-CoachCommands {
    $commandsDir = Join-Path $ClaudeHome "commands"
    $removed = 0

    if (-not (Test-Path $commandsDir)) {
        Write-Info "No commands directory found, skipping"
        return
    }

    # Dynamic deletion: remove all .md files in commands/coach/
    $coachDir = Join-Path $commandsDir "coach"
    if (Test-Path $coachDir) {
        $commandFiles = Get-ChildItem (Join-Path $coachDir "*.md") -ErrorAction SilentlyContinue
        foreach ($file in $commandFiles) {
            Remove-Item $file.FullName -Force
            $removed++
        }
    }

    Write-Info "Removed $removed command file(s)"

    # Remove coach directory if empty
    $coachDir = Join-Path $commandsDir "coach"
    if (Test-Path $coachDir) {
        $coachRemaining = Get-ChildItem $coachDir -ErrorAction SilentlyContinue
        if ($null -eq $coachRemaining -or $coachRemaining.Count -eq 0) {
            Remove-Item $coachDir -Force
            Write-Info "Removed empty coach/ directory"
        }
    }

    # Remove commands/ dir if empty
    $remaining = Get-ChildItem $commandsDir -ErrorAction SilentlyContinue
    if ($null -eq $remaining -or $remaining.Count -eq 0) {
        Remove-Item $commandsDir -Force
        Write-Info "Removed empty commands/ directory"
    }
}

function Remove-ClaudeBlock {
    $targetFile = Join-Path $ClaudeHome "CLAUDE.md"

    if (-not (Test-Path $targetFile)) {
        Write-Info "No CLAUDE.md found, skipping"
        return
    }

    $content = Get-Content $targetFile -Raw -Encoding UTF8

    if (-not $content.Contains($MarkerStart)) {
        Write-Info "No AI Coach block found in CLAUDE.md, skipping"
        return
    }

    # Backup before modifying
    $backupFile = "$targetFile.bak"
    Copy-Item $targetFile $backupFile -Force
    Write-Info "Backed up CLAUDE.md to CLAUDE.md.bak"

    # Remove the marker block
    $startIdx = $content.IndexOf($MarkerStart)
    $endIdx = $content.IndexOf($MarkerEnd, $startIdx)

    if ($endIdx -gt $startIdx) {
        $before = $content.Substring(0, $startIdx)
        $after = $content.Substring($endIdx + $MarkerEnd.Length)
        $newContent = ($before + $after).Trim()

        if ([string]::IsNullOrWhiteSpace($newContent)) {
            Remove-Item $targetFile -Force
            Write-Info "CLAUDE.md was coach-only, removed entirely"
        } else {
            Set-Content $targetFile $newContent -Encoding UTF8 -NoNewline
            Write-Info "AI Coach block removed from CLAUDE.md (user rules preserved)"
        }
    }

    # Remove backup created during this uninstall
    if (Test-Path $backupFile) {
        Remove-Item $backupFile -Force
    }
}

function Remove-Progress {
    $progressFile = Join-Path $ClaudeHome "PROGRESS.md"

    if (-not (Test-Path $progressFile)) {
        Write-Info "No PROGRESS.md found, skipping"
        return
    }

    Remove-Item $progressFile -Force
    Write-Info "PROGRESS.md removed"
}

function Remove-Guide {
    $guideFile = Join-Path $ClaudeHome "ai-engineering-leveling-guide.md"

    if (Test-Path $guideFile) {
        Remove-Item $guideFile -Force
        Write-Info "ai-engineering-leveling-guide.md removed"
    } else {
        Write-Info "No guide file found, skipping"
    }
}

function Remove-AchievementTriggers {
    $achievementFile = Join-Path $ClaudeHome "achievement-triggers.md"

    if (Test-Path $achievementFile) {
        Remove-Item $achievementFile -Force
        Write-Info "achievement-triggers.md removed"
    } else {
        Write-Info "No achievement-triggers.md found, skipping"
    }
}

function Remove-Engine {
    $engineDir = Join-Path $ClaudeHome "coach-engine"

    if (Test-Path $engineDir) {
        Remove-Item $engineDir -Recurse -Force
        Write-Info "Coaching engine removed"
    } else {
        Write-Info "No coaching engine found, skipping"
    }
}

function Remove-Hooks {
    $settingsFile = Join-Path $ClaudeHome "settings.json"

    if (-not (Test-Path $settingsFile)) {
        Write-Info "No settings.json found, skipping hook removal"
        return
    }

    try {
        $settingsRaw = Get-Content $settingsFile -Raw -Encoding UTF8
        $settings = $settingsRaw | ConvertFrom-Json
    } catch {
        Write-Warn "Could not parse settings.json: $_"
        Write-Warn "Manually remove the on-stop.sh hook entry from $settingsFile"
        return
    }

    # Check if there are any coach hooks to remove
    $hasCoachHook = $false
    if ($settings.hooks -and $settings.hooks.Stop) {
        foreach ($entry in $settings.hooks.Stop) {
            # Check nested format: { matcher: "", hooks: [{ command: "..." }] }
            if ($entry.hooks) {
                foreach ($h in $entry.hooks) {
                    if ($h.command -and $h.command.Contains("on-stop.sh")) {
                        $hasCoachHook = $true
                        break
                    }
                }
            }
            # Check flat format: { command: "..." }
            if ($entry.command -and $entry.command.Contains("on-stop.sh")) {
                $hasCoachHook = $true
            }
            if ($hasCoachHook) { break }
        }
    }

    if (-not $hasCoachHook) {
        Write-Info "No coach hook found in settings.json, skipping"
        return
    }

    # Filter out coach hook entries from Stop array
    $filteredStop = @()
    foreach ($entry in $settings.hooks.Stop) {
        $isCoachEntry = $false

        # Check nested format
        if ($entry.hooks) {
            foreach ($h in $entry.hooks) {
                if ($h.command -and $h.command.Contains("on-stop.sh")) {
                    $isCoachEntry = $true
                    break
                }
            }
        }
        # Check flat format
        if ($entry.command -and $entry.command.Contains("on-stop.sh")) {
            $isCoachEntry = $true
        }

        if (-not $isCoachEntry) {
            $filteredStop += $entry
        }
    }

    # Update or remove the Stop key
    if ($filteredStop.Count -eq 0) {
        # Remove Stop key
        $settings.hooks.PSObject.Properties.Remove("Stop")
    } else {
        $settings.hooks.Stop = $filteredStop
    }

    # Check if hooks object is now empty
    $hooksProps = @($settings.hooks.PSObject.Properties)
    if ($hooksProps.Count -eq 0) {
        # Remove hooks key
        $settings.PSObject.Properties.Remove("hooks")
    }

    # Check if entire settings is now empty
    $settingsProps = @($settings.PSObject.Properties)
    if ($settingsProps.Count -eq 0) {
        Remove-Item $settingsFile -Force
        Write-Info "settings.json was coach-only, removed entirely"
    } else {
        $json = $settings | ConvertTo-Json -Depth 10
        [System.IO.File]::WriteAllText($settingsFile, $json, [System.Text.UTF8Encoding]::new($false))
        Write-Info "Coach hook removed from settings.json"
    }
}

function Remove-Backups {
    $claudeBak = Join-Path $ClaudeHome "CLAUDE.md.bak"
    if (Test-Path $claudeBak) {
        Remove-Item $claudeBak -Force
        Write-Info "Removed CLAUDE.md.bak"
    }
}

function Test-PostUninstall {
    $hasError = $false

    Write-Info "Running post-uninstall verification..."

    # Check coach commands directory is gone (or empty)
    $commandsDir = Join-Path $ClaudeHome "commands"
    $coachDir = Join-Path $commandsDir "coach"
    if (Test-Path $coachDir) {
        $remainingFiles = Get-ChildItem (Join-Path $coachDir "*.md") -ErrorAction SilentlyContinue
        if ($remainingFiles -and $remainingFiles.Count -gt 0) {
            foreach ($file in $remainingFiles) {
                Write-Err "Verification failed: $($file.Name) still exists in $ClaudeHome\commands\coach\"
            }
            $hasError = $true
        }
    }

    # Check CLAUDE.md marker block is gone
    $claudeFile = Join-Path $ClaudeHome "CLAUDE.md"
    if (Test-Path $claudeFile) {
        $content = Get-Content $claudeFile -Raw -Encoding UTF8
        if ($content.Contains($MarkerStart)) {
            Write-Err "Verification failed: AI Coach block still present in CLAUDE.md"
            $hasError = $true
        } else {
            # Verify CLAUDE.md still has content after removal
            if (-not [string]::IsNullOrWhiteSpace($content)) {
                Write-Info "CLAUDE.md cleaned successfully (user content preserved)"
            } else {
                Write-Err "Verification failed: CLAUDE.md is empty after cleanup"
                $hasError = $true
            }
        }
    }

    # Check guide is gone
    if (Test-Path (Join-Path $ClaudeHome "ai-engineering-leveling-guide.md")) {
        Write-Err "Verification failed: ai-engineering-leveling-guide.md still exists"
        $hasError = $true
    }

    # Check PROGRESS.md
    if (Test-Path (Join-Path $ClaudeHome "PROGRESS.md")) {
        Write-Err "Verification failed: PROGRESS.md still exists"
        $hasError = $true
    }

    # Check achievement-triggers.md is gone
    if (Test-Path (Join-Path $ClaudeHome "achievement-triggers.md")) {
        Write-Err "Verification failed: achievement-triggers.md still exists"
        $hasError = $true
    }

    # Check coach-engine/ directory is gone
    if (Test-Path (Join-Path $ClaudeHome "coach-engine")) {
        Write-Err "Verification failed: coach-engine/ directory still exists"
        $hasError = $true
    }

    # Check settings.json is still valid JSON (if it exists)
    $settingsFile = Join-Path $ClaudeHome "settings.json"
    if (Test-Path $settingsFile) {
        try {
            $null = Get-Content $settingsFile -Raw -Encoding UTF8 | ConvertFrom-Json
            Write-Info "settings.json is valid JSON after hook removal"
        } catch {
            Write-Err "Verification failed: settings.json is not valid JSON after cleanup"
            $hasError = $true
        }
    }

    if ($hasError) {
        Write-Err "Post-uninstall verification failed. Some files may remain."
        return $false
    }

    Write-Info "Post-uninstall verification passed"
    return $true
}

function Uninstall-CoachSystem {
    param(
        [switch]$Yes
    )

    Write-Info "Uninstalling AI Coach System from $ClaudeHome ..."

    # Confirm uninstall (skip with -Yes)
    if (-not $Yes) {
        $confirm = Read-Host "Are you sure you want to uninstall? [y/N]"
        if ($confirm -notmatch '^[Yy]$') {
            Write-Info "Uninstall cancelled."
            return
        }
    }

    # Step 1: Remove commands
    Remove-CoachCommands

    # Step 2: Remove coach block from CLAUDE.md
    Remove-ClaudeBlock

    # Step 3: Remove PROGRESS.md
    Remove-Progress

    # Step 4: Remove guide
    Remove-Guide

    # Step 5: Remove achievement triggers
    Remove-AchievementTriggers

    # Step 6: Remove coaching engine
    Remove-Engine

    # Step 7: Remove hooks from settings.json
    Remove-Hooks

    # Step 8: Clean up backups
    Remove-Backups

    # Step 9: Verify
    $verified = Test-PostUninstall

    Write-Host ""
    Write-Info "Uninstall complete! AI Coach has been removed."
}

# Parse -y/--yes flag
$autoYes = $args -contains '-y' -or $args -contains '--yes'
if ($autoYes) {
    Uninstall-CoachSystem -Yes
} else {
    Uninstall-CoachSystem
}
