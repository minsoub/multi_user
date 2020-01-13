<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String file_name ="NotebookCheckList";
	String ExcelName  = new String(file_name.getBytes(),"UTF-8")+".xls";
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "attachment; filename="+ExcelName);
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setHeader("Pragma", "no-cache");
%>

<!document html>
<html lang="ko">
   <body>
      ${excelResult.fe_html}
   </body>
</html>