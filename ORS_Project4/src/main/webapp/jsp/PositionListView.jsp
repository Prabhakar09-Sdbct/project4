<%@page import="java.util.HashMap"%>
<%@page import="com.rays.pro4.Bean.PositionBean"%>
<%@page import="com.rays.pro4.Model.PositionModel"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.rays.pro4.Bean.PositionBean"%>
<%@page import="com.rays.pro4.controller.PositionListCtl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<link rel="icon" type="image/png"
	href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16" />
<title>Position List</title>

<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js""></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/Checkbox11.js"></script>


</head>
<body>
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.PositionBean"
		scope="request"></jsp:useBean>

	<form action="<%=ORSView.POSITION_LIST_CTL%>" method="post">
		<%@include file="Header.jsp"%>

		<center>

			<div align="center">
				<h1>Position List</h1>
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
			Iterator<PositionBean> it = list.iterator();

			if (list.size() != 0) {
			%>

			<table width="100%" align="center">
				<tr>
					<td align="center"><label> Designation:</label> <input
						type="text" name="designation" placeholder="Enter Designation"
						Size="25"
						value="<%=ServletUtility.getParameter("designation", request)%>">
						&nbsp; <label>Required Experience:</label> <input type="text"
						name="requiredExperience" placeholder="Enter Required Experience"
						Size="25"
						value="<%=ServletUtility.getParameter("requiredExperience", request)%>">
						&nbsp; <label>Condition:</label> <%
 HashMap map = new HashMap();
 map.put("Open", "Open");
 map.put("Closed", "Closed");
 map.put("OnHold", "On Hold");

 String hlist = HTMLUtility.getList("condition", String.valueOf(bean.getCondition()), map);
 %> <%=hlist%> &nbsp; <input type="submit" name="operation"
						value="<%=PositionListCtl.OP_SEARCH%>"> <input
						type="submit" name="operation"
						value="<%=PositionListCtl.OP_RESET%>"></td>
				</tr>
			</table>

			<br>

			<table border="1" width="100%" align="center" cellpadding=6px
				cellspacing=".2">
				<tr style="background: skyblue">
					<th><input type="checkbox" id="select_all" name="select">Select
						All.</th>

					<th>S No.</th>
					<th>Desigation.</th>
					<th>Opening Date.</th>
					<th>Required Experience.</th>
					<th>Condition.</th>
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
					<td><%=bean.getDesignation()%></td>
					<td><%=bean.getOpeningDate()%></td>
					<td><%=bean.getRequiredExperience()%></td>
					<td><%=bean.getCondition()%></td>
					<td><a href="PositionCtl?id=<%=bean.getId()%>">Edit</a></td>
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
						value="<%=PositionListCtl.OP_PREVIOUS%>"> <%
 } else {
 %>
					<td><input type="submit" name="operation"
						value="<%=PositionListCtl.OP_PREVIOUS%>"></td>
					<%
					}
					%>

					<td><input type="submit" name="operation"
						value="<%=PositionListCtl.OP_DELETE%>"></td>
					<td><input type="submit" name="operation"
						value="<%=PositionListCtl.OP_NEW%>"></td>

					<%
					PositionModel model = new PositionModel();
					%>
					<%
					if (list.size() < pageSize || model.nextPK() - 1 == bean.getId()) {
					%>
					<td align="right"><input type="submit" name="operation"
						disabled="disabled" value="<%=PositionListCtl.OP_NEXT%>"></td>
					<%
					} else {
					%>
					<td align="right"><input type="submit" name="operation"
						value="<%=PositionListCtl.OP_NEXT%>"></td>
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
				value="<%=PositionListCtl.OP_BACK%>"></td>
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