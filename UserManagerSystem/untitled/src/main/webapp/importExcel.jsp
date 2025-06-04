<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>批量导入用户</title>
    <style>
        .container { max-width: 500px; margin: 50px auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .note { background: #f0f8ff; padding: 10px; margin-bottom: 20px; border-left: 4px solid #2196F3; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Excel用户批量导入</h2>
        <div class="note">
            <p>Excel格式要求：</p>
            <ol>
                <li>第一行是标题（ID, 姓名, 密码）</li>
                <li>数据从第二行开始</li>
                <li>列顺序：ID | 姓名 | 密码</li>
                <li>文件类型：.xls 或 .xlsx</li>
            </ol>
        </div>

        <form action="importAction.jsp" method="post" enctype="multipart/form-data">
            <input type="file" name="excelFile" accept=".xls,.xlsx" required>
            <br><br>
            <input type="submit" value="开始导入">
        </form>
    </div>
</body>
</html>