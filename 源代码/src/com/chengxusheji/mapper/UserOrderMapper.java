package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.UserOrder;

public interface UserOrderMapper {
	/*添加用户预约信息*/
	public void addUserOrder(UserOrder userOrder) throws Exception;

	/*按照查询条件分页查询用户预约记录*/
	public ArrayList<UserOrder> queryUserOrder(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有用户预约记录*/
	public ArrayList<UserOrder> queryUserOrderList(@Param("where") String where) throws Exception;

	/*按照查询条件的用户预约记录数*/
	public int queryUserOrderCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条用户预约记录*/
	public UserOrder getUserOrder(int orderId) throws Exception;

	/*更新用户预约记录*/
	public void updateUserOrder(UserOrder userOrder) throws Exception;

	/*删除用户预约记录*/
	public void deleteUserOrder(int orderId) throws Exception;

}
