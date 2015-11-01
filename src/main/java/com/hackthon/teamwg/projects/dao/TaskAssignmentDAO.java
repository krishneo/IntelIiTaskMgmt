package com.hackthon.teamwg.projects.dao;

import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import com.hackthon.teamwg.projects.dto.RaasGroupsDTO;
import com.hackthon.teamwg.projects.dto.RaasTasksDTO;
import com.hackthon.teamwg.projects.dto.RaasUsersDTO;
import com.hackthon.teamwg.projects.utils.CommonUtils;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

public class TaskAssignmentDAO {

	final static Logger logger = Logger.getLogger(TaskAssignmentDAO.class);

	private MysqlDataSource mysqlDS;

	private QueryRunner queryRunner;

	private String isEmergencyCondPrevail() throws Exception {
		String emergency_ind = "N";
		String sql = "SELECT DISTINCT"
+"       (CASE"
+"           WHEN (Assigned = 0 AND Unassigned > 100) THEN 'Y'"
+"           WHEN (Unassigned / Assigned) > 8 THEN 'Y'"
+"           ELSE 'N'"
+"        END)"
+"          emergency_ind"
+"  FROM (SELECT SUM(status = 'UNASSIGNED') AS Unassigned,"
+"               SUM(status = 'ASSIGNED') AS Assigned,"
+"               SUM(status = 'WORKING') AS Working"
+"          FROM raas_tasks"
+"         WHERE status != 'COMPLETED') consolidated_tbl";
		
		ResultSetHandler<List<String>> usageResultSet = new BeanListHandler<String>(String.class);
		List<String> result=getQueryRunner().query(sql, usageResultSet);
		
		if(result.size() > 0 && "Y".equalsIgnoreCase(result.get(0)))
			emergency_ind= "Y";
		else
			emergency_ind= "N";
		logger.info("Is EMergency on?"+emergency_ind);
		return emergency_ind;
	}
	public void runTaskAssignmentAlgorithm(String group_name) throws Exception {
		String emergency_ind = this.isEmergencyCondPrevail();
		if("ALL".equalsIgnoreCase(group_name))
		{
			List<RaasGroupsDTO> groups=getAllGroupsWithUnAssignedTasks();
			for(RaasGroupsDTO obj:groups)
			{
				logger.info("Running Assignement for group "+obj.getGroupName());
				this.invokeTaskAssignment(obj.getGroupName(),emergency_ind);
			}
		}else
			this.invokeTaskAssignment(group_name, emergency_ind);
		
	}

	private void allocateHighPriorityTask(String group_name,String emergency_ind) throws Exception {
		// GetList Of Users Above user_bound to be assigned
		List<RaasTasksDTO> unassigned_tasks = this.getListOfHighPriorityTasks(group_name, emergency_ind);
		// List<RaasUsersDTO> unassigned_users =
		// this.getListOfUnAssignedUsersInGroup(group_name);
		RaasUsersDTO curr_user = null;
		int availablility = 0;
		for (RaasTasksDTO curr_task : unassigned_tasks) {

			curr_user = getNextUnAssignedUsersInGroupForHighPriorityTask(group_name, emergency_ind);
			if (curr_user == null)
				break;
			logger.info("Assigning user :" + curr_user.getLoginId() + " task " + curr_task.getTask_key());
			curr_task.setUser_name(curr_user.getLoginId());
			curr_task.setStatus("ASSIGNED");
			logger.info("Assigend Task Obj " + curr_task);
			this.updateTasks(curr_task);

		}		
	}
	private List<RaasGroupsDTO> getAllGroupsWithUnAssignedTasks() throws Exception {

		String sql = "SELECT DISTINCT group_name groupName" + "  FROM raas_tasks tasks, raas_groups grp"
				+ " WHERE grp.name = tasks.group_name AND tasks.status = 'UNASSIGNED'";

		ResultSetHandler<List<RaasGroupsDTO>> usageResultSet = new BeanListHandler<RaasGroupsDTO>(RaasGroupsDTO.class);
		List<RaasGroupsDTO> groups = getQueryRunner().query(sql, usageResultSet);		
		return groups;
	}

