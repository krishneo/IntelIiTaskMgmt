package com.hackthon.teamwg.projects.services;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;

import com.hackthon.teamwg.projects.dao.TaskAssignmentDAO;
import com.hackthon.teamwg.projects.dto.RaasTasksDTO;

@Path("/rest")
public class TaskAssignementService {

	public static void main(String... args) throws Exception {

	}

	final static Logger logger = Logger.getLogger(RaasRestService.class);

	private TaskAssignmentDAO taskAssignmentDAO = new TaskAssignmentDAO();

	@GET
	@Path("/task/assign/invoke/{group_name}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response invokeTaskAssignment(@PathParam("group_name") String group_name) {
		Boolean resp = false ;
		try {
			taskAssignmentDAO.runTaskAssignmentAlgorithm(group_name);
			resp = true ;
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}

		// return HTTP response 200 in case of success
		return Response.status(200).entity(resp).build();
	}
	
	@GET
	@Path("/task/demo/setup/{group_name}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response setupDemoData(@PathParam("group_name") String group_name) {
		Boolean resp = false ;
		try {
			taskAssignmentDAO.setDemoData(group_name);
			resp = true ;
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}

		// return HTTP response 200 in case of success
		return Response.status(200).entity(resp).build();
	}
	
	@GET
	@Path("/task/demo/sql/{run_sql}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response runSQL(@PathParam("run_sql") String run_sql) {
		Boolean resp = false ;
		try {
			taskAssignmentDAO.runSQL(run_sql);
			resp = true ;
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}

		// return HTTP response 200 in case of success
		return Response.status(200).entity(resp).build();
	}

}
