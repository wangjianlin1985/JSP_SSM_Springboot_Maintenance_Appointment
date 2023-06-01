<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/xiaofei.css" />
<div id="xiaofeiAddDiv">
	<form id="xiaofeiAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">消费项目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="xiaofei_serviceItemObj_itemId" name="xiaofei.serviceItemObj.itemId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">消费金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="xiaofei_xiaofeiMoney" name="xiaofei.xiaofeiMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">消费用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="xiaofei_userObj_user_name" name="xiaofei.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">消费时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="xiaofei_xiaofeiTime" name="xiaofei.xiaofeiTime" />

			</span>

		</div>
		<div>
			<span class="label">服务维修人员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="xiaofei_barberObj_barberId" name="xiaofei.barberObj.barberId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">消费备注:</span>
			<span class="inputControl">
				<textarea id="xiaofei_xiaofeiMemo" name="xiaofei.xiaofeiMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="xiaofeiAddButton" class="easyui-linkbutton">添加</a>
			<a id="xiaofeiClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Xiaofei/js/xiaofei_add.js"></script> 
