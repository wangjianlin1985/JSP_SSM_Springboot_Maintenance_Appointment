$(function () {
	$("#xiaofei_serviceItemObj_itemId").combobox({
	    url:'ServiceItem/listAll',
	    valueField: "itemId",
	    textField: "itemName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#xiaofei_serviceItemObj_itemId").combobox("getData"); 
            if (data.length > 0) {
                $("#xiaofei_serviceItemObj_itemId").combobox("select", data[0].itemId);
            }
        }
	});
	$("#xiaofei_xiaofeiMoney").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入消费金额',
		invalidMessage : '消费金额输入不对',
	});

	$("#xiaofei_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#xiaofei_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#xiaofei_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#xiaofei_xiaofeiTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#xiaofei_barberObj_barberId").combobox({
	    url:'Barber/listAll',
	    valueField: "barberId",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#xiaofei_barberObj_barberId").combobox("getData"); 
            if (data.length > 0) {
                $("#xiaofei_barberObj_barberId").combobox("select", data[0].barberId);
            }
        }
	});
	//单击添加按钮
	$("#xiaofeiAddButton").click(function () {
		//验证表单 
		if(!$("#xiaofeiAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#xiaofeiAddForm").form({
			    url:"Xiaofei/add",
			    onSubmit: function(){
					if($("#xiaofeiAddForm").form("validate"))  { 
	                	$.messager.progress({
							text : "正在提交数据中...",
						}); 
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#xiaofeiAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#xiaofeiAddForm").submit();
		}
	});

	//单击清空按钮
	$("#xiaofeiClearButton").click(function () { 
		$("#xiaofeiAddForm").form("clear"); 
	});
});
