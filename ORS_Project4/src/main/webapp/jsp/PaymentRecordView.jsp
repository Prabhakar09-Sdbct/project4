<%@page import="com.rays.pro4.controller.PaymentRecordCtl"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="com.rays.pro4.controller.CourseCtl"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<link rel="icon" type="image/png"
	href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16" />
<title>Payment Record Page</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <script>
  $( function() {
    $( "#udatee" ).datepicker({
      changeMonth: true,
      changeYear: true,
	  yearRange:'1980:2020',
    });
  } );
  </script>
</head>
<body>
	<jsp:useBean id="bean" class="com.rays.pro4.Bean.PaymentRecordBean"
		scope="request"></jsp:useBean>
	<form action="<%=ORSView.PAYMENT_RECORD_CTL%>" method="post">
		<%@include file="Header.jsp"%>

		<center>
			<h1>
				<%
				if (bean != null && bean.getId() > 0) {
				%>
				<tr>
					<th>Update Payment Record</th>
				</tr>
				<%
				} else {
				%>
				<tr>
					<th>Add Payment Record</th>
				</tr>
				<%
				}
				%>
			</h1>
			<div align="center">
				<h3>
					<font color="green"><%=ServletUtility.getSuccessMessage(request)%></font>
					</h2>
					<h2>
						<font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
					</h2>
			</div>

			<input type="hidden" name="id" value="<%=bean.getId()%>"> <input
				type="hidden" name="createdby" value="<%=bean.getCreatedBy()%>">
			<input type="hidden" name="modifiedby"
				value="<%=bean.getModifiedBy()%>"> <input type="hidden"
				name="createdDatetime"
				value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
			<input type="hidden" name="modifiedDatetime"
				value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

			<table>
				<tr>
					<th align="left">Transaction Id <span style="color: red">*</span>
						:
					</th>
					<td><input type="text" name="transactionId"
						placeholder="Enter Transaction Id" size="26"
						value="<%=DataUtility.getStringData(bean.getTransactionId())%>">
					</td>
					<td style="position: fixed"><font color="red"><%=ServletUtility.getErrorMessage("transactionId", request)%></font>
					</td>
				</tr>

				<tr>
					<th style="padding: 3px"></th>
				</tr>
				<tr>
					<th align="left">Amount <span style="color: red">*</span> :
					</th>
					<td><input type="text" name="amount"
						placeholder="Enter Description" size="26"
						value="<%=DataUtility.getStringData(bean.getAmount())%>">
					</td>
					<td style="position: fixed"><font color="red"><%=ServletUtility.getErrorMessage("amount", request)%></font>
					</td>
				</tr>
				<tr>
					<th style="padding: 3px"></th>
				</tr>
				<tr>
					<th align="left">Transaction Date<span style="color: red">*</span>
						:
					</th>
					<td><input type="text" name="transactionDate"
						placeholder="Enter Transaction Date" size="26" id="udatee"
						value="<%=DataUtility.getDateString(bean.getTransactionDate())%>">
					</td>
					<td style="position: fixed"><font color="red"><%=ServletUtility.getErrorMessage("transactionDate", request)%></font>
					</td>
				</tr>

				<tr>
					<th style="padding: 3px"></th>
				</tr>

				<tr>
					<th align="left">Status <span style="color: red">*</span> :
					</th>
					<td><input type="text" name="status"
						placeholder="Enter Description" size="26"
						value="<%=DataUtility.getStringData(bean.getStatus())%>">
					</td>
					<td style="position: fixed"><font color="red"><%=ServletUtility.getErrorMessage("status", request)%></font>
					</td>
				</tr>

				<tr>
					<th style="padding: 3px"></th>
				</tr>

				<tr>
					<th align="left">Payment Method <span style="color: red">*</span>
						:
					</th>
					<td>
						<%
						LinkedHashMap map = new LinkedHashMap();
						//	HashMap map = new HashMap();
						map.put("UPI", "UPI");
						map.put("Card", "Card");

						String htmlList = HTMLUtility.getList("paymentMethod", bean.getPaymentMethod(), map);
						%> <%=htmlList%>

					</td>
					<td style="position: fixed"><font color="red"><%=ServletUtility.getErrorMessage("duration", request)%></font>
					</td>
				</tr>

				<tr>
					<th style="padding: 3px"></th>
				</tr>
				<tr>
					<th></th>
					<%
					if (bean.getId() > 0) {
					%>
					<td>&nbsp; &emsp; <input type="submit" name="operation"
						value="<%=PaymentRecordCtl.OP_UPDATE%>"> &nbsp; &nbsp; <input
						type="submit" name="operation"
						value="<%=PaymentRecordCtl.OP_CANCEL%>">
					</td>
					<%
					} else {
					%>
					<td>&nbsp; &emsp; <input type="submit" name="operation"
						value="<%=PaymentRecordCtl.OP_SAVE%>"> &nbsp; &nbsp; <input
						type="submit" name="operation"
						value="<%=PaymentRecordCtl.OP_RESET%>">
					</td>
					<%
					}
					%>
				</tr>
			</table>
	</form>
	</center>


	<%@include file="Footer.jsp"%>
</body>
</html>