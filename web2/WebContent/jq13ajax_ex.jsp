<?xml version="1.0" encoding="utf-8" ?>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<sangdatas>
<%
request.setCharacterEncoding("utf-8");
String sangname = request.getParameter("sangname");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl", "scott", "tiger");
	String sql = "select * from sangdata where sang like ? order by code";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, sangname + "%");
	rs = pstmt.executeQuery();
	while(rs.next()){ 
%>
	<sangdata>
		<code><%=rs.getString("code") %></code> 
		<sang><%=rs.getString("sang") %></sang>
		<su><%=rs.getString("su") %></su>
		<dan><%=rs.getString("dan") %></dan>
	</sangdata>
<%	 
	}
	rs.close();
	pstmt.close();
	conn.close();
}catch(Exception e2){
	System.out.println("에러: " + e2);
	return;
}
%>
</sangdatas>
