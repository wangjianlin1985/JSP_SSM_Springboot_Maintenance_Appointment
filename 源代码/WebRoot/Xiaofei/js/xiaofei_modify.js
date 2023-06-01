$(function () {
	$.ajax({
		url : "Xiaofei/" + $("#xiaofei_xiaofeiId_edit").val() + "/update",
		type : "get",
		data : {
			//xiaofeiId : $("#xiaofei_xiaofeiId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (xiaofei, response, status) {
			$.messager.progress("close");
			if (xiaofei) { 
				$("#xiaofei_xiaofeiId_edit").val(xiaofei.xiaofeiId);
				$("#xiaofei_xiaofeiId_edit").validatebox({
					required : true,
					missingMessage : "请输入消费id",
					editable: false
				});
				$("#xiaofei_serviceItemObj_itemId_edit").combobox({
					url:"ServiceItem/listAll",
					valueField:"itemId",
					textField:"itemName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#xiaofei_serviceItemObj_itemId_edit").combobox("select", xiaofei.serviceItemObjPri);
						//var data = $("#xiaofei_serviceItemObj_itemId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#xiaofei_serviceItemObj_itemId_edit").combobox("select", data[0].itemId);
						//}
					}
				});
				$("#xiaofei_xiaofeiMoney_edit").val(xiaofei.xiaofeiMoney);
				$("#xiaofei_xiaofeiMoney_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入消费金额",
					invalidMessage : "消费金额输入不对",
				});
				$("#xiaofei_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#xiaofei_userObj_user_name_edit").combobox("select", xiaofei.userObjPri);
						//var data = $("#xiaofei_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#xiaofei_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#xiaofei_xiaofeiTime_edit").datetimebox({
					value: xiaofei.xiaofeiTime,
					required: true,
					showSeconds: true,
				});
				$("#xiaofei_barberObj_barberId_edit").combobox({
					url:"Barber/listAll",
					valueField:"barberId",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#xiaofei_barberObj_barberId_edit").combobox("select", xiaofei.barberObjPri);
						//var data = $("#xiaofei_barberObj_barberId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#xiaofei_barberObj_barberId_edit").combobox("select", data[0].barberId);
						//}
					}
				});
				$("#xiaofei_xiaofeiMemo_edit").val(xiaofei.xiaofeiMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#xiaofeiModifyButton").click(function(){ 
		if ($("#xiaofeiEditForm").form("validate")) {
			$("#xiaofeiEditForm").form({
			    url:"Xiaofei/" +  $("#xiaofei_xiaofeiId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#xiaofeiEditForm").form("validate"))  {
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#xiaofeiEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
