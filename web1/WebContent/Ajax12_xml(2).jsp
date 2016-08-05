<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<gogeks>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

request.setCharacterEncoding("utf-8");

String name = request.getParameter("name");
//System.out.println(name);

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
}catch(Exception e){
	System.out.println("연결 오류: " + e);
	return;
}
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
	String sql = "select gogek_no, gogek_name, gogek_jumin, gogek_tel "
				+"from gogek inner join sawon on gogek_damsano=sawon_no "
				+"where sawon_name = ?";
	pstmt =conn.prepareStatement(sql);
	pstmt.setString(1, name);
	rs =pstmt.executeQuery();
	
	while(rs.next()){
%>
		<gogek>
			<gogek_no><%=rs.getString("gogek_no")%></gogek_no>
			<gogek_name><%=rs.getString("gogek_name")%></gogek_name>
			<gogek_jumin><%=rs.getString("gogek_jumin")%></gogek_jumin>
			<gogek_tel><%=rs.getString("gogek_tel")%></gogek_tel>
		</gogek>
<%
	}
	rs.close();
	pstmt.close();
	conn.close();
	
}catch(Exception e2){
	System.out.println("DB연동 오류: " + e2);
}
%>
</gogeks>