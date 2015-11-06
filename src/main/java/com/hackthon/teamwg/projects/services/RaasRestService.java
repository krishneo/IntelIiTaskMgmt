package com.hackthon.teamwg.projects.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;

import com.hackthon.teamwg.projects.dao.RaasServicesDAO;
import com.hackthon.teamwg.projects.dao.TaskAssignmentDAO;
import com.hackthon.teamwg.projects.dto.RaasGenericCountDTO;
import com.hackthon.teamwg.projects.dto.RaasTasksDTO;
import com.hackthon.teamwg.projects.dto.RaasUsersDTO;
import com.hackthon.teamwg.projects.utils.CommonUtils;

@Path("/")
public class RaasRestService {

	final static Logger logger = Logger.getLogger(RaasRestService.class);
	private TaskAssignmentDAO taskAssignmentDAO = new TaskAssignmentDAO();

	private RaasServicesDAO raasServicesDAO = new RaasServicesDAO();
	private RaasChartService chartService = new RaasChartService();

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
	public Response getSlaExpiredTasks(
			@PathParam("groupName") String groupName,
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
	@Path("/task/{taskKey}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getTask(
			@PathParam("taskKey") String taskKey ) {
		RaasTasksDTO tasksDTO = new RaasTasksDTO() ;
		try {
			tasksDTO = raasServicesDAO.getTask(taskKey) ;
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}

		// return HTTP response 200 in case of success
		return Response.status(200).entity(tasksDTO).build();
	}
	
	@POST
	@Path("/task/update/{taskId}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response udpateTask(
			@PathParam("taskId") String taskId,
			@DefaultValue("WORKING") @QueryParam("status") String status,
			 @QueryParam("user_name") String user_name) {
		int count = 0;
		try {
			RaasTasksDTO tasks = new RaasTasksDTO() ;
			tasks.setTask_oid(taskId);
			tasks.setStatus(status);
			tasks.setUser_name(user_name);
			count = taskAssignmentDAO.updateTasks(tasks) ;
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}

		// return HTTP response 200 in case of success
		return Response.status(200).entity(count).build();
	}

	@GET
	@Path("/task/unassignedgg/{groupName}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getUnassignedGroupTasks(
			@PathParam("groupName") String groupName,
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

	@GET
	@Path("/task/unassigned/{managerName}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getUnassignedTasksForManager(
			@PathParam("managerName") String managerName,
			@DefaultValue("1") @QueryParam("page_no") Integer page_no) {
		List<RaasGenericCountDTO> dto = null;
		try {
			dto = raasServicesDAO.getUnassignedTasksUnderManager(managerName);
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}
		// return HTTP response 200 in case of success
		return Response.status(200).entity(dto).build();
	}
	
	@GET
	@Path("/task/mytask/{userName}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getUnassignedTasksForManager(
			@PathParam("userName") String userName ) {
		List<RaasTasksDTO> dto = null;
		try {
			dto = raasServicesDAO.getMyTasks(userName);
		} catch (Exception e) {
			logger.info("Error Parsing: - " + e.getMessage());
		}
		// return HTTP response 200 in case of success
		return Response.status(200).entity(dto).build();
	}

	@POST
	@Path("/task/add")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response createTask(RaasTasksDTO tasksDTO) {
		boolean res = false;
		try {
			if (tasksDTO != null)
				res = raasServicesDAO.createNewTask(tasksDTO.getTask_key(),
						tasksDTO.getGroup_name(), tasksDTO.getPriority(),
						tasksDTO.getInternal_sla(), tasksDTO.getExternal_sla());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return Response.status(200).entity(null).build();
	}

	@GET
	@Path("/chart/users/{managerName}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getUserStatusOfManager(
			@PathParam("managerName") String managerName) {

		Map<String, Object> respMap = new HashMap<String, Object>();
		List<RaasGenericCountDTO> dto = raasServicesDAO
				.getUserStatusUnderManager(managerName);
		if (dto != null && dto.size() > 0)
			respMap = chartService.getStackedColumnChartData(dto);
		// return HTTP response 200 in case of success
		return Response.status(200).entity(respMap).build();
	}

	@GET
	@Path("/chart/groups/{managerName}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getUserStatusOfManager(
			@PathParam("managerName") String managerName,
			@QueryParam("group_name") String groupName) {

		List<Map<String, String>> respData = new ArrayList<Map<String, String>>();
		List<RaasGenericCountDTO> dto = raasServicesDAO.getTasksSplitUpByGroup(
				managerName, groupName);
		if (dto != null && dto.size() > 0)
			respData = chartService.getGroupTaskSplitups(dto);
		return Response.status(200).entity(respData).build();
	}

	@GET
	@Path("/chart/user/statisfaction/{managerName}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getUserSatisfaction(
			@PathParam("managerName") String managerName,
			@QueryParam("group_name") String groupName) {

		Map<String, Object> respData = new HashMap<String, Object>();
		List<RaasGenericCountDTO> dto = raasServicesDAO.getUserSatisfaction(
				managerName, groupName);
		if (dto != null && dto.size() > 0)
			respData = chartService.getUserSatisfaction(dto);
		return Response.status(200).entity(respData).build();
	}
	
	@GET
	@Path("/create/dummytask")
	@Produces(MediaType.APPLICATION_JSON)
	public Response createDummyTasks( @DefaultValue("15") @QueryParam("taskCounts") Integer taskCounts) {
 
		List<String > keyList = new ArrayList<String> () ;
		
		String rep[] = { "WG", "CPNI", "ST", "CMC" };
		
		for (int i = 0; i < taskCounts; i++) {

			String taskKey = "TEST" + System.currentTimeMillis();
			String groupName = rep[CommonUtils.getRandomNumber(0, 4)];
			String priority = String
					.valueOf(CommonUtils.getRandomNumber(1, 10));
			int weit = CommonUtils.getRandomNumber(1, 10);
			String weightage = String.valueOf(weit);
			String sla = String.valueOf((int) (weit
					* CommonUtils.getRandomNumber(1, 3) * 1.414));
			boolean actual = raasServicesDAO .createNewTask(taskKey, groupName, priority,
					weightage, sla);
			if (actual)
			keyList.add(taskKey) ;

		}
		
		return Response.status(200).entity(keyList).build();
	}

}
