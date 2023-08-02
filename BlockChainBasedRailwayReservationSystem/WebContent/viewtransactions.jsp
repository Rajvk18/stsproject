<%@page import="com.voidmain.service.BlockChainService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.voidmain.service.AES"%>
<%@page import="com.voidmain.pojo.Train"%>
<%@page import="com.voidmain.pojo.Block"%>
<%@page import="com.voidmain.pojo.BlockChain"%>
<%@page import="com.voidmain.pojo.Transaction"%>
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
	<h1>View Bookings</h1>
	<%
		}
	%>
	
	<table style="width: 100%; border-spacing: 0;">
		<tr>
			<th>Transaction No</th>
			<th>Train No</th>
			<th>User Name</th>
			<th>Source</th>
			<th>Destination</th>
			<th>Timing</th>
			<th>No of Seats</th>
			<th>Mobile Number</th>
			<th>Total Fair</th>
			<th>Date of Journey</th>
		</tr>
		
		<%
			if(role.equals("user"))
			{
			
				for (Transaction transaction : HibernateDAO.getTransactions()) {
				
				BlockChain blockChain=HibernateDAO.getBlockChainById(transaction.getBlockChainId());
				
				Block b1=HibernateDAO.getBlockById(blockChain.getOne());
				Block b2=HibernateDAO.getBlockById(blockChain.getTwo());
				Block b3=HibernateDAO.getBlockById(blockChain.getThree());
				Block b4=HibernateDAO.getBlockById(blockChain.getFour());
				Block b5=HibernateDAO.getBlockById(blockChain.getFive());
				Block b6=HibernateDAO.getBlockById(blockChain.getSix());
				
				List<Block> blocks=new ArrayList<Block>();
				
				blocks.add(b1);
				blocks.add(b2);
				blocks.add(b3);
				blocks.add(b4);
				blocks.add(b5);
				blocks.add(b6);
				
				 Train train=HibernateDAO.getTrainById(Integer.parseInt(AES.decrypt(b1.getData())));
				
					if (transaction.getUserName().equals(username) && BlockChainService.validate(blocks)) 
					{		
						System.out.println(transaction.getUserName()+"\t"+username);
			%>
						<tr>
							<td><%=transaction.getTransactionId()%></td>
							<td><%=train.getTrainId()%></td>
							<td><%=transaction.getUserName()%></td>
							<td><%=train.getSource()%></td>
							<td><%=train.getDest()%></td>
							<td><%=train.getTiming()%></td>
							<td><%=AES.decrypt(b2.getData())%></td>
							<td><%=AES.decrypt(b3.getData())%></td>
							<td><%=(Integer.parseInt(train.getFair())*Integer.parseInt(AES.decrypt(b2.getData())))%></td>
							<td><%=AES.decrypt(b6.getData())+"-"+(Integer.parseInt(AES.decrypt(b5.getData()))+1)+"-"+(Integer.parseInt(AES.decrypt(b4.getData()))+1900)%></td>
						</tr>
		<%
					}
				}
			}
		%>
		
		<%
			if(role.equals("admin"))
			{
				for (Transaction transaction : HibernateDAO.getTransactions()) {
					
					BlockChain blockChain=HibernateDAO.getBlockChainById(transaction.getBlockChainId());
					
					Block b1=HibernateDAO.getBlockById(blockChain.getOne());
					Block b2=HibernateDAO.getBlockById(blockChain.getTwo());
					Block b3=HibernateDAO.getBlockById(blockChain.getThree());
					Block b4=HibernateDAO.getBlockById(blockChain.getFour());
					Block b5=HibernateDAO.getBlockById(blockChain.getFive());
					Block b6=HibernateDAO.getBlockById(blockChain.getSix());
					
					List<Block> blocks=new ArrayList<Block>();
					
					blocks.add(b1);
					blocks.add(b2);
					blocks.add(b3);
					blocks.add(b4);
					blocks.add(b5);
					blocks.add(b6);
					
					Train train=HibernateDAO.getTrainById(Integer.parseInt(AES.decrypt(b1.getData())));
					
					if(BlockChainService.validate(blocks))
					{
			%>
						<tr>
							<td><%=transaction.getTransactionId()%></td>
							<td><%=train.getTrainId()%></td>
							<td><%=transaction.getUserName()%></td>
							<td><%=train.getSource()%></td>
							<td><%=train.getDest()%></td>
							<td><%=train.getTiming()%></td>
							<td><%=AES.decrypt(b2.getData())%></td>
							<td><%=AES.decrypt(b3.getData())%></td>
							<td><%=(Integer.parseInt(train.getFair())*Integer.parseInt(AES.decrypt(b2.getData())))%></td>
							<td><%=AES.decrypt(b6.getData())+"-"+(Integer.parseInt(AES.decrypt(b5.getData()))+1)+"-"+(Integer.parseInt(AES.decrypt(b4.getData()))+1900)%></td>
						</tr>
			<%
					}
				}
			}
		
			%>
			
	</table>
	
</div>
<%@include file="footer.jsp"%>