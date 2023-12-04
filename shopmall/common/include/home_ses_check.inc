<%


	String cust_id = (String)session.getAttribute("cust_id");
	String cust_name = (String)session.getAttribute("cust_name);
	Boolean login = false;
	
	if((cust_id != null) && (cust_name != null)){
		login = true;
	}
%>