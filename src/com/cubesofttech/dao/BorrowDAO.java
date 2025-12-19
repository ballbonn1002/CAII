package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Borrow;
import com.cubesofttech.model.Equipment;

public interface BorrowDAO {

	public void save(Borrow borrow) throws Exception;

	public List<Borrow> findAll() throws Exception;
	public List<Map<String, Object>> findAll_1() throws Exception;

	public Borrow findById(int i) throws Exception;

	public void update(Borrow borrow) throws Exception;

	public void delete(Borrow borrow) throws Exception;

	Integer getMaxId() throws Exception;
	
	public List<Map<String, Object>> Borrowinglist() throws Exception;
	
	public List<Map<String, Object>> Borrowcheck() throws Exception;
	
	public List<Map<String, Object>> check() throws Exception;

	List<Borrow> findByStatusId(String statusid) throws Exception;

	public Borrow Borrowchecked(String string);
	
	public List<Map<String, Object>> Showdetail() throws Exception;

	//public List<Map<String, Object>> Borrowlistnirobonxx() throws Exception;


	public int findByIdx(Integer valueOf) throws Exception;

	//public List<Map<String, Object>> Borrowlistnirobonxx(Borrow b) throws Exception;

	//public List<Map<String, Object>> Borrowlistnirobonxx(Integer borrowid) throws Exception;

	public List<Map<String, Object>> Borrowlistnirobonxx(int borrowID) throws Exception;

	
	//public List<Map<String, Object>> Borrowlistnirobon(String string) throws Exception;
	
	public List<Borrow> getAll();
	
	
	public List<Borrow> find_History(String equipmentId) throws Exception;
	public List<Map<String, Object>> search_borrow(String user) throws Exception;
	public List<Map<String, Object>> findHistoryByUser(String user) throws Exception;
	public List<Map<String, Object>> findBorrowAll() throws Exception;

	public List<Borrow> findBorrowByEquipmentId(String eId);
	public List<Borrow> findBorrowByEquipmentIdAndStatus(String eId, String bStatus);

	public List<Borrow> findBorrowByUser(String id);
	public List<Borrow> findBorrowByStatus(String status);
	
	public List<Map<String, Object>> borrower(String id) throws Exception; 

	public String findlatestborrowbyequipmentid(Integer id) throws Exception;
	
	public List<Map<String, Object>> findBorrowWithUserByEquipmentId(String eId);
	
	public List<Borrow> findAll_exceptStatus_A() throws Exception;

	public List<Map<String, Object>> getBorrowListByUserId(String logonUser);
}
