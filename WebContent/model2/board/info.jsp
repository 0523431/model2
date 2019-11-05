<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� �� ����</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>

<table>
	<caption>�Խù� �� ����</caption>
	
	<tr><th width="20%">�۾���</th>
		<td style="text-align:left">${info.name}</td></tr>
	<tr><th>����</th>
		<td style="text-align:left">${info.title}</td></tr>
	<tr><th>����</th>
		<td><table style="width:100%; height:250px;">
				<tr>
					<td style="border-width:0px; vertical-align:top; text-align:left">
					${info.content}
					<%-- <c:out value="${info.content}" /> �±� ����ȭ--%>
					</td>
				</tr>
			</table></td></tr>
	<tr><th>÷������</th>
		<%-- <td><%=(info.getFile1() ==null)? "":info.getFile1() %></td> --%>
		<td>
			<c:if test="${empty info.file1}">
				&nbsp;
			</c:if>
			<c:if test="${!empty info.file1}">
				<a href="file/${info.file1}">${info.file1}</a>
			</c:if>
		</td>
	</tr>
	<tr><td colspan="2">
		<a href="replyForm.do?num=${num}">[�亯]</a>
		<a href="updateForm.do?num=${info.num}">[����]</a>
		<a href="deleteForm.do?num=${num}">[����]</a>
		<a href="list.do">[���]</a>
		</td></tr>
</table>

</body>
</html>