<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Xiaofei" %>
<%@ page import="com.chengxusheji.po.Barber" %>
<%@ page import="com.chengxusheji.po.ServiceItem" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Xiaofei> xiaofeiList = (List<Xiaofei>)request.getAttribute("xiaofeiList");
    //获取所有的barberObj信息
    List<Barber> barberList = (List<Barber>)request.getAttribute("barberList");
    //获取所有的serviceItemObj信息
    List<ServiceItem> serviceItemList = (List<ServiceItem>)request.getAttribute("serviceItemList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    ServiceItem serviceItemObj = (ServiceItem)request.getAttribute("serviceItemObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String xiaofeiTime = (String)request.getAttribute("xiaofeiTime"); //消费时间查询关键字
    Barber barberObj = (Barber)request.getAttribute("barberObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>消费记录查询</title>
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
			    	<li role="presentation" class="active"><a href="#xiaofeiListPanel" aria-controls="xiaofeiListPanel" role="tab" data-toggle="tab">消费记录列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Xiaofei/xiaofei_frontAdd.jsp" style="display:none;">添加消费记录</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="xiaofeiListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>消费id</td><td>消费项目</td><td>消费金额</td><td>消费用户</td><td>消费时间</td><td>服务维修人员</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<xiaofeiList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Xiaofei xiaofei = xiaofeiList.get(i); //获取到消费记录对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=xiaofei.getXiaofeiId() %></td>
 											<td><%=xiaofei.getServiceItemObj().getItemName() %></td>
 											<td><%=xiaofei.getXiaofeiMoney() %></td>
 											<td><%=xiaofei.getUserObj().getName() %></td>
 											<td><%=xiaofei.getXiaofeiTime() %></td>
 											<td><%=xiaofei.getBarberObj().getName() %></td>
 											<td>
 												<a href="<%=basePath  %>Xiaofei/<%=xiaofei.getXiaofeiId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="xiaofeiEdit('<%=xiaofei.getXiaofeiId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="xiaofeiDelete('<%=xiaofei.getXiaofeiId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>消费记录查询</h1>
		</div>
		<form name="xiaofeiQueryForm" id="xiaofeiQueryForm" action="<%=basePath %>Xiaofei/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="serviceItemObj_itemId">消费项目：</label>
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
            	<label for="userObj_user_name">消费用户：</label>
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
				<label for="xiaofeiTime">消费时间:</label>
				<input type="text" id="xiaofeiTime" name="xiaofeiTime" class="form-control"  placeholder="请选择消费时间" value="<%=xiaofeiTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="barberObj_barberId">服务维修人员：</label>
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
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="xiaofeiEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;消费记录信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="xiaofeiEditForm" id="xiaofeiEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="xiaofei_xiaofeiId_edit" class="col-md-3 text-right">消费id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="xiaofei_xiaofeiId_edit" name="xiaofei.xiaofeiId" class="form-control" placeholder="请输入消费id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="xiaofei_serviceItemObj_itemId_edit" class="col-md-3 text-right">消费项目:</label>
		  	 <div class="col-md-9">
			    <select id="xiaofei_serviceItemObj_itemId_edit" name="xiaofei.serviceItemObj.itemId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xiaofei_xiaofeiMoney_edit" class="col-md-3 text-right">消费金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="xiaofei_xiaofeiMoney_edit" name="xiaofei.xiaofeiMoney" class="form-control" placeholder="请输入消费金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xiaofei_userObj_user_name_edit" class="col-md-3 text-right">消费用户:</label>
		  	 <div class="col-md-9">
			    <select id="xiaofei_userObj_user_name_edit" name="xiaofei.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xiaofei_xiaofeiTime_edit" class="col-md-3 text-right">消费时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date xiaofei_xiaofeiTime_edit col-md-12" data-link-field="xiaofei_xiaofeiTime_edit">
                    <input class="form-control" id="xiaofei_xiaofeiTime_edit" name="xiaofei.xiaofeiTime" size="16" type="text" value="" placeholder="请选择消费时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xiaofei_barberObj_barberId_edit" class="col-md-3 text-right">服务维修人员:</label>
		  	 <div class="col-md-9">
			    <select id="xiaofei_barberObj_barberId_edit" name="xiaofei.barberObj.barberId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xiaofei_xiaofeiMemo_edit" class="col-md-3 text-right">消费备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="xiaofei_xiaofeiMemo_edit" name="xiaofei.xiaofeiMemo" rows="8" class="form-control" placeholder="请输入消费备注"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#xiaofeiEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxXiaofeiModify();">提交</button>
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
    document.xiaofeiQueryForm.currentPage.value = currentPage;
    document.xiaofeiQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.xiaofeiQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.xiaofeiQueryForm.currentPage.value = pageValue;
    documentxiaofeiQueryForm.submit();
}

/*弹出修改消费记录界面并初始化数据*/
function xiaofeiEdit(xiaofeiId) {
	$.ajax({
		url :  basePath + "Xiaofei/" + xiaofeiId + "/update",
		type : "get",
		dataType: "json",
		success : function (xiaofei, response, status) {
			if (xiaofei) {
				$("#xiaofei_xiaofeiId_edit").val(xiaofei.xiaofeiId);
				$.ajax({
					url: basePath + "ServiceItem/listAll",
					type: "get",
					success: function(serviceItems,response,status) { 
						$("#xiaofei_serviceItemObj_itemId_edit").empty();
						var html="";
		        		$(serviceItems).each(function(i,serviceItem){
		        			html += "<option value='" + serviceItem.itemId + "'>" + serviceItem.itemName + "</option>";
		        		});
		        		$("#xiaofei_serviceItemObj_itemId_edit").html(html);
		        		$("#xiaofei_serviceItemObj_itemId_edit").val(xiaofei.serviceItemObjPri);
					}
				});
				$("#xiaofei_xiaofeiMoney_edit").val(xiaofei.xiaofeiMoney);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#xiaofei_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#xiaofei_userObj_user_name_edit").html(html);
		        		$("#xiaofei_userObj_user_name_edit").val(xiaofei.userObjPri);
					}
				});
				$("#xiaofei_xiaofeiTime_edit").val(xiaofei.xiaofeiTime);
				$.ajax({
					url: basePath + "Barber/listAll",
					type: "get",
					success: function(barbers,response,status) { 
						$("#xiaofei_barberObj_barberId_edit").empty();
						var html="";
		        		$(barbers).each(function(i,barber){
		        			html += "<option value='" + barber.barberId + "'>" + barber.name + "</option>";
		        		});
		        		$("#xiaofei_barberObj_barberId_edit").html(html);
		        		$("#xiaofei_barberObj_barberId_edit").val(xiaofei.barberObjPri);
					}
				});
				$("#xiaofei_xiaofeiMemo_edit").val(xiaofei.xiaofeiMemo);
				$('#xiaofeiEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除消费记录信息*/
function xiaofeiDelete(xiaofeiId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Xiaofei/deletes",
			data : {
				xiaofeiIds : xiaofeiId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#xiaofeiQueryForm").submit();
					//location.href= basePath + "Xiaofei/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交消费记录信息表单给服务器端修改*/
function ajaxXiaofeiModify() {
	$.ajax({
		url :  basePath + "Xiaofei/" + $("#xiaofei_xiaofeiId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#xiaofeiEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#xiaofeiQueryForm").submit();
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

    /*消费时间组件*/
    $('.xiaofei_xiaofeiTime_edit').datetimepicker({
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

