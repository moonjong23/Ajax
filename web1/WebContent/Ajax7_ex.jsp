<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

{"sawons":
[
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String result = "";

request.setCharacterEncoding("utf-8");

String sabun = request.getParameter("sabun");
String name = request.getParameter("name");
System.out.println(sabun + " " + name);

try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
}catch(Exception e){
	System.out.println("연결 오류: " + e);
	return;
}

try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
	//사원
	pstmt =conn.prepareStatement("select gogek_name, gogek_tel, sawon_no, "+
			"CASE WHEN SUBSTR(gogek_jumin,8,1) = 1 THEN '남' ELSE '여' END as gen "+
			"from sawon join gogek on sawon_no=gogek_damsano " +
			 "where sawon_no=? and sawon_name=?");
	pstmt.setString(1, sabun);
	pstmt.setString(2, name);
	rs = pstmt.executeQuery();
	
	while(rs.next()){  // json에서 JAVA를 이용해 DB자료 불러오기

	result += "{";
	result += "\"gogek_name\":" + "\"" +rs.getString("gogek_name") + "\",";
	result += "\"gogek_tel\":" + "\"" +rs.getString("gogek_tel") + "\",";
	result += "\"gen\":" + "\"" +rs.getString("gen") + "\",";
	result += "\"sawon_no\":" + "\"" +rs.getString("sawon_no") + "\"";
	
	
	result += "},";
	}
	if(result.length()>0){
		result= result.substring(0, result.length()-1);  // 마지막 , 지우기
	}
	out.println(result);
	
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