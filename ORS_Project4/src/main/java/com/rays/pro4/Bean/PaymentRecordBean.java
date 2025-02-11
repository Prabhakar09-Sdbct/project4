package com.rays.pro4.Bean;

import java.util.Date;


/**
 * PaymentRecord JavaBean encapsulates PaymentRecord attributes.
 * 
 * @author Prabhakar Mandloi
 *
 */
public class PaymentRecordBean extends BaseBean {

	private String transactionId;
    private double amount;
    private Date transactionDate;
    private String status; 
    private String paymentMethod; 
    
	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public Date getTransactionDate() {
		return transactionDate;
	}

	public void setTransactionDate(Date transactionDate) {
		this.transactionDate = transactionDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	@Override
	public String getkey() {
		// TODO Auto-generated method stub
		return id + "";
	}

	@Override
	public String getValue() {
		// TODO Auto-generated method stub
		return paymentMethod;
	}

}
