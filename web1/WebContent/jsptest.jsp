<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
자료받아 출력하기
<p/>
<%
String irum = request.getParameter("irum"); //웹상에서 값을 받아올 때
out.println(irum);
%>
여긴 html영역: <% out.println(irum); %> <%=irum%> <!-- 출력 전용 태그 -->
</body>
</html>