# AI Coach System Install Tool
# Usage: .\scripts\install.ps1 [-Lang en|zh]

param(
    [ValidateSet("en", "zh")]
    [string]$Lang = "zh"
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$ClaudeHome = Join-Path $env:USERPROFILE ".claude"

$MarkerStart = "<!-- AI-COACH-START -->"
$MarkerEnd = "<!-- AI-COACH-END -->"

# Track temp files for cleanup
$script:TempFiles = @()

function Write-Info { param($Msg) Write-Host "[INFO] $Msg" -ForegroundColor Green }
function Write-Warn { param($Msg) Write-Host "[WARN] $Msg" -ForegroundColor Yellow }
function Write-Err  { param($Msg) Write-Host "[ERROR] $Msg" -ForegroundColor Red }

function Remove-TempFiles {
    foreach ($f in $script:TempFiles) {
        if (Test-Path $f) {
            Remove-Item $f -Force -ErrorAction SilentlyContinue
        }
    }
}

function Test-Preflight {
    $hasError = $false

    if (-not (Test-Path (Join-Path $RepoRoot "CLAUDE.md"))) {
        Write-Err "CLAUDE.md not found in repo root ($RepoRoot)"
        Write-Err "Are you running this script from the correct repository?"
        $hasError = $true
    }

    if (-not (Test-Path (Join-Path $RepoRoot "PROGRESS.md"))) {
        Write-Err "PROGRESS.md not found in repo root ($RepoRoot)"
        $hasError = $true
    }

    if (-not (Test-Path (Join-Path $RepoRoot "ai-engineering-leveling-guide.md"))) {
        Write-Err "ai-engineering-leveling-guide.md not found in repo root ($RepoRoot)"
        $hasError = $true
    }

    if ($hasError) {
        Write-Err "Pre-flight check failed. Aborting installation."
        exit 1
    }

    Write-Info "Pre-flight check passed"
}

function Test-PostInstall {
    $hasError = $false

    Write-Info "Running post-install verification..."

    if (-not (Test-Path (Join-Path $ClaudeHome "CLAUDE.md"))) {
        Write-Err "Verification failed: CLAUDE.md not found in $ClaudeHome"
        $hasError = $true
    }

    if (-not (Test-Path (Join-Path $ClaudeHome "PROGRESS.md"))) {
        Write-Err "Verification failed: PROGRESS.md not found in $ClaudeHome"
        $hasError = $true
    }

    if (-not (Test-Path (Join-Path $ClaudeHome "commands" "assess.md"))) {
        Write-Err "Verification failed: commands/assess.md not found in $ClaudeHome"
        $hasError = $true
    }

    if ($hasError) {
        Write-Err "Post-install verification failed. Installation may be incomplete."
        return $false
    }

    Write-Info "Post-install verification passed"
    return $true
}

function Get-SourcePaths {
    if ($Lang -eq "en") {
        return @{
            ClaudeMd = Join-Path $RepoRoot "en\CLAUDE.md"
            Progress = Join-Path $RepoRoot "en\PROGRESS.md"
            Guide    = Join-Path $RepoRoot "en\ai-engineering-leveling-guide.md"
            Commands = Join-Path $RepoRoot "en\commands"
        }
    } else {
        return @{
            ClaudeMd = Join-Path $RepoRoot "CLAUDE.md"
            Progress = Join-Path $RepoRoot "PROGRESS.md"
            Guide    = Join-Path $RepoRoot "ai-engineering-leveling-guide.md"
            Commands = Join-Path $RepoRoot ".claude\commands"
        }
    }
}

function Install-CoachSystem {
    try {
        # Pre-flight validation
        Test-Preflight

        $paths = Get-SourcePaths

        if ($Lang -eq "en") {
            Write-Info "Installing AI Coach System (English) to $ClaudeHome ..."
        } else {
            Write-Info "Installing AI Coach to $ClaudeHome ..."
        }

        # Create directory
        $commandsDir = Join-Path $ClaudeHome "commands"
        if (-not (Test-Path $commandsDir)) {
            New-Item -ItemType Directory -Path $commandsDir -Force | Out-Null
        }

        # 1. Install commands/
        $sourceCommands = $paths.Commands
        if (Test-Path $sourceCommands) {
            $commandFiles = Get-ChildItem "$sourceCommands\*.md" -ErrorAction SilentlyContinue
            foreach ($file in $commandFiles) {
                Copy-Item $file.FullName $commandsDir -Force
            }
            Write-Info "Commands installed"
        }

        # 2. Sync CLAUDE.md (marker block merge)
        $sourceFile = $paths.ClaudeMd
        $targetFile = Join-Path $ClaudeHome "CLAUDE.md"

        # Fallback to Chinese if English not found
        if (-not (Test-Path $sourceFile)) {
            Write-Warn "CLAUDE.md source not found at $sourceFile, falling back to Chinese"
            $sourceFile = Join-Path $RepoRoot "CLAUDE.md"
        }

        $sourceContent = Get-Content $sourceFile -Raw -Encoding UTF8
        $coachBlock = $MarkerStart + "`r`n" + $sourceContent + "`r`n" + $MarkerEnd

        if (Test-Path $targetFile) {
            # Backup before modifying
            $backupFile = "$targetFile.bak"
            Copy-Item $targetFile $backupFile -Force
            Write-Info "Backed up existing CLAUDE.md to CLAUDE.md.bak"

            $targetContent = Get-Content $targetFile -Raw -Encoding UTF8

            if ($targetContent.Contains($MarkerStart)) {
                $startIdx = $targetContent.IndexOf($MarkerStart)
                $endIdx = $targetContent.IndexOf($MarkerEnd, $startIdx)

                if ($endIdx -gt $startIdx) {
                    $before = $targetContent.Substring(0, $startIdx)
                    $after = $targetContent.Substring($endIdx + $MarkerEnd.Length)
                    $newContent = $before + $coachBlock + $after
                    Set-Content $targetFile $newContent -Encoding UTF8 -NoNewline
                    Write-Info "CLAUDE.md coach block updated (preserving existing rules)"
                }
            }
            else {
                $newContent = $targetContent.TrimEnd() + "`r`n`r`n" + $coachBlock + "`r`n"
                Set-Content $targetFile $newContent -Encoding UTF8 -NoNewline
                Write-Info "CLAUDE.md coach block appended (existing rules unaffected)"
            }
        }
        else {
            Set-Content $targetFile $coachBlock -Encoding UTF8 -NoNewline
            Write-Info "CLAUDE.md created"
        }

        # 3. PROGRESS.md (only create if not exists — protect local progress)
        $progressFile = Join-Path $ClaudeHome "PROGRESS.md"
        if (Test-Path $progressFile) {
            Write-Warn "PROGRESS.md already exists, skipping (protecting local progress)"
            Write-Warn "To reset, manually delete ~/.claude/PROGRESS.md and re-run install"
        }
        else {
            $progressSource = $paths.Progress
            if (-not (Test-Path $progressSource)) {
                $progressSource = Join-Path $RepoRoot "PROGRESS.md"
            }
            Copy-Item $progressSource $ClaudeHome -Force
            Write-Info "PROGRESS.md created (initial state)"
        }

        # 4. Sync guide
        $guideSource = $paths.Guide
        if (Test-Path $guideSource) {
            Copy-Item $guideSource $ClaudeHome -Force
            Write-Info "Guide installed"
        } elseif (Test-Path (Join-Path $RepoRoot "ai-engineering-leveling-guide.md")) {
            Copy-Item (Join-Path $RepoRoot "ai-engineering-leveling-guide.md") $ClaudeHome -Force
            Write-Info "Guide installed (fallback to Chinese)"
        }

        # Post-install verification
        Test-PostInstall | Out-Null

        Write-Host ""
        if ($Lang -eq "en") {
            Write-Info "Install complete! AI Coach is now globally active."
            Write-Info "Open Claude Code in any project and run /assess for initial evaluation."
        } else {
            Write-Info "Install complete! AI Coach is now globally active."
            Write-Info "Open Claude Code in any project and run /assess for initial evaluation."
        }
    }
    finally {
        Remove-TempFiles
    }
}

Install-CoachSystem
