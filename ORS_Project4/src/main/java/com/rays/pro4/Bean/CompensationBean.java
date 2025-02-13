package com.rays.pro4.Bean;

import java.util.Date;

/**
 * Compensation JavaBean encapsulates Compensation attributes.
 * 
 * @author Prabhakar Mandloi
 *
 */
/**
 * 
 */
public class CompensationBean extends BaseBean {

	private String staffMember;
	private Long paymentAmount;
	private Date dateApplied;
	private String state;

	public String getStaffMember() {
		return staffMember;
	}

	public void setStaffMember(String staffMember) {
		this.staffMember = staffMember;
	}

	public Long getPaymentAmount() {
		return paymentAmount;
	}

	public void setPaymentAmount(Long paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public Date getDateApplied() {
		return dateApplied;
	}

	public void setDateApplied(Date dateApplied) {
		this.dateApplied = dateApplied;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Override
	public String getkey() {
		return staffMember;
	}

	public String getValue() {
		return staffMember;
	}

}
