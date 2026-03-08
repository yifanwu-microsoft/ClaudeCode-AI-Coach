<#
.SYNOPSIS
    将 AI 教练系统同步到/从全局 ~/.claude/ 目录

.DESCRIPTION
    push: 部署 repo 配置到本机 $env:USERPROFILE\.claude\
    pull: 拉取本机 PROGRESS.md 回 repo

.PARAMETER Direction
    同步方向：push 或 pull

.EXAMPLE
    .\scripts\sync.ps1 -Direction push
    .\scripts\sync.ps1 -Direction pull
#>

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
    Write-Info "开始部署到 $ClaudeHome ..."

    # 创建目录
    $commandsDir = Join-Path $ClaudeHome "commands"
    New-Item -ItemType Directory -Path $commandsDir -Force | Out-Null

    # 1. 同步 commands/
    $sourceCommands = Join-Path $RepoRoot ".claude\commands"
    if (Test-Path $sourceCommands) {
        Get-ChildItem "$sourceCommands\*.md" | ForEach-Object {
            Copy-Item $_.FullName $commandsDir -Force
        }
        Write-Info "Commands 已同步"
    }

    # 2. 同步 CLAUDE.md（标记块合并）
    $sourceContent = Get-Content (Join-Path $RepoRoot "CLAUDE.md") -Raw -Encoding UTF8
    $coachBlock = "$MarkerStart`r`n$sourceContent`r`n$MarkerEnd"

    $targetFile = Join-Path $ClaudeHome "CLAUDE.md"
    if (Test-Path $targetFile) {
        $targetContent = Get-Content $targetFile -Raw -Encoding UTF8
        if ($targetContent -match [regex]::Escape($MarkerStart)) {
            # 替换已有的教练块
            $pattern = "(?s)" + [regex]::Escape($MarkerStart) + ".*?" + [regex]::Escape($MarkerEnd)
            $targetContent = $targetContent -replace $pattern, $coachBlock
            Set-Content $targetFile $targetContent -Encoding UTF8 -NoNewline
            Write-Info "CLAUDE.md 教练块已更新（保留原有规则）"
        }
        else {
            # 追加教练块
            $targetContent = $targetContent.TrimEnd() + "`r`n`r`n$coachBlock`r`n"
            Set-Content $targetFile $targetContent -Encoding UTF8 -NoNewline
            Write-Info "CLAUDE.md 教练块已追加（原有规则不受影响）"
        }
    }
    else {
        Set-Content $targetFile $coachBlock -Encoding UTF8 -NoNewline
        Write-Info "CLAUDE.md 已创建"
    }

    # 3. 同步 PROGRESS.md
    Copy-Item (Join-Path $RepoRoot "PROGRESS.md") $ClaudeHome -Force
    Write-Info "PROGRESS.md 已同步"

    # 4. 同步参考文档
    $guideFile = Join-Path $RepoRoot "ai-engineering-leveling-guide.md"
    if (Test-Path $guideFile) {
        Copy-Item $guideFile $ClaudeHome -Force
        Write-Info "参考文档已同步"
    }

    Write-Host ""
    Write-Info "✅ 部署完成！教练系统已在本机全局生效。"
    Write-Info "在任何项目中打开 Claude Code 即可使用。"
}

function Pull-FromGlobal {
    Write-Info "从 $ClaudeHome 拉取进度 ..."

    $globalProgress = Join-Path $ClaudeHome "PROGRESS.md"
    if (Test-Path $globalProgress) {
        Copy-Item $globalProgress (Join-Path $RepoRoot "PROGRESS.md") -Force
        Write-Info "✅ PROGRESS.md 已拉取到 repo"
        Write-Host ""
        Write-Info "下一步：git add PROGRESS.md && git commit -m 'chore: sync progress' && git push"
    }
    else {
        Write-Warn "未找到 $globalProgress，无需拉取"
    }
}

# 主逻辑
switch ($Direction) {
    "push" { Push-ToGlobal }
    "pull" { Pull-FromGlobal }
}
