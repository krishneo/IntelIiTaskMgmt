package com.hackthon.teamwg.projects.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;

import com.hackthon.teamwg.projects.dao.RaasServicesDAO;
import com.hackthon.teamwg.projects.dto.RaasUsersDTO;

@Path("/")
public class RaasRestService {

	final static Logger logger = Logger.getLogger(RaasRestService.class);
	
	private RaasServicesDAO raasServicesDAO  = new RaasServicesDAO() ;
	
	@GET
	@Path("/user/{loginId}")
	public Response getUser(@PathParam("loginId") String loginId) {
		RaasUsersDTO dto = null ;
		try {
			 dto=  raasServicesDAO.getUser(loginId) ;
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}

		// return HTTP response 200 in case of success
		return Response.status(200).entity(dto).build();
	}
	
}
