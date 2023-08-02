<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
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

	<%
		List<Train> trains=HibernateDAO.getTrains();
	
		Set<String> sources=new HashSet<String>();
		Set<String> destinations=new HashSet<String>();
		
		for(Train train : trains)
		{
			sources.add(train.getSource());
			destinations.add(train.getDest());
		}
	%>
	
	<form action="searchtrains.jsp">
		<div class="form_settings">

			<p>
				<span>Select Source</span> <select name="source">
					<%
						for (String source : sources) {
					%>
					<option value="<%=source%>"><%=source%></option>
					<%
						}
					%>
				</select>
			</p>
			
			<p>
				<span>Select Destination</span> <select name="dest">
					<%
						for (String dest : destinations) {
					%>
					<option value="<%=dest%>"><%=dest%></option>
					<%
						}
					%>
				</select>
			</p>
			
			
			<p style="padding-top: 15px">
				<span>&nbsp;</span><input class="submit" type="submit"
					name="contact_submitted" value="Search" />
			</p>
		</div>
	</form>
	
	<%
		String source=request.getParameter("source");
		String dest=request.getParameter("dest");
	
		if(dest!=null && source!=null)
		{
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

				if (train.getSource().equals(source) && train.getDest().equals(dest)) 
				{
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
					<td><a href="searchtrains.jsp?id=<%=train.getTrainId()%>">delete</a></td>
			<%
				}
			%>
			
		</tr>

		<%	
				}
			}
		%>
	</table>
	
	<%
		}
	%>

	<%
		String id = request.getParameter("id");

		if (id != null) {
			if (HibernateTemplate.deleteObject(Train.class,
					Integer.parseInt(id)) == 1) {
				response.sendRedirect("searchtrains.jsp?status=success");
			} else {
				response.sendRedirect("searchtrains.jsp?status=failed");
			}
		}
	%>
	
</div>
<%@include file="footer.jsp"%>