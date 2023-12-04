<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dbconnclose.*" %>

<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 회원정보 DB삭제</title>
<link rel="stylesheet" href="../../common/CSS/common.css">
</head>
<body>
<%
	String cust_id = request.getParameter("cust_id");
	String cust_pw = request.getParameter("cust_pw");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	conn = DbConnClose.getConnection();
	
	try{
		String sql = "DELETE FORM customer"
				+ "WHERE(cust_id = ?) and (cust_pw = ?)";
		pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cust_id);
			pstmt.setString(2, cust_pw);
		pstmt.executeUpdate();
	}catch(SQLException sqlerr){
		out.println("SQL 질의처리 오류!" + sqlerr.getMessage());
	}finally{
		DbConnClose.resourceClose(pstmt, conn);
	}
	
	out.println("고객테이블 튜플 삭제성공!"+ "<Br>");
	out.println("<script>alert('회원정보가 삭제 되었습니다!!'); location.href= './customer_maintenance' ");
%>
</body>
</html>