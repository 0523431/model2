<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSTL core �±� : �ݺ���</title>
</head>
<body>

<h3>�ݺ� ���� �±� : forEach</h3>
<co:forEach var="test" begin="1" end="10">
	${test}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</co:forEach>
<hr>
	<h4>step="2" ����</h4>
	<co:forEach var="test" begin="1" end="10" step="2">
		${test}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</co:forEach>

<hr>
<h3>forEach �±׸� �̿��Ͽ� 1���� 100������ �� ���ϱ�</h3>
<co:forEach var="i" begin="1" end="100">
	<co:set var="sum" value="${sum +i}" />
</co:forEach>
<h4>
	1���� 100������ �� : ${sum}
</h4>

<hr>
<h3>forEach �±׸� �̿��Ͽ� 1���� 100���� ¦���� �� ���ϱ�</h3>
<co:forEach var="even" begin="2" end="100" step="2">
	<co:set var="evensum" value="${evensum +even}" />
</co:forEach>
<h4>
	1���� 100���� ¦���� �� : ${evensum}
</h4>

<hr>
<h3>forEach �±׸� �̿��Ͽ� 1���� 100���� Ȧ���� �� ���ϱ�</h3>
<co:set var="sum" value="${0}" />
<co:forEach var="i" begin="1" end="100">
	<co:if test="${i%2 ==1}">
		<co:set var="sum" value="${sum +i}" />
	</co:if>
</co:forEach>
<h4>
	1���� 100���� Ȧ���� �� : ${sum}
</h4>

<hr>
<h3>forEach �±׸� �̿��Ͽ� 2�ܺ��� 9�ܱ����� ������ ����ϱ�</h3>
<co:forEach var="i" begin="2" end="9">
	<h4>${i}��</h4>
	<co:forEach var="j" begin="1" end="9">
		${i}*${j}=${i*j}<br>
	</co:forEach>
	<br>
</co:forEach>

<hr>
<h3>forEach �±׸� �̿��Ͽ� List ��ü ����ϱ�</h3>
<%
	List<Integer> list = new ArrayList<Integer>();
	for(int i=1; i<=10; i++) {
		list.add(i*10);
	}
	// EL�� ���� ���ؼ� �ݵ�� �Ӽ��� ����ؾ��ϴϱ�, page�� ���
	pageContext.setAttribute("list", list); // (�Ӽ��̸�, )
%>
<co:forEach var="i" items="${list}"> <%-- ${list} : �Ӽ��� �̸� --%>
	${i}&nbsp;&nbsp;&nbsp;&nbsp;
</co:forEach>
<%--
	var="i" items="${list}
	- i�� ÷�ڰ� �ƴ϶�, list�� �ִ� ���� �ϳ��ϳ��� ��
--%>
<hr>
<co:forEach var="i" items="${list}" varStatus="stat">
	<co:if test="${stat.index ==0}">
		<h4>forEach �±��� varStatus �Ӽ� ����</h4>
	</co:if>
	${stat.count} : ${i}<br> <%-- ��µǴ� ��� --%>
</co:forEach>
<%--
	count : 1���� ���� -> �ݺ��Ǹ鼭 2, 3, 4, ... 10 ���
	
	index : 0���� ���� : 0��°���ִ� �� ��� -> 2��°�� �ִ� �� ... 9��°�� �ִ� �� ���
--%>

<hr>
<h3>forEach �±׸� �̿��Ͽ� Map ��ü ����ϱ�</h3>
<%
	// key�� �ڷ���:String
	// value�� �ڷ��� :Object == ������� ���� �� ����
	// HashMap : ������ �� �� ����
	Map<String, Object> map = new HashMap<String, Object>();
	map.put("name", "ȫ�浿");
	map.put("today", new Date());
	map.put("age", 20);
	// EL�� ���� ���ؼ� �ݵ�� �Ӽ��� ��ϵǾ� �־����
	pageContext.setAttribute("maps", map);
%>
<co:forEach var="m" items="${maps}" varStatus="stat">
	${stat.count} : ${m.key} = ${m.value}<br> <%-- ��µǴ� ��� --%>
</co:forEach>

<hr>
<h3>EL�� �̿��Ͽ� Map ��ü ����ϱ�</h3>
	name= ${maps.name}<br>
	today= ${maps.today}<br>
	age= ${maps.age}<br>
	name= \${maps.name} ���⼭ \${maps.name}���� maps�� �Ӽ��̸�<br>

<hr>
<h3>forEach �±׸� �̿��Ͽ� �迭 ��ü ����ϱ�</h3>
<co:set var="arr" value="<%=new int[]{10,20,30,40,50} %>" />
<%-- set�� EL�Ӹ� �ƴ϶�, ǥ����<%= %>�� value���� �� �� ���� --%>

<co:forEach var="a" items="${arr }" varStatus="stat">
	arr[${stat.index}] = ${a}<br>
</co:forEach>

<hr>
<h4>�׷��ϱ�, EL�� �迭�� ����Ʈ�� ���� ������ �� ����</h4>
${arr[0]}<br>
${list[2]}

<hr>
<h4>forEach �±׸� �̿��Ͽ� �迭 ��ü�� �ι�° ��Һ��� ����° ��ұ��� ����ϱ�</h4>
<co:forEach var="a" items="${arr}" varStatus="stat" begin="1" end="2">
	arr[${stat.index}] = ${a}<br>
</co:forEach>
<%-- arr�迭�� ����ϴµ� begin1���� end2������ �������� --%>

<hr>
<h4>forEach �±׸� �̿��Ͽ� �迭 ��ü�� ¦�� �ε����� ����ϱ�</h4>
<co:forEach var="a" items="${arr}" varStatus="stat" step="2">
	arr[${stat.index}] = ${a}<br>
</co:forEach>

<hr>
<h4>forEach �±׸� �̿��Ͽ� �迭 ��ü�� Ȧ�� �ε����� ����ϱ�</h4>
<co:forEach var="a" items="${arr}" varStatus="stat" begin="1" step="2">
	arr[${stat.index}] = ${a}<br>
</co:forEach>

</body>
</html>