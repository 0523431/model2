<%@page import="model.Board"%>
<%@page import="model.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խ��� ��� ����</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>

<form action="reply.do" name="f" method="post">
	<%--
		���ۿ� ���� ������ hidden������ ����
		--> ����, num�� grp�� ���� ����  & grplevel�� grpstep�� 0
	--%>
	<input type="hidden" name="num" value="${info.num}">
	<input type="hidden" name="grp" value="${info.grp}">
	<input type="hidden" name="grplevel" value="${info.grplevel}">
	<input type="hidden" name="grpstep" value="${info.grpstep}">
	
	<table>
		<caption>�Խ��� ��� ���</caption>
		<tr><th>�۾���</th>
			<td><input type="text" name="name"></td></tr>
		<tr><th>��й�ȣ</th>
			<td><input type="password" name="pass"></td></tr>
		<tr><th>����</th>
			<td><input type="text" name="title"
				 value="RE:${info.title}"></td></tr> <%--������ ���ۿ��� ������ --%>
		<tr><th>����</th>
			<td><textarea name="content" rows="15"></textarea></td></tr>
		<tr><td colspan="2"><a href="javascript:document.f.submit()">[�亯�۵��]</a></td></tr>
	</table>
</form>

</body>
</html>