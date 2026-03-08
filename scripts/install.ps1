# AI Coach System Install Tool
# Usage: .\scripts\install.ps1

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$ClaudeHome = Join-Path $env:USERPROFILE ".claude"

$MarkerStart = "<!-- AI-COACH-START -->"
$MarkerEnd = "<!-- AI-COACH-END -->"

function Write-Info { param($Msg) Write-Host "[INFO] $Msg" -ForegroundColor Green }
function Write-Warn { param($Msg) Write-Host "[WARN] $Msg" -ForegroundColor Yellow }

function Install-CoachSystem {
    Write-Info "Installing AI Coach to $ClaudeHome ..."

    # Create directory
    $commandsDir = Join-Path $ClaudeHome "commands"
    if (-not (Test-Path $commandsDir)) {
        New-Item -ItemType Directory -Path $commandsDir -Force | Out-Null
    }

    # 1. Install commands/
    $sourceCommands = Join-Path $RepoRoot ".claude\commands"
    if (Test-Path $sourceCommands) {
        $commandFiles = Get-ChildItem "$sourceCommands\*.md" -ErrorAction SilentlyContinue
        foreach ($file in $commandFiles) {
            Copy-Item $file.FullName $commandsDir -Force
        }
        Write-Info "Commands installed"
    }

    # 2. Sync CLAUDE.md (marker block merge)
    $sourceFile = Join-Path $RepoRoot "CLAUDE.md"
    $targetFile = Join-Path $ClaudeHome "CLAUDE.md"

    $sourceContent = Get-Content $sourceFile -Raw -Encoding UTF8
    $coachBlock = $MarkerStart + "`r`n" + $sourceContent + "`r`n" + $MarkerEnd

    if (Test-Path $targetFile) {
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
        Copy-Item (Join-Path $RepoRoot "PROGRESS.md") $ClaudeHome -Force
        Write-Info "PROGRESS.md created (initial state)"
    }

    # 4. Sync guide
    $guideFile = Join-Path $RepoRoot "ai-engineering-leveling-guide.md"
    if (Test-Path $guideFile) {
        Copy-Item $guideFile $ClaudeHome -Force
        Write-Info "Guide installed"
    }

    Write-Host ""
    Write-Info "Install complete! AI Coach is now globally active."
    Write-Info "Open Claude Code in any project and run /assess for initial evaluation."
}

Install-CoachSystem
