---
description: "环境和凭证配置规范"
applyTo: "**/.devconfig/**"
---

# .devconfig 目录规范

## 目录结构

```
.devconfig/
├── environments/
│   ├── dev.env.example     # 开发环境模板 (提交到git)
│   ├── dev.env             # 开发环境实际配置 (gitignore)
│   ├── test.env.example    # 测试环境模板
│   ├── test.env            # 测试环境实际配置 (gitignore)
│   ├── prod.env.example    # 生产环境模板
│   └── prod.env            # 生产环境实际配置 (gitignore)
├── servers.md              # 服务器/服务清单
└── credentials.md          # 凭证管理说明
```

## 安全规则

1. **永远不要** 在git中提交实际的环境变量值
2. `.env` 文件必须在 `.gitignore` 中
3. 只提交 `.env.example` 模板文件
4. `credentials.md` 只说明凭证的获取方式，不包含实际值

## servers.md 格式

```markdown
# 服务器/服务清单

| 名称 | 用途 | 地址 | 端口 | 备注 |
|------|------|------|------|------|
| DB | PostgreSQL | localhost | 5432 | 开发环境 |
| Redis | 缓存 | localhost | 6379 | |
| API | 后端服务 | localhost | 3000 | |
```

## credentials.md 格式

```markdown
# 凭证管理

## 获取方式
| 凭证 | 用途 | 获取方式 |
|------|------|---------|
| DB_PASSWORD | 数据库密码 | 从密钥管理器获取 |
| API_KEY | 第三方API | 登录控制台获取 |

## 注意事项
- 所有密码/Token通过环境变量注入
- 生产环境凭证仅运维人员访问
```

## .env.example 格式

```env
# 数据库
DB_HOST=localhost
DB_PORT=5432
DB_NAME=myapp_dev
DB_USER=
DB_PASSWORD=

# API
API_PORT=3000
API_SECRET=

# 第三方服务
THIRD_PARTY_API_KEY=
```
