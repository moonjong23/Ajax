<%@page import="java.sql.*" %>
<%@page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
{"gogeks":
[
<%
String goSerch = request.getParameter("goSerch");
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
	String sql = "select gogek_name, gogek_tel, decode(substr(gogek_jumin, 8, 1), 1,'남',2,'여') as gogek_gen," 
			+ " to_char(sysdate, 'yyyy') - to_char(to_date(substr(gogek_jumin, 1, 6)), 'yyyy') as gogek_age from sawon"
			+ " left outer join gogek on sawon_no = gogek_damsano where gogek_damsano = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, goSerch);
	rs = pstmt.executeQuery();
	while(rs.next()){ 
		result += "{";
		result += "\"gogek_name\":" + "\"" + rs.getString(1) + "\",";
		result += "\"gogek_tel\":" + "\"" + rs.getString(2) + "\",";
		result += "\"gogek_gen\":" + "\"" + rs.getString(3) + "\",";
		result += "\"gogek_age\":" + "\"" + rs.getString(4) + "\"";
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