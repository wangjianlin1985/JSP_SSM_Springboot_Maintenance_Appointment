<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ServiceItem" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<ServiceItem> serviceItemList = (List<ServiceItem>)request.getAttribute("serviceItemList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String itemType = (String)request.getAttribute("itemType"); //项目类型查询关键字
    String itemName = (String)request.getAttribute("itemName"); //项目名称查询关键字
    String addTime = (String)request.getAttribute("addTime"); //发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>维修项目查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>ServiceItem/frontlist">维修项目信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>ServiceItem/serviceItem_frontAdd.jsp" style="display:none;">添加维修项目</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<serviceItemList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		ServiceItem serviceItem = serviceItemList.get(i); //获取到维修项目对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>ServiceItem/<%=serviceItem.getItemId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=serviceItem.getItemPhoto()%>" /></a>
			     <div class="showFields">
			      
			     	<div class="field">
	            		项目类型:<%=serviceItem.getItemType() %>
			     	</div>
			     	<div class="field">
	            		项目名称:<%=serviceItem.getItemName() %>
			     	</div>
			     	<div class="field">
	            		项目价格:<%=serviceItem.getItemPrice() %>
			     	</div>
			     	<div class="field">
	            		发布时间:<%=serviceItem.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>ServiceItem/<%=serviceItem.getItemId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="serviceItemEdit('<%=serviceItem.getItemId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="serviceItemDelete('<%=serviceItem.getItemId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>维修项目查询</h1>
		</div>
		<form name="serviceItemQueryForm" id="serviceItemQueryForm" action="<%=basePath %>ServiceItem/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="itemType">项目类型:</label>
				<input type="text" id="itemType" name="itemType" value="<%=itemType %>" class="form-control" placeholder="请输入项目类型">
			</div>
			<div class="form-group">
				<label for="itemName">项目名称:</label>
				<input type="text" id="itemName" name="itemName" value="<%=itemName %>" class="form-control" placeholder="请输入项目名称">
			</div>
			<div class="form-group">
				<label for="addTime">发布时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择发布时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="serviceItemEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;维修项目信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="serviceItemEditForm" id="serviceItemEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="serviceItem_itemId_edit" class="col-md-3 text-right">项目id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="serviceItem_itemId_edit" name="serviceItem.itemId" class="form-control" placeholder="请输入项目id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="serviceItem_itemType_edit" class="col-md-3 text-right">项目类型:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="serviceItem_itemType_edit" name="serviceItem.itemType" class="form-control" placeholder="请输入项目类型">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="serviceItem_itemName_edit" class="col-md-3 text-right">项目名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="serviceItem_itemName_edit" name="serviceItem.itemName" class="form-control" placeholder="请输入项目名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="serviceItem_itemPhoto_edit" class="col-md-3 text-right">项目图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="serviceItem_itemPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="serviceItem_itemPhoto" name="serviceItem.itemPhoto"/>
			    <input id="itemPhotoFile" name="itemPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="serviceItem_itemDesc_edit" class="col-md-3 text-right">项目介绍:</label>
		  	 <div class="col-md-9">
			 	<textarea name="serviceItem.itemDesc" id="serviceItem_itemDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="serviceItem_itemPrice_edit" class="col-md-3 text-right">项目价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="serviceItem_itemPrice_edit" name="serviceItem.itemPrice" class="form-control" placeholder="请输入项目价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="serviceItem_addTime_edit" class="col-md-3 text-right">发布时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date serviceItem_addTime_edit col-md-12" data-link-field="serviceItem_addTime_edit">
                    <input class="form-control" id="serviceItem_addTime_edit" name="serviceItem.addTime" size="16" type="text" value="" placeholder="请选择发布时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#serviceItemEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxServiceItemModify();">提交</button>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var serviceItem_itemDesc_edit = UE.getEditor('serviceItem_itemDesc_edit'); //项目介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.serviceItemQueryForm.currentPage.value = currentPage;
    document.serviceItemQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.serviceItemQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.serviceItemQueryForm.currentPage.value = pageValue;
    documentserviceItemQueryForm.submit();
}

/*弹出修改维修项目界面并初始化数据*/
function serviceItemEdit(itemId) {
	$.ajax({
		url :  basePath + "ServiceItem/" + itemId + "/update",
		type : "get",
		dataType: "json",
		success : function (serviceItem, response, status) {
			if (serviceItem) {
				$("#serviceItem_itemId_edit").val(serviceItem.itemId);
				$("#serviceItem_itemType_edit").val(serviceItem.itemType);
				$("#serviceItem_itemName_edit").val(serviceItem.itemName);
				$("#serviceItem_itemPhoto").val(serviceItem.itemPhoto);
				$("#serviceItem_itemPhotoImg").attr("src", basePath +　serviceItem.itemPhoto);
				serviceItem_itemDesc_edit.setContent(serviceItem.itemDesc, false);
				$("#serviceItem_itemPrice_edit").val(serviceItem.itemPrice);
				$("#serviceItem_addTime_edit").val(serviceItem.addTime);
				$('#serviceItemEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除维修项目信息*/
function serviceItemDelete(itemId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "ServiceItem/deletes",
			data : {
				itemIds : itemId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#serviceItemQueryForm").submit();
					//location.href= basePath + "ServiceItem/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交维修项目信息表单给服务器端修改*/
function ajaxServiceItemModify() {
	$.ajax({
		url :  basePath + "ServiceItem/" + $("#serviceItem_itemId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#serviceItemEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#serviceItemQueryForm").submit();
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

    /*发布时间组件*/
    $('.serviceItem_addTime_edit').datetimepicker({
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

