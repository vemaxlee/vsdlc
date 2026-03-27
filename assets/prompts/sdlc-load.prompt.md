---
description: "载入旧项目并接入/补齐 SDLC 工作流 - 自动识别是否已接入，再继续开发"
agent: "va-pm"
---

# SDLC 旧项目载入

你正在执行 SDLC 旧项目载入与恢复开发流程。

兼容命令入口:
- `/sdlc-load`

目标:
1. 自动识别当前工作区是否已经接入 SDLC
2. 如果未接入，则在不破坏现有代码的前提下补齐 SDLC 管理骨架
3. 如果部分接入，则只补缺失项，不覆盖已有业务文件和文档
4. 如果已完整接入，则直接恢复上下文并继续推进开发

## 执行原则

- 默认在当前工作区根目录执行
- 优先复用现有命令和模板，不重复发明流程
- 严禁覆盖用户现有业务代码、配置和需求文档
- 仅补齐缺失的 SDLC 文件和目录
- 能自动判断时直接执行，不额外询问用户
- 只有在项目类型/技术栈/需求来源无法可靠推断时，才使用 `vscode_askQuestions`
- 所有对话框必须包含 `稍后处理`

## 第一步: 检测当前项目状态

检查以下标志物是否存在:

- `.github/copilot-instructions.md`
- `docs/project-state.md`
- `docs/session-handover/latest.md`
- `docs/task-todo/`
- `docs/task-done/`
- `docs/requirements/`
- `docs/architecture/`
- `docs/api-contracts/`
- `.devconfig/`

同时扫描现有项目信息来源:

- `README.md`
- `package.json`
- `pyproject.toml`
- `requirements.txt`
- `go.mod`
- `Cargo.toml`
- 现有 `docs/`、`spec/`、`design/`、`architecture/` 等说明文件
- Git 仓库状态与默认分支

## 第二步: 状态分类

按以下规则分类:

### A. 已完整接入 SDLC

满足以下核心条件:
- `docs/project-state.md` 存在
- `docs/session-handover/latest.md` 存在
- `docs/task-todo/` 存在
- `.github/copilot-instructions.md` 存在

处理方式:
- 直接执行与 `/session-start` 等价的恢复流程
- 读取项目状态、交接文档、待办任务
- 汇报当前阶段、阻塞项、推荐动作
- 根据阶段自动委派到合适 Agent 继续执行

### B. 部分接入 SDLC

表现为:
- 已有部分 `docs/` 或 `.github/` 结构
- 存在 `project-state.md` 或任务目录中的一部分，但不完整

处理方式:
- 仅补齐缺失的 SDLC 目录和文件
- 保留并复用已有状态、需求、架构、任务文档
- 若已有内容与模板冲突，以现有项目内容为准，只做最小补充
- 补齐后自动进入 `/session-start` 恢复流程

### C. 尚未接入 SDLC 的旧项目

表现为:
- 没有核心 SDLC 标志物
- 但已有业务代码、配置、README、需求文档或 Git 历史

处理方式:
- 按“旧项目接入”模式执行，不能当作空白新项目处理
- 优先把已有 README、现有 docs、issue 描述、接口说明视为需求来源
- 自动推断项目类型与技术栈；若结论不唯一，再弹框确认
- 使用全局模板和脚本补齐 SDLC 骨架，但不得覆盖现有业务文件
- 初始化完成后自动进入 `/session-start` 恢复流程

## 第三步: 补齐策略

优先使用全局模板:
- `~/.copilot/templates/sdlc-project-template/`

优先使用初始化脚本:
- `~/.copilot/bin/sdlc-template-init`

但在旧项目模式下，必须遵守以下规则:

1. 只创建缺失的 SDLC 文件和目录
2. 若目标文件已存在，只在确认是模板占位/空壳时才更新
3. 不覆盖现有 `README.md`，除非用户明确要求
4. 不修改现有业务代码目录结构
5. 如项目已有 `.git/`，保留现有历史

最少应补齐这些内容:

- `.github/copilot-instructions.md`
- `docs/project-state.md`
- `docs/session-handover/latest.md`
- `docs/task-todo/.gitkeep`
- `docs/task-done/.gitkeep`
- `docs/requirements/.gitkeep`
- `docs/architecture/adr/.gitkeep`
- `docs/api-contracts/.gitkeep`
- `.devconfig/environments/dev.env.example`
- `.devconfig/environments/prod.env.example`
- `.devconfig/servers.md`
- `.devconfig/credentials.md`

## 第四步: 恢复与继续开发

补齐或识别完成后，必须继续执行:

1. 读取 `docs/project-state.md`
2. 读取 `docs/session-handover/latest.md`
3. 扫描 `docs/task-todo/`
4. 结合当前代码库状态，给出简要状态报告
5. 自动选择一个最合理、最具体的下一步并推进执行
6. 如存在多个合理方向，再用对话框让用户选择

## 第五步: Git 与提交

- 若本次仅新增或补齐 SDLC 管理文件，且仓库工作区干净或改动可明确归属，则可提交:

```bash
git add .
git commit -m "chore(sdlc): load project into sdlc workflow"
```

- 若工作区已有用户未提交改动，不要混入提交，改为在汇报中说明

## 输出要求

最终向用户汇报:

1. 当前项目属于 A/B/C 哪一类
2. 检测到了哪些现有项目信息
3. 新增或补齐了哪些 SDLC 文件
4. 当前项目阶段和推荐继续动作
5. 若未自动提交，说明原因