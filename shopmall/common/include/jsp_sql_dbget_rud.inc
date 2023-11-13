<%
	String sql = "SELECT * FROM customer WHERE (cust_id = ? )";
	pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,cust_id);
		rset = pstmt.excuteQuery();
		
	if(!rset.isBeforeFirst()){
		out.print("<script>alert('존재하지 않는 아이디입니다!!');"
		 + "history.back();"
		 + "</script>);
	}
	
	rset.next();
	cust_id = reset.getString("cust_id");
	String cust_pw = reset.getString("cust_pw");
	String cust_name = reset.getString("cust_name");
	String custTelNo = reset.getString("custTelNo");
	String cust_addr = reset.getString("cust_addr");
	String cust_grnder = reset.getString("cust_gender");
	String cust_email = reset.getString("cust_email");
	String cust_join_date = reset.getString("cust_join_date");

%>