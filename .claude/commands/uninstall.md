AI 教练系统一键卸载。执行此命令后自动完成卸载，用户无需手动操作。

## 执行步骤

### Step 1：确认卸载意图

询问用户：
- 是否保留 PROGRESS.md（包含学习进度数据）
- 默认建议保留（`--keep-progress`）

### Step 2：检测环境并执行卸载

1. 检测当前操作系统
2. 确认当前目录是 AI Coach repo（检查 scripts/uninstall.sh 是否存在）
3. 如果不在 repo 目录中，提示用户先 `cd` 到 repo 目录
4. 根据用户选择执行卸载脚本：
   - macOS/Linux：`chmod +x scripts/uninstall.sh && ./scripts/uninstall.sh [--keep-progress]`
   - Windows：`powershell -File scripts\uninstall.ps1 [-KeepProgress]`

### Step 3：验证卸载结果

卸载脚本内置了验证，但额外检查以下内容：
- `~/.claude/CLAUDE.md` 中不再包含 `<!-- AI-COACH-START -->` 标记
- `~/.claude/commands/` 中不再包含教练系统的命令文件（assess.md, practice.md 等）
- `~/.claude/ai-engineering-leveling-guide.md` 已删除
- 如果用户选择删除进度：`~/.claude/PROGRESS.md` 已删除

如果任何验证失败，报告错误并给出手动清理建议。

### Step 4：卸载后说明

- 告知用户：✅ 卸载完成！教练系统已从本机移除
- 如果保留了 PROGRESS.md，说明：你的学习进度已保留，重新安装后可继续
- 提示：如需重新安装，执行 `/install`

## 注意事项

- 卸载只移除教练系统安装的内容，不影响 CLAUDE.md 中用户自己的规则
- 建议默认保留 PROGRESS.md，避免丢失学习进度
- 卸载后 `/assess`、`/practice` 等命令将不再可用
