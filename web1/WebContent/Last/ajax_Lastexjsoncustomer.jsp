<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
{"customers": 
[
<%
request.setCharacterEncoding("utf-8");
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
	} catch (Exception e) {
		System.out.println("연결 오류:" + e);
		return;
	}
	try {
		String result = "";
		String staff = request.getParameter("staff");
		
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "scott", "tiger");
		pstmt = conn.prepareStatement("select * from gogek where gogek_damsano = (select sawon_no from sawon where sawon_name = ?)");
		
		pstmt.setString(1, staff);
		
		rs = pstmt.executeQuery();
		while (rs.next()) {
			result += "{";
			result += "\"no\":" + "\"" + rs.getString("gogek_no")+ "\",";	
			result += "\"name\":" + "\"" + rs.getString("gogek_name")+ "\",";
			result += "\"jumin\":" + "\"" + rs.getString("gogek_jumin")+ "\",";
			result += "\"tel\":" + "\"" + rs.getString("gogek_tel")+ "\"";
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