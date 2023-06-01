package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Xiaofei {
    /*消费id*/
    private Integer xiaofeiId;
    public Integer getXiaofeiId(){
        return xiaofeiId;
    }
    public void setXiaofeiId(Integer xiaofeiId){
        this.xiaofeiId = xiaofeiId;
    }

    /*消费项目*/
    private ServiceItem serviceItemObj;
    public ServiceItem getServiceItemObj() {
        return serviceItemObj;
    }
    public void setServiceItemObj(ServiceItem serviceItemObj) {
        this.serviceItemObj = serviceItemObj;
    }

    /*消费金额*/
    @NotNull(message="必须输入消费金额")
    private Float xiaofeiMoney;
    public Float getXiaofeiMoney() {
        return xiaofeiMoney;
    }
    public void setXiaofeiMoney(Float xiaofeiMoney) {
        this.xiaofeiMoney = xiaofeiMoney;
    }

    /*消费用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*消费时间*/
    @NotEmpty(message="消费时间不能为空")
    private String xiaofeiTime;
    public String getXiaofeiTime() {
        return xiaofeiTime;
    }
    public void setXiaofeiTime(String xiaofeiTime) {
        this.xiaofeiTime = xiaofeiTime;
    }

    /*服务维修人员*/
    private Barber barberObj;
    public Barber getBarberObj() {
        return barberObj;
    }
    public void setBarberObj(Barber barberObj) {
        this.barberObj = barberObj;
    }

    /*消费备注*/
    private String xiaofeiMemo;
    public String getXiaofeiMemo() {
        return xiaofeiMemo;
    }
    public void setXiaofeiMemo(String xiaofeiMemo) {
        this.xiaofeiMemo = xiaofeiMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonXiaofei=new JSONObject(); 
		jsonXiaofei.accumulate("xiaofeiId", this.getXiaofeiId());
		jsonXiaofei.accumulate("serviceItemObj", this.getServiceItemObj().getItemName());
		jsonXiaofei.accumulate("serviceItemObjPri", this.getServiceItemObj().getItemId());
		jsonXiaofei.accumulate("xiaofeiMoney", this.getXiaofeiMoney());
		jsonXiaofei.accumulate("userObj", this.getUserObj().getName());
		jsonXiaofei.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonXiaofei.accumulate("xiaofeiTime", this.getXiaofeiTime().length()>19?this.getXiaofeiTime().substring(0,19):this.getXiaofeiTime());
		jsonXiaofei.accumulate("barberObj", this.getBarberObj().getName());
		jsonXiaofei.accumulate("barberObjPri", this.getBarberObj().getBarberId());
		jsonXiaofei.accumulate("xiaofeiMemo", this.getXiaofeiMemo());
		return jsonXiaofei;
    }}