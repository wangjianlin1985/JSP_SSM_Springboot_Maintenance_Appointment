<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.UserOrder" %>
<%@ page import="com.chengxusheji.po.Barber" %>
<%@ page import="com.chengxusheji.po.ServiceItem" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<UserOrder> userOrderList = (List<UserOrder>)request.getAttribute("userOrderList");
    //获取所有的barberObj信息
    List<Barber> barberList = (List<Barber>)request.getAttribute("barberList");
    //获取所有的serviceItemObj信息
    List<ServiceItem> serviceItemList = (List<ServiceItem>)request.getAttribute("serviceItemList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Barber barberObj = (Barber)request.getAttribute("barberObj");
    ServiceItem serviceItemObj = (ServiceItem)request.getAttribute("serviceItemObj");
    String orderDate = (String)request.getAttribute("orderDate"); //预约服务日期查询关键字
    String shzt = (String)request.getAttribute("shzt"); //审核状态查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String addTime = (String)request.getAttribute("addTime"); //提交时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>用户预约查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#userOrderListPanel" aria-controls="userOrderListPanel" role="tab" data-toggle="tab">用户预约列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>UserOrder/userOrder_frontAdd.jsp" style="display:none;">添加用户预约</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="userOrderListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>维修项目</td><td>预约维修人员</td><td>预约服务日期</td><td>预约时间</td><td>提交时间</td><td>审核状态</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<userOrderList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		UserOrder userOrder = userOrderList.get(i); //获取到用户预约对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=userOrder.getServiceItemObj().getItemName() %></td>
 											<td><%=userOrder.getBarberObj().getName() %></td>
 											<td><%=userOrder.getOrderDate() %></td>
 											<td><%=userOrder.getOrderTime() %></td>
 											<td><%=userOrder.getAddTime() %></td>
 											<td><%=userOrder.getShzt() %></td>
 											<td>
 												<a href="<%=basePath  %>UserOrder/<%=userOrder.getOrderId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="userOrderEdit('<%=userOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="userOrderDelete('<%=userOrder.getOrderId() %>');" ><i class="fa fa-trash-o fa-fw"></i>取消预约</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>用户预约查询</h1>
		</div>
		<form name="userOrderQueryForm" id="userOrderQueryForm" action="<%=basePath %>UserOrder/userFrontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="barberObj_barberId">预约维修人员：</label>
                <select id="barberObj_barberId" name="barberObj.barberId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Barber barberTemp:barberList) {
	 					String selected = "";
 					if(barberObj!=null && barberObj.getBarberId()!=null && barberObj.getBarberId().intValue()==barberTemp.getBarberId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=barberTemp.getBarberId() %>" <%=selected %>><%=barberTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="serviceItemObj_itemId">维修项目：</label>
                <select id="serviceItemObj_itemId" name="serviceItemObj.itemId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(ServiceItem serviceItemTemp:serviceItemList) {
	 					String selected = "";
 					if(serviceItemObj!=null && serviceItemObj.getItemId()!=null && serviceItemObj.getItemId().intValue()==serviceItemTemp.getItemId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=serviceItemTemp.getItemId() %>" <%=selected %>><%=serviceItemTemp.getItemName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="orderDate">预约服务日期:</label>
				<input type="text" id="orderDate" name="orderDate" class="form-control"  placeholder="请选择预约服务日期" value="<%=orderDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="shzt">审核状态:</label>
				<input type="text" id="shzt" name="shzt" value="<%=shzt %>" class="form-control" placeholder="请输入审核状态">
			</div>

 

            <div class="form-group" style="display:none;">
            	<label for="userObj_user_name">预约用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="addTime">提交时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择提交时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="userOrderEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;用户预约信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="userOrderEditForm" id="userOrderEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="userOrder_orderId_edit" class="col-md-3 text-right">预约id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="userOrder_orderId_edit" name="userOrder.orderId" class="form-control" placeholder="请输入预约id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="userOrder_barberObj_barberId_edit" class="col-md-3 text-right">预约维修人员:</label>
		  	 <div class="col-md-9">
			    <select id="userOrder_barberObj_barberId_edit" name="userOrder.barberObj.barberId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userOrder_serviceItemObj_itemId_edit" class="col-md-3 text-right">维修项目:</label>
		  	 <div class="col-md-9">
			    <select id="userOrder_serviceItemObj_itemId_edit" name="userOrder.serviceItemObj.itemId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userOrder_orderDate_edit" class="col-md-3 text-right">预约服务日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date userOrder_orderDate_edit col-md-12" data-link-field="userOrder_orderDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="userOrder_orderDate_edit" name="userOrder.orderDate" size="16" type="text" value="" placeholder="请选择预约服务日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userOrder_orderTime_edit" class="col-md-3 text-right">预约时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="userOrder_orderTime_edit" name="userOrder.orderTime" class="form-control" placeholder="请输入预约时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userOrder_userObj_user_name_edit" class="col-md-3 text-right">预约用户:</label>
		  	 <div class="col-md-9">
			    <select id="userOrder_userObj_user_name_edit" name="userOrder.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userOrder_addTime_edit" class="col-md-3 text-right">提交时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date userOrder_addTime_edit col-md-12" data-link-field="userOrder_addTime_edit">
                    <input class="form-control" id="userOrder_addTime_edit" name="userOrder.addTime" size="16" type="text" value="" placeholder="请选择提交时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userOrder_orderMemo_edit" class="col-md-3 text-right">订单备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="userOrder_orderMemo_edit" name="userOrder.orderMemo" rows="8" class="form-control" placeholder="请输入订单备注"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userOrder_shzt_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="userOrder_shzt_edit" name="userOrder.shzt" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="userOrder_replyContent_edit" class="col-md-3 text-right">管理回复:</label>
		  	 <div class="col-md-9">
			    <textarea id="userOrder_replyContent_edit" name="userOrder.replyContent" rows="8" class="form-control" placeholder="请输入管理回复"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#userOrderEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxUserOrderModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.userOrderQueryForm.currentPage.value = currentPage;
    document.userOrderQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.userOrderQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.userOrderQueryForm.currentPage.value = pageValue;
    documentuserOrderQueryForm.submit();
}

/*弹出修改用户预约界面并初始化数据*/
function userOrderEdit(orderId) {
	$.ajax({
		url :  basePath + "UserOrder/" + orderId + "/update",
		type : "get",
		dataType: "json",
		success : function (userOrder, response, status) {
			if (userOrder) {
				$("#userOrder_orderId_edit").val(userOrder.orderId);
				$.ajax({
					url: basePath + "Barber/listAll",
					type: "get",
					success: function(barbers,response,status) { 
						$("#userOrder_barberObj_barberId_edit").empty();
						var html="";
		        		$(barbers).each(function(i,barber){
		        			html += "<option value='" + barber.barberId + "'>" + barber.name + "</option>";
		        		});
		        		$("#userOrder_barberObj_barberId_edit").html(html);
		        		$("#userOrder_barberObj_barberId_edit").val(userOrder.barberObjPri);
					}
				});
				$.ajax({
					url: basePath + "ServiceItem/listAll",
					type: "get",
					success: function(serviceItems,response,status) { 
						$("#userOrder_serviceItemObj_itemId_edit").empty();
						var html="";
		        		$(serviceItems).each(function(i,serviceItem){
		        			html += "<option value='" + serviceItem.itemId + "'>" + serviceItem.itemName + "</option>";
		        		});
		        		$("#userOrder_serviceItemObj_itemId_edit").html(html);
		        		$("#userOrder_serviceItemObj_itemId_edit").val(userOrder.serviceItemObjPri);
					}
				});
				$("#userOrder_orderDate_edit").val(userOrder.orderDate);
				$("#userOrder_orderTime_edit").val(userOrder.orderTime);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#userOrder_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#userOrder_userObj_user_name_edit").html(html);
		        		$("#userOrder_userObj_user_name_edit").val(userOrder.userObjPri);
					}
				});
				$("#userOrder_addTime_edit").val(userOrder.addTime);
				$("#userOrder_orderMemo_edit").val(userOrder.orderMemo);
				$("#userOrder_shzt_edit").val(userOrder.shzt);
				$("#userOrder_replyContent_edit").val(userOrder.replyContent);
				$('#userOrderEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除用户预约信息*/
function userOrderDelete(orderId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "UserOrder/deletes",
			data : {
				orderIds : orderId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#userOrderQueryForm").submit();
					//location.href= basePath + "UserOrder/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交用户预约信息表单给服务器端修改*/
function ajaxUserOrderModify() {
	$.ajax({
		url :  basePath + "UserOrder/" + $("#userOrder_orderId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#userOrderEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#userOrderQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

    /*预约服务日期组件*/
    $('.userOrder_orderDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    /*提交时间组件*/
    $('.userOrder_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

