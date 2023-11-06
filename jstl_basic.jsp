<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstl core</title>
</head>
<body>
<b> 변수 설정</b><br>
변수 jum = 99<p>
<c:set var="jum" value="99"/>
<b> 변수 출력(out)</b><br>
<c:out value="${jum}"/><p>

<b>조건 처리(if)</b><br>
<c:if test="${jum <= 100 }">jum = ${jum}<br></c:if>
<c:out value="jum = ${jum}"></c:out><p>

<b>조건처리(choose-when-otherwise)</b><br>
	<c:choose>
		<c:when test="${jum >= 90}"><c:set var="grd" value="A"/></c:when>
		<c:when test="${jum >= 80}"><c:set var="grd" value="B"/></c:when>
		<c:when test="${jum >= 70}"><c:set var="grd" value="C"/></c:when>
		<c:when test="${jum >= 60}"><c:set var="grd" value="D"/></c:when>
		<c:when test="${jum >= 0}"><c:set var="grd" value="F"/></c:when>
		<c:otherwise><c:set var="grd" value="점수 오류!"/></c:otherwise>
	</c:choose>
	<c:out value="${jum}(${grd})"/><p>
	
<b>변수 삭제(remove)</b><br>
	<c:remove var="jum"/>
	<c:out value="${jum }(${grd })"/><p>

<b>예외 처리(catch)</b><br>
	<c:catch var="errmsg"><%= 99 / 0 %></c:catch>
	<c:out value="${errmsg}"></c:out>
</body>
</html>
