package com.rays.pro4.Bean;


/**
 * Task JavaBean encapsulates Task attributes.
 * 
 * @author Prabhakar Mandloi
 *
 */
public class TaskBean extends BaseBean {
	
	private String title;
	private String details;
	private String assignedTo;
	private String status;
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getAssignedTo() {
		return assignedTo;
	}

	public void setAssignedTo(String assignedTo) {
		this.assignedTo = assignedTo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String getkey() {
		// TODO Auto-generated method stub
		return id + "";
	}

	@Override
	public String getValue() {
		// TODO Auto-generated method stub
		return assignedTo;
	}

	

}
