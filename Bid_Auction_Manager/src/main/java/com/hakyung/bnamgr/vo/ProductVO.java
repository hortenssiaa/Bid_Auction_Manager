package com.hakyung.bnamgr.vo;

public class ProductVO {

	int p_num, p_kind, p_min_price, max_party, current_party, p_category_code;
    String member_id, p_name, p_indate, p_min_price_op;
    String product_savedfile, product_originalfile, p_category;
    
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public int getP_kind() {
		return p_kind;
	}
	public void setP_kind(int p_kind) {
		this.p_kind = p_kind;
	}
	public int getP_min_price() {
		return p_min_price;
	}
	public void setP_min_price(int p_min_price) {
		this.p_min_price = p_min_price;
	}
	public int getMax_party() {
		return max_party;
	}
	public void setMax_party(int max_party) {
		this.max_party = max_party;
	}
	public int getCurrent_party() {
		return current_party;
	}
	public void setCurrent_party(int current_party) {
		this.current_party = current_party;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_indate() {
		return p_indate;
	}
	public void setP_indate(String p_indate) {
		this.p_indate = p_indate;
	}
	
	public String getP_min_price_op() {
		return p_min_price_op;
	}
	public void setP_min_price_op(String p_min_price_op) {
		this.p_min_price_op = p_min_price_op;
	}
	
	public String getProduct_savedfile() {
		return product_savedfile;
	}
	public void setProduct_savedfile(String product_savedfile) {
		this.product_savedfile = product_savedfile;
	}
	public String getProduct_originalfile() {
		return product_originalfile;
	}
	public void setProduct_originalfile(String product_originalfile) {
		this.product_originalfile = product_originalfile;
	}
	public int getP_category_code() {
		return p_category_code;
	}
	public void setP_category_code(int p_category_code) {
		this.p_category_code = p_category_code;
	}
	public String getP_category() {
		return p_category;
	}
	public void setP_category(String p_category) {
		this.p_category = p_category;
	}
	
	@Override
	public String toString() {
		return "ProductVO [p_num=" + p_num + ", p_kind=" + p_kind + ", p_min_price=" + p_min_price + ", max_party="
				+ max_party + ", current_party=" + current_party + ", p_category_code=" + p_category_code
				+ ", member_id=" + member_id + ", p_name=" + p_name + ", p_indate=" + p_indate + ", p_min_price_op="
				+ p_min_price_op + ", product_savedfile=" + product_savedfile + ", product_originalfile="
				+ product_originalfile + ", p_category=" + p_category + "]";
	}
	
	
    
}
