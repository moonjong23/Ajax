<?xml version="1.0" encoding="utf-8" ?>
<%@page import="java.sql.*" %>
<%@page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<sawons>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl", "scott", "tiger");
	String sql = "select sawon_no, sawon_name, buser_name from sawon left join buser on buser_num = buser_no order by sawon_no";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	while(rs.next()){ 
%>
	<sawon>
		<sawon_no><%=rs.getString("sawon_no") %></sawon_no> 
		<sawon_name><%=rs.getString("sawon_name") %></sawon_name>
		<buser_name><%=rs.getString("buser_name") %></buser_name>
	</sawon>
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
</sawons>