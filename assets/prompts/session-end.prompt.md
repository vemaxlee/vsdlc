---
description: "结束SDLC工作会话 - 保存状态并生成交接文档"
agent: "va-handover"
---

# SDLC 会话结束

请执行完整的会话交接流程:

1. **总结本次会话**: 梳理所有完成的工作和关键决策
2. **更新项目状态**: 更新 `docs/project-state.md`
3. **整理任务**: 确保 `docs/task-todo/` 和 `docs/task-done/` 准确
4. **生成交接文档**: 
   - 保存为 `docs/session-handover/latest.md`
   - 同时归档为 `docs/session-handover/{YYYY-MM-DD-HHmm}.md`
5. **提交改动**: 若当前仓库存在未提交改动，按以下规则提交:
   - 任务完成提交: `feat/chore/fix(...): complete TASK-xxx`
   - 阶段完成提交: `chore(sdlc): phase completion ...`
   - 重大改动提交: `refactor(...): major change ...`
6. **输出摘要**: 向我展示本次会话的简要总结
