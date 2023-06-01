<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Paiban" %>
<%@ page import="com.chengxusheji.po.Barber" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Paiban> paibanList = (List<Paiban>)request.getAttribute("paibanList");
    //获取所有的barberObj信息
    List<Barber> barberList = (List<Barber>)request.getAttribute("barberList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Barber barberObj = (Barber)request.getAttribute("barberObj");
    String paibanDate = (String)request.getAttribute("paibanDate"); //排班时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>维修人员排班查询</title>
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
			    	<li role="presentation" class="active"><a href="#paibanListPanel" aria-controls="paibanListPanel" role="tab" data-toggle="tab">维修人员排班列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Paiban/paiban_frontAdd.jsp" style="display:none;">添加维修人员排班</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="paibanListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>排班id</td><td>维修人员</td><td>排班时间</td><td>工作时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<paibanList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Paiban paiban = paibanList.get(i); //获取到维修人员排班对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=paiban.getPaibanId() %></td>
 											<td><%=paiban.getBarberObj().getName() %></td>
 											<td><%=paiban.getPaibanDate() %></td>
 											<td><%=paiban.getWorkTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Paiban/<%=paiban.getPaibanId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="paibanEdit('<%=paiban.getPaibanId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="paibanDelete('<%=paiban.getPaibanId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>维修人员排班查询</h1>
		</div>
		<form name="paibanQueryForm" id="paibanQueryForm" action="<%=basePath %>Paiban/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="barberObj_barberId">维修人员：</label>
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
				<label for="paibanDate">排班时间:</label>
				<input type="text" id="paibanDate" name="paibanDate" class="form-control"  placeholder="请选择排班时间" value="<%=paibanDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="paibanEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;维修人员排班信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="paibanEditForm" id="paibanEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="paiban_paibanId_edit" class="col-md-3 text-right">排班id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="paiban_paibanId_edit" name="paiban.paibanId" class="form-control" placeholder="请输入排班id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="paiban_barberObj_barberId_edit" class="col-md-3 text-right">维修人员:</label>
		  	 <div class="col-md-9">
			    <select id="paiban_barberObj_barberId_edit" name="paiban.barberObj.barberId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="paiban_paibanDate_edit" class="col-md-3 text-right">排班时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date paiban_paibanDate_edit col-md-12" data-link-field="paiban_paibanDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="paiban_paibanDate_edit" name="paiban.paibanDate" size="16" type="text" value="" placeholder="请选择排班时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="paiban_workTime_edit" class="col-md-3 text-right">工作时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="paiban_workTime_edit" name="paiban.workTime" class="form-control" placeholder="请输入工作时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="paiban_paibanMemo_edit" class="col-md-3 text-right">排班备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="paiban_paibanMemo_edit" name="paiban.paibanMemo" rows="8" class="form-control" placeholder="请输入排班备注"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#paibanEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxPaibanModify();">提交</button>
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
    document.paibanQueryForm.currentPage.value = currentPage;
    document.paibanQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.paibanQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.paibanQueryForm.currentPage.value = pageValue;
    documentpaibanQueryForm.submit();
}

/*弹出修改维修人员排班界面并初始化数据*/
function paibanEdit(paibanId) {
	$.ajax({
		url :  basePath + "Paiban/" + paibanId + "/update",
		type : "get",
		dataType: "json",
		success : function (paiban, response, status) {
			if (paiban) {
				$("#paiban_paibanId_edit").val(paiban.paibanId);
				$.ajax({
					url: basePath + "Barber/listAll",
					type: "get",
					success: function(barbers,response,status) { 
						$("#paiban_barberObj_barberId_edit").empty();
						var html="";
		        		$(barbers).each(function(i,barber){
		        			html += "<option value='" + barber.barberId + "'>" + barber.name + "</option>";
		        		});
		        		$("#paiban_barberObj_barberId_edit").html(html);
		        		$("#paiban_barberObj_barberId_edit").val(paiban.barberObjPri);
					}
				});
				$("#paiban_paibanDate_edit").val(paiban.paibanDate);
				$("#paiban_workTime_edit").val(paiban.workTime);
				$("#paiban_paibanMemo_edit").val(paiban.paibanMemo);
				$('#paibanEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除维修人员排班信息*/
function paibanDelete(paibanId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Paiban/deletes",
			data : {
				paibanIds : paibanId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#paibanQueryForm").submit();
					//location.href= basePath + "Paiban/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交维修人员排班信息表单给服务器端修改*/
function ajaxPaibanModify() {
	$.ajax({
		url :  basePath + "Paiban/" + $("#paiban_paibanId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#paibanEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#paibanQueryForm").submit();
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

    /*排班时间组件*/
    $('.paiban_paibanDate_edit').datetimepicker({
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
})
</script>
</body>
</html>

