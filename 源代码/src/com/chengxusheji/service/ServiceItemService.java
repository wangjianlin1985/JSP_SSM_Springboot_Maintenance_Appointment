package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ServiceItem;

import com.chengxusheji.mapper.ServiceItemMapper;
@Service
public class ServiceItemService {

	@Resource ServiceItemMapper serviceItemMapper;
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

    /*添加维修项目记录*/
    public void addServiceItem(ServiceItem serviceItem) throws Exception {
    	serviceItemMapper.addServiceItem(serviceItem);
    }

    /*按照查询条件分页查询维修项目记录*/
    public ArrayList<ServiceItem> queryServiceItem(String itemType,String itemName,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!itemType.equals("")) where = where + " and t_serviceItem.itemType like '%" + itemType + "%'";
    	if(!itemName.equals("")) where = where + " and t_serviceItem.itemName like '%" + itemName + "%'";
    	if(!addTime.equals("")) where = where + " and t_serviceItem.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return serviceItemMapper.queryServiceItem(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ServiceItem> queryServiceItem(String itemType,String itemName,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!itemType.equals("")) where = where + " and t_serviceItem.itemType like '%" + itemType + "%'";
    	if(!itemName.equals("")) where = where + " and t_serviceItem.itemName like '%" + itemName + "%'";
    	if(!addTime.equals("")) where = where + " and t_serviceItem.addTime like '%" + addTime + "%'";
    	return serviceItemMapper.queryServiceItemList(where);
    }

    /*查询所有维修项目记录*/
    public ArrayList<ServiceItem> queryAllServiceItem()  throws Exception {
        return serviceItemMapper.queryServiceItemList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String itemType,String itemName,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(!itemType.equals("")) where = where + " and t_serviceItem.itemType like '%" + itemType + "%'";
    	if(!itemName.equals("")) where = where + " and t_serviceItem.itemName like '%" + itemName + "%'";
    	if(!addTime.equals("")) where = where + " and t_serviceItem.addTime like '%" + addTime + "%'";
        recordNumber = serviceItemMapper.queryServiceItemCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取维修项目记录*/
    public ServiceItem getServiceItem(int itemId) throws Exception  {
        ServiceItem serviceItem = serviceItemMapper.getServiceItem(itemId);
        return serviceItem;
    }

    /*更新维修项目记录*/
    public void updateServiceItem(ServiceItem serviceItem) throws Exception {
        serviceItemMapper.updateServiceItem(serviceItem);
    }

    /*删除一条维修项目记录*/
    public void deleteServiceItem (int itemId) throws Exception {
        serviceItemMapper.deleteServiceItem(itemId);
    }

    /*删除多条维修项目信息*/
    public int deleteServiceItems (String itemIds) throws Exception {
    	String _itemIds[] = itemIds.split(",");
    	for(String _itemId: _itemIds) {
    		serviceItemMapper.deleteServiceItem(Integer.parseInt(_itemId));
    	}
    	return _itemIds.length;
    }
}
