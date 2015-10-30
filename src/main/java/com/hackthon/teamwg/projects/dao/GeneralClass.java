package com.hackthon.teamwg.projects.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ParameterMetaData;

public class GeneralClass {

	public static void main(String[] args) throws Exception {
		RaasServicesDAO dao = new RaasServicesDAO();
		Connection conn = dao.getDataSource().getConnection();

		String simpleProc = "{ call assign_task(?, ?, ?) }";
		CallableStatement cs = conn.prepareCall(simpleProc);
		cs.setString(1, "Prakash");
		cs.setString(2, "Task-2");
		cs.setString(3, "ASSIGNED");
		cs.execute();
		conn.close();
		
		System.out.println("Sample");
	}
}
