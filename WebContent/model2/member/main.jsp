<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	1. �α��� �Ŀ� �������� ������
	   => �α����� �� �� ���, loginForm.jsp ������ �̵��ϱ�
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������</title>
</head>
<body>

	<h3>${sessionScope.login}(��)�� �α��� �Ǿ����ϴ�</h3>
	<h3><a href="logout.me">�α׾ƿ�</a></h3>
	<h3><a href="info.me?id=${sessionScope.login}">ȸ����������</a></h3>
		<%--
			info.jsp���� id��� �Ķ���Ͱ� �پ
			info.jsp�� DB�κ��� ���� login��=id
		--%>
	<co:if test="${sessionScope.login == 'admin'}"> <%--�����ڷ� �α��� �ߴٸ�,--%>
		<h3><a href="list.me">ȸ����Ϻ���</a></h3>
	</co:if>
		
</body>
</html>