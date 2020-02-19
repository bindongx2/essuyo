package com.webproject.essuyo.domain;

public class ImageInfoVO {

	private int id;
	private String savePath;
	private String type;
	private String name;
	private String creDate;
	private String modDate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSavePath() {
		return savePath;
	}
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreDate() {
		return creDate;
	}
	public void setCreDate(String creDate) {
		this.creDate = creDate;
	}
	public String getModDate() {
		return modDate;
	}
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	@Override
	public String toString() {
		return "ImageInfoVO [id=" + id + ", savePath=" + savePath + ", type=" + type + ", name=" + name + ", creDate="
				+ creDate + ", modDate=" + modDate + "]";
	}
	
	
	
}
	
	
