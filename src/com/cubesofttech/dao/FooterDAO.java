package com.cubesofttech.dao;

import java.util.List;
import java.util.Map;

import com.cubesofttech.model.Footer;

public interface FooterDAO {

	public void save(Footer footer) throws Exception;

	public void update(Footer footer) throws Exception;

	public void delete(Footer footer) throws Exception;

	public List<Map<String, Object>> findAll() throws Exception;

	public Footer findById(long footer_id) throws Exception;

	public List<Footer> findByParentId(Long parent_footer_id) throws Exception;
	
	public List<Map<String, Object>> findAllParentFooter() throws Exception;

	Long getMaxId() throws Exception;

	List<Map<String, Object>> findParentIdByFooterId(long footer_id) throws Exception;

	boolean checkExistByName(String footer_name);

	public boolean hasChildFooters(String footerId);

	public boolean deleteById(String footerId);

	public List<Map<String, Object>> countChildFooter() throws Exception;

	public Integer findSequenceUnderParent(String id) throws Exception;

	public void updateSequence(List<Integer> sortedIDs) throws Exception;
}
