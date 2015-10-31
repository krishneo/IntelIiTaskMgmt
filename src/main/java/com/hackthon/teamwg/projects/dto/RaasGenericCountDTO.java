package com.hackthon.teamwg.projects.dto;

public class RaasGenericCountDTO implements Comparable<RaasGenericCountDTO> {

	private String key1;
	private String key2;
	private String key3;

	private String value1;
	private String value2;
	private String value3;

	public String getKey1() {
		return key1;
	}

	public void setKey1(String key1) {
		this.key1 = key1;
	}

	public String getKey2() {
		return key2;
	}

	public void setKey2(String key2) {
		this.key2 = key2;
	}

	public String getKey3() {
		return key3;
	}

	public void setKey3(String key3) {
		this.key3 = key3;
	}

	public String getValue1() {
		return value1;
	}

	public void setValue1(String value1) {
		this.value1 = value1;
	}

	public String getValue2() {
		return value2;
	}

	public void setValue2(String value2) {
		this.value2 = value2;
	}

	public String getValue3() {
		return value3;
	}

	public void setValue3(String value3) {
		this.value3 = value3;
	}

	public RaasGenericCountDTO(String key1, String key2, String key3,
			String value1, String value2, String value3) {
		super();
		this.key1 = key1;
		this.key2 = key2;
		this.key3 = key3;
		this.value1 = value1;
		this.value2 = value2;
		this.value3 = value3;
	}

	public RaasGenericCountDTO(String key1, String value1) {
		super();
		this.key1 = key1;
		this.value1 = value1;
	}
	
	public RaasGenericCountDTO(String key1, String key2, String key3) {
		super();
		this.key1 = key1;
		this.key2 = key2;
		this.key3 = key3;
	}

	public RaasGenericCountDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "RaasGenericCountDTO [key1=" + key1 + ", key2=" + key2
				+ ", key3=" + key3 + ", value1=" + value1 + ", value2="
				+ value2 + ", value3=" + value3 + "]";
	}

	@Override
	public int compareTo(RaasGenericCountDTO o) {
		if (this.getKey1() != null && o.getKey1() != null && !this.getKey1().equals(o.getKey1()))	
			return this.getKey1() .compareTo(o.getKey1()) ;
		else if (this.getKey2() != null && o.getKey2() != null && !this.getKey2().equals(o.getKey2()))
			return this.getKey2() .compareTo(o.getKey2()) ;
		return 0;
	}
	

}
