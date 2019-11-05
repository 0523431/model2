<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	tag library
		- prefix : c =>���ξ�
		- uri : ���ͳ����� �������°� �ƴ϶�
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL core �±� ���� : taglib ���þ ǥ���ؾ� �Ѵ�</title>
</head>
<body>

<h3>�Ӽ� ���� �±� : set, remove, out �±�</h3>
<br>
��ũ��Ʈ������ ǥ���ϸ�,<br>
<% session.setAttribute("test", "Hello JSTL"); %>
<c:set var="test" value="${'Hello JSTL'}" scope="session" />

<br>
�Ʒ� �� ����� ����������, c:out => ���ȿ� �� ġ���� Ÿ��
test �Ӽ� : ${sessionScope.test}<br>
test �Ӽ� : <c:out value="${test}" /><br>

<c:remove var="test" />
test �Ӽ� : ${test}<br>

</body>
</html>