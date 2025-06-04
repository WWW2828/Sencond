<%@ page language="java" import="java.util.*, model.*, entity.User" 
         contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.io.InputStream" %>

<%
// 配置上传参数
DiskFileItemFactory factory = new DiskFileItemFactory();
factory.setSizeThreshold(1024 * 1024); // 1MB内存缓冲
factory.setRepository(new java.io.File(System.getProperty("java.io.tmpdir"))); // 临时目录

ServletFileUpload upload = new ServletFileUpload(factory);
upload.setSizeMax(5 * 1024 * 1024); // 最大5MB文件

List<FileItem> items = null;
InputStream fileContent = null;
Model model = new Model();
int successCount = 0;
int failCount = 0;
List<String> messages = new ArrayList<>();
List<User> failedUsers = new ArrayList<>();
List<String> systemErrors = new ArrayList<>();

try {
    items = upload.parseRequest(request);
    
    for (FileItem item : items) {
        if (!item.isFormField() && "excelFile".equals(item.getFieldName())) {
            fileContent = item.getInputStream();
            
            // 验证文件类型
            String fileName = item.getName().toLowerCase();
            if (!fileName.endsWith(".xls") && !fileName.endsWith(".xlsx")) {
                systemErrors.add("错误：仅支持 .xls 或 .xlsx 格式的文件");
                break;
            }
            
            // 解析Excel
            List<User> users = ExcelImportUtil.parseExcel(fileContent);
            
            // 批量导入数据库
            for (User user : users) {
                try {
                    // 检查是否有错误
                    if (user.getError() != null && !user.getError().isEmpty()) {
                        throw new Exception(user.getError());
                    }
                    
                    // 执行插入
                    int result = model.insert(user.getId(), user.getName(), user.getPassword());
                    if (result > 0) {
                        successCount++;
                    } else {
                        throw new Exception("数据库插入失败");
                    }
                } catch (Exception e) {
                    failCount++;
                    // 设置错误信息以便在结果页面显示
                    user.setError(e.getMessage());
                    failedUsers.add(user);
                    messages.add("错误: ID=" + user.getId() + " - " + e.getMessage());
                }
            }
        }
    }
} catch (FileUploadBase.SizeLimitExceededException e) {
    systemErrors.add("文件大小超过限制（最大5MB）");
} catch (Exception e) {
    e.printStackTrace();
    systemErrors.add("系统错误: " + e.getMessage());
} finally {
    if (fileContent != null) try { fileContent.close(); } catch (Exception e) {}
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>导入结果</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .result-container { max-width: 1200px; margin: 30px auto; padding: 20px; }
        .success-badge { background-color: #d4edda; color: #155724; }
        .error-badge { background-color: #f8d7da; color: #721c24; }
        .user-table { width: 100%; margin-top: 20px; }
        .error-row { background-color: #fff3f3; }
        .system-error { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container result-container">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h2 class="mb-0">导入结果</h2>
            </div>
            <div class="card-body">
                <% if (!systemErrors.isEmpty()) { %>
                    <div class="alert alert-danger">
                        <h4><i class="bi bi-exclamation-circle"></i> 系统错误</h4>
                        <ul>
                            <% for (String error : systemErrors) { %>
                                <li class="system-error"><%= error %></li>
                            <% } %>
                        </ul>
                    </div>
                <% } else { %>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded text-center">
                                <h3 class="text-success"><%= successCount %></h3>
                                <p class="mb-0">成功导入</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded text-center">
                                <h3 class="text-danger"><%= failCount %></h3>
                                <p class="mb-0">导入失败</p>
                            </div>
                        </div>
                    </div>
                <% } %>

                <% if (failCount > 0) { %>
                <div class="alert alert-danger">
                    <h4><i class="bi bi-exclamation-triangle"></i> 错误详情：</h4>
                    <table class="table table-hover user-table">
                        <thead class="table-danger">
                            <tr>
                                <th>ID</th>
                                <th>姓名</th>
                                <th>错误原因</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (User user : failedUsers) { %>
                            <tr class="error-row">
                                <!-- 修复点：避免原始类型与null比较 -->
                                <td><%= user.getId() == 0 ? "N/A" : user.getId() %></td>
                                <td><%= user.getName() == null || user.getName().isEmpty() ? "N/A" : user.getName() %></td>
                                <td class="text-danger"><%= user.getError() %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>
                
                <div class="d-flex justify-content-between mt-4">
                    <a href="importExcel.jsp" class="btn btn-outline-primary">
                        <i class="bi bi-arrow-left"></i> 返回导入页面
                    </a>
                    <% if (failCount > 0) { %>
                    <a href="UserImportTemplate.xlsx" class="btn btn-info">
                        <i class="bi bi-file-earmark-excel"></i> 下载模板
                    </a>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>