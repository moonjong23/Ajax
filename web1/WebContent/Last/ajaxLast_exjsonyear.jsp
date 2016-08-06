<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
{"years": 
[
<%
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
	} catch (Exception e) {
		System.out.println("연결 오류:" + e);
		return;
	}
	try {
		String result = "";
		String keyword = request.getParameter("keyword");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
		pstmt = conn.prepareStatement("select distinct to_char(sawon_ibsail,'yyyy') from sawon where  to_char(sawon_ibsail,'yyyy') like ?");
		pstmt.setString(1, keyword + "%");
		
		rs = pstmt.executeQuery();
		while (rs.next()) {
			result += "{";
			result += "\"year\":" + "\"" + rs.getString(1) + "\"";
			result += "},";
		}
		if (result.length() > 0) {
			result = result.substring(0, result.length() - 1);
		}
		result += "]}";
		out.println(result);
		rs.close();
		pstmt.close();
		conn.close();
	} catch (Exception e3) {
		System.out.println("에러:" + e3);
	}
%>
		