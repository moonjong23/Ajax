<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String dcode = request.getParameter("dcode"); //숫자로는 안 넘어온다

Connection conn = null;
PreparedStatement pstmt = null;

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl", "scott", "tiger");
	String sql = "delete from sangdata where code=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, dcode);
	int re = pstmt.executeUpdate();
	if(re >= 1){ 
		out.print("t");
	}else{
		out.print("f");
	}
}catch(Exception e2){
	out.print("f");
	System.out.println("insert 에러: " + e2);
	return;
}finally{
	pstmt.close();
	conn.close();
}
%>




















