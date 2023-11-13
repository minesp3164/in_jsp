<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbconnclose.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 데이터베이스 DB 삭제</title>				
</head>
<body>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	conn = DbConnClose.getConnection();

	try{
		String sql = "DROP DATABASE shopmall";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		out.println("쇼핑몰 데이터베이스 삭제 성공!");
		
	}catch(SQLException sqlerr){
		out.println("SQL 질의처리 오류!" + sqlerr.getMessage());
	}finally{
		DbConnClose.resourceClose(pstmt, conn);
	}
%>
</body>
</html>