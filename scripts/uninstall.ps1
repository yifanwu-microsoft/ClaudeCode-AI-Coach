# AI Coach System Uninstall Tool
# Usage: .\scripts\uninstall.ps1 [-KeepProgress]

param(
    [switch]$KeepProgress
)

$ErrorActionPreference = "Stop"

$ClaudeHome = Join-Path $env:USERPROFILE ".claude"

$MarkerStart = "<!-- AI-COACH-START -->"
$MarkerEnd = "<!-- AI-COACH-END -->"

# Coach command files installed by install.ps1
$CoachCommands = @(
    "coach\assess.md",
    "coach\install.md",
    "coach\uninstall.md",
    "coach\practice.md",
    "coach\progress-report.md",
    "coach\review-prompt.md",
    "coach\i18n.md"
)

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

    foreach ($cmd in $CoachCommands) {
        $cmdPath = Join-Path $commandsDir $cmd
        if (Test-Path $cmdPath) {
            Remove-Item $cmdPath -Force
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

    if ($KeepProgress) {
        Write-Warn "Keeping PROGRESS.md (-KeepProgress flag set)"
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

    # Check coach commands are gone
    foreach ($cmd in $CoachCommands) {
        $cmdPath = Join-Path $ClaudeHome "commands" $cmd
        if (Test-Path $cmdPath) {
            Write-Err "Verification failed: $cmd still exists in $ClaudeHome\commands\"
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
        }
    }

    # Check guide is gone
    if (Test-Path (Join-Path $ClaudeHome "ai-engineering-leveling-guide.md")) {
        Write-Err "Verification failed: ai-engineering-leveling-guide.md still exists"
        $hasError = $true
    }

    # Check PROGRESS.md (only if not keeping)
    if (-not $KeepProgress -and (Test-Path (Join-Path $ClaudeHome "PROGRESS.md"))) {
        Write-Err "Verification failed: PROGRESS.md still exists"
        $hasError = $true
    }

    if ($hasError) {
        Write-Err "Post-uninstall verification failed. Some files may remain."
        return $false
    }

    Write-Info "Post-uninstall verification passed"
    return $true
}

function Uninstall-CoachSystem {
    Write-Info "Uninstalling AI Coach System from $ClaudeHome ..."

    # Confirm uninstall
    $confirm = Read-Host "Are you sure you want to uninstall? [y/N]"
    if ($confirm -notmatch '^[Yy]$') {
        Write-Info "Uninstall cancelled."
        return
    }

    # Step 1: Remove commands
    Remove-CoachCommands

    # Step 2: Remove coach block from CLAUDE.md
    Remove-ClaudeBlock

    # Step 3: Remove PROGRESS.md (unless -KeepProgress)
    Remove-Progress

    # Step 4: Remove guide
    Remove-Guide

    # Step 5: Clean up backups
    Remove-Backups

    # Step 6: Verify
    $verified = Test-PostUninstall

    Write-Host ""
    Write-Info "Uninstall complete! AI Coach has been removed."
    if ($KeepProgress) {
        Write-Warn "PROGRESS.md was kept at $ClaudeHome\PROGRESS.md"
    }
}

Uninstall-CoachSystem
