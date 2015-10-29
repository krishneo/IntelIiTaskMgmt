package com.hackthon.teamwg.projects.dao;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import com.hackthon.teamwg.projects.dto.RaasGroupsDTO;
import com.hackthon.teamwg.projects.dto.RaasUsersDTO;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;

public class RaasServicesDAO {

	final static Logger logger = Logger.getLogger(RaasServicesDAO.class);

	private MysqlDataSource mysqlDS;

	private QueryRunner queryRunner;

	public DataSource getDataSource() {
		if (mysqlDS == null) {
			mysqlDS = new MysqlDataSource();
			//mysqlDS.setURL("jdbc:mysql://113.128.163.212:3306/raasdb");
		//	mysqlDS.setUser("appuser");
		//	mysqlDS.setPassword("appuser");
			 
			mysqlDS.setURL("jdbc:mysql://us-cdbr-iron-east-03.cleardb.net/ad_2c6b60203891d7f");
			mysqlDS.setUser("b70f66a0807549");
			mysqlDS.setPassword("be3556ce");
			
		}

		return mysqlDS;

	}

	public QueryRunner getQueryRunner() {
		if (queryRunner == null) {
			queryRunner = new QueryRunner(getDataSource());
		}
		return queryRunner;
	}

	public RaasUsersDTO getUser(String loginId ) {
		String sql = "SELECT login_id loginId, first_name firstName, "
				+ " last_name lastName, user_role userRole, lower_bound lowerBound, "
				+ " user_bound upperBound, max_bound maxBound FROM raas_users where login_id = '"
				+ loginId + "'";
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
		String sql = "SELECT group_name groupName, manager FROM raas_groups where group_name = '"
				+ groupName + "'";
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
	
	public static void main(String[] args) {
		RaasServicesDAO dao = new RaasServicesDAO() ;
		System.out.println( dao.getUser("Prakash" ) ) ;
		System.out.println( dao.getGroup("CPNI"));
	}
}