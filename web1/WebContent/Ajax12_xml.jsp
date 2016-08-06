<?xml version="1.0" encoding="utf-8" ?>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<sawons>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

request.setCharacterEncoding("utf-8");

String ibsaDay = request.getParameter("ibsaDay");
//System.out.println(ibsaDay);

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
}catch(Exception e){
	System.out.println("연결 오류: " + e);
	return;
}
try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
	String sql = "select sawon_name, substr(to_char(sawon_ibsail,'yyyy'),0,4) as ibsayear "
				+"from sawon where substr(to_char(sawon_ibsail,'yyyy'),0,2) like ? "
				+"order by to_char(sawon_ibsail,'yyyy')";
	pstmt =conn.prepareStatement(sql);
	pstmt.setString(1, ibsaDay+"%%");
	rs =pstmt.executeQuery();
	
	while(rs.next()){
%>
		<sawon>
			<sawon_name><%=rs.getString("sawon_name")%></sawon_name>
			<ibsayear><%=rs.getString("ibsayear")%></ibsayear>
		</sawon>
<%
	}
	rs.close();
	pstmt.close();
	conn.close();
	
}catch(Exception e2){
	System.out.println("DB연동 오류: " + e2);
}
%>
</sawons>