	public List<RaasTasksDTO> invokeTaskAssignment(String group_name,String emergency_ind) throws Exception {

		this.allocateHighPriorityTask(group_name, emergency_ind);
		List<RaasTasksDTO> unassigned_tasks = this.shuffleTasksAccordingToPriorities(group_name, emergency_ind);
		List<RaasUsersDTO> unassigned_users = this.getListOfUnAssignedUsersInGroup(group_name, emergency_ind);
		RaasTasksDTO curr_task = null;
		int availablility = 0;
		for (RaasUsersDTO obj : unassigned_users) {
			availablility = obj.getAvailablity() != null ? Integer.parseInt(obj.getAvailablity()) : 0;
			curr_task = getNextUnAssignedTasks(group_name, emergency_ind);
			if (curr_task == null)
				break;
			for (int i = 1; i <= availablility; i++) {
				curr_task = getNextUnAssignedTasks(group_name, emergency_ind);

				if (curr_task != null) {
					logger.info("Assigning user :" + obj.getLoginId() + " task " + curr_task.getTask_key());
					curr_task.setUser_name(obj.getLoginId());
					curr_task.setStatus("ASSIGNED");
					logger.info("Assigend Task Obj " + curr_task);
					this.updateTasks(curr_task);
					//break;
				} else
					break;
			}

		}
		return null;
	}

	private List<RaasUsersDTO> getListOfUnAssignedUsersInGroup(String group_name,String emergency_ind) throws Exception {

		String sql = "SELECT *" + "    FROM (SELECT in_consolidated_tbl.*,"
				+ "                 (userBound - assigned_tasks - working_tasks) availablity"
				+ "            FROM (SELECT login_id loginId," + "                         user_role userRole,"
				+ "                         lower_bound lowerBound," + "                         user_bound userBound,"
				+ "                         max_bound upperBound," + "                         (SELECT count(*)"
				+ "                            FROM raas_tasks"
				+ "                           WHERE user_name = login_id AND status = 'ASSIGNED')"
				+ "                            assigned_tasks," + "                         (SELECT count(*)"
				+ "                            FROM raas_tasks"
				+ "                           WHERE user_name = login_id AND status = 'WORKING')"
				+ "                            working_tasks," + "                         (SELECT count(*)"
				+ "                            FROM raas_tasks"
				+ "                           WHERE user_name = login_id AND status = 'COMPLETED')"
				+ "                            finished_tasks"
				+ "                    FROM raas_users up, raas_group_user_map gum"
				+ "                   WHERE     user_role != 'MANAGER'"
				+ "                         AND gum.group_name IN (select name name from raas_groups where name='"+group_name+"' union select child_group_name name from raas_group_map where parent_group_name='"+group_name+"' AND 'Y'='"+emergency_ind+"')"
				+ "                         AND up.login_id = gum.user_name) in_consolidated_tbl)"
				+ "         ou_consolidated_tbl" + "   WHERE availablity != 0"
				+ " ORDER BY working_tasks ASC, availablity DESC, assigned_tasks DESC";

		ResultSetHandler<List<RaasUsersDTO>> usageResultSet = new BeanListHandler<RaasUsersDTO>(RaasUsersDTO.class);
		List<RaasUsersDTO> users = getQueryRunner().query(sql, usageResultSet);
		logger.info(users);
		return users;
	}

