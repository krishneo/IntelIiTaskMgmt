package com.hackthon.teamwg.projects.services;

import com.hackthon.teamwg.projects.services.RaasChartService.*;

import static org.hamcrest.CoreMatchers.*;
import static org.junit.Assert.*;

import org.junit.Test;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.hackthon.teamwg.projects.dto.RaasGenericCountDTO;
public class RaasChartServiceTest {

	@Test
	public void type() throws Exception {
		// TODO auto-generated by JUnit Helper.
		assertThat(RaasChartService.class, notNullValue());
	}

	@Test
	public void instantiation() throws Exception {
		// TODO auto-generated by JUnit Helper.
		RaasChartService target = new RaasChartService();
		assertThat(target, notNullValue());
	}

	@Test
	public void getUserSatisfaction_A$List() throws Exception {
		// TODO auto-generated by JUnit Helper.
		RaasChartService target = new RaasChartService();
		List<RaasGenericCountDTO> countDTOs = new ArrayList<RaasGenericCountDTO>();
		RaasGenericCountDTO countDTO = new RaasGenericCountDTO("Prakash", "COMPLETED", "1") ;
		countDTOs.add(countDTO) ;		
		Map<String, Object> actual = target.getUserSatisfaction(countDTOs);
		Map<String, Object> expected = null;
		assertNotNull(actual);
	}

	@Test
	public void getGroupTaskSplitups_A$List() throws Exception {
		// TODO auto-generated by JUnit Helper.
		RaasChartService target = new RaasChartService();
		List<RaasGenericCountDTO> countDTOs = new ArrayList<RaasGenericCountDTO>();
		List actual = target.getGroupTaskSplitups(countDTOs);
		assertNotNull(actual);
	}

	@Test
	public void getStackedColumnChartData_A$List() throws Exception {
		// TODO auto-generated by JUnit Helper.
		RaasChartService target = new RaasChartService();
		List<RaasGenericCountDTO> countDTOs = new ArrayList<RaasGenericCountDTO>();
		Map<String, Object> actual = target.getStackedColumnChartData(countDTOs);
		assertNotNull(actual);
	}

}
