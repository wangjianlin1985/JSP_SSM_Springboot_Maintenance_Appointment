<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Xiaofei" %>
<%@ page import="com.chengxusheji.po.Barber" %>
<%@ page import="com.chengxusheji.po.ServiceItem" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的barberObj信息
    List<Barber> barberList = (List<Barber>)request.getAttribute("barberList");
    //获取所有的serviceItemObj信息
    List<ServiceItem> serviceItemList = (List<ServiceItem>)request.getAttribute("serviceItemList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Xiaofei xiaofei = (Xiaofei)request.getAttribute("xiaofei");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改消费记录信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">消费记录信息修改</li>
	</ul>
		<div class="row"> 
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
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxXiaofeiModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#xiaofeiEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
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
			} else {
				alert("获取信息失败！");
			}
		}
	});
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
                location.reload(true);
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
    xiaofeiEdit("<%=request.getParameter("xiaofeiId")%>");
 })
 </script> 
</body>
</html>

