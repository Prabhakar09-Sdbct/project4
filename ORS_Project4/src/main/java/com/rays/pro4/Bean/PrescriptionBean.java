package com.rays.pro4.Bean;

import java.util.Date;

/**
 * Prescription JavaBean encapsulates Prescription attributes.
 * 
 * @author Prabhakar Mandloi
 *
 */
public class PrescriptionBean extends BaseBean {

	private String name;
	private String decease;
	private Date date;
	private Double capacity;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDecease() {
		return decease;
	}

	public void setDecease(String decease) {
		this.decease = decease;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Double getCapacity() {
		return capacity;
	}

	public void setCapacity(Double capacity) {
		this.capacity = capacity;
	}

	@Override
	public String getkey() {
		return decease;
	}

	public String getValue() {
		return decease;
	}

}
