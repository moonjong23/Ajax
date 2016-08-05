<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String irum = request.getParameter("name"); //인자값 받기를 기다리고있다.
String nai = request.getParameter("age");
System.out.println(irum + " " + nai);

out.print(irum + "님의 나이는 " + nai);
%>