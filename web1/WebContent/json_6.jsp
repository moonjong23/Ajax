<%@page import="java.sql.*"%>
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
}catch(Exception e){
	System.out.println("연결 오류: " + e);
	return;
}

try{
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","scott","tiger");
	//사원
	pstmt =conn.prepareStatement("select * from sawon left join buser on buser_no=buser_num");
	rs = pstmt.executeQuery();
	
	while(rs.next()){  // json에서 JAVA를 이용해 DB자료 불러오기

	result += "{";
	result += "\"sawon_no\":" + "\"" +rs.getString("sawon_no") + "\",";
	result += "\"sawon_name\":" + "\"" +rs.getString("sawon_name") + "\",";
	result += "\"buser_num\":" + "\"" +rs.getString("buser_num") + "\",";
	result += "\"sawon_jik\":" + "\"" +rs.getString("sawon_jik") + "\",";
	result += "\"sawon_gen\":" + "\"" +rs.getString("sawon_gen") + "\",";
	result += "\"buser_name\":" + "\"" +rs.getString("buser_name") + "\",";
	result += "\"buser_tel\":" + "\"" +rs.getString("buser_tel") + "\"";
	
	
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