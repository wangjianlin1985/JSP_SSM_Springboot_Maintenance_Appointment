package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Barber;
import com.chengxusheji.po.Paiban;

import com.chengxusheji.mapper.PaibanMapper;
@Service
public class PaibanService {

	@Resource PaibanMapper paibanMapper;
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

    /*添加维修人员排班记录*/
    public void addPaiban(Paiban paiban) throws Exception {
    	paibanMapper.addPaiban(paiban);
    }

    /*按照查询条件分页查询维修人员排班记录*/
    public ArrayList<Paiban> queryPaiban(Barber barberObj,String paibanDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != barberObj && barberObj.getBarberId()!= null && barberObj.getBarberId()!= 0)  where += " and t_paiban.barberObj=" + barberObj.getBarberId();
    	if(!paibanDate.equals("")) where = where + " and t_paiban.paibanDate like '%" + paibanDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return paibanMapper.queryPaiban(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Paiban> queryPaiban(Barber barberObj,String paibanDate) throws Exception  { 
     	String where = "where 1=1";
    	if(null != barberObj && barberObj.getBarberId()!= null && barberObj.getBarberId()!= 0)  where += " and t_paiban.barberObj=" + barberObj.getBarberId();
    	if(!paibanDate.equals("")) where = where + " and t_paiban.paibanDate like '%" + paibanDate + "%'";
    	return paibanMapper.queryPaibanList(where);
    }

    /*查询所有维修人员排班记录*/
    public ArrayList<Paiban> queryAllPaiban()  throws Exception {
        return paibanMapper.queryPaibanList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Barber barberObj,String paibanDate) throws Exception {
     	String where = "where 1=1";
    	if(null != barberObj && barberObj.getBarberId()!= null && barberObj.getBarberId()!= 0)  where += " and t_paiban.barberObj=" + barberObj.getBarberId();
    	if(!paibanDate.equals("")) where = where + " and t_paiban.paibanDate like '%" + paibanDate + "%'";
        recordNumber = paibanMapper.queryPaibanCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取维修人员排班记录*/
    public Paiban getPaiban(int paibanId) throws Exception  {
        Paiban paiban = paibanMapper.getPaiban(paibanId);
        return paiban;
    }

    /*更新维修人员排班记录*/
    public void updatePaiban(Paiban paiban) throws Exception {
        paibanMapper.updatePaiban(paiban);
    }

    /*删除一条维修人员排班记录*/
    public void deletePaiban (int paibanId) throws Exception {
        paibanMapper.deletePaiban(paibanId);
    }

    /*删除多条维修人员排班信息*/
    public int deletePaibans (String paibanIds) throws Exception {
    	String _paibanIds[] = paibanIds.split(",");
    	for(String _paibanId: _paibanIds) {
    		paibanMapper.deletePaiban(Integer.parseInt(_paibanId));
    	}
    	return _paibanIds.length;
    }
}
