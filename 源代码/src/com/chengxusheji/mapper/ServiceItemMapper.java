package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ServiceItem;

public interface ServiceItemMapper {
	/*添加维修项目信息*/
	public void addServiceItem(ServiceItem serviceItem) throws Exception;

	/*按照查询条件分页查询维修项目记录*/
	public ArrayList<ServiceItem> queryServiceItem(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有维修项目记录*/
	public ArrayList<ServiceItem> queryServiceItemList(@Param("where") String where) throws Exception;

	/*按照查询条件的维修项目记录数*/
	public int queryServiceItemCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条维修项目记录*/
	public ServiceItem getServiceItem(int itemId) throws Exception;

	/*更新维修项目记录*/
	public void updateServiceItem(ServiceItem serviceItem) throws Exception;

	/*删除维修项目记录*/
	public void deleteServiceItem(int itemId) throws Exception;

}
