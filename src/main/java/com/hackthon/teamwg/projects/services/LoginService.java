package com.hackthon.teamwg.projects.services;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.hackthon.teamwg.projects.dao.RaasServicesDAO;
import com.hackthon.teamwg.projects.dto.RaasUsersDTO;

public class LoginService extends HttpServlet {

	final static Logger logger = Logger.getLogger(LoginService.class);

	private static final long serialVersionUID = 1L;

	private RaasServicesDAO servicesDAO = new RaasServicesDAO();

	/**
	 * Default constructor.
	 */
	public LoginService() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		logger.info("doPost: ");
		String urls = null;
		String customer_id = (String) request.getParameter("customer_id");
		String password = (String) request.getParameter("password");

		logger.info("customer_id: " + customer_id + " - password: " + password);

		RaasUsersDTO customerDTO = servicesDAO.getUser(customer_id );

		logger.info("customerDTO: " + customerDTO);
		if (customerDTO == null) {
			urls = "error.jsp";
		} else {
			HttpSession session = request.getSession(true);
			session.setAttribute("customerDTO", customerDTO);
			urls = "home.jsp";
		}

		RequestDispatcher rs = request.getRequestDispatcher(urls);
		rs.forward(request, response);
	}

}
