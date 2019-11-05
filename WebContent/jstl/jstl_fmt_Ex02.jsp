<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���İ��� �±� ����2</title>
</head>
<body>

<h1>
����ȭ  tag<br>
format : ���� �� ���ڿ�<br>
parse : ���ڿ� �� ����
</h1>

<hr>
<h3>Format�� ���ڸ� �Ϲ� ���ڷ� ����</h3>
<fmt:parseNumber value="20,000" var="num1" pattern="##,###" />
<fmt:parseNumber value="10,000" var="num2" pattern="##,###" />
�� : ${num1 + num2}<br>
�� : <fmt:formatNumber value="${num1+num2}" pattern="##,###" /><br>
�� : <fmt:formatNumber value="${num1+num2}" pattern="##,###" var="num3"/>
	${num3} <%-- num3�� ���ڿ� --%>
<hr>
<h3>Format�� ��¥�� �Ϲ� ��¥�� ����</h3>
<fmt:parseDate value="2019-10-31 12:00:00" var="day" pattern="yyyy-MM-dd HH:mm:ss" />
��¥ : ${day}

<h3>2019-10-30�� ���� ����ϱ�</h3>
<fmt:formatDate value="${day}" pattern="yyyy-MM-dd E����" />
<%-- �������� ���� ������ �ٽ� �� �Ը��� �°� ����ȭ(pattern) --%>

</body>
</html>