<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.time.*" %>

<%@ page import="dbconnclose.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테이블 개인 고객정보 DB 삽입</title>
</head>
<body>
	<%@ include file="../../common/include/jsp_id_check_irud.inc" %>
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		conn = DbConnClose.getConnection();
		
		try{
			String sql = "SELECT * FROM customer WHERE(cust_id = ?)";
			pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,cust_id);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				out.print("<script>alert('사용할 수 없는 아이디입니다!');"
				 + "history.back();"
				 + "</script>");
			}else{
				%>
				<%@ include file = "../../common/include/jsp_sql_dbset_iu.inc" %>
				<%
				
				sql = "INSERT INTO customer VALUES(?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,cust_id);
					pstmt.setString(2,cust_pw);
					pstmt.setString(3,cust_name);
					pstmt.setString(4,cust_tel_no);
					pstmt.setString(5,cust_addr);
					pstmt.setString(6,cust_gender);
					pstmt.setString(7,cust_email);
					pstmt.setString(8, LocalDate.now().toString());
				pstmt.executeUpdate();
					
			}
		}catch(SQLException sqlerr){
			out.println("SQL 질의처리 오류" + sqlerr.getMessage());
		}finally{
			DbConnClose.resourceClose(rset, pstmt, conn);
		}
		
		out.println("고객테이블(customer) 튜플 저장 성공!");
	%>
</body>
</html>