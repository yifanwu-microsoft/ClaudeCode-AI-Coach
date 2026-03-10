# AI Coach System Install Tool
# Usage: .\scripts\install.ps1
# Can also be invoked via: powershell -ExecutionPolicy Bypass -File ".\scripts\install.ps1"

param([string]$RepoRoot = "")

$ErrorActionPreference = "Stop"

# Robust RepoRoot detection - handles invocation from bash, direct PowerShell, etc.
if ([string]::IsNullOrEmpty($RepoRoot)) {
    # Try $MyInvocation.MyCommand.Path first (works when called directly)
    if ($MyInvocation.MyCommand.Path) {
        $RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
    }
    # Fallback: try $PSScriptRoot (works in some contexts)
    elseif ($PSScriptRoot) {
        $RepoRoot = Split-Path -Parent $PSScriptRoot
    }
    # Final fallback: use current directory and verify
    else {
        $RepoRoot = $PWD.Path
        # If we're in scripts directory, go up one level
        if ($RepoRoot -like "*scripts") {
            $RepoRoot = Split-Path -Parent $RepoRoot
        }
    }
}

$ClaudeHome = Join-Path $env:USERPROFILE ".claude"

$MarkerStart = "<!-- AI-COACH-START -->"
$MarkerEnd = "<!-- AI-COACH-END -->"

# Track temp files for cleanup
$script:TempFiles = @()
$script:IsUpdate = $false

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

    Write-Info "Repo root: $RepoRoot"

    $coachPath = Join-Path $RepoRoot "coach"
    if (-not (Test-Path (Join-Path $coachPath "CLAUDE.md"))) {
        Write-Err "CLAUDE.md not found in coach/ directory"
        Write-Err "Are you running this script from the correct repository?"
        $hasError = $true
    }

    if (-not (Test-Path (Join-Path $coachPath "PROGRESS.template.md"))) {
        Write-Err "PROGRESS.template.md not found in coach/ directory"
        $hasError = $true
    }

    if (-not (Test-Path (Join-Path $coachPath "ai-engineering-leveling-guide.md"))) {
        Write-Err "ai-engineering-leveling-guide.md not found in coach/ directory"
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

    $assessPath = Join-Path (Join-Path $ClaudeHome "commands") "coach"
    $assessPath = Join-Path $assessPath "assess.md"
    if (-not (Test-Path $assessPath)) {
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
    $coachPath = Join-Path $RepoRoot "coach"
    return @{
        ClaudeMd = Join-Path $coachPath "CLAUDE.md"
        Progress = Join-Path $coachPath "PROGRESS.template.md"
        Guide    = Join-Path $coachPath "ai-engineering-leveling-guide.md"
        Commands = Join-Path (Join-Path $coachPath "templates") "commands"
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
            $sourceCoachDir = Join-Path $sourceCommands "coach"
            $commandFiles = Get-ChildItem (Join-Path $sourceCoachDir "*.md") -ErrorAction SilentlyContinue
            foreach ($file in $commandFiles) {
                Copy-Item $file.FullName $coachDir -Force
            }
            # Verify critical command files were copied
            $criticalCommands = @("assess.md", "practice.md", "progress-report.md", "review-prompt.md")
            $verifyFailed = $false
            foreach ($cmd in $criticalCommands) {
                $cmdPath = Join-Path $coachDir $cmd
                if (-not (Test-Path $cmdPath)) {
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
            $script:IsUpdate = $true
        }
        else {
            $progressSource = $paths.Progress
            if (-not (Test-Path $progressSource)) {
                $progressSource = Join-Path (Join-Path $RepoRoot "coach") "PROGRESS.template.md"
            }
            # Copy with explicit destination filename to ensure correct name
            Copy-Item $progressSource $progressFile -Force
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
        if ($script:IsUpdate) {
            Write-Info "Configuration updated. Your progress has been preserved."
            Write-Host "INSTALL_STATUS: UPDATE"
        } else {
            Write-Info "Initial assessment will begin automatically - stay in this session."
            Write-Host "INSTALL_STATUS: FIRST_INSTALL"
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
