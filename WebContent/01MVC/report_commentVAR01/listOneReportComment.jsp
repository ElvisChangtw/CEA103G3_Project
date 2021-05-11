<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.report_comment.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	ReportCommentVO reportcommentVO = (ReportCommentVO) request.getAttribute("reportcommentVO"); //ReportCommentServlet.java(Concroller), 存入req的reportcommentVO物件
%>

<html>
<head>
<title>檢舉評論資料 - listOneReportComment.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>檢舉評論資料 - ListOneReportComment.jsp</h3>
		 <h4><a href="select_report_comment_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>檢舉編號</th>
		<th>評論編號</th>
		<th>檢舉內容</th>
		<th>檢舉日期</th>
		<th>會員編號</th>
		<th>處理日期</th>
		<th>檢舉狀態</th>
		<th>備註</th>
	</tr>
	<tr>
		<td><%=reportcommentVO.getReportno()%></td>
		<td><%=reportcommentVO.getCommentno()%></td>
		<td><%=reportcommentVO.getContent()%></td>
		<td><%=reportcommentVO.getCreatdate()%></td>
		<td><%=reportcommentVO.getMemberno()%></td>
		<td><%=reportcommentVO.getExecutedate()%></td>
		<td><%=reportcommentVO.getStatus()%></td>
		<td><%=reportcommentVO.getDesc()%></td>		
	</tr>
</table>

</body>
</html>