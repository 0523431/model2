<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%--
	1. ���Ͼ��ε�			: java ����
	2. opener ȭ�鿡 ���	: javaScript ���� ==> ���⼭ �ϴ� ���
	3. ����ȭ�� close()		: javaScript ���� ==> ���⼭ �ϴ� ���
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%  // 1. ���� ���ε� = java ���� =========> PictureAction.java�� �Ұž�	%>

<script type="text/javascript">
	img = opener.document.getElementById("pic");
	img.src = "picture/${fname}"; // fname�̶�� �Ӽ��� �ʿ���(PictureAction���� ����ž�)
	
	opener.document.f.picture.value="${fname}";
	self.close();
</script>

</body>
</html>