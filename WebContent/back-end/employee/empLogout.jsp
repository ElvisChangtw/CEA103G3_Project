<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="com.employee.model.*"%>

<%
if (session.getAttribute("employeeVO") != null)
	{
		session.removeAttribute("employeeVO");
		request.getSession(false);
		session.setAttribute("employeeVO", null);
		session.invalidate();
		response.sendRedirect(request.getContextPath() + "/back-end/employee/empLogin.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>
</body>
</html>