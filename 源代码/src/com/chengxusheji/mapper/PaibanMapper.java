package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Paiban;

public interface PaibanMapper {
	/*添加维修人员排班信息*/
	public void addPaiban(Paiban paiban) throws Exception;

	/*按照查询条件分页查询维修人员排班记录*/
	public ArrayList<Paiban> queryPaiban(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有维修人员排班记录*/
	public ArrayList<Paiban> queryPaibanList(@Param("where") String where) throws Exception;

	/*按照查询条件的维修人员排班记录数*/
	public int queryPaibanCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条维修人员排班记录*/
	public Paiban getPaiban(int paibanId) throws Exception;

	/*更新维修人员排班记录*/
	public void updatePaiban(Paiban paiban) throws Exception;

	/*删除维修人员排班记录*/
	public void deletePaiban(int paibanId) throws Exception;

}
