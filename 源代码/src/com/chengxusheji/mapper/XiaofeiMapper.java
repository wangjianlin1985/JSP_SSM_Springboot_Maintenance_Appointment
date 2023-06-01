package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Xiaofei;

public interface XiaofeiMapper {
	/*添加消费记录信息*/
	public void addXiaofei(Xiaofei xiaofei) throws Exception;

	/*按照查询条件分页查询消费记录记录*/
	public ArrayList<Xiaofei> queryXiaofei(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有消费记录记录*/
	public ArrayList<Xiaofei> queryXiaofeiList(@Param("where") String where) throws Exception;

	/*按照查询条件的消费记录记录数*/
	public int queryXiaofeiCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条消费记录记录*/
	public Xiaofei getXiaofei(int xiaofeiId) throws Exception;

	/*更新消费记录记录*/
	public void updateXiaofei(Xiaofei xiaofei) throws Exception;

	/*删除消费记录记录*/
	public void deleteXiaofei(int xiaofeiId) throws Exception;

}
