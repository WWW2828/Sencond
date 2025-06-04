package model;

import entity.User;
import org.apache.poi.ss.usermodel.*;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ExcelImportUtil {
    public static List<User> parseExcel(InputStream is) throws Exception {
        List<User> userList = new ArrayList<>();

        Workbook workbook = WorkbookFactory.create(is);
        Sheet sheet = workbook.getSheetAt(0);
        Iterator<Row> rowIterator = sheet.iterator();

        DataFormatter formatter = new DataFormatter();

        // 跳过标题行
        if (rowIterator.hasNext()) rowIterator.next();

        int rowNum = 1; // 从第二行开始（标题行之后）

        while (rowIterator.hasNext()) {
            Row row = rowIterator.next();
            rowNum++;
            User user = new User();

            try {
                // 安全获取单元格值
                String idStr = formatter.formatCellValue(row.getCell(0));
                String name = formatter.formatCellValue(row.getCell(1));
                String password = formatter.formatCellValue(row.getCell(2));

                // 验证ID是否为数字
                if (idStr == null || idStr.trim().isEmpty()) {
                    throw new IllegalArgumentException("ID不能为空");
                }

                if (!idStr.matches("\\d+")) {
                    throw new IllegalArgumentException("ID必须是数字: " + idStr);
                }

                user.setId(Integer.parseInt(idStr));
                user.setName(name);
                user.setPassword(password);

                userList.add(user);
            } catch (Exception e) {
                // 设置错误信息
                user.setError(e.getMessage() + " (行号: " + rowNum + ")");
                userList.add(user);
            }
        }

        workbook.close();
        return userList;
    }
}