
<%@page import="com.rays.pro4.Bean.PrescriptionBean"%>
<%@page import="com.rays.pro4.Bean.StudentBean"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="javax.swing.text.html.HTML"%>
<%@page import="java.util.List"%>
<%@page import="com.rays.pro4.controller.PrescriptionCtl"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<html>
<head>
<link rel="icon" type="image/png" href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16"/>
<title> Prescription Registration Page</title>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#udate4" ).datepicker({
      changeMonth: true,
      changeYear: true,
	  yearRange:'1980:2020', 
	  
    });
  } );
  </script>


</head>
<body>
    <jsp:useBean id="bean" class="com.rays.pro4.Bean.PrescriptionBean" scope="request"></jsp:useBean>
    	
	<form action="<%=ORSView.PRESCRIPTION_CTL%>" method="post">
    <%@include file="Header.jsp"%>
    
    <% 
    	List <PrescriptionBean> clist = (List <PrescriptionBean>)request.getAttribute("dList");
    
    %>
    
    <center>
        <h1>
        	<%
        		if( bean != null && bean.getId()>0){
        	%> 
        	<tr><th><font>Update Prescription</font></th></tr>
        	<% }else{%>
        	<tr><th><font>Add Prescription</font></th></tr>
        	<% }%>
        </h1>
		
		<div>
		<h3><font style="color: green"><%=ServletUtility.getSuccessMessage(request) %></font></h1>
		<h3><font style="color: red"><%=ServletUtility.getErrorMessage(request) %></font>
		</h1>
		</div>
		
		<input type="hidden" name="id" value="<%=bean.getId()%>">
		<input type="hidden" name="createdby" value="<%=bean.getCreatedBy()%>">
		<input type="hidden" name="modifiedby" value="<%=bean.getModifiedBy()%>">
		<input type="hidden" name="createddatetime" value="<%=bean.getCreatedDatetime()%>">
		<input type="hidden" name="modifieddatetime" value="<%=bean.getModifiedDatetime()%>">

	<table>
	
		<tr>
		<th align="left">Name <span style="color: red">*</span> :</th>
		<td><input type="text" name="name" placeholder="Enter Name" size="26" value="<%=DataUtility.getStringData(bean.getName())%>"></td>
		<td style="position: fixed"><font  color="red"><%=ServletUtility.getErrorMessage("firstname", request)%></font>
		</td>
		</tr>
		
		 <tr><th style="padding: 3px"></th></tr>    
	
		<tr>
		<th align="left">Decease <span style="color: red">*</span> :</th>
		<td><input type="text" name="decease" maxlength="10" placeholder="Enter Decease" size="26" value="<%=DataUtility.getStringData(bean.getDecease())%>"></td>
		<td style="position: fixed" ><font color="red"><%=ServletUtility.getErrorMessage("decease", request)%></font>
		</td>
		</tr>
		
		  <tr><th style="padding: 3px"></th></tr>    
		
		 <tr>
		  <th align="left">Date <span style="color: red">*</span> :</th>
          <td><input type="text" name="date" id="udate4" readonly="readonly" placeholder=" Date" size="26"  value="<%=DataUtility.getDateString(bean.getDate())%>"></td> 
         <td style="position: fixed"><font color="red"> <%=ServletUtility.getErrorMessage("date", request)%></font></td>
                </tr>
	
		  <tr><th style="padding: 3px"></th></tr>    
	
		<tr>
		<th align="left">Capacity <span style="color: red">*</span> :</th>
		<td><input type="text" name="capacity" placeholder="Enter Capacity" size="26" value="<%=DataUtility.getStringData(bean.getCapacity())%>"></td>
		<td style="position: fixed" ><font color="red"><%=ServletUtility.getErrorMessage("capacity", request)%></font>
		</td>
		</tr>
	
		  <tr><th style="padding: 3px"></th></tr>    
		

	<tr>
	<th></th>
		<%
		if(bean.getId() > 0){ %>
		<td>
		 &nbsp;  &emsp;
		<input type="submit" name="operation" value="<%=PrescriptionCtl.OP_UPDATE %>">
		 &nbsp;  &nbsp;
		<input type="submit" name="operation" value="<%=PrescriptionCtl.OP_CANCEL%>"></td>
		<%}else{ %>
		<td>
		 &nbsp;  &emsp;
		<input type="submit" name="operation" value="<%=PrescriptionCtl.OP_SAVE %>">
		 &nbsp;  &nbsp;
		<input type="submit" name="operation" value="<%=PrescriptionCtl.OP_RESET%>"></td>
	
		<%} %>
	</tr>
	
	</table>
</form>
</center>

<%@ include file = "Footer.jsp" %>
</body>
</html>
