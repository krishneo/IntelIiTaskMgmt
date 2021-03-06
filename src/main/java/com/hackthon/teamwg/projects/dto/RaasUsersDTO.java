package com.hackthon.teamwg.projects.dto;

public class RaasUsersDTO {

	private String loginId;
	private String firstName;
	private String lastName;
	private String userRole;
	private Integer lowerBound;
	private Integer upperBound;
	private Integer userBound;
	private String managingGroups;
	private String assigned_tasks;
	private String working_tasks;
	private String finished_tasks;
	private String availablity;	
	public String getAssigned_tasks() {
		return assigned_tasks;
	}

	public void setAssigned_tasks(String assigned_tasks) {
		this.assigned_tasks = assigned_tasks;
	}

	public String getWorking_tasks() {
		return working_tasks;
	}

	public void setWorking_tasks(String working_tasks) {
		this.working_tasks = working_tasks;
	}

	public String getFinished_tasks() {
		return finished_tasks;
	}

	public void setFinished_tasks(String finished_tasks) {
		this.finished_tasks = finished_tasks;
	}

	public String getAvailablity() {
		return availablity;
	}

	public void setAvailablity(String availablity) {
		this.availablity = availablity;
	}



	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	public Integer getLowerBound() {
		return lowerBound;
	}

	public void setLowerBound(Integer lowerBound) {
		this.lowerBound = lowerBound;
	}

	public Integer getUpperBound() {
		return upperBound;
	}

	public void setUpperBound(Integer upperBound) {
		this.upperBound = upperBound;
	}

	public Integer getUserBound() {
		return userBound;
	}

	public void setUserBound(Integer userBound) {
		this.userBound = userBound;
	}

	public RaasUsersDTO(String loginId, String firstName, String lastName, String userRole, Integer lowerBound,
			Integer upperBound, Integer userBound) {
		super();
		this.loginId = loginId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.userRole = userRole;
		this.lowerBound = lowerBound;
		this.upperBound = upperBound;
		this.userBound = userBound;
	}

	public String getManagingGroups() {
		return managingGroups;
	}

	public void setManagingGroups(String managingGroups) {
		this.managingGroups = managingGroups;
	}

	public RaasUsersDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "RaasUsersDTO [loginId=" + loginId + ", firstName=" + firstName + ", lastName=" + lastName
				+ ", userRole=" + userRole + ", lowerBound=" + lowerBound + ", upperBound=" + upperBound
				+ ", userBound=" + userBound + ", managingGroups=" + managingGroups + "]";
	}

}
