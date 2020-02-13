package com.keji09.weixin.bean;



public class OrderBean {
	private String name;
	private Float nowPrice;
	public String getName() {
		if(name.length()==1){
			return name;
		}else if(name.length()==2){
			return "*"+name.charAt(1);
		}else{
			String x="";
			for(int i=0;i<name.length()-2;i++){
				x+="*";
			}
			return name.charAt(0)+x+name.charAt(name.length()-1);
		}
	}
	public Float getNowPrice() {
		return nowPrice;
	}
	public void setNowPrice(Float nowPrice) {
		this.nowPrice = nowPrice;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
