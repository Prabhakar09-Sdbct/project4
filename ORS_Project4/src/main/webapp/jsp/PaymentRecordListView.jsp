<%@page import="com.rays.pro4.Bean.PaymentRecordBean"%>
<%@page import="com.rays.pro4.controller.PaymentRecordListCtl"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.controller.SubjectListCtl"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Bean.SubjectBean"%>
<%@page import="com.rays.pro4.Bean.CourseBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.rays.pro4.Model.SubjectModel"%>
<%@page import="com.rays.pro4.Model.StudentModel"%>
<%@page import="javax.management.modelmbean.ModelMBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<html>
<head>
<title>Payment Record List</title>
<link rel="icon" type="image/png"
	href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16x16" />
<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/Checkbox11.js"></script>

</script>
</head>
<body>
	<%@include file="Header.jsp"%>
	<div align="center">
		<h1 align="center" style="margin-bottom: -15; color: navy;">Payment Record
			List</h1>

		<div style="height: 15px; margin-bottom: 12px">
			<h3>
				<font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
			</h3>
			<h3>
				<font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>
			</h3>
		</div>
		<jsp:useBean id="bean" class="com.rays.pro4.Bean.PaymentRecordBean"
			scope="request"></jsp:useBean>
		<form action="<%=ORSView.PAYMENT_RECORD_LIST_CTL%>" method="post">

			<%
				int pageNo = ServletUtility.getPageNo(request);
				int pageSize = ServletUtility.getPageSize(request);
				int index = ((pageNo - 1) * pageSize) + 1;
				int nextPageSize = DataUtility.getInt(request.getAttribute("nextListSize").toString());

				@SuppressWarnings("unchecked")
				List<PaymentRecordBean> list = (List<PaymentRecordBean>) ServletUtility.getList(request);
				Iterator<PaymentRecordBean> it = list.iterator();
				
			%>
			<% System.out.println("list.size()"+list.size()); %>

   <%if (list.size() != 0) { %>
			<input type="hidden" name="pageNo" value="<%=pageNo%>"><input
				type="hidden" name="pageSize" value="<%=pageSize%>">

			<table border="1" width="100%" align="center" cellpadding=6px
				cellspacing=".2">
				<tr style="background: skyblue;">
					<th><input type="checkbox" id="select_all" name="select">
						</th>
					<th width="5%">S.No</th>
					<th width="30%">Subject Name</th>
					<th width="15%">Course Name</th>
					<th width="40%">Description</th>
					<th width="5%">Edit</th>
				</tr>

				<%
					while (it.hasNext()) {
							bean = it.next();
				%>
				<tr>
					<td><input type="checkbox" class="checkbox" name="ids"
						value="<%=bean.getId()%>"></td>
					<td style="text-align: center;"><%=index++%></td>
					<td style="text-align: center; text-transform: capitalize;"><%=bean.getTransactionId()%></td>
					<td style="text-align: center; text-transform: capitalize;"><%=bean.getAmount()%></td>
					<td style="text-align: center; text-transform: capitalize;"><%=bean.getPaymentMethod()%></td>
					<td style="text-align: center;"><a
						href="PaymentRecordCtl?id=<%=bean.getId()%>">Edit</a></td>
				</tr>
				<%
					}
				%>
			</table>
			<table style="width: 100%">
				<tr>

					<td style="width: 25%"><input type="submit" name="operation"
						value="<%=PaymentRecordListCtl.OP_PREVIOUS%>"
						<%=pageNo > 1 ? "" : "disabled"%>></td>
					<td align="center" style="width: 25%"><input type="submit"
						name="operation" value="<%=PaymentRecordListCtl.OP_NEW%>"></td>
					<td align="center" style="width: 25%"><input type="submit"
						name="operation" value="<%=PaymentRecordListCtl.OP_DELETE%>"></td>
					<td style="width: 25%" align="right"><input type="submit"
						name="operation" value="<%=PaymentRecordListCtl.OP_NEXT%>"
						<%=(nextPageSize != 0) ? "" : "disabled"%>></td>

				</tr>

			</table>
			<%
				}
				if (list.size() == 0) {
			%>
			<table>
				<tr>
					<td align="right"><input type="submit" name="operation"
						value="<%=PaymentRecordListCtl.OP_BACK%>"></td>
				</tr>
			</table>
			<%
				}
			%>
		</form>
	</div>
	</br>
	</br>
	</br>
	</br>
	<%@include file="Footer.jsp"%>
</body>
</html>