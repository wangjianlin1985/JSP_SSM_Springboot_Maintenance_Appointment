package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Paiban {
    /*排班id*/
    private Integer paibanId;
    public Integer getPaibanId(){
        return paibanId;
    }
    public void setPaibanId(Integer paibanId){
        this.paibanId = paibanId;
    }

    /*维修人员*/
    private Barber barberObj;
    public Barber getBarberObj() {
        return barberObj;
    }
    public void setBarberObj(Barber barberObj) {
        this.barberObj = barberObj;
    }

    /*排班时间*/
    @NotEmpty(message="排班时间不能为空")
    private String paibanDate;
    public String getPaibanDate() {
        return paibanDate;
    }
    public void setPaibanDate(String paibanDate) {
        this.paibanDate = paibanDate;
    }

    /*工作时间*/
    @NotEmpty(message="工作时间不能为空")
    private String workTime;
    public String getWorkTime() {
        return workTime;
    }
    public void setWorkTime(String workTime) {
        this.workTime = workTime;
    }

    /*排班备注*/
    private String paibanMemo;
    public String getPaibanMemo() {
        return paibanMemo;
    }
    public void setPaibanMemo(String paibanMemo) {
        this.paibanMemo = paibanMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPaiban=new JSONObject(); 
		jsonPaiban.accumulate("paibanId", this.getPaibanId());
		jsonPaiban.accumulate("barberObj", this.getBarberObj().getName());
		jsonPaiban.accumulate("barberObjPri", this.getBarberObj().getBarberId());
		jsonPaiban.accumulate("paibanDate", this.getPaibanDate().length()>19?this.getPaibanDate().substring(0,19):this.getPaibanDate());
		jsonPaiban.accumulate("workTime", this.getWorkTime());
		jsonPaiban.accumulate("paibanMemo", this.getPaibanMemo());
		return jsonPaiban;
    }}