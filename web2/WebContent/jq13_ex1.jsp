<%@page import="java.sql.*" %>
<%@page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
{"sawons":
[
<%
String buserSerch = request.getParameter("buserSerch");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String result = "";

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
}catch(Exception e){
	System.out.println("연결 에러: " + e);
	return;
}

try{	
	conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl", "scott", "tiger");
	String sql = "select buser_name, sawon_no, sawon_name, sawon_jik, count(gogek_no) as gogek_no  from sawon" 
					+ " left outer join gogek on sawon_no = gogek_damsano"
					+ " left outer join buser on buser_no = buser_num"
					+ " group by sawon_name, sawon_no, sawon_jik, buser_name having buser_name=? order by sawon_no";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, buserSerch);
	rs = pstmt.executeQuery();
	while(rs.next()){ 
		result += "{";
		result += "\"buser_name\":" + "\"" + rs.getString(1) + "\",";
		result += "\"sawon_no\":" + "\"" + rs.getString(2) + "\",";
		result += "\"sawon_name\":" + "\"" + rs.getString(3) + "\",";
		result += "\"sawon_jik\":" + "\"" + rs.getString(4) + "\",";
		result += "\"gogek_no\":" + "\"" + rs.getString(5) + "\"";
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