package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Barber;
import com.chengxusheji.po.ServiceItem;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.UserOrder;

import com.chengxusheji.mapper.UserOrderMapper;
@Service
public class UserOrderService {

	@Resource UserOrderMapper userOrderMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加用户预约记录*/
    public void addUserOrder(UserOrder userOrder) throws Exception {
    	userOrderMapper.addUserOrder(userOrder);
    }

    /*按照查询条件分页查询用户预约记录*/
    public ArrayList<UserOrder> queryUserOrder(Barber barberObj,ServiceItem serviceItemObj,String orderDate,String shzt,UserInfo userObj,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != barberObj && barberObj.getBarberId()!= null && barberObj.getBarberId()!= 0)  where += " and t_userOrder.barberObj=" + barberObj.getBarberId();
    	if(null != serviceItemObj && serviceItemObj.getItemId()!= null && serviceItemObj.getItemId()!= 0)  where += " and t_userOrder.serviceItemObj=" + serviceItemObj.getItemId();
    	if(!orderDate.equals("")) where = where + " and t_userOrder.orderDate like '%" + orderDate + "%'";
    	if(!shzt.equals("")) where = where + " and t_userOrder.shzt like '%" + shzt + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_userOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_userOrder.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return userOrderMapper.queryUserOrder(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<UserOrder> queryUserOrder(Barber barberObj,ServiceItem serviceItemObj,String orderDate,String shzt,UserInfo userObj,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != barberObj && barberObj.getBarberId()!= null && barberObj.getBarberId()!= 0)  where += " and t_userOrder.barberObj=" + barberObj.getBarberId();
    	if(null != serviceItemObj && serviceItemObj.getItemId()!= null && serviceItemObj.getItemId()!= 0)  where += " and t_userOrder.serviceItemObj=" + serviceItemObj.getItemId();
    	if(!orderDate.equals("")) where = where + " and t_userOrder.orderDate like '%" + orderDate + "%'";
    	if(!shzt.equals("")) where = where + " and t_userOrder.shzt like '%" + shzt + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_userOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_userOrder.addTime like '%" + addTime + "%'";
    	return userOrderMapper.queryUserOrderList(where);
    }

    /*查询所有用户预约记录*/
    public ArrayList<UserOrder> queryAllUserOrder()  throws Exception {
        return userOrderMapper.queryUserOrderList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Barber barberObj,ServiceItem serviceItemObj,String orderDate,String shzt,UserInfo userObj,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(null != barberObj && barberObj.getBarberId()!= null && barberObj.getBarberId()!= 0)  where += " and t_userOrder.barberObj=" + barberObj.getBarberId();
    	if(null != serviceItemObj && serviceItemObj.getItemId()!= null && serviceItemObj.getItemId()!= 0)  where += " and t_userOrder.serviceItemObj=" + serviceItemObj.getItemId();
    	if(!orderDate.equals("")) where = where + " and t_userOrder.orderDate like '%" + orderDate + "%'";
    	if(!shzt.equals("")) where = where + " and t_userOrder.shzt like '%" + shzt + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_userOrder.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_userOrder.addTime like '%" + addTime + "%'";
        recordNumber = userOrderMapper.queryUserOrderCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取用户预约记录*/
    public UserOrder getUserOrder(int orderId) throws Exception  {
        UserOrder userOrder = userOrderMapper.getUserOrder(orderId);
        return userOrder;
    }

    /*更新用户预约记录*/
    public void updateUserOrder(UserOrder userOrder) throws Exception {
        userOrderMapper.updateUserOrder(userOrder);
    }

    /*删除一条用户预约记录*/
    public void deleteUserOrder (int orderId) throws Exception {
        userOrderMapper.deleteUserOrder(orderId);
    }

    /*删除多条用户预约信息*/
    public int deleteUserOrders (String orderIds) throws Exception {
    	String _orderIds[] = orderIds.split(",");
    	for(String _orderId: _orderIds) {
    		userOrderMapper.deleteUserOrder(Integer.parseInt(_orderId));
    	}
    	return _orderIds.length;
    }
}
