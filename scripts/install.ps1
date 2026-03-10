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

    # Check A: CLAUDE.md exists
    if (-not (Test-Path (Join-Path $coachPath "CLAUDE.md"))) {
        Write-Err "CLAUDE.md not found in coach/ directory"
        Write-Err "Are you running this script from the correct repository?"
        $hasError = $true
    }

    # Check B: PROGRESS.template.md exists
    if (-not (Test-Path (Join-Path $coachPath "PROGRESS.template.md"))) {
        Write-Err "PROGRESS.template.md not found in coach/ directory"
        $hasError = $true
    }

    # Check C: Guide exists
    if (-not (Test-Path (Join-Path $coachPath "ai-engineering-leveling-guide.md"))) {
        Write-Err "ai-engineering-leveling-guide.md not found in coach/ directory"
        $hasError = $true
    }

    # Check D: Engine directory exists
    if (-not (Test-Path (Join-Path $coachPath "engine"))) {
        Write-Err "coach/engine/ directory not found in coach/ directory"
        $hasError = $true
    }

    if ($hasError) {
        Write-Err "Pre-flight check failed. Aborting installation."
        exit 1
    }

    # Check E: PROGRESS.template.md must have "Pending Assessment" as default
    $progressTemplate = Join-Path $coachPath "PROGRESS.template.md"
    $progressContent = Get-Content $progressTemplate -Raw -Encoding UTF8
    if ($progressContent -match "Pending Assessment") {
        Write-Info "PROGRESS.template.md has correct default (Pending Assessment)"
    } else {
        Write-Err "PROGRESS.template.md MUST have 'Current Level: Pending Assessment' as default"
        Write-Err "This is required to trigger initial assessment on first install."
        Write-Err "Fix: Update coach/PROGRESS.template.md with 'Current Level: Pending Assessment'"
        $hasError = $true
    }

    # Check F: Command files must not be empty
    $cmdDir = Join-Path (Join-Path (Join-Path $coachPath "templates") "commands") "coach"
    if (Test-Path $cmdDir) {
        $cmdFiles = Get-ChildItem (Join-Path $cmdDir "*.md") -ErrorAction SilentlyContinue
        foreach ($file in $cmdFiles) {
            if ($file.Length -eq 0) {
                Write-Err "Command file is empty: $($file.FullName)"
                $hasError = $true
            }
        }
        Write-Info "Command files content validated"
    }

    # Check G/H: Shell script syntax validation is N/A on Windows
    # (bash -n requires a POSIX shell which may not be available)
    Write-Info "Shell script syntax check skipped (N/A on Windows)"

    if ($hasError) {
        Write-Err "Pre-flight check failed. Please fix the errors above."
        exit 1
    }

    Write-Info "Pre-flight check passed"
}

function Test-PostInstall {
    $hasError = $false

    Write-Info "Running post-install verification..."

    # Check CLAUDE.md exists and has valid marker block
    $claudeFile = Join-Path $ClaudeHome "CLAUDE.md"
    if (-not (Test-Path $claudeFile)) {
        Write-Err "Verification failed: CLAUDE.md not found in $ClaudeHome"
        $hasError = $true
    } else {
        $claudeContent = Get-Content $claudeFile -Raw -Encoding UTF8
        if ($claudeContent.Contains("AI-COACH-START") -and $claudeContent.Contains("AI-COACH-END")) {
            Write-Info "CLAUDE.md marker block integrity verified"
        } else {
            Write-Err "Verification failed: CLAUDE.md missing AI-COACH markers"
            $hasError = $true
        }
    }

    # Check PROGRESS.md exists and has expected structure
    $progressFile = Join-Path $ClaudeHome "PROGRESS.md"
    if (-not (Test-Path $progressFile)) {
        Write-Err "Verification failed: PROGRESS.md not found in $ClaudeHome"
        $hasError = $true
    } else {
        $progressContent = Get-Content $progressFile -Raw -Encoding UTF8
        if ($progressContent -match "Current Level" -and $progressContent -match "Sub-skill") {
            Write-Info "PROGRESS.md structure verified"
        } else {
            Write-Err "Verification failed: PROGRESS.md missing expected sections"
            $hasError = $true
        }
    }

    # Check assess.md command
    $assessPath = Join-Path (Join-Path (Join-Path $ClaudeHome "commands") "coach") "assess.md"
    if (-not (Test-Path $assessPath)) {
        Write-Err "Verification failed: commands/coach/assess.md not found in $ClaudeHome"
        $hasError = $true
    }

    # Check coach-engine/coach-cli.sh exists
    $cliPath = Join-Path (Join-Path $ClaudeHome "coach-engine") "coach-cli.sh"
    if (-not (Test-Path $cliPath)) {
        Write-Err "Verification failed: coach-engine/coach-cli.sh not found"
        $hasError = $true
    }

    # Check coach-engine/hooks/on-stop.sh exists
    $hookPath = Join-Path (Join-Path (Join-Path $ClaudeHome "coach-engine") "hooks") "on-stop.sh"
    if (-not (Test-Path $hookPath)) {
        Write-Err "Verification failed: coach-engine/hooks/on-stop.sh not found"
        $hasError = $true
    }

    # Check settings.json is valid JSON (if exists)
    $settingsFile = Join-Path $ClaudeHome "settings.json"
    if (Test-Path $settingsFile) {
        try {
            $null = Get-Content $settingsFile -Raw -Encoding UTF8 | ConvertFrom-Json
            Write-Info "settings.json is valid JSON"
        } catch {
            Write-Err "Verification failed: settings.json is not valid JSON"
            $hasError = $true
        }
    }

    if ($hasError) {
        Write-Err "Post-install verification failed. Installation may be incomplete."
        Write-Err "Run .\scripts\uninstall.ps1 to clean up and try again."
        return $false
    }

    Write-Info "Post-install verification passed"
    return $true
}

