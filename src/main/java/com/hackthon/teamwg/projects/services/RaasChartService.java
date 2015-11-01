package com.hackthon.teamwg.projects.services;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.hackthon.teamwg.projects.dto.RaasGenericCountDTO;

public class RaasChartService {

	public Map<String, Object> getUserSatisfaction(
			List<RaasGenericCountDTO> countDTOs) {

		Map<String, Object> finalResult = new HashMap<String, Object>();

		List<Map<String, Object>> repList = new ArrayList<Map<String, Object>>();

		RaasGenericCountDTO genericCountDTO = countDTOs.get(0);

		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("minValue", 0);
		dataMap.put("maxValue", genericCountDTO.getKey1());
		dataMap.put("code", "#6baa01");

		Map<String, Object> dataMap1 = new HashMap<String, Object>();
		dataMap1.put("minValue", genericCountDTO.getKey1());
		dataMap1.put("maxValue", genericCountDTO.getKey2());
		dataMap1.put("code", "#f8bd19");

		Map<String, Object> dataMap2 = new HashMap<String, Object>();
		dataMap2.put("minValue", genericCountDTO.getKey2());
		dataMap2.put("maxValue", genericCountDTO.getKey3());
		dataMap2.put("code", "#e44a00");

		repList.add(dataMap);
		repList.add(dataMap1);
		repList.add(dataMap2);

		finalResult.put("max_value", genericCountDTO.getKey3());
		finalResult.put("marked_value", genericCountDTO.getValue1());
		finalResult.put("data", repList);

		return finalResult;

	}

	public List<Map<String, String>> getGroupTaskSplitups(
			List<RaasGenericCountDTO> countDTOs) {

		List<Map<String, String>> repList = new ArrayList<Map<String, String>>();

		for (RaasGenericCountDTO countDTO : countDTOs) {
			Map<String, String> dataMap = new HashMap<String, String>();
			dataMap.put("label", countDTO.getKey1());
			dataMap.put("value", countDTO.getKey2());
			repList.add(dataMap);
		}

		return repList;
	}

	public Map<String, Object> getStackedColumnChartData(
			List<RaasGenericCountDTO> countDTOs) {
		Map<String, Map<String, String>> userCharingMap = new HashMap<String, Map<String, String>>();

		Collections.sort(countDTOs);

		Map<String, String> cMaps = new TreeMap<String, String>(
				new Comparator<String>() {
					public int compare(String o1, String o2) {
						return o1.compareTo(o2);
					}
				});

		for (RaasGenericCountDTO countItr : countDTOs) {
			System.out.println("Itr: " + countItr);
			Map<String, String> resp = new HashMap<String, String>();
			if (userCharingMap.get(countItr.getKey1()) != null)
				resp = userCharingMap.get(countItr.getKey1());
			else
				System.out.println("Using new value");
			resp.put(countItr.getKey2(), countItr.getKey3());
			cMaps.put(countItr.getKey1(), null);
			userCharingMap.put(countItr.getKey1(), resp);
		}

		System.out.println("userCharingMap: " + userCharingMap);
		System.out.println("cMaps: " + cMaps);

		Iterator<String> dummyItr = cMaps.keySet().iterator();
		while (dummyItr.hasNext()) {

			String key = dummyItr.next();
			Map<String, String> dummy = userCharingMap.get(key);

			if (dummy.get("COMPLETED") == null)
				countDTOs.add(new RaasGenericCountDTO(key, "COMPLETED", "0"));
			if (dummy.get("WORKING") == null)
				countDTOs.add(new RaasGenericCountDTO(key, "WORKING", "0"));
			if (dummy.get("ASSIGNED") == null)
				countDTOs.add(new RaasGenericCountDTO(key, "ASSIGNED", "0"));
		}

		Collections.sort(countDTOs);

		System.out.println("Final countDto after sorting: " + countDTOs);

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

		Map<String, Object> mapDummyMap = new HashMap<String, Object>();
		mapDummyMap.put("category", categories);

		List<Object> catDummyList = new ArrayList<Object>();
		catDummyList.add(mapDummyMap);

		System.out.println("categories: " + catDummyList);

		Map<String, Object> chartData = new HashMap<String, Object>();
		chartData.put("categories", catDummyList);
		chartData.put("dataset", datasets);

		System.out.println("Complete chartData: " + chartData);

		return chartData;
	}

}
