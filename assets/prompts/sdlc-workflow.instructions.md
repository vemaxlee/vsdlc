---
description: "SDLC全流程工作规范 - 所有Agent共享的基础工作流标准"
---

# SDLC 工作流规范

## 项目结构标准

### 命令入口约定
- 新项目初始化使用 `/sdlc-init`
- 旧项目接入或半接入补齐使用 `/sdlc-load`
- 会话恢复默认使用 `/session-start`，若检测到项目未接入，必须自动转入 `/sdlc-load` 等价流程

每个SDLC项目必须包含以下目录结构:

```
{project}/
├── .github/
│   ├── copilot-instructions.md    # 项目级Copilot指令
│   └── hooks/                     # 项目级hooks
├── .devconfig/
│   ├── environments/              # 环境配置
│   ├── servers.md                 # 服务器清单
│   └── credentials.md            # 凭证说明
├── docs/
│   ├── project-state.md           # 项目总状态
│   ├── requirements/              # 需求文档
│   ├── architecture/              # 架构文档
│   │   └── adr/                   # 架构决策记录
│   ├── api-contracts/             # API契约(OpenAPI/GraphQL)
│   ├── task-todo/                 # 待办任务
│   ├── task-done/                 # 已完成任务
│   └── session-handover/          # 会话交接
│       └── latest.md              # 最新交接文档
└── src/                           # 源代码
```

## 角色协作规范

### 任务流转
1. **PM** 创建任务 → `docs/task-todo/`
2. 执行角色完成任务 → 更新任务文件状态
3. 完成后移动到 `docs/task-done/`
4. 更新 `docs/project-state.md`

### 状态驱动自动委派
- 以 `docs/project-state.md` 的“当前阶段”为自动路由依据，主代理必须自动切换或委派:
	- 需求分析 → `@va-pm`
	- 架构设计/API契约 → `@va-architect`
	- 开发实现 → `@va-developer`
	- 测试验证 → `@va-tester`
	- 代码审查 → `@va-reviewer`
	- 部署运维 → `@va-devops`
	- 会话交接 → `@va-handover`
- 当前代理不具备最优能力时，必须自动委派子代理执行，不得停在“建议用户自己切换”。

### 问题自动处理
- 先自动诊断并尝试修复；同类问题最多 3 次有效尝试
- 失败后自动委派更专业代理或子代理继续处理
- 仅当必须人工介入时，使用 `vscode_askQuestions` 对话框询问，且必须包含 `稍后处理`

### 提交与衔接规则
- 每次任务结束后立即提交一次改动
- 每个阶段完成后立即提交一次改动
- 重大改动后立即提交一次改动
- 提交信息建议格式:
	- `feat(sdlc): complete TASK-xxx ...`
	- `chore(sdlc): phase transition ...`
	- `refactor(core): major change ...`
- 提交前必须执行与改动相关的最小验证

### 会话生命周期
- **开始**: 阅读 `docs/project-state.md` + `docs/session-handover/latest.md`
- **进行中**: 按任务计划执行，实时更新进度
- **结束**: @va-handover 生成交接文档

## Markdown 任务管理

所有任务管理通过纯Markdown文件完成，不依赖外部工具。

### 任务ID规则
- 需求: `REQ-{NNN}`
- 任务: `TASK-{NNN}`
- 缺陷: `BUG-{NNN}`

### 状态追踪
在 `docs/project-state.md` 中统一维护任务看板。

## API Contract-First 原则

**任何涉及API的功能开发，必须先有契约文档。**

流程: 需求 → API契约 → 用户确认 → 实现 → 契约测试
