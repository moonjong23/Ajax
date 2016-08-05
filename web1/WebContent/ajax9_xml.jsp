<?xml version="1.0" encoding="utf-8" ?>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
 <gogeks>
 <%
 Connection conn = null;
 PreparedStatement pstmt = null;
 ResultSet rs = null;
 
 request.setCharacterEncoding("utf-8");

 String gen = request.getParameter("gen");
 //System.out.println("jsp로 넘어간 gen: " + gen);
 
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
		
		while(rs.next()){  // XML에서 JAVA를 이용해 DB자료 불러오기
 %>
 		<gogek>
 			<gogek_name><%=rs.getString("gogek_name")%></gogek_name>
 			<gogek_tel><%=rs.getString("gogek_tel")%></gogek_tel>
 			<gen><%=rs.getString("gen")%></gen>
 			<sawon_name><%=rs.getString("sawon_name")%></sawon_name>
 			<buser_tel><%=rs.getString("buser_tel")%></buser_tel>
 		</gogek>
 <%
		}
		rs.close();
		pstmt.close();
		conn.close();
		
	}catch(Exception e2){
		System.out.println("에러: " + e2);
		return;
	}
 %>
 </gogeks>
 
 
 
 
 
 
 
 
 
 