	private RaasUsersDTO getNextUnAssignedUsersInGroupForHighPriorityTask(String group_name,String emergency_ind) throws Exception {

		String sql = "SELECT *" + "    FROM (SELECT in_consolidated_tbl.*,"
				+ "                 (upperBound - assigned_tasks - working_tasks) availablity"
				+ "            FROM (SELECT login_id loginId," + "                         user_role userRole,"
				+ "                         lower_bound lowerBound," + "                         user_bound userBound,"
				+ "                         max_bound upperBound," + "                         (SELECT count(*)"
				+ "                            FROM raas_tasks"
				+ "                           WHERE user_name = login_id AND status = 'ASSIGNED')"
				+ "                            assigned_tasks," + "                         (SELECT count(*)"
				+ "                            FROM raas_tasks"
				+ "                           WHERE user_name = login_id AND status = 'WORKING')"
				+ "                            working_tasks," + "                         (SELECT count(*)"
				+ "                            FROM raas_tasks"
				+ "                           WHERE user_name = login_id AND status = 'COMPLETED')"
				+ "                            finished_tasks"
				+ "                    FROM raas_users up, raas_group_user_map gum"
				+ "                   WHERE     user_role != 'MANAGER'"
				+ "                         AND gum.group_name IN (select name name from raas_groups where name='"+group_name+"' union select child_group_name name from raas_group_map where parent_group_name='"+group_name+"' AND 'Y'='"+emergency_ind+"')"
				+ "                         AND NOT EXISTS"
				+ "                (SELECT 1"
                + "                   FROM raas_tasks tsk"
                + "                  WHERE     (   tsk.status = 'ASSIGNED'"
                + "                             OR tsk.status = 'WORKING')"
                + "                        AND tsk.user_name = up.login_id"
                + "                        AND tsk.priority = 10)"
				+ "                         AND up.login_id = gum.user_name) in_consolidated_tbl)"
				+ "         ou_consolidated_tbl" + "   WHERE 1 != 2"
				+ " ORDER BY working_tasks ASC, availablity DESC, assigned_tasks DESC";

		ResultSetHandler<List<RaasUsersDTO>> usageResultSet = new BeanListHandler<RaasUsersDTO>(RaasUsersDTO.class);
		List<RaasUsersDTO> users = getQueryRunner().query(sql, usageResultSet);
		if (users.size() > 0) {
			logger.info(users.get(0));
			return users.get(0);
		} else
			return null;
		
	}

	
	private RaasTasksDTO getNextUnAssignedTasks(String group_name,String emergency_ind) throws Exception {

		String sql = "SELECT" + "        task_oid,task_key," + "            priority," + "            external_sla,"
				+ "            time_lapse_to_sla" + "    FROM" + "        (SELECT" + "        raas_tasks.task_oid,"
				+ "            raas_tasks.task_key," + "            raas_tasks.user_name,"
				+ "            raas_tasks.status," + "            raas_tasks.group_name,"
				+ "            raas_tasks.created_timestamp," + "            raas_tasks.work_start_timestamp,"
				+ "            raas_tasks.priority," + "            raas_tasks.internal_sla,"
				+ "            raas_tasks.external_sla,"
				+ "            ((UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(created_timestamp)) / 3600) time_lapse_to_sla"
				+ "    FROM" + "        raas_tasks" + "    WHERE" + "        user_name IS NULL"
				+ "            AND group_name = '" + group_name + "' "
				+ "    ORDER BY priority DESC , (NOW() - created_timestamp) DESC) inner_derived_tbl"
				+ "    ORDER BY priority DESC , (external_sla - time_lapse_to_sla) DESC";
		ResultSetHandler<List<RaasTasksDTO>> usageResultSet = new BeanListHandler<RaasTasksDTO>(RaasTasksDTO.class);

		List<RaasTasksDTO> tasks = getQueryRunner().query(sql, usageResultSet);
		if (tasks.size() > 0) {
			logger.info(tasks.get(0));
			return tasks.get(0);
		} else
			return null;
	}

	private List<RaasTasksDTO> getListOfUnAssignedTasks(String group_name,String emergency_ind) throws Exception {

		String sql = "SELECT" + "        task_oid," + "            priority," + "            external_sla,"
				+ "            time_lapse_to_sla" + "    FROM" + "        (SELECT" + "        raas_tasks.task_oid,"
				+ "            raas_tasks.task_key," + "            raas_tasks.user_name,"
				+ "            raas_tasks.status," + "            raas_tasks.group_name,"
				+ "            raas_tasks.created_timestamp," + "            raas_tasks.work_start_timestamp,"
				+ "            raas_tasks.priority," + "            raas_tasks.internal_sla,"
				+ "            raas_tasks.external_sla,"
				+ "            ((UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(created_timestamp)) / 3600) time_lapse_to_sla"
				+ "    FROM" + "        raas_tasks" + "    WHERE" + "        user_name IS NULL"
				+ "            AND group_name = '" + group_name + "' "
				+ "    ORDER BY priority DESC , (NOW() - created_timestamp) DESC) inner_derived_tbl"
				+ "    ORDER BY priority DESC , (external_sla - time_lapse_to_sla) DESC";
		ResultSetHandler<List<RaasTasksDTO>> usageResultSet = new BeanListHandler<RaasTasksDTO>(RaasTasksDTO.class);

		List<RaasTasksDTO> tasks = getQueryRunner().query(sql, usageResultSet);

		logger.info(tasks);
		return tasks;
	}

	private List<RaasTasksDTO> getListOfHighPriorityTasks(String group_name,String emergency_ind) throws Exception {

		String sql = "SELECT" + "        task_oid," + "            priority," + "            external_sla,"
				+ "            time_lapse_to_sla" + "    FROM" + "        (SELECT" + "        raas_tasks.task_oid,"
				+ "            raas_tasks.task_key," + "            raas_tasks.user_name,"
				+ "            raas_tasks.status," + "            raas_tasks.group_name,"
				+ "            raas_tasks.created_timestamp," + "            raas_tasks.work_start_timestamp,"
				+ "            raas_tasks.priority," + "            raas_tasks.internal_sla,"
				+ "            raas_tasks.external_sla,"
				+ "            ((UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(created_timestamp)) / 3600) time_lapse_to_sla"
				+ "    FROM" + "        raas_tasks" + "    WHERE" + "        user_name IS NULL AND priority=10 "
				+ "            AND group_name = '" + group_name + "' "
				+ "    ORDER BY priority DESC , (NOW() - created_timestamp) DESC) inner_derived_tbl"
				+ "    ORDER BY priority DESC , (external_sla - time_lapse_to_sla) DESC";
		ResultSetHandler<List<RaasTasksDTO>> usageResultSet = new BeanListHandler<RaasTasksDTO>(RaasTasksDTO.class);

		List<RaasTasksDTO> tasks = getQueryRunner().query(sql, usageResultSet);

		logger.info(tasks);
		return tasks;
	}	
	
