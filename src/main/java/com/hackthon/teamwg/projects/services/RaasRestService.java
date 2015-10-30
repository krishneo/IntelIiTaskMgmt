package com.hackthon.teamwg.projects.services;

import java.util.List;

import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;

import com.hackthon.teamwg.projects.dao.RaasServicesDAO;
import com.hackthon.teamwg.projects.dto.RaasTasksDTO;
import com.hackthon.teamwg.projects.dto.RaasUsersDTO;

@Path("/")
public class RaasRestService {

	final static Logger logger = Logger.getLogger(RaasRestService.class);

	private RaasServicesDAO raasServicesDAO = new RaasServicesDAO();

	@GET
	@Path("/user/{loginId}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getUser(@PathParam("loginId") String loginId) {
		RaasUsersDTO dto = null;
		try {
			dto = raasServicesDAO.getUser(loginId);
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}

		// return HTTP response 200 in case of success
		return Response.status(200).entity(dto).build();
	}

	@GET
	@Path("/group/slaexpire/{groupName}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getSlaExpiredTasks(@PathParam("groupName") String groupName,
			@DefaultValue("1") @QueryParam("page_no") Integer page_no) {
		List<RaasTasksDTO> dto = null;
		try {
			dto = raasServicesDAO.getSLAExpiredTasks(groupName, page_no);
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}

		// return HTTP response 200 in case of success
		return Response.status(200).entity(dto).build();
	}

	@GET
	@Path("/task/unassigned/{groupName}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getUnassignedGroupTasks(@PathParam("groupName") String groupName,
			@DefaultValue("1") @QueryParam("page_no") Integer page_no) {
		List<RaasTasksDTO> dto = null;
		try {
			dto = raasServicesDAO.getGroupUnassignedTasks(groupName, page_no);
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}
		// return HTTP response 200 in case of success
		return Response.status(200).entity(dto).build();
	}

}
