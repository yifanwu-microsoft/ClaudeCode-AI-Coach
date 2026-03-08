# AI Coach System Sync Tool
# Usage: .\scripts\sync.ps1 -Direction push|pull

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("push", "pull")]
    [string]$Direction
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$ClaudeHome = Join-Path $env:USERPROFILE ".claude"

$MarkerStart = "<!-- AI-COACH-START -->"
$MarkerEnd = "<!-- AI-COACH-END -->"

function Write-Info { param($Msg) Write-Host "[INFO] $Msg" -ForegroundColor Green }
function Write-Warn { param($Msg) Write-Host "[WARN] $Msg" -ForegroundColor Yellow }

function Push-ToGlobal {
    Write-Info "Deploying to $ClaudeHome ..."

    # Create directory
    $commandsDir = Join-Path $ClaudeHome "commands"
    if (-not (Test-Path $commandsDir)) {
        New-Item -ItemType Directory -Path $commandsDir -Force | Out-Null
    }

    # 1. Sync commands/
    $sourceCommands = Join-Path $RepoRoot ".claude\commands"
    if (Test-Path $sourceCommands) {
        $commandFiles = Get-ChildItem "$sourceCommands\*.md" -ErrorAction SilentlyContinue
        foreach ($file in $commandFiles) {
            Copy-Item $file.FullName $commandsDir -Force
        }
        Write-Info "Commands synced"
    }

    # 2. Sync CLAUDE.md (marker block merge)
    $sourceFile = Join-Path $RepoRoot "CLAUDE.md"
    $targetFile = Join-Path $ClaudeHome "CLAUDE.md"

    $sourceContent = Get-Content $sourceFile -Raw -Encoding UTF8
    $coachBlock = $MarkerStart + "`r`n" + $sourceContent + "`r`n" + $MarkerEnd

    if (Test-Path $targetFile) {
        $targetContent = Get-Content $targetFile -Raw -Encoding UTF8

        if ($targetContent.Contains($MarkerStart)) {
            # Replace existing coach block
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
            # Append coach block
            $newContent = $targetContent.TrimEnd() + "`r`n`r`n" + $coachBlock + "`r`n"
            Set-Content $targetFile $newContent -Encoding UTF8 -NoNewline
            Write-Info "CLAUDE.md coach block appended (existing rules unaffected)"
        }
    }
    else {
        Set-Content $targetFile $coachBlock -Encoding UTF8 -NoNewline
        Write-Info "CLAUDE.md created"
    }

    # 3. Sync PROGRESS.md
    Copy-Item (Join-Path $RepoRoot "PROGRESS.md") $ClaudeHome -Force
    Write-Info "PROGRESS.md synced"

    # 4. Sync guide
    $guideFile = Join-Path $RepoRoot "ai-engineering-leveling-guide.md"
    if (Test-Path $guideFile) {
        Copy-Item $guideFile $ClaudeHome -Force
        Write-Info "Guide synced"
    }

    Write-Host ""
    Write-Info "Deploy complete! AI Coach is now globally active."
    Write-Info "You can use it in any project with Claude Code."
}

function Pull-FromGlobal {
    Write-Info "Pulling progress from $ClaudeHome ..."

    $globalProgress = Join-Path $ClaudeHome "PROGRESS.md"
    if (Test-Path $globalProgress) {
        Copy-Item $globalProgress (Join-Path $RepoRoot "PROGRESS.md") -Force
        Write-Info "PROGRESS.md pulled to repo"
        Write-Host ""
        Write-Info "Next: git add PROGRESS.md ; git commit -m 'chore: sync progress' ; git push"
    }
    else {
        Write-Warn "No PROGRESS.md found at $globalProgress"
    }
}

# Main logic
if ($Direction -eq "push") {
    Push-ToGlobal
}
elseif ($Direction -eq "pull") {
    Pull-FromGlobal
}
