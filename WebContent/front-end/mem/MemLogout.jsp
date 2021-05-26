<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="com.employee.model.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>
<%
if (session.getAttribute("memVO") != null)
	{
		session.removeAttribute("memVO");
		request.getSession(false);
		session.setAttribute("memVO", null);
		session.invalidate();
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>
</body>
</html>