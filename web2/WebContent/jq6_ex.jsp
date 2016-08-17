<%@ page import="java.lang.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
String name = request.getParameter("name");
String kor = request.getParameter("kor");
String eng = request.getParameter("eng");
int hap = Integer.valueOf(kor) +  Integer.valueOf(eng);
System.out.println(name + "학생의 총점은 " + hap + " 평균은 " + (hap/2));
%>
