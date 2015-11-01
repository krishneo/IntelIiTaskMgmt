package com.hackthon.teamwg.projects.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.hackthon.teamwg.projects.dto.RaasGenericCountDTO;

public class GeneralClass {

	static RaasServicesDAO dao = new RaasServicesDAO();

	public static void mains(String[] args) throws Exception {

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

	public List<RaasGenericCountDTO> getUnassignedTasksUnderManager(
			String managerName) {

		String sql = "SELECT DISTINCT rgum.user_name, rt.status, COUNT(task_key) task_count"
				+ " FROM raas_users ru, raas_groups rg, raas_group_user_map rgum, raas_tasks rt"
				+ " WHERE  ru.login_id = rg.manager AND  rg.name = rgum.group_name AND"
				+ " rgum.user_name = rt.user_name AND ru.login_id = '"
				+ managerName + "' " + " GROUP BY rgum.user_name, rt.status ";
		try {
			ResultSetHandler<List<RaasGenericCountDTO>> usageResultSet = new BeanListHandler<RaasGenericCountDTO>(
					RaasGenericCountDTO.class);
			List<RaasGenericCountDTO> usageResult = dao.getQueryRunner().query(
					sql, usageResultSet);
			return usageResult;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String[] args) {
		getChartData(); 
	}

	public static Object getChartData() {

		Map<String, String> categoriesqq = new HashMap<String, String>();
		categoriesqq.put("COMPLETED", "0");
		categoriesqq.put("ASSIGNED", "0");
		categoriesqq.put("WORKING", "0");

		List<RaasGenericCountDTO> countDTOs = new ArrayList<RaasGenericCountDTO>();

		RaasGenericCountDTO countDto = new RaasGenericCountDTO("Prakash", "COMPLETED", "20");
		countDTOs.add(countDto);
		countDto = new RaasGenericCountDTO("Prakash", "ASSIGNED", "10");
		countDTOs.add(countDto);
		countDto = new RaasGenericCountDTO("Prakash", "WORKING", "1");
		countDTOs.add(countDto);

		countDto = new RaasGenericCountDTO("Venkat", "WORKING", "1");
		countDTOs.add(countDto);
		countDto = new RaasGenericCountDTO("Venkat", "ASSIGNED", "1");
		countDTOs.add(countDto);

		countDto = new RaasGenericCountDTO("Thasneem", "WORKING", "1");
		countDTOs.add(countDto);
		countDto = new RaasGenericCountDTO("Thasneem", "COMPLETED", "3");
		countDTOs.add(countDto);
		
		//System.out.println("Primary countDto: " + countDTOs);
		
		RaasServicesDAO dao = new RaasServicesDAO() ;
		countDTOs = dao.getUserStatusUnderManager("Prakash") ;
		
		System.out.println("Primary countDto: " + countDTOs);
		
		Map<String, Map<String, String>> userCharingMap = new HashMap<String, Map<String,String>> () ;
		
		Map<String, String> cMaps = new TreeMap<String, String>(
				new Comparator<String>() {
					public int compare(String o1, String o2) {
						return o1.compareTo(o2);
					}
				});
		
		for (RaasGenericCountDTO countItr : countDTOs) {
			System.out.println("Itr: "+ countItr);
			Map<String, String> resp = new HashMap<String, String>() ;
			if (userCharingMap.get(countItr.getKey1()) != null ) 
				resp = userCharingMap.get(countItr.getKey1()) ;
			else
				System.out.println("Using new value");
			resp.put(countItr.getKey2(), countItr.getKey3()) ;	
			cMaps.put(countItr.getKey1(), null);
			userCharingMap.put(countItr.getKey1(), resp) ;
		}
		
		System.out.println("userCharingMap: " + userCharingMap);
		System.out.println("cMaps: " + cMaps);
		
		Iterator<String> dummyItr = cMaps.keySet().iterator();
		while (dummyItr.hasNext()) {
			
			String key = dummyItr.next() ;
			Map<String, String> dummy =  userCharingMap.get(key) ;
			
			if (dummy.get("COMPLETED") == null )
				countDTOs.add(new RaasGenericCountDTO(key, "COMPLETED", "0")) ;
			if (dummy.get("WORKING") == null )
				countDTOs.add(new RaasGenericCountDTO(key, "WORKING", "0")) ;
			if (dummy.get("ASSIGNED") == null )
				countDTOs.add(new RaasGenericCountDTO(key, "ASSIGNED", "0")) ;			
		}
		
		Collections.sort(countDTOs);
		
		System.out.println("Final countDto: " + countDto);

		Map<String, Object> COMPLETED_MAP = new HashMap<String, Object>();
		COMPLETED_MAP.put("seriesname", "COMPLETED");

		Map<String, Object> WORKING_MAP = new HashMap<String, Object>();
		WORKING_MAP.put("seriesname", "WORKING");

		Map<String, Object> ASSIGNED_MAP = new HashMap<String, Object>();
		ASSIGNED_MAP.put("seriesname", "ASSIGNED");

		List<Object> datasets = new ArrayList<Object>();

		for (RaasGenericCountDTO countDTO : countDTOs) {

			System.out.println("countDTO: " + countDTO);
			
			List<Map<String, String>> data = new ArrayList<Map<String, String>>();
			Map<String, Object> datasetMap = null;

			if ("COMPLETED".equals(countDTO.getKey2()))
				datasetMap = COMPLETED_MAP;
			else if ("WORKING".equals(countDTO.getKey2()))
				datasetMap = WORKING_MAP;
			else if ("ASSIGNED".equals(countDTO.getKey2()))
				datasetMap = ASSIGNED_MAP;

			if (datasetMap.get("data") != null)
				data = (List<Map<String, String>>) datasetMap.get("data");

			Map<String, String> dataMap = new HashMap<String, String>();
			dataMap.put("value", countDTO.getKey3());
			data.add(dataMap);

			datasetMap.put("data", data);

		}

		datasets.add(COMPLETED_MAP);
		datasets.add(WORKING_MAP);
		datasets.add(ASSIGNED_MAP);

		System.out.println("datasets: " + datasets);

		List<Object> categories = new ArrayList<Object>();

		Iterator<String> iterator = cMaps.keySet().iterator();
		while (iterator.hasNext()) {
			Map<String, String> categoriesMap = new HashMap<String, String>();
			categoriesMap.put("label", iterator.next());
			categories.add(categoriesMap);
		}
		
		Map<String, Object> mapDummyMap = new HashMap<String, Object> () ;
		mapDummyMap.put("category", categories) ;

		List<Object> catDummyList = new ArrayList<Object>();
		catDummyList.add(mapDummyMap) ;
		
		System.out.println("categories: " + catDummyList);

		Map<String, Object> chartData = new HashMap<String, Object>();
		chartData.put("categories", catDummyList);
		chartData.put("dataset", datasets);

		System.out.println("Complete chartData: " + chartData);

		return chartData;

	}

}
