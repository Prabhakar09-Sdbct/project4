<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.Bean.FacultyBean"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.rays.pro4.Bean.CompensationBean"%>
<%@page import="com.rays.pro4.Model.CompensationModel"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.rays.pro4.Bean.CompensationBean"%>
<%@page import="com.rays.pro4.controller.CompensationListCtl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<link rel="icon" type="image/png"
	href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16" />
<title>Compensation List</title>

<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/Checkbox11.js"></script>


<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		$("#udate").datepicker({
			changeMonth : true,
			changeYear : true,
			yearRange : '1980:2020',

		});
	});
</script>


</head>
<body>
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.CompensationBean"
		scope="request"></jsp:useBean>

	<form action="<%=ORSView.COMPENSATION_LIST_CTL%>" method="post">
		<%@include file="Header.jsp"%>
		
		<%
		List<FacultyBean> cl = (List<FacultyBean>) request.getAttribute("fList");
		int next = DataUtility.getInt(request.getAttribute("nextlist").toString());
		
		%>

		<center>

			<div align="center">
				<h1>Compensation List</h1>
				<h3>
					<font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
					<font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>
				</h3>
			</div>

			<%
			int pageNo = ServletUtility.getPageNo(request);
			int pageSize = ServletUtility.getPageSize(request);
			int index = ((pageNo - 1) * pageSize) + 1;

			List list = ServletUtility.getList(request);
			Iterator<CompensationBean> it = list.iterator();

			if (list.size() != 0) {
			%>

			<table width="100%" align="center">
				<tr>
					<td align="center"><label> Staff Member:</label> 
					<%=HTMLUtility.getList("staffMember", String.valueOf(bean.getStaffMember()), cl)%>&emsp;

						&nbsp; <label>Payment Amount:</label> <input type="text"
						name="paymentAmount" placeholder="Enter Payment Amount" Size="25"
						value="<%=ServletUtility.getParameter("paymentAmount", request)%>">

						&nbsp; <label>Date Applied</font> :
					</label> <input type="text" id="udate" name="dateApplied"
						placeholder="Enter Date Applied"
						value="<%=ServletUtility.getParameter("dateApplied", request)%>">


						&nbsp; <label>Condition:</label> <%
 HashMap map = new HashMap();
 map.put("Active", "Active");
 map.put("Inactive", "Inactive");

 String hlist = HTMLUtility.getList("state", String.valueOf(bean.getState()), map);
 %> <%=hlist%> &nbsp; <input type="submit" name="operation"
						value="<%=CompensationListCtl.OP_SEARCH%>"> <input
						type="submit" name="operation"
						value="<%=CompensationListCtl.OP_RESET%>"></td>
				</tr>
			</table>

			<br>

			<table border="1" width="100%" align="center" cellpadding=6px
				cellspacing=".2">
				<tr style="background: skyblue">
					<th><input type="checkbox" id="select_all" name="select">Select
						All.</th>

					<th>S No.</th>
					<th>Staff Member.</th>
					<th>Payment Amount.</th>
					<th>Date Applied.</th>
					<th>State</th>
					<th>Edit</th>
				</tr>

				<%
				while (it.hasNext()) {
					bean = it.next();
				%>



				<tr align="center">
					<td><input type="checkbox" class="checkbox" name="ids"
						value="<%=bean.getId()%>">
					<td><%=index++%></td>
					<td><%=bean.getStaffMember()%></td>
					<td><%=bean.getPaymentAmount()%></td>
					<td><%=bean.getDateApplied()%></td>
					<td><%=bean.getState()%></td>
					<td><a href="CompensationCtl?id=<%=bean.getId()%>">Edit</a></td>
				</tr>
				<%
				}
				%>
			</table>
			<table width="100%">
				<tr>
					<%
					if (pageNo == 1) {
					%>
					<td><input type="submit" name="operation" disabled="disabled"
						value="<%=CompensationListCtl.OP_PREVIOUS%>"> <%
 } else {
 %>
					<td><input type="submit" name="operation"
						value="<%=CompensationListCtl.OP_PREVIOUS%>"></td>
					<%
					}
					%>

					<td><input type="submit" name="operation"
						value="<%=CompensationListCtl.OP_DELETE%>"></td>
					<td><input type="submit" name="operation"
						value="<%=CompensationListCtl.OP_NEW%>"></td>

					<%
					CompensationModel model = new CompensationModel();
					%>
					<%
					if (list.size() < pageSize || next == 0) {
					%>
					<td align="right"><input type="submit" name="operation"
						disabled="disabled" value="<%=CompensationListCtl.OP_NEXT%>"></td>
					<%
					} else {
					%>
					<td align="right"><input type="submit" name="operation"
						value="<%=CompensationListCtl.OP_NEXT%>"></td>
					<%
					}
					%>

				</tr>
			</table>
			<%
			}
			if (list.size() == 0) {
			%>
			<td align="center"><input type="submit" name="operation"
				value="<%=CompensationListCtl.OP_BACK%>"></td>
			<%
			}
			%>

			<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
	</form>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</center>

	<%@include file="Footer.jsp"%>
</body>
</html>