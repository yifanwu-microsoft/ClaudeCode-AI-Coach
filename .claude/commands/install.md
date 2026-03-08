AI 教练系统一键安装。执行此命令后自动完成安装，用户无需手动操作。

## 执行步骤

### Step 1：检测环境并执行安装

1. 检测当前操作系统
2. 确认当前目录是 AI Coach repo（检查 CLAUDE.md 和 scripts/ 是否存在）
3. 如果不在 repo 目录中，提示用户先 `cd` 到 repo 目录
4. 直接执行安装脚本：
   - macOS/Linux：`chmod +x scripts/install.sh && ./scripts/install.sh`
   - Windows：`powershell -File scripts\install.ps1`

**直接执行，不要询问确认。**

### Step 2：验证安装结果

安装脚本执行后，验证关键文件是否到位：
- 检查 `~/.claude/CLAUDE.md` 是否存在
- 检查 `~/.claude/commands/assess.md` 是否存在
- 检查 `~/.claude/PROGRESS.md` 是否存在

如果任何文件缺失，报告错误并给出修复建议。

### Step 3：安装后引导

根据情况给出不同引导：

**首次安装**（安装脚本输出中包含"已创建"）：
- 告知用户：✅ 安装成功！教练系统已全局生效
- 建议：现在可以去任何项目中打开 Claude Code，输入 `/assess` 进行首次评估
- 说明：之后每次交互 Claude 会自动附加教练反馈，无需额外操作

**更新安装**（安装脚本输出中包含"已存在，跳过"）：
- 告知用户：✅ 配置已更新！你的进度不受影响
- 说明：Commands 和 CLAUDE.md 规则已更新到最新版本

## 注意事项

- 安装不会覆盖已有的 PROGRESS.md（保护本机进度）
- CLAUDE.md 使用标记块合并，不影响用户自己的规则
- 如需重置进度，手动删除 `~/.claude/PROGRESS.md` 后重新执行 `/install`