	private List<RaasTasksDTO> shuffleTasksAccordingToPriorities(String group_name,String emergency_ind) throws Exception {

		List<RaasTasksDTO> tasks = this.getListOfUnAssignedTasks(group_name, emergency_ind);
		logger.info("All Tasks before shuffle running");
		logger.info(tasks);
		for (RaasTasksDTO obj : tasks) {
			int external_sla = 0;
			float elapsed_time = 0, ratio = 0;
			int priority = 0, set_priority = 0;
			external_sla = Integer.parseInt(obj.getExternal_sla());
			elapsed_time = Float.parseFloat(obj.getTime_lapse_to_sla());
			ratio = (elapsed_time / external_sla);
			priority = Integer.parseInt(obj.getPriority());
			if (ratio > 3)
				set_priority = 10;
			else if (ratio > 2 && priority == 10)
				set_priority = 8;
			else if (ratio > 1)
				set_priority = priority + 2;
			else if (ratio < 1 && ratio > 0.8)
				set_priority = priority + 1;
			else
				set_priority = priority;

			if (set_priority > 10)
				set_priority = 10;

			obj.setPriority(set_priority + "");
			updateTasks(obj);
		}
		logger.info("All Tasks after shuffle running");
		logger.info(tasks);

		return null;
	}

	public int updateTasks(RaasTasksDTO tasks) throws Exception {
		String sql = "UPDATE raas_tasks SET ";
		if (tasks.getPriority() != null)
			sql += " priority=" + tasks.getPriority() + " ,";
		if (tasks.getStatus() != null ) {
			sql += " status='" + tasks.getStatus() + "' ,";
			if ("COMPLETED".equals(tasks.getStatus()))
				sql += " Work_start_timestamp=NOW() "  + " ,";
			else if ("ACCEPTED".equals(tasks.getStatus()))
				sql += " completed_ts=NOW() "  + " ,";
		}
		if (tasks.getGroup_name() != null)
			sql += " group_name='" + tasks.getGroup_name() + "' ,";
		if (tasks.getUser_name() != null)
			sql += " user_name='" + tasks.getUser_name() + "' ,";
		if (tasks.getWork_start_timestamp() != null)
			sql += " Work_start_timestamp=" + tasks.getWork_start_timestamp();
		else {
			sql = sql.substring(0, sql.lastIndexOf(","));
		}
		sql += "  WHERE task_oid=" + tasks.getTask_oid();

		logger.info("update task sql:" + sql);
		return getQueryRunner().update(sql);

	}

	public QueryRunner getQueryRunner() {
		if (queryRunner == null) {
			queryRunner = new QueryRunner(getDataSource());
		}
		return queryRunner;
	}

	public DataSource getDataSource() {
		if (mysqlDS == null) {
			mysqlDS = new MysqlDataSource();
			// mysqlDS.setURL("jdbc:mysql://113.128.163.212:3306/raasdb");
			// mysqlDS.setUser("appuser");
			// mysqlDS.setPassword("appuser");

			// mysqlDS.setURL("jdbc:mysql://us-cdbr-iron-east-03.cleardb.net/ad_2c6b60203891d7f");
			// mysqlDS.setUser("b70f66a0807549");
			// mysqlDS.setPassword("be3556ce");

			mysqlDS.setURL(CommonUtils.getPropertyValue("dburl"));
			mysqlDS.setUser(CommonUtils.getPropertyValue("dbuser"));
			mysqlDS.setPassword(CommonUtils.getPropertyValue("dbpassword"));

		}

		return mysqlDS;

	}

	public static void main(String... args) throws Exception {
		TaskAssignmentDAO tskDAO = new TaskAssignmentDAO();
		// tskDAO.shuffleTasksAccordingToPriorities();
		tskDAO.runTaskAssignmentAlgorithm("CPNI");
		//System.out.println(tskDAO.isEmergencyCondPrevail());

	}
}
