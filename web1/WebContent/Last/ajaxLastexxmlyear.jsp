<?xml version="1.0" encoding="UTF-8"?>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<names>    
<%

request.setCharacterEncoding("utf-8");
String keyword = request.getParameter("keyword");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
}catch(Exception e){
	System.out.print("오류1"+e);
}


try{
	conn= DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
	pstmt = conn.prepareStatement("select sawon_name,sawon_ibsail from sawon where TO_CHAR (sawon_ibsail,'yyyy') =?");
	
	pstmt.setString(1, keyword);
	rs = pstmt.executeQuery();
	while(rs.next()){
%>		
	<sname><%=  rs.getString(1)   %></sname> 
	<syear><%=  rs.getString(2)   %></syear> 
<%		
	}
}catch(Exception e1){
	System.out.print("오류2"+e1);
}

%>
</names>    