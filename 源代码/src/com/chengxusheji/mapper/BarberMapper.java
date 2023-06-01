package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Barber;

public interface BarberMapper {
	/*添加维修人员信息*/
	public void addBarber(Barber barber) throws Exception;

	/*按照查询条件分页查询维修人员记录*/
	public ArrayList<Barber> queryBarber(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有维修人员记录*/
	public ArrayList<Barber> queryBarberList(@Param("where") String where) throws Exception;

	/*按照查询条件的维修人员记录数*/
	public int queryBarberCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条维修人员记录*/
	public Barber getBarber(int barberId) throws Exception;

	/*更新维修人员记录*/
	public void updateBarber(Barber barber) throws Exception;

	/*删除维修人员记录*/
	public void deleteBarber(int barberId) throws Exception;

}
