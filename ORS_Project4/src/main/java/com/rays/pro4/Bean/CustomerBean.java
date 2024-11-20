package com.rays.pro4.Bean;

/**
 * CustomerBean JavaBean encapsulates College attributes.
 * @author Prabhakar Mandloi
 *
 */
public class CustomerBean extends BaseBean{

	private String name;
	private String address;
	private String email;
	private String gender;
	private String phoneNo;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	@Override
	public String getkey() {
		// TODO Auto-generated method stub
		return id+" ";
	}
	@Override
	public String getValue() {
		// TODO Auto-generated method stub
		return name;
	}
	
}
