<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���̵� ã��</title>

<script type="text/javascript">
	function sendId() {
		opener.document.f.id.value = "${fn:substring(id,0,id.length()-2)}";
		opener.document.f.id.focus();
  		self.close();
  	}
	
</script>

</head>

<body>

<form name="f">
	<h3 id="idcut">���̵� ${id}**</h3>
	<input type="button" value="���̵� ����" onclick="sendId()">
</form>

</body>
</html>