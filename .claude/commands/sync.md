AI 教练系统同步工具。执行参数：$ARGUMENTS

## 同步方向说明

| 方向 | 作用 | 使用场景 |
|------|------|---------|
| `push` | repo → 本机全局 `~/.claude/` | git pull 后、修改了教练配置后 |
| `pull` | 本机全局 `~/.claude/` → repo | 练习一段时间后，想把进度同步到远端 |

典型工作流：
```
在电脑 A 练完了：
  /sync pull  →  git add + commit + push

换到电脑 B 继续：
  git pull    →  /sync push
```

## 执行步骤

### Step 1：分析当前状态

检查以下信息：
1. 操作系统（Windows/macOS/Linux）
2. 当前 git 状态（是否有未提交的变更）
3. 用户指定的同步方向（从 $ARGUMENTS 解析，如果没有则询问）

### Step 2：确认同步方向

如果 $ARGUMENTS 中没有明确指定 push 或 pull，询问用户：
- "你想往哪个方向同步？push（部署到本机）还是 pull（拉取进度回 repo）？"

### Step 3：执行同步

根据操作系统选择脚本并执行：

**Windows**：
```powershell
.\scripts\sync.ps1 -Direction push
# 或
.\scripts\sync.ps1 -Direction pull
```

**macOS/Linux**：
```bash
./scripts/sync.sh push
# 或
./scripts/sync.sh pull
```

### Step 4：后续操作建议

同步完成后，根据方向给出建议：

**push 完成后**：
- 提示用户教练系统已在全局生效
- 告知可以在任何项目中使用

**pull 完成后**：
- 检查是否有未提交的变更（PROGRESS.md）
- 如果有，询问是否需要 git add + commit + push
- 可选：自动执行 git 操作（需用户确认）

## 冲突处理

如果同步过程中出现问题：
1. 停止并报告错误
2. 分析错误原因
3. 提供解决方案
4. 不擅自修改用户文件

## 注意事项

- CLAUDE.md 使用标记块合并（`<!-- AI-COACH-START -->` / `<!-- AI-COACH-END -->`）
- 不会覆盖用户在 `~/.claude/CLAUDE.md` 中的原有规则
- commands/ 只覆盖教练系统的文件，不影响用户自己的 commands
