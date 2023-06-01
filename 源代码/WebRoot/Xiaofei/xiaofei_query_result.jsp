<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/xiaofei.css" /> 

<div id="xiaofei_manage"></div>
<div id="xiaofei_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="xiaofei_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="xiaofei_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="xiaofei_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="xiaofei_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="xiaofei_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="xiaofeiQueryForm" method="post">
			消费项目：<input class="textbox" type="text" id="serviceItemObj_itemId_query" name="serviceItemObj.itemId" style="width: auto"/>
			消费用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			消费时间：<input type="text" id="xiaofeiTime" name="xiaofeiTime" class="easyui-datebox" editable="false" style="width:100px">
			服务维修人员：<input class="textbox" type="text" id="barberObj_barberId_query" name="barberObj.barberId" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="xiaofei_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="xiaofeiEditDiv">
	<form id="xiaofeiEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">消费id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="xiaofei_xiaofeiId_edit" name="xiaofei.xiaofeiId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">消费项目:</span>
			<span class="inputControl">
				<input class="textbox"  id="xiaofei_serviceItemObj_itemId_edit" name="xiaofei.serviceItemObj.itemId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">消费金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="xiaofei_xiaofeiMoney_edit" name="xiaofei.xiaofeiMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">消费用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="xiaofei_userObj_user_name_edit" name="xiaofei.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">消费时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="xiaofei_xiaofeiTime_edit" name="xiaofei.xiaofeiTime" />

			</span>

		</div>
		<div>
			<span class="label">服务维修人员:</span>
			<span class="inputControl">
				<input class="textbox"  id="xiaofei_barberObj_barberId_edit" name="xiaofei.barberObj.barberId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">消费备注:</span>
			<span class="inputControl">
				<textarea id="xiaofei_xiaofeiMemo_edit" name="xiaofei.xiaofeiMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Xiaofei/js/xiaofei_manage.js"></script> 
