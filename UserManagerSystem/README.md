------

# 用户综合管理系统（UserManagerSystem）

## 📘 项目简介

​	本系统为一个基于 Java Web 的用户信息管理平台，后端采用 JSP+Servlet 架构，数据库使用 MySQL，支持对用户信息的增删改查操作，并扩展实现了 Excel 文件的批量导入功能。该系统采用模块化设计，前后端分离清晰，适用于中小型信息管理项目的教学和实训使用。

---

## 🛠️ 核心功能

- ✅ 用户信息新增、删除、更新、查询（CRUD）
- ✅ 按用户ID精确查询
- ✅ 展示所有用户信息
- ✅ Excel 批量导入用户信息
- ✅ 导航主页整合所有功能
- ✅ MySQL 持久化存储，JDBC 连接
- ✅ JSP 页面美观交互友好

---

## 🧱 技术栈

| 分类     | 工具/框架                                           |
| -------- | --------------------------------------------------- |
| 后端语言 | Java 8+                                             |
| Web框架  | JSP / Servlet                                       |
| 数据库   | MySQL 8.0+                                          |
| 构建管理 | Maven                                               |
| 依赖管理 | `mysql-connector-java`<br>`Apache POI`（Excel功能） |
| 容器部署 | Tomcat 9.0                                          |
| 前端组件 | HTML + CSS（可拓展为 Bootstrap）                    |

---

## 📂 项目结构说明

UserManagerSystem/
 ├── src/
 │   ├── main/
 │   │   ├── java/
 │   │   │   ├── dbutil/        // 数据库连接工具类
 │   │   │   ├── entity/        // 实体类User.java
 │   │   │   └── model/         // 数据增删改查逻辑类
 │   │   └── webapp/
 │   │       ├── css/           // 页面样式
 │   │       ├── index.jsp      // 主界面（导航入口）
 │   │       ├── insert.jsp / insertShow.jsp
 │   │       ├── update.jsp / updateShow.jsp
 │   │       ├── dele.jsp / deleShow.jsp
 │   │       ├── allShow.jsp / showUser.jsp
 │   │       ├── search.jsp
 │   │       └── excelimport.jsp
 ├── user.sql                   // 初始化数据库脚本
 ├── pom.xml                   // Maven依赖配置
 └── README.md

---

## ⚙️ 环境搭建说明

### 🔹 Step 1: 安装环境
- JDK 8+
- MySQL 8.0
- Apache Tomcat 9.0
- IntelliJ IDEA（或 Eclipse）
- Maven 3+

### 🔹 Step 2: 克隆项目

```bash
git clone https://github.com/example/UserManagerSystem.git
```

### 🔹 Step 3: 导入数据库

1. 登录 MySQL
2. 创建数据库并导入脚本：

```sql
CREATE DATABASE userdb;
USE userdb;

CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    gender VARCHAR(10),
    email VARCHAR(100)
);
```

或直接运行项目目录下的 `user.sql` 文件。

### 🔹 Step 4: 配置数据库连接（Dbconn.java）

```java
private static String url = "jdbc:mysql://localhost:3306/userdb?useSSL=false&serverTimezone=UTC";
private static String username = "root";
private static String password = "yourpassword";
```

### 🔹 Step 5: 启动Tomcat并部署项目

1. 在IDEA中添加Tomcat配置
2. 启动服务器后访问：http://localhost:8080/UserManagerSystem/index.jsp

------

## 📌 功能页面导航说明

| 页面路径        | 功能描述              |
| --------------- | --------------------- |
| index.jsp       | 功能导航主页          |
| insert.jsp      | 添加用户信息页面      |
| insertShow.jsp  | 提交后处理添加请求    |
| update.jsp      | 选择用户并修改信息    |
| updateShow.jsp  | 更新用户数据          |
| dele.jsp        | 输入ID删除用户        |
| deleShow.jsp    | 执行删除操作          |
| allShow.jsp     | 展示所有用户信息      |
| showUser.jsp    | 单个用户信息展示      |
| search.jsp      | 根据ID查询用户        |
| excelimport.jsp | 批量导入Excel用户数据 |

------

## 📥 Excel导入功能说明

- 格式要求：.xlsx
- 内容要求：第一行为标题，后续每行包含：姓名、性别、邮箱
- 文件解析：由 Apache POI 完成，每行数据映射为一个 `User` 对象后批量插入数据库
- 错误处理：空值、非法格式自动提示；导入成功会提示导入成功条数

------

## 🌐 GitHub 项目地址

👉 https://github.com/SYY-SYY5/First-Repository

------

## 📸 示例界面截图

- 项目结构树（见 `docs/structure.png`）
- 系统主界面导航（见 `docs/index_screenshot.png`）

------

## 🧑‍🤝‍🧑 开发团队成员

| 姓名   | 负责内容                             |
| ------ | ------------------------------------ |
| 龚科碩 | 项目初始化、数据库设计、CRUD模块开发 |
| 吴彦富 | JSP页面设计、交互优化、前端样式      |
| 欧梓航 | Excel导入功能开发、异常处理          |
| 宋延贇 | GitHub项目维护、说明文档编写         |

------

## 🚀 未来拓展建议

- 引入 Spring Boot 框架重构项目结构
- 使用 Thymeleaf 或 Vue 实现更现代的页面交互
- 加入登录验证、权限控制等功能
- Excel导出用户信息
- 接入 RESTful API 支持前后端完全分离

------

## 📜 License

本项目仅用于教学实践用途，不可直接用于商业用途。如需使用请联系开发团队。