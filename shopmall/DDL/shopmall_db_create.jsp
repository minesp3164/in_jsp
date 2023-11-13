<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰데이터베이스(shopmall) DB 생성</title>
</head>
<body>
<%
	//JDBC 드라이버 로딩(loading JDBC driver)
	String driverClass = "org.mariadb.jdbc.Driver";
		
		try {
			Class.forName(driverClass);
			out.println("JDBC Driver loading 성공!<br>");
		}catch(ClassNotFoundException err) {
			out.println("JDBC Driver loading 실패!!...WEB-INF/lib 폴더 확인");
		}
		//MariaDB 서버와 데이터베이스 연결(connect server & database)
		String url = "jdbc:mariadb://localhost:3303/";
		String id = "root";
		String pw = "admin";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		
		try{
			conn = DriverManager.getConnection(url,id,pw);
			
			String sql = "CREATE DATABASE shopmall";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			out.println("쇼핑몰데이터베이스(shopmall)생성 성공!<br>");
			
		}catch(SQLException sqlerr){
			out.println("쇼핑몰데이터베이스(shopmall)생성 실패!!" + sqlerr.getMessage() + "<Br>");
		}finally{
			//데이터베이스 연결 종료(close database)
			if(pstmt != null)try{pstmt.close();}catch(SQLException sqlerr){}
			if(conn != null)try{conn.close();}catch(SQLException sqlerr){}
		}
%>

</body>
</html>