# {{PROJECT_NAME}} - Copilot 指令

## 项目信息
- **项目名称**: {{PROJECT_NAME}}
- **类型**: {{PROJECT_TYPE}}
- **技术栈**: {{TECH_STACK}}
- **描述**: {{PROJECT_DESCRIPTION}}

## 开发规范
- 所有 API 定义前先在 `docs/api-contracts/` 创建 OpenAPI 或 GraphQL 契约
- 任务通过 `docs/task-todo/` 和 `docs/task-done/` 管理
- 使用 `@va-pm` 管理需求、`@va-architect` 设计架构、`@va-developer` 编码、`@va-tester` 测试、`@va-reviewer` 审查、`@va-devops` 部署
- 每次会话结束前运行 `/session-end`
- 每次会话开始时运行 `/session-start`

## 核心原则
- API Contract-First
- 纯 Markdown 任务管理
- 每次结束会话都要保存交接文档
