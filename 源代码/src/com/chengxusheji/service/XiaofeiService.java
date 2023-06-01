package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ServiceItem;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Barber;
import com.chengxusheji.po.Xiaofei;

import com.chengxusheji.mapper.XiaofeiMapper;
@Service
public class XiaofeiService {

	@Resource XiaofeiMapper xiaofeiMapper;
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

    /*添加消费记录记录*/
    public void addXiaofei(Xiaofei xiaofei) throws Exception {
    	xiaofeiMapper.addXiaofei(xiaofei);
    }

    /*按照查询条件分页查询消费记录记录*/
    public ArrayList<Xiaofei> queryXiaofei(ServiceItem serviceItemObj,UserInfo userObj,String xiaofeiTime,Barber barberObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != serviceItemObj && serviceItemObj.getItemId()!= null && serviceItemObj.getItemId()!= 0)  where += " and t_xiaofei.serviceItemObj=" + serviceItemObj.getItemId();
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_xiaofei.userObj='" + userObj.getUser_name() + "'";
    	if(!xiaofeiTime.equals("")) where = where + " and t_xiaofei.xiaofeiTime like '%" + xiaofeiTime + "%'";
    	if(null != barberObj && barberObj.getBarberId()!= null && barberObj.getBarberId()!= 0)  where += " and t_xiaofei.barberObj=" + barberObj.getBarberId();
    	int startIndex = (currentPage-1) * this.rows;
    	return xiaofeiMapper.queryXiaofei(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Xiaofei> queryXiaofei(ServiceItem serviceItemObj,UserInfo userObj,String xiaofeiTime,Barber barberObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != serviceItemObj && serviceItemObj.getItemId()!= null && serviceItemObj.getItemId()!= 0)  where += " and t_xiaofei.serviceItemObj=" + serviceItemObj.getItemId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_xiaofei.userObj='" + userObj.getUser_name() + "'";
    	if(!xiaofeiTime.equals("")) where = where + " and t_xiaofei.xiaofeiTime like '%" + xiaofeiTime + "%'";
    	if(null != barberObj && barberObj.getBarberId()!= null && barberObj.getBarberId()!= 0)  where += " and t_xiaofei.barberObj=" + barberObj.getBarberId();
    	return xiaofeiMapper.queryXiaofeiList(where);
    }

    /*查询所有消费记录记录*/
    public ArrayList<Xiaofei> queryAllXiaofei()  throws Exception {
        return xiaofeiMapper.queryXiaofeiList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(ServiceItem serviceItemObj,UserInfo userObj,String xiaofeiTime,Barber barberObj) throws Exception {
     	String where = "where 1=1";
    	if(null != serviceItemObj && serviceItemObj.getItemId()!= null && serviceItemObj.getItemId()!= 0)  where += " and t_xiaofei.serviceItemObj=" + serviceItemObj.getItemId();
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_xiaofei.userObj='" + userObj.getUser_name() + "'";
    	if(!xiaofeiTime.equals("")) where = where + " and t_xiaofei.xiaofeiTime like '%" + xiaofeiTime + "%'";
    	if(null != barberObj && barberObj.getBarberId()!= null && barberObj.getBarberId()!= 0)  where += " and t_xiaofei.barberObj=" + barberObj.getBarberId();
        recordNumber = xiaofeiMapper.queryXiaofeiCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取消费记录记录*/
    public Xiaofei getXiaofei(int xiaofeiId) throws Exception  {
        Xiaofei xiaofei = xiaofeiMapper.getXiaofei(xiaofeiId);
        return xiaofei;
    }

    /*更新消费记录记录*/
    public void updateXiaofei(Xiaofei xiaofei) throws Exception {
        xiaofeiMapper.updateXiaofei(xiaofei);
    }

    /*删除一条消费记录记录*/
    public void deleteXiaofei (int xiaofeiId) throws Exception {
        xiaofeiMapper.deleteXiaofei(xiaofeiId);
    }

    /*删除多条消费记录信息*/
    public int deleteXiaofeis (String xiaofeiIds) throws Exception {
    	String _xiaofeiIds[] = xiaofeiIds.split(",");
    	for(String _xiaofeiId: _xiaofeiIds) {
    		xiaofeiMapper.deleteXiaofei(Integer.parseInt(_xiaofeiId));
    	}
    	return _xiaofeiIds.length;
    }
}
