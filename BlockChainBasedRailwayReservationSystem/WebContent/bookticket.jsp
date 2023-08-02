<%@page import="com.voidmain.service.AES"%>
<%@page import="com.voidmain.pojo.BlockChain"%>
<%@page import="com.voidmain.pojo.Block"%>
<%@page import="com.voidmain.dao.HibernateTemplate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.voidmain.pojo.Transaction"%>
<%@page import="com.voidmain.dao.HibernateDAO"%>
<%@page import="com.voidmain.pojo.Train"%>
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
		<h1>Book Tickets</h1>
		<%
			}
		%>
		
		<%
			String trainId=request.getParameter("id");
		
			if(trainId!=null)
			{
				System.out.println("train id :\t"+trainId);
				
				Train train=HibernateDAO.getTrainById(Integer.parseInt(trainId));
		%>
	
		<form action="bookticket.jsp" name="appform">
			
			<input type="hidden" name="trainId" value="<%=trainId%>">
	
			<div class="form_settings">
				<p>
					<span>Source</span><input class="contact" type="text" name="source" value="<%=train.getSource()%>" readonly="readonly"/>
				</p>
				<p>
					<span>Destination</span><input class="contact" type="text" name="dest" value="<%=train.getDest()%>" readonly="readonly">
				</p>
				<p>
					<span>Timing</span><input class="contact" type="text" name="timing" value="<%=train.getTiming()%>" readonly="readonly">
				</p>
				<p>
					<span>Fair</span><input class="contact" type="text" name="fair" value="<%=train.getFair()%>" readonly="readonly">
				</p>
				<p>
					<span>No Of Seats Required</span><input class="contact" type="text" name="noOfSeats">
				</p>
				
				<p>
					<span>Mobile </span><input class="contact" type="text" name="mobile">
				</p>
			
				<p>
					<span>Date of Journey </span><input class="contact" type="text" name="date">dd/mm/yyyy
				</p>
				
				<p style="padding-top: 15px">
					<span>&nbsp;</span><input class="submit" type="submit"
						name="contact_submitted" value="Book Ticket" onclick="return validate()"/>
				</p>
			</div>
		</form>
		
		<%
			}
		%>
		
		<%
			String trainNo=request.getParameter("trainId");
			String seats=request.getParameter("noOfSeats");
			String mobile=request.getParameter("mobile");
			String date=request.getParameter("date");
			
			if(trainNo!=null && seats!=null && mobile!=null && date!=null)
			{
				Date journeyDate=new SimpleDateFormat("dd-MM-yyyy").parse(date);
				
				Transaction transaction=new Transaction();
				transaction.setUserName(username);
	
				
				Block one = new Block(AES.encrypt(trainNo),0);
		        Block two = new Block(AES.encrypt(seats),one.getHash());
		        Block three = new Block(AES.encrypt(mobile),two.getHash());
		        Block four = new Block(AES.encrypt(journeyDate.getYear()+""),three.getHash());
		        Block five = new Block(AES.encrypt(journeyDate.getMonth()+""),four.getHash());
		        Block six = new Block(AES.encrypt(journeyDate.getDate()+""),five.getHash());
		        
		        BlockChain blockChain=new BlockChain();
		      
		        HibernateTemplate.addObject(one);
		        blockChain.setOne(HibernateDAO.getBlocks().size());
		        
		        HibernateTemplate.addObject(two);
		        blockChain.setTwo(HibernateDAO.getBlocks().size());
		        
		        HibernateTemplate.addObject(three);
		        blockChain.setThree(HibernateDAO.getBlocks().size());
		        
		        HibernateTemplate.addObject(four);
		        blockChain.setFour(HibernateDAO.getBlocks().size());
		        
		        HibernateTemplate.addObject(five);
		        blockChain.setFive(HibernateDAO.getBlocks().size());
		        
		        HibernateTemplate.addObject(six);
		        blockChain.setSix(HibernateDAO.getBlocks().size());
		       
		        HibernateTemplate.addObject(blockChain);
		           
		        transaction.setBlockChainId(HibernateDAO.getBlockChains().size());
		   
				if (HibernateTemplate.addObject(transaction)== 1) {
					response.sendRedirect("viewtrains.jsp?status=success");
				} else {
					response.sendRedirect("viewtrains.jsp?status=failed");
				}
			}
		%>
		
	</div>
<%@include file="footer.jsp"%>