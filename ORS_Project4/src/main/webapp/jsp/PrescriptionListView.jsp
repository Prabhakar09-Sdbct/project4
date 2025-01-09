<%@page import="com.rays.pro4.Bean.PrescriptionBean"%>
<%@page import="com.rays.pro4.Bean.PrescriptionBean"%>
<%@page import="com.rays.pro4.Model.StudentModel"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.rays.pro4.Bean.StudentBean"%>
<%@page import="com.rays.pro4.controller.PrescriptionListCtl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
<link rel="icon" type="image/png" href="<%=ORSView.APP_CONTEXT%>/img/logo.png" sizes="16*16"/>
<title> Student List</title>

<script src="<%=ORSView.APP_CONTEXT %>/js/jquery.min.js""></script>
<script src="<%=ORSView.APP_CONTEXT %>/js/Checkbox11.js"></script>


</head>
<body>
<jsp:useBean id="cbean" class="com.rays.pro4.Bean.CollegeBean" scope="request" ></jsp:useBean>
<jsp:useBean id="bean" class="com.rays.pro4.Bean.PrescriptionBean" scope="request" ></jsp:useBean>

  <form action="<%=ORSView.PRESCRIPTION_LIST_CTL%>" method="post">
    <%@include file="Header.jsp"%>
   
    <center>
    
     <div align="center">
	        <h1>Prescription List</h1>
            <h3><font color="red"><%=ServletUtility.getErrorMessage(request)%></font>
            <font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></h3>
     </div>
     
     <% 
         List clist=(List) request.getAttribute("dList");
     %>
     
       <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;

                    List list = ServletUtility.getList(request);
                    Iterator<PrescriptionBean> it = list.iterator();

	       			if(list.size() !=0){
                    %>
            
            <table width="100%" align="center">
                 <tr>
                 <td align="center">
                 <label> Name:</label> 
                 	<input type="text" name="name" placeholder="Enter Name" Size= "25" value="<%=ServletUtility.getParameter("name", request)%>">
					&nbsp;
                 	
                    <label>Decease:</label> 
    	             <%=HTMLUtility.getList("decease", String.valueOf(bean.getDecease()), clist)%>
                    &nbsp;   
                    <label>Capacity:</label> 
    	             <input type="text" name=capacity placeholder="Enter Capacity" Size= "25" value="<%=ServletUtility.getParameter("capacity", request)%>">
                    &nbsp; 
        	         <input type="submit" name="operation" value="<%=PrescriptionListCtl.OP_SEARCH%>">
        	       
        	         <input type="submit" name="operation" value="<%=PrescriptionListCtl.OP_RESET%>">
        	         
                 </td>
                </tr>
            </table>
            
            <br>
            
            <table border="1" width="100%" align="center" cellpadding=6px cellspacing=".2">
                <tr style="background: skyblue">
                <th><input type="checkbox" id="select_all" name="select">Select All.</th>
                
                <th>S No.</th>
                <th>Name.</th>
                 <th>Decease</th>
                <th>Date</th>
                <th>Capacity.</th>
                <th>Edit</th>
                </tr>
                
                <%
                	while(it.hasNext())
                	{
                	 bean = it.next();
                %>
                
                
                
       <tr align="center">
           	<td><input type="checkbox" class="checkbox" name="ids" value="<%=bean.getId() %>">
                    <td><%=index++%></td>
                    <td><%=bean.getName()%></td>
                    <td><%=bean.getDecease()%></td>
                    <td><%=bean.getDate()%></td>
                    <td><%=bean.getCapacity()%></td>
                    <td><a href="PrescriptionCtl?id=<%=bean.getId()%>">Edit</a></td>
                </tr>
                <%
                    }
                %>
            </table>
            <table width="100%">
                <tr>
                <%if(pageNo == 1){ %>
                    <td><input type="submit" name="operation" disabled="disabled" value="<%=PrescriptionListCtl.OP_PREVIOUS%>">
       				<%}else{ %>
       				<td><input type="submit" name="operation"  value="<%=PrescriptionListCtl.OP_PREVIOUS%>"></td>
       				<%} %>		
                     
                     <td><input type="submit" name="operation" value="<%=PrescriptionListCtl.OP_DELETE%>"> </td>
                    <td> <input type="submit" name="operation" value="<%=PrescriptionListCtl.OP_NEW%>"></td>
                    
                  <% StudentModel model = new StudentModel();                  
                  %>  
                  <% if(list.size() < pageSize || model.nextPK()-1 == bean.getId()){ %>
                  <td align="right"> <input type="submit" name="operation" disabled="disabled" value="<%=PrescriptionListCtl.OP_NEXT%>"></td>
  					<%}else{ %>                   
  				  <td align="right"> <input type="submit" name="operation"  value="<%=PrescriptionListCtl.OP_NEXT%>"></td>
   					<%} %>                 
                    
                </tr>
            </table>
            		<%}if(list.size() == 0){ %>
            		<td align="center"><input type="submit" name="operation" value="<%=PrescriptionListCtl.OP_BACK%>"></td>	
            		<% } %>
            	
            <input type="hidden" name="pageNo" value="<%=pageNo%>"> 
            <input type="hidden" name="pageSize" value="<%=pageSize%>">
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