package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Barber;

import com.chengxusheji.mapper.BarberMapper;
@Service
public class BarberService {

	@Resource BarberMapper barberMapper;
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

    /*添加维修人员记录*/
    public void addBarber(Barber barber) throws Exception {
    	barberMapper.addBarber(barber);
    }

    /*按照查询条件分页查询维修人员记录*/
    public ArrayList<Barber> queryBarber(String name,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!name.equals("")) where = where + " and t_barber.name like '%" + name + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return barberMapper.queryBarber(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Barber> queryBarber(String name) throws Exception  { 
     	String where = "where 1=1";
    	if(!name.equals("")) where = where + " and t_barber.name like '%" + name + "%'";
    	return barberMapper.queryBarberList(where);
    }

    /*查询所有维修人员记录*/
    public ArrayList<Barber> queryAllBarber()  throws Exception {
        return barberMapper.queryBarberList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String name) throws Exception {
     	String where = "where 1=1";
    	if(!name.equals("")) where = where + " and t_barber.name like '%" + name + "%'";
        recordNumber = barberMapper.queryBarberCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取维修人员记录*/
    public Barber getBarber(int barberId) throws Exception  {
        Barber barber = barberMapper.getBarber(barberId);
        return barber;
    }

    /*更新维修人员记录*/
    public void updateBarber(Barber barber) throws Exception {
        barberMapper.updateBarber(barber);
    }

    /*删除一条维修人员记录*/
    public void deleteBarber (int barberId) throws Exception {
        barberMapper.deleteBarber(barberId);
    }

    /*删除多条维修人员信息*/
    public int deleteBarbers (String barberIds) throws Exception {
    	String _barberIds[] = barberIds.split(",");
    	for(String _barberId: _barberIds) {
    		barberMapper.deleteBarber(Integer.parseInt(_barberId));
    	}
    	return _barberIds.length;
    }
}
