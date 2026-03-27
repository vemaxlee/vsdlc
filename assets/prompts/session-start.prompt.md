---
description: "开始新的SDLC工作会话 - 加载项目状态和上次交接内容"
agent: "va-pm"
---

# SDLC 会话开始

请执行以下步骤来初始化本次工作会话:

1. **读取项目状态**: 查看 `docs/project-state.md`
2. **读取交接文档**: 查看 `docs/session-handover/latest.md`
3. **检查待办任务**: 扫描 `docs/task-todo/` 下的所有任务
4. **生成简报**: 向我汇报:
   - 当前项目阶段
   - 上次会话的关键进展
   - 当前活跃/阻塞的任务
   - 推荐本次会话优先处理的工作
5. **自动路由执行**: 根据项目阶段自动切换/委派到对应 Agent 开始执行首个可落地任务:
   - 需求分析 → `@va-pm`
   - 架构/API契约 → `@va-architect`
   - 开发实现 → `@va-developer`
   - 测试验证 → `@va-tester`
   - 审查治理 → `@va-reviewer`
   - 部署运维 → `@va-devops`
6. **问题处理**: 遇到阻塞时先自动修复，再自动委派更合适的代理/子代理继续推进
7. **人工介入门槛**: 仅在必须人工决策时使用 `vscode_askQuestions` 对话框，且必须提供 `稍后处理` 选项

如果当前项目未接入或只部分接入 SDLC（例如缺少 `docs/project-state.md`、`docs/session-handover/latest.md`、`.github/copilot-instructions.md` 中的关键项），优先告知用户先运行 `/sdlc-load` 自动识别并补齐；只有明确是空白新项目时，才建议使用 `/sdlc-init`。
