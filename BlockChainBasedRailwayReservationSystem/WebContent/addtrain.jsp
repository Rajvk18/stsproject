<script type="text/javascript">
	
	function validate()
	{
		var source=document.appform.source.value;
		var dest=document.appform.dest.value;
		var noOfSeats=document.appform.noOfSeats.value;
		var timing=document.appform.timing.value;
		var fair=document.appform.fair.value;
		
		if(source=="" || source==null)
		{
			alert("please enter source");
			return false;
		}
		if(dest=="" || dest==null)
		{
			alert("please enter destination");
			return false;
		}
		if(noOfSeats=="" || noOfSeats==null || isNaN(noOfSeats))
		{
			alert("please enter no of seats");
			return false;
		}
		if(timing=="" || timing==null)
		{
			alert("please enter train timing");
			return false;
		}
		if(fair=="" || fair==null || isNaN(fair))
		{
			alert("please enter fair amount");
			return false;
		}
	}
	
</script>

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
		<h1>Add Train</h1>
		<%
			}
		%>
	
		<form action="VoidmainServlet" method="post" name="appform">

			<input type="hidden" name="type" value="com.voidmain.pojo.Train"> 
			<input type="hidden" name="operation" value="add">
			<input type="hidden" name="redirect" value="addtrain.jsp">
	
			<div class="form_settings">
				<p>
					<span>Source</span><input class="contact" type="text" name="source"
						value="" />
				</p>
				<p>
					<span>Destination</span><input class="contact" type="text" name="dest">
				</p>
				<p>
					<span>Total No Of Seats</span><input class="contact" type="text" name="noOfSeats">
				</p>
				<p>
					<span>Timing</span><input class="contact" type="text" name="timing">
				</p>
				<p>
					<span>Fair</span><input class="contact" type="text" name="fair">
				</p>
				<p style="padding-top: 15px">
					<span>&nbsp;</span><input class="submit" type="submit"
						name="contact_submitted" value="Add" onclick="return validate()"/>
				</p>
			</div>
		</form>
	</div>
<%@include file="footer.jsp"%>