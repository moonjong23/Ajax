<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
{"gogeks":
[
<%
request.setCharacterEncoding("utf-8");

String gen = request.getParameter("gen");
//System.out.println("jsp로 넘어간 gen: " + gen);

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
	
	if(gen.equals("전체")){
		//System.out.println("전체값");
		String str = "select gogek_name, case when substr(gogek_jumin,8,1) = 1 then '남' else '여' end as gen,"+
				   "gogek_tel, sawon_name, buser_tel from gogek left join sawon on gogek_damsano = sawon_no inner join buser on sawon.buser_num = buser_no";
		pstmt =conn.prepareStatement(str);
	}else{
		String str = "select gogek_name, case when substr(gogek_jumin,8,1) = 1 then '남' else '여' end as gen,"+
			   "gogek_tel, sawon_name, buser_tel from gogek left join sawon on gogek_damsano = sawon_no inner join buser on sawon.buser_num = buser_no "+
				"where substr(gogek_jumin,8,1) = ?";		
		pstmt =conn.prepareStatement(str);
		pstmt.setString(1, gen);
	}
	
	rs = pstmt.executeQuery();
	
	while(rs.next()){  // json에서 JAVA를 이용해 DB자료 불러오기

	result += "{";
	result += "\"gogek_name\":" + "\"" +rs.getString("gogek_name") + "\",";
	result += "\"gogek_tel\":" + "\"" +rs.getString("gogek_tel") + "\",";
	result += "\"gen\":" + "\"" +rs.getString("gen") + "\",";
	result += "\"sawon_name\":" + "\"" +rs.getString("sawon_name") + "\", ";
	result += "\"buser_tel\":" + "\"" +rs.getString("buser_tel") + "\"";
	
	
	result += "},";
	}
	if(result.length()>0){
		result= result.substring(0, result.length()-1);  // 마지막 , 지우기
	}
	out.println(result);
	//System.out.println(result);
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