<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Խù� ��� ����</title>
<link rel="stylesheet" href="../../css/main.css">

<script>
	// �˻� ��, �� ����� �������� ���������ִ� �޼����Լ�
	function listdo(page) { // listdo �޼��忡 page���� �ְ�
		document.sf.pageNum.value = page; // pageNum�� value���� �ٲ��ִ� �ž�
		document.sf.submit(); // form�� submit���ִ� �ž�
	}
</script>

</head>
<body>

<%--
	��� �׼��� form�� ���ؼ� ��������, �˻������ ������ �� �ְ� ��
	�׷��ϱ� �˻� ����� 12���̸�, 1�������� 10�� 2�������� 2���� �����ָ� �ǰ� ����������
--%>
<form action="list.do" method="post" name="sf">
<input type="hidden" name="pageNum" value="1">
<table>
	<tr><td style="border-width: 0px; border-radius:10px 10px;">
		<select name="column">
			<option value="">�����ϼ���</option>
			<option value="title">����</option>
			<option value="name">�ۼ���</option>
			<option value="content">����</option>
			<option value="title,name">����+�ۼ���</option>
			<option value="title,content">����+����</option>
			<option value="name,content">�ۼ���+����</option>
		</select>
		<script type="text/javascript">
			document.sf.column.value="${param.column}";
		</script>
		<input type="text" name="find" value="${param.find}" style="width:50%">
		<input type="submit" value="�˻�">
		</td>
	</tr>
</table>
</form>
<br>
<table>
	<caption>�Խ��� ���</caption>
	<co:if test="${boardcnt ==0}">
		<tr><td colspan="5">��ϵ� �Խñ��� �����ϴ�</td></tr>
	</co:if>
	
	<co:if test="${boardcnt >0}">
		<tr><td colspan="5" style="text-align:right">�۰��� : ${boardcnt}</td></tr>
		<tr><th width="8%">��ȣ</th>
			<th width="50%">����</th>
			<th width="14%">�ۼ���</th>
			<th width="17%">�����</th>
			<th width="11%">��ȸ��</th></tr>
		<co:forEach var="b" items="${list}">
			<tr><td>${boardnum}</td><%--<%=b.getNum() %>  // boardnum : �����ֱ�� ��ȣ --%>
				<co:set var="boardnum" value="${boardnum -1}" />
				<td style="text-align:left">
					
				<%-- ÷������ Ȯ��--%>
				<co:if test="${!empty b.file1}">
						<a href="file/${b.file1}" style="text-decoration:none;">[÷��]</a>
				</co:if>
				<co:if test="${empty b.file1}">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</co:if>
								
				<%-- ��� ǥ�� : ������ grplevel���� �ٸ��� ǥ���ϴ� ��� --%>
				<co:if test="${b.grplevel >0}">
					<co:forEach begin="1" end="${b.grplevel}">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</co:forEach>
					��>
				</co:if>
				
				<%-- ${b.num}&pageNum=${pageNum} --%>
				<a href="info.do?num=${b.num}">${b.title}</a></td>
				<td>${b.name}</td>
				<%-- ����� --%>
				<td>
					<co:set var="today" value="<%= new java.util.Date() %>" />
					<fmt:formatDate value="${today}" var="today1" pattern="yyyy-MM-dd" />
				<%--<fmt:parseDate value="${b.regdate}" var="today2" pattern="yyyy-MM-dd HH:mm:ss" />  --%>
					<fmt:formatDate value="${b.regdate}" var="today3" pattern="yyyy-MM-dd" />

					<co:if test="${today1 == today3}">
						<fmt:formatDate value="${b.regdate}" pattern="HH:mm:ss" />						
					</co:if>
					<co:if test="${today1 != today3}">
						<fmt:formatDate value="${b.regdate}" pattern="yy-MM-dd HH:mm" />
					</co:if>
				</td>
				
				<td>${b.readcnt}</td></tr>
		</co:forEach>
		
		<%-- ����� �κ� --%>
		<tr><td colspan="5">
		<co:if test="${pageNum <=1}">
			[����]
		</co:if>
		<co:if test="${pageNum >1}">
				<%-- <a href="list.do?pageNum=${pageNum -1}">[����]</a> --%>
				<a href="javascript:listdo(${pageNum -1})">[����]</a>
		</co:if>
		
		<co:forEach var="a" begin="${startpage}" end="${endpage}">
			<co:if test="${a ==pageNum}">
				[${a}]
			</co:if>
			<co:if test="${a !=pageNum}">
				<%-- <a href="list.do?pageNum=${a}">[${a}]</a> --%>
				<a href="javascript:listdo(${a})">[${a}]</a>
			</co:if>
		</co:forEach>

		<co:if test="${pageNum >= maxpage}">
			[����]
		</co:if>
		<co:if test="${pageNum < maxpage}">
			<%-- <a href="list.do?pageNum=${pageNum +1}">[����]</a> --%>
			<a href="javascript:listdo(${pageNum +1})">[����]</a>
		</co:if>
		</td></tr>
	</co:if>
		
		<tr><td colspan="5" style="text-align:right">
			<a href="writeForm.do">[�۾���]</a></td></tr>
</table>

</body>
</html>