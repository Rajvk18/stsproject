package com.voidmain.dao;

import java.util.List;

import com.voidmain.pojo.Block;
import com.voidmain.pojo.BlockChain;
import com.voidmain.pojo.Train;
import com.voidmain.pojo.Transaction;
import com.voidmain.pojo.User;

public class HibernateDAO {

	public static boolean isValidUser(String username,String password)
	{
		User user=getUserById(username);

		if(user!=null && user.getPassword().equals(password))
		{
			return true;
		}

		return false;
	}

	//============================================================================

	public static User getUserById(String id)
	{
		return (User)HibernateTemplate.getObject(User.class,id);
	}

	public static int deleteUser(int id)
	{
		return HibernateTemplate.deleteObject(User.class,id);
	}

	public static List<User> getUsers()
	{
		List<User> users=(List)HibernateTemplate.getObjectListByQuery("From User");

		return users;
	}
	
	//==============================================================================
	
	public static Train getTrainById(int id)
	{
		return (Train)HibernateTemplate.getObject(Train.class,id);
	}

	public static int deleteTrain(int id)
	{
		return HibernateTemplate.deleteObject(Train.class,id);
	}

	public static List<Train> getTrains()
	{
		List<Train> trains=(List)HibernateTemplate.getObjectListByQuery("From Train");

		return trains;
	}

	//=========================================================================
	
	public static Transaction getTransactionsById(int id)
	{
		return (Transaction)HibernateTemplate.getObject(Transaction.class,id);
	}

	public static int deleteTransactions(int id)
	{
		return HibernateTemplate.deleteObject(Transaction.class,id);
	}

	public static List<Transaction> getTransactions()
	{
		List<Transaction> transactions=(List)HibernateTemplate.getObjectListByQuery("From Transaction");

		return transactions;
	}

	//=========================================================================
	
	public static Block getBlockById(int id)
	{
		return (Block)HibernateTemplate.getObject(Block.class,new Integer(id));
	}

	public static int deleteBlock(int id)
	{
		return HibernateTemplate.deleteObject(Block.class,new Integer(id));
	}

	public static List<Block> getBlocks()
	{
		List<Block> blocks=(List)HibernateTemplate.getObjectListByQuery("From Block");

		return blocks;
	}

	//======================================================================

	public static BlockChain getBlockChainById(int id)
	{
		return (BlockChain)HibernateTemplate.getObject(BlockChain.class,new Integer(id));
	}

	public static int deleteBlockChain(int id)
	{
		return HibernateTemplate.deleteObject(BlockChain.class,new Integer(id));
	}

	public static List<BlockChain> getBlockChains()
	{
		List<BlockChain> blockChains=(List)HibernateTemplate.getObjectListByQuery("From BlockChain");

		return blockChains;
	}
	
	//============================================================================
}
