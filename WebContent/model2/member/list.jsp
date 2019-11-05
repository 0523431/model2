<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
	1. �α׾ƿ����� : �α����� �ʿ��մϴ�. �޽�ó ���
				  loginForm.jsp�������� �̵�
	2. �α��� ����
	   - �Ϲ� ����� : '�����ڸ� ������ �Ÿ��Դϴ�' �޽��� ���
	   - ������ : �������� �ŷ� ����
	3. DB���� ��� ȸ�� ������ ��ȸ�Ͽ�, LIST<Member> ��ü�� ����
	   List<Member> list - new MemberDao().list();
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ�� ��� ����</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>

<table>
	<caption>ȸ�� ���</caption>
	<tr><th>���̵�</th><th>�̸�</th><th>����</th><th>��ȭ</th><th>�̸���</th><th>&nbsp;</th></tr>
	
		<co:forEach var="m" items="${list}">
			<tr><td><a href="info.me?id=${m.id}">${m.id}</a></td>
				<td>${m.name}</td>
				<td>${m.gender==1? "����":"����"}</td>
				<td>${m.tel}</td>
				<td>${m.email}</td>
				<td><a href="updateForm.me?id=${m.id}">[����]</a>
					<co:if test="${m.id != 'admin'}">
						<a href="delete.me?id=${m.id}">[����Ż��]</a>
					</co:if>
					</td>
			</tr>
		</co:forEach>
</table>

</body>
</html>