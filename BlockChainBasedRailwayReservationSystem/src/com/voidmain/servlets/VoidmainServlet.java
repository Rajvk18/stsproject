package com.voidmain.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.voidmain.dao.HibernateTemplate;

@WebServlet("/VoidmainServlet")
public class VoidmainServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	HttpServletRequest request;
	HttpServletResponse response;

	Class c=null;
	Object obj=null;
	String redirect=null;
	String type;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		this.request=request;
		this.response=response;

		try {

			String operation=request.getParameter("operation");
			type=request.getParameter("type");
			redirect=request.getParameter("redirect");

			System.out.println(operation+"\t"+type+"\t"+redirect);

			if(type!=null && operation!=null && redirect!=null)
			{

				obj=Class.forName(type).newInstance();

				//======================================================

				if(operation.equals("add"))
				{
					addObject();
				}
				else if(operation.equals("update"))
				{
					updateObject();
				}
				else if(operation.equals("delete"))
				{
					deleteObject();

				}

			}

			//======================================================

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	public void addObject() throws Exception
	{	
		if(!ServletFileUpload.isMultipartContent(request))
		{
			Object object=HttpRequestParser.parseRequest(request, obj);
			
			if(HibernateTemplate.addObject(object)==1)
			{
				response.sendRedirect(redirect+"?status=success");
			}
			else
			{
				response.sendRedirect(redirect+"?status=failed");
			}
		}
	}

	public void deleteObject() throws Exception
	{
		if(HibernateTemplate.deleteObject(c,Integer.parseInt(request.getParameter("userId")))==1)
		{
			response.sendRedirect(redirect+"?status=success");
		}
		else
		{
			response.sendRedirect(redirect+"?status=failed");
		}
	}

	public void updateObject() throws Exception
	{
		Object object=HttpRequestParser.parseRequest(request,obj);

		if(HibernateTemplate.updateObject(object)==1)
		{
			response.sendRedirect(redirect+"?status=success");
		}
		else
		{
			response.sendRedirect(redirect+"?status=failed");
		}
	}
}
