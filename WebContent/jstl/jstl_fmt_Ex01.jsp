<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL ����ȭ �±� ����</title>
</head>
<body>

<h1>
����ȭ �±�<br>
format : ���� �� ���ڿ�<br>
parse : ���ڿ� �� ����
</h1>

<hr>
<h3>���� ���� ���� �����ϱ�</h3>
<fmt:formatNumber value="5000000" type="currency" currencySymbol="��" /><br>
<fmt:formatNumber value="0.15" type="percent" /><br>
<fmt:formatNumber value="500000000000.366" pattern="###,###.00" /><br>
									  <%-- pattern : �ݿø����� --%>
fmt:setLocale : ���� ����(�������� �ش��� ����Ʈ ������ �����Ǿ�����)<br>
<fmt:setLocale value="en_US" />
<fmt:formatNumber value="500000" type="currency" /><br>
<fmt:setLocale value="ko_KR" />
<fmt:formatNumber value="500000" type="currency" currencySymbol="��" /><br><br>

<hr>
<h3>��¥ ���� ���� �����ϱ�</h3>
<%-- <jsp:useBean id="today" class="java.util.Date" /> --%>
<c:set var="today" value="<%=new java.util.Date() %>" />
${today}<br>
����� : <fmt:formatDate value="${today}" type="date" /><br>
�ú��� : <fmt:formatDate value="${today}" type="time" /><br>
�Ͻ� 	: <fmt:formatDate value="${today}" type="both" /><br>
�������� : <fmt:formatDate value="${today}" pattern="yyyy-MM-dd HH:mm:ss a E����" /><br>

�Ͻ�1 : <fmt:formatDate value="${today}" type="both" timeStyle="short" dateStyle="short" /><br>
�Ͻ�2 : <fmt:formatDate value="${today}" type="both" timeStyle="long" dateStyle="long" /><br>
�Ͻ�3 : <fmt:formatDate value="${today}" type="both" timeStyle="full" dateStyle="full" /><br>
�Ͻ�4 : <fmt:formatDate value="${today}" type="both" timeStyle="full" dateStyle="full" timeZone="GMT"/><br>

</body>
</html>