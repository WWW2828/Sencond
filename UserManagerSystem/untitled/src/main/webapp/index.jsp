<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户管理系统导航</title>
<style>
    :root {
        --primary-color: #4a6fa5;
        --hover-color: #3a5a8c;
        --bg-color: #f4f4f9;
        --card-bg: #ffffff;
    }

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: var(--bg-color);
        line-height: 1.6;
        padding: 20px;
        background-image: linear-gradient(120deg, #fdfbfb 0%, #ebedee 100%);
    }

    .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
    }

    header {
        text-align: center;
        margin-bottom: 30px;
        padding: 20px 0;
        border-bottom: 1px solid #e0e0e0;
    }

    h1 {
        color: #2c3e50;
        font-size: 2.5rem;
        margin-bottom: 10px;
    }

    .subtitle {
        color: #7f8c8d;
        font-size: 1.1rem;
    }

    .nav-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-top: 20px;
    }

    .nav-card {
        background: var(--card-bg);
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .nav-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    }

    .card-header {
        background-color: var(--primary-color);
        color: white;
        padding: 15px 20px;
        font-weight: 600;
    }

    .card-body {
        padding: 20px;
    }

    .nav-link {
        display: block;
        padding: 12px 15px;
        margin: 10px 0;
        background-color: #eef2f7;
        color: #2c3e50;
        text-decoration: none;
        border-radius: 5px;
        transition: all 0.3s ease;
        font-weight: 500;
    }

    .nav-link:hover {
        background-color: var(--primary-color);
        color: white;
        transform: translateX(5px);
    }

    .nav-link i {
        margin-right: 10px;
        width: 20px;
        text-align: center;
    }

    .footer {
        text-align: center;
        margin-top: 40px;
        color: #7f8c8d;
        font-size: 0.9rem;
    }

    /* 响应式设计 */
    @media (max-width: 600px) {
        .nav-grid {
            grid-template-columns: 1fr;
        }

        h1 {
            font-size: 2rem;
        }

        .container {
            padding: 10px;
        }
    }
</style>
</head>
<body>
<div class="container">
    <header>
        <h1>用户管理系统导航</h1>
        <p class="subtitle">请选择以下操作管理用户数据</p>
    </header>

    <div class="nav-grid">
        <!-- 用户数据操作 -->
        <div class="nav-card">
            <div class="card-header">用户管理操作</div>
            <div class="card-body">
                <a href="allShow.jsp" class="nav-link">查看所有用户</a>
                <a href="search.jsp" class="nav-link">查询用户</a>
                <a href="insert.jsp" class="nav-link">新增用户</a>
                <a href="update.jsp" class="nav-link">更新用户信息</a>
                <a href="dele.jsp" class="nav-link">删除用户</a>
            </div>
        </div>



        <!-- 数据工具 -->
        <div class="nav-card">
            <div class="card-header">数据工具</div>
            <div class="card-body">
                <a href="importExcel.jsp" class="nav-link">Excel导入/导出</a>
            </div>
        </div>
    </div>

    <div class="footer">
        <p>© 2025 用户管理系统 | 最后更新: 2025-06-04</p>
    </div>
</div>
</body>
</html>