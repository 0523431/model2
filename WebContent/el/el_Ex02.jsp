<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>el_Ex01.jsp�� ��� ȭ��</title>
</head>
<body>

<%
	request.setCharacterEncoding("euc-kr");

	String tel = "010-1234-1234";
	
	// ������������ ����ϴ� ��ü pageContext
	// (�ش�Ǵ� �� ������ �ϳ� = ���� ���� ����)
	pageContext.setAttribute("tel", tel);
	
	pageContext.setAttribute("test", "pageContext��ü�� test �Ӽ���");
	request.setAttribute("test", "request��ü�� test �Ӽ���");
	application.setAttribute("test", "application��ü�� test �Ӽ���");

%>

<h3>JSP�� ��ũ��Ʈ�� �̿��Ͽ� �Ķ���Ϳ� �Ӽ��� ���</h3>

pageContext test �Ӽ��� : <%=pageContext.getAttribute("test") %><br>
session test �Ӽ��� : <%=session.getAttribute("test") %><br>
today �Ӽ��� : <%=session.getAttribute("today") %><br>
name �Ķ���Ͱ� : <%=request.getParameter("name") %><br>
tel ������ : <%=tel %><br>
tel �Ӽ��� : <%=pageContext.getAttribute("tel") %><br>
noAttr �Ӽ��� : <%=pageContext.getAttribute("noAttr") %><br>
noparam �Ķ���Ͱ� : <%=request.getParameter("noparam") %>

<br>
<hr>
<br>
<%--
	EL(ǥ�����) : ǥ������ ��ü�ϴ� ���
				${��}
				��, �������� ǥ���� �� ���� => �Ӽ��̳� �Ķ���� ���� ǥ�� ����
--%>
<h3>
	JSP�� EL(ǥ��)�� �̿��Ͽ� �Ķ���Ϳ� �Ӽ��� ���<br>
	�ݵ�� �Ӽ��� ���ִ� ���� �ҷ��� �� ����
</h3>
pageContext test �Ӽ��� : ${test }<br>
session test �Ӽ��� : ${sessionScope.test }<br>
today �Ӽ��� : ${today }<br>
<%--
	today�Ӽ��� session�� ���� => ���� ǥ�ð� ������, ���� �������� ã��
	�ܰ躰�� ã���ʰ� �ٷ� �� �������� ���� ������,
		- ����Scope.�Ӽ��̸��� ���

	������ ũ��
	: page < request < session < application
--%>
name �Ķ���Ͱ� : ${param.name }<br>
tel ������ : EL�� ǥ�� �� ��. <%=tel %><br>
tel �Ӽ��� : ${tel }<br>
noAttr �Ӽ��� : ${noAttr }<br>
noparam �Ӽ��� :${param.noparam }
	<%--
	${test} : ������� ��ü�� ����� �Ӽ� �� �̸��� test�� ���� ����
	  - page ���� : pageContext ��ü
	  - request ���� : request
	  - session ���� : session
	  - application ���� : application

	1. pageContext ��ü�� ��ε� �Ӽ� �� �̸��� test�� �Ӽ��� ���� ����
	2. 1���� �ش��ϴ� �Ӽ��� ���� ���
	   request ��ü�� ��ε� �Ӽ� �� �̸��� test�� �Ӽ��� ���� ����
	3. 2���� �ش��ϴ� �Ӽ��� ���� ���
	   session ��ü�� ��ε� �Ӽ� �� �̸��� test�� �Ӽ��� ���� ����
	4. 3���� �ش��ϴ� �Ӽ��� ���� ���
	   application ��ü�� ��ε� �Ӽ� �� �̸��� test�� �Ӽ��� ���� ����
	5. 4���� �ش��ϴ� �Ӽ��� ���� ���
	   null�� �ƴϰ� �ƹ��͵� ������� ����. �����߻��� ����
	   
	<���� ���� ��� ��ü�� �����Ͽ� ����ϱ�>
	 - pageContext ��ü�� �Ӽ� : ${pageScope.test}
 	 - request ��ü�� �Ӽ� : ${requestScope.test}
 	 - session ��ü�� �Ӽ� : ${sessionScope.test}
 	 - application ��ü�� �Ӽ� : ${applicationScope.test}

--%>
<hr>
<h3>
	������ �����Ͽ� test �Ӽ��� ����ϱ�
</h3>
\${test} = ${test }<br>
\${pageScope.test} = ${pageScope.test}<br>
\${requestScope.test} = ${requestScope.test}<br>
\${sessionScope.test} = ${sessionScope.test}<br>
\${applicationScope.test} = ${applicationScope.test}<br>
\${requestScope.today} = ${requestScope.today}<br>
��(request�������� today��� �Ӽ��� �����ϱ� �ƹ��͵� �ȳ���)
</body>
</html>