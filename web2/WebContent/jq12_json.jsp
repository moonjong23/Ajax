<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
{"sawons":
[
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String result = "";

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl", "scott", "tiger");
	String sql = "select sawon_no, sawon_name, buser_num from sawon order by sawon_no";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	while(rs.next()){ 
		result += "{";
		result += "\"sawon_no\":" + "\"" + rs.getString("sawon_no") + "\",";
		result += "\"sawon_name\":" + "\"" + rs.getString("sawon_name") + "\",";
		result += "\"buser_num\":" + "\"" + rs.getString("buser_num") + "\"";
		result += "},";		
	}
	if(result.length() > 0){
		result = result.substring(0, result.length() -1);
	}
	out.print(result);

	rs.close();
	pstmt.close();
	conn.close();
}catch(Exception e2){
	System.out.println("에러: " + e2);
	return;
}
%>
]
}