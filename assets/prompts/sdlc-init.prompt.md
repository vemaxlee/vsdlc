---
description: "初始化 SDLC 多智能体项目 - 创建完整的项目脚手架和配置"
agent: "va-pm"
---

# SDLC 项目初始化

你正在执行 SDLC 项目初始化。优先使用全局模板目录进行复制初始化，而不是临时逐文件生成。

兼容命令入口:
- `/sdlc-init`

全局模板位置:
- `~/.copilot/templates/sdlc-project-template/`

复制脚本:
- `~/.copilot/bin/sdlc-template-init`

初始化策略:
1. 优先复制模板到当前工作区根目录或用户指定目录
2. 复制后替换模板变量 (`{{PROJECT_NAME}}` 等)
3. 仅当模板目录或脚本缺失时，才退回到手动创建文件流程
4. 初始化过程中遇到问题，先自动修复；无法自动修复时自动委派合适代理/子代理
5. 仅在必须人工介入时才弹对话框询问，且选项必须包含 `稍后处理`

---

## 步骤1: 收集项目信息

向用户询问以下信息（使用对话框或直接对话）:

1. **项目名称** — 英文，用于目录名
2. **项目类型** — 从以下选择:
   - Web Application (前后端分离或全栈)
   - REST API / Microservice (纯后端API服务)
   - CLI Tool (命令行工具)
   - Mobile App (iOS/Android/跨平台)
   - Library / SDK (供其他项目引用)
   - Static Website (静态网站)
   - Data Pipeline (ETL/数据处理)
   - Monorepo (多包仓库)
3. **技术栈** — 从以下选择或自定义:
   - Frontend: React+TS, Next.js, Vue+TS
   - Backend: Node.js+Express/Fastify, Python+FastAPI, Go, Rust
   - Fullstack: Next.js Fullstack, T3 Stack
   - Mobile: Flutter, React Native
4. **项目简述** — 一句话描述项目目标

---

## 步骤2: 复制模板并初始化

在**当前工作区根目录**或用户指定目录，优先执行以下命令:

```bash
~/.copilot/bin/sdlc-template-init <target-dir> <project-name> <project-type> <tech-stack> <project-description>
```

如果脚本不可用，再按下述目录结构手动创建（如目录/文件已存在则跳过）:

```
.github/
├── copilot-instructions.md
docs/
├── project-state.md
├── requirements/
│   └── .gitkeep
├── architecture/
│   ├── adr/
│   │   └── .gitkeep
│   └── .gitkeep
├── api-contracts/
│   └── .gitkeep
├── task-todo/
│   └── .gitkeep
├── task-done/
│   └── .gitkeep
└── session-handover/
    └── latest.md
.devconfig/
├── environments/
│   ├── dev.env.example
│   └── prod.env.example
├── servers.md
└── credentials.md
src/
└── .gitkeep
tests/
└── .gitkeep
.gitignore
README.md
```

---

## 步骤3: 生成 `.github/copilot-instructions.md`

根据项目类型和技术栈生成项目级 Copilot 指令:

```markdown
# {项目名} - Copilot 指令

## 项目信息
- 类型: {项目类型}
- 技术栈: {技术栈}
- 描述: {项目简述}

## SDLC 工作流
本项目使用 SDLC 多智能体工作流:
- 使用 `/session-start` 开始工作会话
- 使用 `/session-end` 保存进度并结束会话
- 通过 `@va-pm` 管理需求和任务、`@va-architect` 架构设计、`@va-developer` 编码、`@va-tester` 测试、`@va-reviewer` 审查、`@va-devops` 部署

## 开发规范
{根据技术栈插入对应规范}

## API Contract-First
所有 API 开发必须先有契约文档 (`docs/api-contracts/`)，后有实现。
```

---

## 步骤4: 生成 `docs/project-state.md`

```markdown
# {项目名} - 项目状态

## 基本信息
- **项目类型**: {类型}
- **技术栈**: {技术栈}
- **创建日期**: {今天日期}
- **最后更新**: {今天日期}

## 当前阶段
需求分析

## 里程碑
- [ ] M1: 项目初始化和需求确认
- [ ] M2: 架构设计和API契约
- [ ] M3: 核心功能开发
- [ ] M4: 测试和质量保证
- [ ] M5: 部署上线

## 活跃任务
| ID | 标题 | 状态 | 指派 | 优先级 |
|----|------|------|------|--------|
| TASK-001 | 完善项目需求 | 待开始 | @va-pm | P0 |

## 已知问题
(无)

## 备注
项目刚刚初始化，需要进一步明确需求。
```

---

## 步骤5: 生成 `docs/session-handover/latest.md`

```markdown
# 会话交接 - {日期时间}

## 本次完成
- [x] 项目初始化
- [x] 目录结构创建
- [x] 项目配置生成

## 待处理
- 与用户确认详细需求
- 架构设计

## 上下文
全新 {项目类型} 项目，技术栈 {技术栈}。目标: {项目简述}。
```

---

## 步骤6: 生成 `.gitignore`

根据技术栈生成，始终包含:
```
.devconfig/environments/*.env
!.devconfig/environments/*.env.example
.env
.env.local
.env.*.local
node_modules/
__pycache__/
.venv/
dist/
build/
.next/
coverage/
```

---

## 步骤7: 生成 `README.md`

```markdown
# {项目名}

{项目简述}

## 技术栈
{技术栈列表}

## 快速开始
{根据技术栈生成安装和启动命令}

## SDLC 工作流
- `/session-start` 开始会话
- `/session-end` 结束会话
- `@va-pm` 管理 | `@va-architect` 架构设计 | `@va-developer` 编码
- `@va-tester` 测试 | `@va-reviewer` 审查 | `@va-devops` 部署
```

---

## 步骤8: 生成 `.devconfig/` 文件

- `environments/dev.env.example` — 根据技术栈生成开发环境变量模板
- `environments/prod.env.example` — 生产环境变量模板（值留空）
- `servers.md` — 服务器/服务清单表格
- `credentials.md` — 凭证获取说明

---

## 步骤9: Git 初始化

如果当前目录没有 `.git/`，执行:
```bash
git init
git add .
git commit -m "chore: init project with SDLC scaffold"
```

若已存在 `.git/`，也要提交本次初始化改动:
```bash
git add .
git commit -m "chore(sdlc): bootstrap project from template"
```

---

## 完成后

向用户汇报初始化结果:
1. 模板已复制到哪个目录
2. 创建了哪些关键文件和目录
3. 项目状态摘要
4. 建议的下一步操作（通常是 "使用 `@va-pm` 开始需求分析"）
