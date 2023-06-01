package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ServiceItem {
    /*项目id*/
    private Integer itemId;
    public Integer getItemId(){
        return itemId;
    }
    public void setItemId(Integer itemId){
        this.itemId = itemId;
    }

    /*项目类型*/
    @NotEmpty(message="项目类型不能为空")
    private String itemType;
    public String getItemType() {
        return itemType;
    }
    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    /*项目名称*/
    @NotEmpty(message="项目名称不能为空")
    private String itemName;
    public String getItemName() {
        return itemName;
    }
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    /*项目图片*/
    private String itemPhoto;
    public String getItemPhoto() {
        return itemPhoto;
    }
    public void setItemPhoto(String itemPhoto) {
        this.itemPhoto = itemPhoto;
    }

    /*项目介绍*/
    @NotEmpty(message="项目介绍不能为空")
    private String itemDesc;
    public String getItemDesc() {
        return itemDesc;
    }
    public void setItemDesc(String itemDesc) {
        this.itemDesc = itemDesc;
    }

    /*项目价格*/
    @NotEmpty(message="项目价格不能为空")
    private String itemPrice;
    public String getItemPrice() {
        return itemPrice;
    }
    public void setItemPrice(String itemPrice) {
        this.itemPrice = itemPrice;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonServiceItem=new JSONObject(); 
		jsonServiceItem.accumulate("itemId", this.getItemId());
		jsonServiceItem.accumulate("itemType", this.getItemType());
		jsonServiceItem.accumulate("itemName", this.getItemName());
		jsonServiceItem.accumulate("itemPhoto", this.getItemPhoto());
		jsonServiceItem.accumulate("itemDesc", this.getItemDesc());
		jsonServiceItem.accumulate("itemPrice", this.getItemPrice());
		jsonServiceItem.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonServiceItem;
    }}