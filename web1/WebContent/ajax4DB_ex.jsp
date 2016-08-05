<?xml version="1.0" encoding="utf-8" ?>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<sawons>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
}catch(Exception e){
	System.out.println("연결 오류: " + e);
	return;
}

try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
	pstmt =conn.prepareStatement("select * from sawon");
	rs = pstmt.executeQuery();
	
	while(rs.next()){
%>
	<sawon>
		<no><%=rs.getString("sawon_no") %></no>
		<name><%=rs.getString("sawon_name") %></name>
		<jik><%=rs.getString("sawon_jik") %></jik>
		<ibsail><%=rs.getString("sawon_ibsail") %></ibsail>
		<gen><%=rs.getString("sawon_gen") %></gen>
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
