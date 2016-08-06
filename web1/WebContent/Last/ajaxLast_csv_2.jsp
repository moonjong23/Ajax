<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String ibsail = request.getParameter("ibsail");
System.out.println(ibsail);


Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String result = "";

try {
	Class.forName("oracle.jdbc.driver.OracleDriver");

	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
	String sql = "select sawon_name from sawon where to_char(to_date(sawon_ibsail), 'YYYY') =" + ibsail;	
	pstmt = conn.prepareStatement(sql);	
	//pstmt.setString(1, ibsail);
	rs = pstmt.executeQuery();
	
	ArrayList<String> list = new ArrayList<String>(); 
	while (rs.next()) {
		System.out.println(rs.getString(1));
		list.add(rs.getString(1));		
	}
	out.print(list.size());
	out.print("|");
	for(int i = 0; i < list.size(); i++){
		String data = list.get(i);
		out.print(data);
		if(i < list.size() - 1){
			out.print(",");
		}				
	}
	
	rs.close();
	pstmt.close();
	conn.close();
} catch (Exception e2) {
	System.out.println("에러 : " + e2);
	return;
}
%>    
    
