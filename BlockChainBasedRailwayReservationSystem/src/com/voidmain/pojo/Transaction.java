package com.voidmain.pojo;

public class Transaction {

	private int transactionId;
	private String userName;
	private int blockChainId;
	
	public int getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(int transactionId) {
		this.transactionId = transactionId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getBlockChainId() {
		return blockChainId;
	}
	public void setBlockChainId(int blockChainId) {
		this.blockChainId = blockChainId;
	}
}
