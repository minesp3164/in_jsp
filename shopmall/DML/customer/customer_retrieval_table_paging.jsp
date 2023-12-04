<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dbconnclose.*" %>
<%@ page import="java.lang.Math.*" %>
<%@ page import="java.text.DecimalFormat" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../common/CSS/table_retrieval.css">
</head>
<body>
<%
	int LINE_PER_PAGE = 1;
	int PAGE_PER_BLOCK = 2;
	int nbr_of_row =0;
	int nbr_of_page = 0;
	
	int start_pointer = 0;
	int cur_page_no = 0;
	int block_nbr = 0;
	int block_startpage_no = 0;
	int block_endpage_no = 0;
	int previous_block_start_pageno = 0;
	int next_block_start_pageno = 0;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rset = null;
	
	conn = DbConnClose.getConnection();
	
	try{
		String sql = "SELECT count(*) FROM customer";
		stmt = conn.createStatement();
		rset = stmt.executeQuery(sql);
		
		
		rset.next();
		nbr_of_row = Integer.parseInt(rset.getString("count(*)"));
		nbr_of_page = (int)Math.ceil((float)nbr_of_row / LINE_PER_PAGE);
		
		if(request.getParameter("pageno") == null){
			cur_page_no = 1;
		}else if(nbr_of_page < Integer.parseInt(request.getParameter("pageno"))){
			cur_page_no = nbr_of_page;
		}else{
			cur_page_no = Integer.parseInt(request.getParameter("pageno"));
		}
		
		start_pointer = (cur_page_no - 1) * LINE_PER_PAGE;
		
		
		sql = "SELECT * FROM customer ORDER BY cust_id ASC LIMIT ?,?";
		pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start_pointer);
			pstmt.setInt(2, LINE_PER_PAGE);
		rset = pstmt.executeQuery();
		
		if(!rset.isBeforeFirst()){
			out.print("<script>alert('고객테이블이 비어 있습니다!'); history.back(); </script>");
		}
		%>
<form name="customer_form_table">
	<table>
		<caption>고객정보 테이블 검색과 페이지 제어</caption>
		<tr style="border-style;hidden hidden solid hidden;">
			<td colspan="8" style="background-color:white; text-align:right; color:blue;">
			현재 회원 수 <%= new DecimalFormat("#,###").format(nbr_of_row) %> 명 &nbsp;
			(전체 <%= nbr_of_page %>쪽 중&nbsp;현재 <%= cur_page_no %>쪽)</td>
		</tr>
		<tr>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>주소</th>
			<th>성별</th>
			<th>이메일</th>
			<th>가입일</th>
		</tr>
			<%
					while(rset.next()){
						String cust_id = rset.getString("cust_id");
						String cust_pw = rset.getString("cust_pw");
						String cust_name = rset.getString("cust_name");
						String cust_tel_no = rset.getString("cust_tel_no");
						String cust_addr = rset.getString("cust_addr");
						String cust_gender = rset.getString("cust_gender");
						if(cust_gender == null){
							cust_gender="";
						}else if (cust_gender.equals("M")){
							cust_gender = "남자(" + cust_gender + ")";
						}else{cust_gender = "여자(" + cust_gender + ")";}
						
						String cust_email = rset.getString("cust_email");
						String cust_join_date = rset.getString("cust_join_date");
					
				%>
			<tr>
				<td><%=cust_id %></td>
				<td><%=cust_pw %></td>
				<td><%=cust_name %></td>
				<td><%=cust_tel_no %></td>
				<td><%=cust_addr %></td>
				<td><%=cust_gender %></td>
				<td><%=cust_email %></td>
				<td><%=cust_join_date %></td>
			</tr>
			<% 
			} 
			%>
			<tr>
				<td colspan="8" style="text-align:center;">
			<%
				block_nbr = ((cur_page_no - 1) / PAGE_PER_BLOCK) + 1;
				block_startpage_no = ((block_nbr - 1) * PAGE_PER_BLOCK) + 1;
				block_endpage_no = ((block_startpage_no + PAGE_PER_BLOCK) - 1);
				
				if(block_nbr  > 1){
					out.print("&nbsp[<a href='./customer_retrieval_table_paging.jsp?pageno=1>맨처음</a>]&nbsp'");
					
					previous_block_start_pageno = block_startpage_no - PAGE_PER_BLOCK;
					out.print("&nbsp[<a href='./customer_retrieval_table_paging.jsp?pageno=" + previous_block_start_pageno +"'>이전</a>]&nbsp");
				}
				
				for(int pgn = block_startpage_no; pgn <= block_endpage_no; pgn++){
					if(pgn > nbr_of_page){
						break;
					}
					
					if(pgn == cur_page_no){
						out.print("&npsp" + pgn + "&nbsp");
					}else{
						out.print("&nbsp[" + "<a href='./customer_retrieval_table_paging.jsp?pageno=" + pgn +"'>" + pgn + "</a>]&nbsp");
					}
				}
				
				if(block_endpage_no < nbr_of_page){
					
					next_block_start_pageno = block_endpage_no + 1;
					out.print("&nbsp[" + "<a href='./customer_retrieval_table_paging.jsp?pageno=" + next_block_start_pageno +"'> + 다음 + </a>]&nbsp");
					out.print("&nbsp[" + "<a href='./customer_retrieval_table_paging.jsp?pageno=" + nbr_of_page +"'> + 맨끝 + </a>]&nbsp");
				}
			%>
			</td>
		</tr>
		<%
	}catch(SQLException sqlerr){
		System.out.println("SQL 질의처리 오류!" + sqlerr.getMessage());
	}finally{
		DbConnClose.resourceClose(rset, pstmt, conn);
	}
		%>
	</table>
</form>
<a href="./customer_maintenance.jsp">[ 고객정보관리 ]</a>
</body>
</html>