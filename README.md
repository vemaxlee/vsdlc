# vsdlc

VS Code / VS Code Insiders + Copilot 的全流程 SDLC 多智能体快速安装包。

## 包含内容

- `va-*` agents
- `sdlc-init` / `session-start` / `session-end` prompts
- 全局 `copilot-instructions.md`
- SDLC 项目模板 `sdlc-project-template`
- 一键初始化脚本 `sdlc-template-init`
- 项目级 MCP 模板 (`memory` / `playwright` / `context7`)
- 自检与回滚脚本
- Git hooks 模板

## 推荐安装

### WSL2 / Linux

```bash
bash install.sh
```

### Windows PowerShell

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

## 安装结果

- Agents 安装到 `~/.copilot/agents/`
- Prompts / Instructions 安装到 `~/.vscode-server-insiders/data/User/prompts/`
- 全局规则安装到 `~/.copilot/copilot-instructions.md`
- 模板安装到 `~/.copilot/templates/sdlc-project-template/`
- 初始化脚本安装到 `~/.copilot/bin/sdlc-template-init`

## 健康检查

```bash
bash scripts/health-check.sh
```

## 一键升级

### WSL2 / Linux

```bash
bash scripts/update.sh
```

### Windows PowerShell

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\update.ps1
```

说明：

- 若当前目录已配置 Git 远程，会先执行 `git pull --ff-only` 获取最新版本
- 随后自动执行安装脚本完成覆盖升级
- 全程保留备份，可用回滚脚本恢复

## 回滚

```bash
bash scripts/rollback.sh
```

## 新项目启动

在 Copilot Chat 中使用：

- `/sdlc-init`

或直接运行：

```bash
~/.copilot/bin/sdlc-template-init <target-dir> <project-name> <project-type> <tech-stack> <project-description>
```
