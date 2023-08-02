<%@page import="com.voidmain.pojo.Train"%>
<%@page import="com.voidmain.dao.HibernateTemplate"%>
<%@page import="com.voidmain.dao.HibernateDAO"%>
<%@page import="java.util.List"%>
<%@include file="header.jsp"%>
<div id="content">
	<!-- insert the page content here -->

	<%
		String status = request.getParameter("status");

		if (status != null) {
	%>
	<h1><%=status%></h1>
	<%
		} else {
	%>
	
	<h1>View Trains</h1>
	
	<%
		}
	%>
	
	<table style="width: 100%; border-spacing: 0;">
		<tr>
			<th>Train No</th>
			<th>Source</th>
			<th>Destination</th>
			<th>No of Seats</th>
			<th>Timing</th>
			<th>Fair Amount</th>
			
			<%
				if (role.equals("user")) 
				{
			%>
					<th>Book Seats</th>
			<%
				}
			%>
			
			<%
				if (role.equals("admin")) 
				{
			%>
					<th>Delete</th>
			<%
				}
			%>
			
		</tr>

		<%
			for (Train train : HibernateDAO.getTrains()) {
		%>
		<tr>
			<td><%=train.getTrainId()%></td>
			<td><%=train.getSource()%></td>
			<td><%=train.getDest()%></td>
			<td><%=train.getNoOfSeats()%></td>
			<td><%=train.getTiming()%></td>
			<td><%=train.getFair()%></td>
			
			<%
				if (role.equals("user")) 
				{
			%>
					<td><a href="bookticket.jsp?id=<%=train.getTrainId()%>">Book Ticket</a></td>
			<%
				}
			%>
			
			<%
				if (role.equals("admin")) 
				{
			%>
					<td><a href="viewtrains.jsp?id=<%=train.getTrainId()%>">delete</a></td>
			<%
				}
			%>
			
		</tr>

		<%	
			}
		%>
	</table>
	
	<%
		String id = request.getParameter("id");

		if (id != null) {
			if (HibernateTemplate.deleteObject(Train.class,
					Integer.parseInt(id)) == 1) {
				response.sendRedirect("viewtrains.jsp?status=success");
			} else {
				response.sendRedirect("viewtrains.jsp?status=failed");
			}
		}
	%>
	
</div>
<%@include file="footer.jsp"%>