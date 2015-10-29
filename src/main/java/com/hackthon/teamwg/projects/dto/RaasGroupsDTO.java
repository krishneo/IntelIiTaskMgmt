package com.hackthon.teamwg.projects.dto;

public class RaasGroupsDTO {

	private String groupName;
	private String manager;

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public RaasGroupsDTO(String groupName, String manager) {
		super();
		this.groupName = groupName;
		this.manager = manager;
	}

	@Override
	public String toString() {
		return "RaasGroupsDTO [groupName=" + groupName + ", manager=" + manager + "]";
	}

	public RaasGroupsDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

}