function Get-SourcePaths {
    $coachPath = Join-Path $RepoRoot "coach"
    return @{
        ClaudeMd            = Join-Path $coachPath "CLAUDE.md"
        Progress            = Join-Path $coachPath "PROGRESS.template.md"
        Guide               = Join-Path $coachPath "ai-engineering-leveling-guide.md"
        AchievementTriggers = Join-Path $coachPath "achievement-triggers.md"
        Commands            = Join-Path (Join-Path $coachPath "templates") "commands"
        Engine              = Join-Path $coachPath "engine"
        Hooks               = Join-Path $coachPath "hooks"
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

        # 3. PROGRESS.md (only create if not exists - protect local progress)
        $progressFile = Join-Path $ClaudeHome "PROGRESS.md"
        if (Test-Path $progressFile) {
            Write-Warn "PROGRESS.md already exists, skipping (protecting local progress)"
            Write-Warn "To reset, manually delete ~/.claude/PROGRESS.md and re-run install"
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

        # 5. Sync achievement triggers
        $achievementSource = $paths.AchievementTriggers
        if (Test-Path $achievementSource) {
            Copy-Item $achievementSource (Join-Path $ClaudeHome "achievement-triggers.md") -Force
            Write-Info "Achievement triggers installed"
        }

        # 6. Install coaching engine
        $engineSource = $paths.Engine
        if (Test-Path $engineSource) {
            $engineDest = Join-Path $ClaudeHome "coach-engine"
            New-Item -ItemType Directory -Force -Path (Join-Path $engineDest "lib") | Out-Null
            New-Item -ItemType Directory -Force -Path (Join-Path $engineDest "tips") | Out-Null
            New-Item -ItemType Directory -Force -Path (Join-Path $engineDest "state") | Out-Null

            # Copy engine scripts
            foreach ($script in @("coach-cli.sh", "tips.sh", "progress.sh", "tier2-prompt.md", "config.default.json")) {
                $srcFile = Join-Path $engineSource $script
                if (Test-Path $srcFile) {
                    Copy-Item $srcFile (Join-Path $engineDest $script) -Force
                }
            }

            # Copy lib/
            $libSource = Join-Path $engineSource "lib"
            if (Test-Path $libSource) {
                $libFiles = Get-ChildItem (Join-Path $libSource "*.sh") -ErrorAction SilentlyContinue
                foreach ($file in $libFiles) {
                    Copy-Item $file.FullName (Join-Path $engineDest "lib") -Force
                }
            }

            # Copy tips database
            $tipsSource = Join-Path $engineSource "tips"
            if (Test-Path $tipsSource) {
                $tipsFiles = Get-ChildItem (Join-Path $tipsSource "*.json") -ErrorAction SilentlyContinue
                foreach ($file in $tipsFiles) {
                    Copy-Item $file.FullName (Join-Path $engineDest "tips") -Force
                }
            }

            # chmod +x is N/A on Windows, skipping

            # Create default config if not exists
            $configDefault = Join-Path $engineSource "config.default.json"
            $configDest = Join-Path $engineDest "config.json"
            if ((-not (Test-Path $configDest)) -and (Test-Path $configDefault)) {
                Copy-Item $configDefault $configDest -Force
            }

            Write-Info "Coaching engine installed"
        }

        # 7. Install hooks + settings.json
        $hooksSource = $paths.Hooks
        if (Test-Path $hooksSource) {
            $hooksDest = Join-Path (Join-Path $ClaudeHome "coach-engine") "hooks"
            New-Item -ItemType Directory -Force -Path $hooksDest | Out-Null

            Copy-Item (Join-Path $hooksSource "on-stop.sh") (Join-Path $hooksDest "on-stop.sh") -Force
            # chmod +x is N/A on Windows

            # Check if bash is available (needed for hook execution)
            $bashAvailable = $null -ne (Get-Command "bash" -ErrorAction SilentlyContinue)
            if (-not $bashAvailable) {
                Write-Warn "bash not found in PATH. The coach hook requires bash (e.g., Git Bash) to run."
                Write-Warn "Install Git for Windows or add bash to PATH for full coaching functionality."
            }

            # Merge hooks config into settings.json
            $settingsFile = Join-Path $ClaudeHome "settings.json"
            # Use forward slashes + ~ for the hook command (executed inside bash)
            $hookCmd = "bash ~/.claude/coach-engine/hooks/on-stop.sh"

            if (Test-Path $settingsFile) {
                try {
                    $settingsRaw = Get-Content $settingsFile -Raw -Encoding UTF8
                    $settings = $settingsRaw | ConvertFrom-Json

                    # Check if our hook is already configured
                    $hookExists = $false
                    if ($settings.hooks -and $settings.hooks.Stop) {
                        foreach ($entry in $settings.hooks.Stop) {
                            # Check nested format: { matcher: "", hooks: [{ command: "..." }] }
                            if ($entry.hooks) {
                                foreach ($h in $entry.hooks) {
                                    if ($h.command -and $h.command.Contains("on-stop.sh")) {
                                        $hookExists = $true
                                        break
                                    }
                                }
                            }
                            # Check flat format: { command: "..." }
                            if ($entry.command -and $entry.command.Contains("on-stop.sh")) {
                                $hookExists = $true
                            }
                            if ($hookExists) { break }
                        }
                    }

                    if (-not $hookExists) {
                        # Add our hook to existing config
                        if (-not $settings.hooks) {
                            $settings | Add-Member -NotePropertyName "hooks" -NotePropertyValue ([PSCustomObject]@{}) -Force
                        }
                        if (-not $settings.hooks.Stop) {
                            $settings.hooks | Add-Member -NotePropertyName "Stop" -NotePropertyValue @() -Force
                        }

                        $newHookEntry = [PSCustomObject]@{
                            matcher = ""
                            hooks   = @(
                                [PSCustomObject]@{
                                    type    = "command"
                                    command = $hookCmd
                                }
                            )
                        }

                        # Convert to list, add entry, convert back
                        $stopList = [System.Collections.ArrayList]@($settings.hooks.Stop)
                        $null = $stopList.Add($newHookEntry)
                        $settings.hooks.Stop = @($stopList)

                        $json = $settings | ConvertTo-Json -Depth 10
                        [System.IO.File]::WriteAllText($settingsFile, $json, [System.Text.UTF8Encoding]::new($false))
                        Write-Info "Coach hook added to existing settings.json"
                    } else {
                        Write-Info "Coach hook already configured in settings.json"
                    }
                } catch {
                    Write-Warn "Could not parse settings.json: $_"
                    Write-Warn "Manually add to $settingsFile`:"
                    Write-Warn "  `"hooks`": { `"Stop`": [{ `"matcher`": `"`", `"hooks`": [{ `"type`": `"command`", `"command`": `"$hookCmd`" }] }] }"
                }
            } else {
                # Create new settings.json with hook
                $newSettings = [PSCustomObject]@{
                    hooks = [PSCustomObject]@{
                        Stop = @(
                            [PSCustomObject]@{
                                matcher = ""
                                hooks   = @(
                                    [PSCustomObject]@{
                                        type    = "command"
                                        command = $hookCmd
                                    }
                                )
                            }
                        )
                    }
                }
                $json = $newSettings | ConvertTo-Json -Depth 10
                [System.IO.File]::WriteAllText($settingsFile, $json, [System.Text.UTF8Encoding]::new($false))
                Write-Info "settings.json created with coach hook"
            }

            Write-Info "Hooks installed"
        }

        # Post-install verification
        $verified = Test-PostInstall
        if ($verified -eq $false) {
            exit 1
        }

        Write-Host ""
        Write-Info "Install complete! AI Coach is now globally active."
        # Match install.sh logic: check PROGRESS.md content for "Pending Assessment"
        $progressFile = Join-Path $ClaudeHome "PROGRESS.md"
        if ((Test-Path $progressFile) -and ((Get-Content $progressFile -Raw -Encoding UTF8) -match "Pending Assessment")) {
            Write-Info "Initial assessment will begin automatically - stay in this session."
            Write-Host "INSTALL_STATUS: FIRST_INSTALL"
        } else {
            Write-Info "Configuration updated. Your progress has been preserved."
            Write-Host "INSTALL_STATUS: UPDATE"
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
