<%@page import="model.Member"%>
<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��й�ȣ ã��</title>

<script type="text/javascript">
	function closePass() {
		opener.document.f.pass.value = ""; // ���޾���
		opener.document.f.pass.focus();
		self.close();
	}
</script>

</head>

<body>
<form name="f">
 <h3 id="passcut">��й�ȣ **${pass}</h3>
 <input type="button" value="�ݱ�" onclick="closePass()">
</form>

</body>
</html>
