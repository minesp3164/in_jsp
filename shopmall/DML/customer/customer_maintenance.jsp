<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객정보 관리</title>
</head>
<body>
<form name="customer_maintenacne_form">
	<b>고객정보 관리</b><p>
	<a href="./customer_insert_form.jsp">회원가입</a><br>
	<a href="./customer_retrieval_form.jsp">회원정보 검색</a><br>
	<a href="./customer_update_form.jsp">회원정보 갱신</a><br>
	<a href="./customer_delete_form.jsp">회원정보 삭제(탈퇴)</a><br>
	<a href="./customer_retrieval_table.jsp">고객정보 테이블 검색과 갱신 및 삭제(관리자)</a><br>
	<a href="./customer_retrieval_table_paging.jsp">고객정보 테이블 검색과 페이지 제어</a><p>
	
	<p><input type="button" value="홈페이지" onClick="location.href='../../home/index.jsp"></p>
</form>
</body>
</html>