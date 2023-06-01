<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/xiaofei.css" />
<div id="xiaofei_editDiv">
	<form id="xiaofeiEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">消费id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="xiaofei_xiaofeiId_edit" name="xiaofei.xiaofeiId" value="<%=request.getParameter("xiaofeiId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="xiaofeiModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Xiaofei/js/xiaofei_modify.js"></script> 
