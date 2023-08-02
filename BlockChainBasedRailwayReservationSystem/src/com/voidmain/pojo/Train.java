package com.voidmain.pojo;

public class Train {

	private int trainId;
	private String source;
	private String dest;
	private String noOfSeats;
	private String timing;
	private String fair;
	
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getDest() {
		return dest;
	}
	public void setDest(String dest) {
		this.dest = dest;
	}
	public String getNoOfSeats() {
		return noOfSeats;
	}
	public void setNoOfSeats(String noOfSeats) {
		this.noOfSeats = noOfSeats;
	}
	public String getTiming() {
		return timing;
	}
	public void setTiming(String timing) {
		this.timing = timing;
	}
	public String getFair() {
		return fair;
	}
	public void setFair(String fair) {
		this.fair = fair;
	}
	public int getTrainId() {
		return trainId;
	}
	public void setTrainId(int trainId) {
		this.trainId = trainId;
	}
	
}
