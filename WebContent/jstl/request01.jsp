<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���۵� �Ķ���� ����</title>
</head>
<body>

<fmt:requestEncoding value="euc-kr" />

�̸� : ${param.name}<br>
���� : ${param.age}<br>
���� : ${param.gender==1? "��":"��"}<br>
��� : ${param.hobby}<br>
����⵵ : ${param.year}<br>

<h3>��� ���� ��� ��ȸ�ϱ�</h3>
��� : 
<c:forEach var="hob" items="${paramValues.hobby}">
	${hob}
</c:forEach>
<br>
${paramValues.hobby}�� �迭�� ���·� �����.
${paramValues.hobby[0]}

<hr>
<h3>��� �Ķ���� ���� ��ȸ�ϱ�(hidden����)</h3>
<table>
	<tr><th>�Ķ�����̸�</th><th>�Ķ���� ��</th></tr>
	<c:forEach var="p" items="${paramValues}">
		<tr><td>${p.key}</td>
			<td>
			<c:forEach var="v" items="${p.value}">
				${v}&nbsp;&nbsp;&nbsp;&nbsp;
			</c:forEach>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>