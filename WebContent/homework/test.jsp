<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<% request.setCharacterEncoding("euc-kr"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title></title>
</head>
<body>
<%
	session.setAttribute("today", new Date());
%>

�̸� : ${param.name }<br>
���� : ${param.age }<br>
���� : ${param.gender==1? "��":"��" }<br>
����⵵ : ${param.year }<br>
������ : ${2019 - param.year}
</body>
</html>