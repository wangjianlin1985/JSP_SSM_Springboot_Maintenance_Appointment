package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class UserOrder {
    /*预约id*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*预约维修人员*/
    private Barber barberObj;
    public Barber getBarberObj() {
        return barberObj;
    }
    public void setBarberObj(Barber barberObj) {
        this.barberObj = barberObj;
    }

    /*维修项目*/
    private ServiceItem serviceItemObj;
    public ServiceItem getServiceItemObj() {
        return serviceItemObj;
    }
    public void setServiceItemObj(ServiceItem serviceItemObj) {
        this.serviceItemObj = serviceItemObj;
    }

    /*预约服务日期*/
    @NotEmpty(message="预约服务日期不能为空")
    private String orderDate;
    public String getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    /*预约时间*/
    @NotEmpty(message="预约时间不能为空")
    private String orderTime;
    public String getOrderTime() {
        return orderTime;
    }
    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
    }

    /*预约用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*提交时间*/
    @NotEmpty(message="提交时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    /*订单备注*/
    private String orderMemo;
    public String getOrderMemo() {
        return orderMemo;
    }
    public void setOrderMemo(String orderMemo) {
        this.orderMemo = orderMemo;
    }

    /*审核状态*/
    @NotEmpty(message="审核状态不能为空")
    private String shzt;
    public String getShzt() {
        return shzt;
    }
    public void setShzt(String shzt) {
        this.shzt = shzt;
    }

    /*管理回复*/
    private String replyContent;
    public String getReplyContent() {
        return replyContent;
    }
    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonUserOrder=new JSONObject(); 
		jsonUserOrder.accumulate("orderId", this.getOrderId());
		jsonUserOrder.accumulate("barberObj", this.getBarberObj().getName());
		jsonUserOrder.accumulate("barberObjPri", this.getBarberObj().getBarberId());
		jsonUserOrder.accumulate("serviceItemObj", this.getServiceItemObj().getItemName());
		jsonUserOrder.accumulate("serviceItemObjPri", this.getServiceItemObj().getItemId());
		jsonUserOrder.accumulate("orderDate", this.getOrderDate().length()>19?this.getOrderDate().substring(0,19):this.getOrderDate());
		jsonUserOrder.accumulate("orderTime", this.getOrderTime());
		jsonUserOrder.accumulate("userObj", this.getUserObj().getName());
		jsonUserOrder.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonUserOrder.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		jsonUserOrder.accumulate("orderMemo", this.getOrderMemo());
		jsonUserOrder.accumulate("shzt", this.getShzt());
		jsonUserOrder.accumulate("replyContent", this.getReplyContent());
		return jsonUserOrder;
    }}