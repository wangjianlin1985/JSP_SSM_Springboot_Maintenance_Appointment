var xiaofei_manage_tool = null; 
$(function () { 
	initXiaofeiManageTool(); //建立Xiaofei管理对象
	xiaofei_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#xiaofei_manage").datagrid({
		url : 'Xiaofei/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "xiaofeiId",
		sortOrder : "desc",
		toolbar : "#xiaofei_manage_tool",
		columns : [[
			{
				field : "xiaofeiId",
				title : "消费id",
				width : 70,
			},
			{
				field : "serviceItemObj",
				title : "消费项目",
				width : 140,
			},
			{
				field : "xiaofeiMoney",
				title : "消费金额",
				width : 70,
			},
			{
				field : "userObj",
				title : "消费用户",
				width : 140,
			},
			{
				field : "xiaofeiTime",
				title : "消费时间",
				width : 140,
			},
			{
				field : "barberObj",
				title : "服务维修人员",
				width : 140,
			},
		]],
	});

	$("#xiaofeiEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#xiaofeiEditForm").form("validate")) {
					//验证表单 
					if(!$("#xiaofeiEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#xiaofeiEditForm").form({
						    url:"Xiaofei/" + $("#xiaofei_xiaofeiId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#xiaofeiEditDiv").dialog("close");
			                        xiaofei_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#xiaofeiEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#xiaofeiEditDiv").dialog("close");
				$("#xiaofeiEditForm").form("reset"); 
			},
		}],
	});
});

function initXiaofeiManageTool() {
	xiaofei_manage_tool = {
		init: function() {
			$.ajax({
				url : "ServiceItem/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#serviceItemObj_itemId_query").combobox({ 
					    valueField:"itemId",
					    textField:"itemName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{itemId:0,itemName:"不限制"});
					$("#serviceItemObj_itemId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Barber/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#barberObj_barberId_query").combobox({ 
					    valueField:"barberId",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{barberId:0,name:"不限制"});
					$("#barberObj_barberId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#xiaofei_manage").datagrid("reload");
		},
		redo : function () {
			$("#xiaofei_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#xiaofei_manage").datagrid("options").queryParams;
			queryParams["serviceItemObj.itemId"] = $("#serviceItemObj_itemId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["xiaofeiTime"] = $("#xiaofeiTime").datebox("getValue"); 
			queryParams["barberObj.barberId"] = $("#barberObj_barberId_query").combobox("getValue");
			$("#xiaofei_manage").datagrid("options").queryParams=queryParams; 
			$("#xiaofei_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#xiaofeiQueryForm").form({
			    url:"Xiaofei/OutToExcel",
			});
			//提交表单
			$("#xiaofeiQueryForm").submit();
		},
		remove : function () {
			var rows = $("#xiaofei_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var xiaofeiIds = [];
						for (var i = 0; i < rows.length; i ++) {
							xiaofeiIds.push(rows[i].xiaofeiId);
						}
						$.ajax({
							type : "POST",
							url : "Xiaofei/deletes",
							data : {
								xiaofeiIds : xiaofeiIds.join(","),
							},
							beforeSend : function () {
								$("#xiaofei_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#xiaofei_manage").datagrid("loaded");
									$("#xiaofei_manage").datagrid("load");
									$("#xiaofei_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#xiaofei_manage").datagrid("loaded");
									$("#xiaofei_manage").datagrid("load");
									$("#xiaofei_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#xiaofei_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Xiaofei/" + rows[0].xiaofeiId +  "/update",
					type : "get",
					data : {
						//xiaofeiId : rows[0].xiaofeiId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (xiaofei, response, status) {
						$.messager.progress("close");
						if (xiaofei) { 
							$("#xiaofeiEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
