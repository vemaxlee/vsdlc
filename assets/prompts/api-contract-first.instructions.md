---
description: "API Contract-First 开发规范"
applyTo: "**/api/**,**/routes/**,**/controllers/**,**/handlers/**,**/endpoints/**"
---

# API Contract-First 规范

## 核心规则

**先有契约，再有代码。** 任何API实现必须有对应的契约文档。

## 契约位置

所有API契约文档存放在: `docs/api-contracts/`

## 契约格式

### REST API (OpenAPI 3.1)
```yaml
openapi: "3.1.0"
info:
  title: "{模块名} API"
  version: "{版本号}"
paths:
  /api/v1/{resource}:
    get:
      operationId: "getResource"
      summary: "描述"
      parameters: []
      responses:
        200:
          description: "成功响应"
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ResourceResponse'
        400:
          $ref: '#/components/responses/BadRequest'
        401:
          $ref: '#/components/responses/Unauthorized'
components:
  schemas:
    ResourceResponse:
      type: object
      properties: {}
  responses:
    BadRequest:
      description: "请求参数错误"
    Unauthorized:
      description: "未认证"
```

### GraphQL
```graphql
# docs/api-contracts/{module}.graphql
type Query {
  resource(id: ID!): Resource
  resources(filter: ResourceFilter): ResourceConnection!
}

type Resource {
  id: ID!
  name: String!
  createdAt: DateTime!
}
```

## 合规检查

在编写或修改API代码时，必须:

1. 检查对应的契约文件是否存在
2. 接口签名与契约一致 (路径、方法、参数、响应)
3. 状态码使用与契约一致
4. 错误响应格式统一
5. 新增/修改API后同步更新契约文档
