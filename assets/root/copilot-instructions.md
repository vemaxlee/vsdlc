<!-- GSD Configuration — managed by get-shit-done installer -->
# Instructions for GSD

- Use the get-shit-done skill when the user asks for GSD or uses a `gsd-*` command.
- Treat `/gsd-...` or `gsd-...` as command invocations and load the matching file from `.github/skills/gsd-*`.
- When a command says to spawn a subagent, prefer a matching custom agent from `.github/agents`.
- Do not apply GSD workflows unless the user explicitly asks for them.
- After completing any `gsd-*` command (or any deliverable it triggers: feature, bug fix, tests, docs, etc.), ALWAYS: (1) offer the user the next step by prompting via `ask_user`; repeat this feedback loop until the user explicitly indicates they are done.
<!-- /GSD Configuration -->

<!-- Global Interaction Rules -->
# 交互规则 (全局强制)

## 自主执行优先
- 如果下一步动作是明确的、唯一合理的，**直接执行，不要询问用户**
- 禁止为了"礼貌"或"确认"而给出选项 — 这浪费 Token 且拖慢节奏

## 所有交互必须使用对话框
- **任何需要用户选择或确认的场景，必须使用 `vscode_askQuestions` 对话框**
- **禁止**在聊天消息中列出选项、建议、或下一步让用户回复 — 一律用对话框
- 包括但不限于：下一步建议、方案选择、确认操作、需求澄清

## 对话框设计规则
- **每个对话框必须包含 `稍后处理` 选项** — 让用户可以跳过当前决策
- 提供明确的预设选项，标记推荐项 (`recommended: true`)
- 只在选项无法覆盖时才允许自由文本输入
- 问题尽量合并，减少弹窗次数

## 下一步建议的标准做法
当完成一个阶段需要给出下一步建议时，**用对话框列出可选动作**，例如:
```
问题: "下一步操作"
选项:
  - "@va-pm 明确详细功能需求 (TASK-001)" [recommended]
  - "@va-architect 进行架构设计和 API 契约定义"
  - "稍后处理"
```

## 判断标准
| 场景 | 做法 |
|------|------|
| 下一步明确且唯一 | 直接执行 |
| 有多个合理方向 | 对话框让用户选择 |
| 用户意图模糊 | 对话框询问 |
| 不可逆操作 (删除、推送) | 对话框确认 |
<!-- /Global Interaction Rules -->

<!-- SDLC Multi-Agent System -->
# SDLC 多智能体系统

本环境配置了 SDLC 全流程多智能体工作流。以下是可用的 Agent 和命令:

## 可用 Agent
- `@va-pm` — 项目经理: 需求分析、任务拆分、进度跟踪
- `@va-architect` — 架构师: 系统设计、API契约定义
- `@va-developer` — 开发者: 代码实现
- `@va-tester` — 测试工程师: 测试策略和执行
- `@va-reviewer` — 代码审查员 (只读权限)
- `@va-devops` — 运维工程师: CI/CD、部署
- `@va-handover` — 交接员: 会话状态保存

## 可用命令 (Prompt)
- `/sdlc-init` — 初始化 SDLC 项目结构（路由到 @va-pm）
- `/session-start` — 开始工作会话，加载项目/交接上下文（路由到 @va-pm）
- `/session-end` — 结束工作会话，保存进度和状态（路由到 @va-handover）

## 自动编排与委派 (强制)
- 基于 `docs/project-state.md` 的当前阶段自动选择主代理，并在必要时委派子代理
- 默认阶段路由:
  - 需求分析 → `@va-pm`
  - 架构/API契约 → `@va-architect`
  - 开发实现 → `@va-developer`
  - 测试验证 → `@va-tester`
  - 审查治理 → `@va-reviewer`
  - 部署运维 → `@va-devops`
  - 会话收尾/交接 → `@va-handover`
- 若主代理在当前步骤不具备最优工具或上下文，必须自动委派给更合适的代理或子代理执行

## 问题处理策略 (强制)
- 项目生命周期遇到问题时，先自动诊断并尝试自愈 (最多 3 次有依据的修复尝试)
- 自愈失败后，自动委派更专业代理/子代理继续处理
- 只有必须人工介入时才与用户交互，并且必须使用 `vscode_askQuestions` 对话框
- 人工介入对话框必须包含 `稍后处理` 选项

## 提交策略 (强制)
- 任务结束后立即提交一次
- 阶段完成后立即提交一次
- 重大改动 (跨目录重构、架构调整、批量文件变更) 后立即提交一次
- 提交前执行最小必要校验 (lint/test/构建中与本次改动相关项)
- 若仓库未初始化或无权限提交，需明确说明原因并给出下一步可执行操作

## 项目文件约定
- `docs/project-state.md` — 项目总状态
- `docs/task-todo/` — 待办任务 | `docs/task-done/` — 已完成任务
- `docs/session-handover/latest.md` — 最新交接文档
- `docs/api-contracts/` — API 契约文档 (OpenAPI/GraphQL)
- `.devconfig/` — 环境配置

## 核心原则
- **API Contract-First**: 先有契约，后有实现
- **纯 Markdown 任务管理**: 不依赖外部工具
- **会话连续性**: 每次结束用 `/session-end` 保存上下文
<!-- /SDLC Multi-Agent System -->
