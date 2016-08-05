<?xml version="1.0" encoding="UTF-8"?>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<gogeks>  
<% 
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
}catch(Exception e){
	System.out.print("오류1"+e);
}

request.setCharacterEncoding("utf-8");
String name = request.getParameter("name");



try{
	conn= DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
	pstmt = conn.prepareStatement("select gogek_no,gogek_name,gogek_jumin,gogek_tel from sawon inner join gogek on sawon_no = gogek.GOGEK_DAMSANO where sawon_name=?");
	pstmt.setString(1, name);
	rs = pstmt.executeQuery();
	while(rs.next()){
%>		
	<gogek>
	<code><%= rs.getString(1)   %></code> 
	<name><%=rs.getString(2) %></name>
	<jumin><%=rs.getString(3) %></jumin>
	<tel><%=rs.getString(4) %></tel>
	</gogek>
<%		
	}
}catch(Exception e1){
	System.out.print("오류2"+e1);
}





%>
</gogeks>  