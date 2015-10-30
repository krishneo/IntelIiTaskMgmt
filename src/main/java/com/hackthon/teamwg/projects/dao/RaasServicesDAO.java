package com.hackthon.teamwg.projects.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import com.hackthon.teamwg.projects.dto.RaasGroupsDTO;
import com.hackthon.teamwg.projects.dto.RaasTasksDTO;
import com.hackthon.teamwg.projects.dto.RaasUsersDTO;
import com.hackthon.teamwg.projects.utils.CommonUtils;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

public class RaasServicesDAO {

	final static Logger logger = Logger.getLogger(RaasServicesDAO.class);

	private MysqlDataSource mysqlDS;

	private QueryRunner queryRunner;

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

	public QueryRunner getQueryRunner() {
		if (queryRunner == null) {
			queryRunner = new QueryRunner(getDataSource());
		}
		return queryRunner;
	}

	public RaasUsersDTO getUser(String loginId) {
		String sql = "SELECT login_id loginId, first_name firstName, "
				+ " last_name lastName, user_role userRole, lower_bound lowerBound, "
				+ " user_bound upperBound, max_bound maxBound, "
				+ " (SELECT GROUP_CONCAT(NAME) dish_ids  FROM raas_groups WHERE manager = login_id GROUP BY manager) managingGroups "
				+ " FROM raas_users where login_id = '" + loginId + "'";
		logger.info("sql for customerDTOs: " + sql);
		try {
			List<RaasUsersDTO> customerDTOs = getUserList(sql, getQueryRunner());
			logger.info("customerDTOs: " + customerDTOs);
			if (customerDTOs != null && customerDTOs.size() == 1)
				return customerDTOs.get(0);
		} catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	public List getUserList(String sql, QueryRunner run) throws SQLException {
		ResultSetHandler<List<RaasUsersDTO>> usageResultSet = new BeanListHandler<RaasUsersDTO>(RaasUsersDTO.class);
		List<RaasUsersDTO> usageResult = run.query(sql, usageResultSet);
		logger.info(usageResult);

		return usageResult;
	}

	public RaasGroupsDTO getGroup(String groupName) {
		String sql = "SELECT group_name groupName, manager FROM raas_groups where group_name = '" + groupName + "'";
		logger.info("sql for customerDTOs: " + sql);
		try {
			List<RaasGroupsDTO> raasGroupsDTO = getGroupList(sql, getQueryRunner());
			logger.info("raasGroupsDTO: " + raasGroupsDTO);
			if (raasGroupsDTO != null && raasGroupsDTO.size() == 1)
				return raasGroupsDTO.get(0);
		} catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	private List getGroupList(String sql, QueryRunner run) throws SQLException {
		ResultSetHandler<List<RaasGroupsDTO>> usageResultSet = new BeanListHandler<RaasGroupsDTO>(RaasGroupsDTO.class);
		List<RaasGroupsDTO> usageResult = run.query(sql, usageResultSet);
		logger.info(usageResult);

		return usageResult;
	}

	public List getGroupUserTaskCount(String groupName) throws Exception {

		String sql = "SELECT rt.user_name,SUM(STATUS='Accepted') acc_count ,SUM(STATUS='Assigned')assign_count,"
				+ " SUM(STATUS='Working')work_count" + " FROM raas_tasks rt,raas_users ru,raas_groups rg"
				+ " WHERE rt.user_name=ru.login_id" + " AND rg.group_name=rt.group_name" + " AND rt.group_name='"
				+ groupName + "'" + " GROUP BY rt.user_name";

		logger.info("sql for getting UserTaskCount: " + sql);

		ArrayListHandler usageResultSet = new ArrayListHandler();
		List<Object[]> usageResult = getQueryRunner().query(sql, usageResultSet);
		logger.info(usageResult);

		return usageResult;
	}

	public List<RaasTasksDTO> getGroupUnassignedTasks(String groupName,  int page_no) {

		int offset = (page_no - 1) * CommonUtils.PAGE_SIZE;

		String sql = "SELECT task_oid, task_key, group_name, created_timestamp, priority, "
				+ "internal_sla, external_sla  "
				+ " FROM  raas_tasks WHERE user_name IS NULL AND STATUS <> 'Completed' " + " AND group_name='"
				+ groupName + "' limit  " + offset + ", " + CommonUtils.PAGE_SIZE;
		logger.info("sql for getting GroupUnassignedTasks: " + sql);
		try {
			ResultSetHandler<List<RaasTasksDTO>> usageResultSet = new BeanListHandler<RaasTasksDTO>(RaasTasksDTO.class);
			List<RaasTasksDTO> usageResult = getQueryRunner().query(sql, usageResultSet);
			logger.info(usageResult);
			return usageResult;
		} catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	public List<RaasTasksDTO> getSLAExpiredTasks(String groupName, int page_no) {
		
		int offset = (page_no - 1) * CommonUtils.PAGE_SIZE;
		
		String sql = "SELECT task_oid ,task_key ,user_name,status,group_name,created_timestamp, \n"
				+ "work_start_timestamp,priority,internal_sla, external_sla,\n"
				+ "(external_sla - elapsed_time) time_lapse_to_sla \n"
				+ "FROM (SELECT raas_tasks.task_oid,raas_tasks.task_key,\n"
				+ "raas_tasks.user_name,raas_tasks.status,raas_tasks.group_name,\n"
				+ "raas_tasks.created_timestamp,raas_tasks.work_start_timestamp,raas_tasks.priority ,\n"
				+ "raas_tasks.internal_sla, \n" + "raas_tasks.external_sla, \n"
				+ "((UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(created_timestamp)) / 3600) 'elapsed_time' \n"
				+ " FROM raas_tasks WHERE user_name IS NULL AND group_name = '" + groupName + "' \n"
				+ " ORDER BY priority DESC , (NOW() - created_timestamp) DESC) derived_tbl\n"
				+ "ORDER BY priority DESC , (external_sla - elapsed_time) DESC limit  " + offset + ", " + CommonUtils.PAGE_SIZE;
		
		logger.info("sql for getting SLAExpiredTasks: " + sql);
		try {
			ResultSetHandler<List<RaasTasksDTO>> usageResultSet = new BeanListHandler<RaasTasksDTO>(RaasTasksDTO.class);
			List<RaasTasksDTO> usageResult = getQueryRunner().query(sql, usageResultSet);
			logger.info(usageResult);
			return usageResult;
		} catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String[] args) throws Exception {
		RaasServicesDAO dao = new RaasServicesDAO();
		// System.out.println(dao.getUser("Prakash"));
		// System.out.println(dao.getGroup("CPNI"));
		System.out.println();
		
		RaasUsersDTO user = dao.getUser("Prakash") ;

		 System.out.println("DAO : " + user);

	}
}