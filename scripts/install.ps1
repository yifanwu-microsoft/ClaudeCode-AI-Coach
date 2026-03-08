# AI Coach System Install Tool
# Usage: .\scripts\install.ps1

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

    if (-not (Test-Path (Join-Path $RepoRoot "coach" "CLAUDE.md"))) {
        Write-Err "CLAUDE.md not found in repo root ($RepoRoot)"
        Write-Err "Are you running this script from the correct repository?"
        $hasError = $true
    }

    if (-not (Test-Path (Join-Path $RepoRoot "coach" "PROGRESS.md"))) {
        Write-Err "PROGRESS.md not found in repo root ($RepoRoot)"
        $hasError = $true
    }

    if (-not (Test-Path (Join-Path $RepoRoot "coach" "ai-engineering-leveling-guide.md"))) {
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

    if (-not (Test-Path (Join-Path $ClaudeHome "commands" "coach" "assess.md"))) {
        Write-Err "Verification failed: commands/coach/assess.md not found in $ClaudeHome"
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
    return @{
        ClaudeMd = Join-Path $RepoRoot "coach" "CLAUDE.md"
        Progress = Join-Path $RepoRoot "coach" "PROGRESS.md"
        Guide    = Join-Path $RepoRoot "coach" "ai-engineering-leveling-guide.md"
        Commands = Join-Path $RepoRoot "coach\commands"
    }
}

function Install-CoachSystem {
    $installStarted = $false
    try {
        # Pre-flight validation
        Test-Preflight

        $paths = Get-SourcePaths
        $installStarted = $true

        Write-Info "Installing AI Coach System to $ClaudeHome ..."

        # Create directory
        $commandsDir = Join-Path $ClaudeHome "commands"
        if (-not (Test-Path $commandsDir)) {
            New-Item -ItemType Directory -Path $commandsDir -Force | Out-Null
        }

        # 1. Install commands/
        $sourceCommands = $paths.Commands
        if (Test-Path $sourceCommands) {
            # Create coach subdirectory
            $coachDir = Join-Path $commandsDir "coach"
            New-Item -ItemType Directory -Force -Path $coachDir | Out-Null
            # Copy coach namespace commands
            $commandFiles = Get-ChildItem (Join-Path $sourceCommands "coach" "*.md") -ErrorAction SilentlyContinue
            foreach ($file in $commandFiles) {
                Copy-Item $file.FullName $coachDir -Force
            }
            # Verify critical command files were copied
            $criticalCommands = @("coach\assess.md", "coach\practice.md", "coach\progress-report.md", "coach\review-prompt.md")
            $verifyFailed = $false
            foreach ($cmd in $criticalCommands) {
                if (-not (Test-Path (Join-Path $commandsDir $cmd))) {
                    Write-Err "Critical command file missing after copy: $cmd"
                    $verifyFailed = $true
                }
            }
            if ($verifyFailed) {
                Write-Err "Command installation failed. Please check source directory: $sourceCommands"
                Write-Err "To clean up a partial install, run: .\scripts\uninstall.ps1"
                exit 1
            }
            Write-Info "Commands installed"
        }

        # 2. Sync CLAUDE.md (marker block merge)
        $sourceFile = $paths.ClaudeMd
        $targetFile = Join-Path $ClaudeHome "CLAUDE.md"

        if (-not (Test-Path $sourceFile)) {
            Write-Err "CLAUDE.md not found at $sourceFile"
            exit 1
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
                    [System.IO.File]::WriteAllText($targetFile, $newContent, [System.Text.UTF8Encoding]::new($false))
                    Write-Info "CLAUDE.md coach block updated (preserving existing rules)"
                }
            }
            else {
                $newContent = $targetContent.TrimEnd() + "`r`n`r`n" + $coachBlock + "`r`n"
                [System.IO.File]::WriteAllText($targetFile, $newContent, [System.Text.UTF8Encoding]::new($false))
                Write-Info "CLAUDE.md coach block appended (existing rules unaffected)"
            }

            # Clean up backup file after successful update
            if (Test-Path "$targetFile.bak") {
                Remove-Item "$targetFile.bak" -Force
                Write-Info "Removed CLAUDE.md.bak (update successful)"
            }
        }
        else {
            $coachContent = $coachBlock + "`r`n"
            [System.IO.File]::WriteAllText($targetFile, $coachContent, [System.Text.UTF8Encoding]::new($false))
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
                $progressSource = Join-Path $RepoRoot "coach" "PROGRESS.md"
            }
            Copy-Item $progressSource $ClaudeHome -Force
            Write-Info "PROGRESS.md created (initial state)"
        }

        # 4. Sync guide
        $guideSource = $paths.Guide
        if (Test-Path $guideSource) {
            Copy-Item $guideSource $ClaudeHome -Force
            Write-Info "Guide installed"
        } else {
            Write-Err "Guide not found at $guideSource"
            exit 1
        }

        # Post-install verification
        Test-PostInstall | Out-Null

        Write-Host ""
        Write-Info "Install complete! AI Coach is now globally active."
        $progressFile = Join-Path $ClaudeHome "PROGRESS.md"
        if ((Test-Path $progressFile) -and (Select-String -Path $progressFile -Pattern "Pending Assessment" -Quiet)) {
            Write-Info "Initial assessment will begin automatically - stay in this session."
        } else {
            Write-Info "Configuration updated. Your progress has been preserved."
        }
    }
    finally {
        Remove-TempFiles
    }
}

trap {
    Write-Err "Installation failed: $_"
    Write-Err "To clean up a partial install, run: .\scripts\uninstall.ps1"
    Remove-TempFiles
    exit 1
}

Install-CoachSystem
