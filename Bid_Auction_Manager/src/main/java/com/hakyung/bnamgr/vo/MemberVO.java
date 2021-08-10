package com.hakyung.bnamgr.vo;

public class MemberVO {

	String member_id, member_pw, member_nm, member_indate, member_phone, member_email;
	String member_savedfile, member_originalfile;
	int member_gender, member_profile;
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_nm() {
		return member_nm;
	}
	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}
	public String getMember_indate() {
		return member_indate;
	}
	public void setMember_indate(String member_indate) {
		this.member_indate = member_indate;
	}
	public int getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(int member_gender) {
		this.member_gender = member_gender;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	
	public String getMember_savedfile() {
		return member_savedfile;
	}
	public void setMember_savedfile(String member_savedfile) {
		this.member_savedfile = member_savedfile;
	}
	public String getMember_originalfile() {
		return member_originalfile;
	}
	public void setMember_originalfile(String member_originalfile) {
		this.member_originalfile = member_originalfile;
	}
	public int getMember_profile() {
		return member_profile;
	}
	public void setMember_profile(int member_profile) {
		this.member_profile = member_profile;
	}
	@Override
	public String toString() {
		return "MemberVO [member_id=" + member_id + ", member_pw=" + member_pw + ", member_nm=" + member_nm
				+ ", member_indate=" + member_indate + ", member_phone=" + member_phone + ", member_email="
				+ member_email + ", member_savedfile=" + member_savedfile + ", member_originalfile="
				+ member_originalfile + ", member_gender=" + member_gender + ", member_profile=" + member_profile + "]";
	}
	
	
}
