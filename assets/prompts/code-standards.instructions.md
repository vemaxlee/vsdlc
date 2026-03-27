---
description: "代码规范 - 通用编码标准"
applyTo: "**/*.{ts,js,tsx,jsx,py,go,rs,java,kt,swift,dart,vue,svelte}"
---

# 编码规范

## 通用原则

- **YAGNI**: 不写不需要的代码
- **DRY**: 适度抽象，避免无意义重复
- **KISS**: 优先选择简单方案
- **单一职责**: 每个函数/类/模块只做一件事

## 安全要求 (OWASP Top 10)

- 所有用户输入必须验证和清理
- SQL查询使用参数化/预编译语句
- 输出编码防止XSS
- 不硬编码密钥、密码、Token
- 使用适当的认证和授权检查
- 敏感数据加密传输和存储
- 日志不记录敏感信息

## 错误处理

- 在系统边界 (用户输入、外部API) 做防御性编程
- 内部代码信任框架保证，不做多余校验
- 使用具体的错误类型，不吞掉异常
- 错误信息对用户友好，对开发者有用

## 命名规范

- 变量/函数: 准确表达意图，不缩写
- 布尔值: 使用 is/has/should/can 前缀
- 集合: 使用复数形式
- 常量: UPPER_SNAKE_CASE

## Git 提交规范

格式: `{type}({scope}): {description}`

类型: feat / fix / docs / refactor / test / chore / ci
