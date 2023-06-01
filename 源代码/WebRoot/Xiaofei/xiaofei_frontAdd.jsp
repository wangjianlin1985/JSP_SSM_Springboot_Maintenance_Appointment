<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Barber" %>
<%@ page import="com.chengxusheji.po.ServiceItem" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>消费记录添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Xiaofei/frontlist">消费记录列表</a></li>
			    	<li role="presentation" class="active"><a href="#xiaofeiAdd" aria-controls="xiaofeiAdd" role="tab" data-toggle="tab">添加消费记录</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="xiaofeiList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="xiaofeiAdd"> 
				      	<form class="form-horizontal" name="xiaofeiAddForm" id="xiaofeiAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="xiaofei_serviceItemObj_itemId" class="col-md-2 text-right">消费项目:</label>
						  	 <div class="col-md-8">
							    <select id="xiaofei_serviceItemObj_itemId" name="xiaofei.serviceItemObj.itemId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="xiaofei_xiaofeiMoney" class="col-md-2 text-right">消费金额:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="xiaofei_xiaofeiMoney" name="xiaofei.xiaofeiMoney" class="form-control" placeholder="请输入消费金额">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="xiaofei_userObj_user_name" class="col-md-2 text-right">消费用户:</label>
						  	 <div class="col-md-8">
							    <select id="xiaofei_userObj_user_name" name="xiaofei.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="xiaofei_xiaofeiTimeDiv" class="col-md-2 text-right">消费时间:</label>
						  	 <div class="col-md-8">
				                <div id="xiaofei_xiaofeiTimeDiv" class="input-group date xiaofei_xiaofeiTime col-md-12" data-link-field="xiaofei_xiaofeiTime">
				                    <input class="form-control" id="xiaofei_xiaofeiTime" name="xiaofei.xiaofeiTime" size="16" type="text" value="" placeholder="请选择消费时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="xiaofei_barberObj_barberId" class="col-md-2 text-right">服务维修人员:</label>
						  	 <div class="col-md-8">
							    <select id="xiaofei_barberObj_barberId" name="xiaofei.barberObj.barberId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="xiaofei_xiaofeiMemo" class="col-md-2 text-right">消费备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="xiaofei_xiaofeiMemo" name="xiaofei.xiaofeiMemo" rows="8" class="form-control" placeholder="请输入消费备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxXiaofeiAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#xiaofeiAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加消费记录信息
	function ajaxXiaofeiAdd() { 
		//提交之前先验证表单
		$("#xiaofeiAddForm").data('bootstrapValidator').validate();
		if(!$("#xiaofeiAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Xiaofei/add",
			dataType : "json" , 
			data: new FormData($("#xiaofeiAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#xiaofeiAddForm").find("input").val("");
					$("#xiaofeiAddForm").find("textarea").val("");
				} else {
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
	//验证消费记录添加表单字段
	$('#xiaofeiAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"xiaofei.xiaofeiMoney": {
				validators: {
					notEmpty: {
						message: "消费金额不能为空",
					},
					numeric: {
						message: "消费金额不正确"
					}
				}
			},
			"xiaofei.xiaofeiTime": {
				validators: {
					notEmpty: {
						message: "消费时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化消费项目下拉框值 
	$.ajax({
		url: basePath + "ServiceItem/listAll",
		type: "get",
		success: function(serviceItems,response,status) { 
			$("#xiaofei_serviceItemObj_itemId").empty();
			var html="";
    		$(serviceItems).each(function(i,serviceItem){
    			html += "<option value='" + serviceItem.itemId + "'>" + serviceItem.itemName + "</option>";
    		});
    		$("#xiaofei_serviceItemObj_itemId").html(html);
    	}
	});
	//初始化消费用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#xiaofei_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#xiaofei_userObj_user_name").html(html);
    	}
	});
	//初始化服务维修人员下拉框值 
	$.ajax({
		url: basePath + "Barber/listAll",
		type: "get",
		success: function(barbers,response,status) { 
			$("#xiaofei_barberObj_barberId").empty();
			var html="";
    		$(barbers).each(function(i,barber){
    			html += "<option value='" + barber.barberId + "'>" + barber.name + "</option>";
    		});
    		$("#xiaofei_barberObj_barberId").html(html);
    	}
	});
	//消费时间组件
	$('#xiaofei_xiaofeiTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#xiaofeiAddForm').data('bootstrapValidator').updateStatus('xiaofei.xiaofeiTime', 'NOT_VALIDATED',null).validateField('xiaofei.xiaofeiTime');
	});
})
</script>
</body>
</html>
