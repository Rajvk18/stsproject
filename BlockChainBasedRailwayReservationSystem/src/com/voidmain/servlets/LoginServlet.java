package com.voidmain.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.voidmain.dao.HibernateDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String username=request.getParameter("username").trim();
		String password=request.getParameter("password").trim();
		
		if(username.equals("admin") && password.equals("admin"))
		{
			request.getSession().setAttribute("role","admin");
			response.sendRedirect("home.jsp");
		}
		else
		{
			if(HibernateDAO.isValidUser(username, password))
			{
				request.getSession().setAttribute("username",username.toLowerCase());
				request.getSession().setAttribute("role","user");
				response.sendRedirect("home.jsp");
			}
			else
			{
				response.sendRedirect("index.jsp?status=Invalid Username and Password");
			}
		}
	}
}
