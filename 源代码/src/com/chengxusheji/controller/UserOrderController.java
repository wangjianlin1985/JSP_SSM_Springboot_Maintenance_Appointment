package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.UserOrderService;
import com.chengxusheji.po.UserOrder;
import com.chengxusheji.service.BarberService;
import com.chengxusheji.po.Barber;
import com.chengxusheji.service.ServiceItemService;
import com.chengxusheji.po.ServiceItem;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//UserOrder管理控制层
@Controller
@RequestMapping("/UserOrder")
public class UserOrderController extends BaseController {

    /*业务层对象*/
    @Resource UserOrderService userOrderService;

    @Resource BarberService barberService;
    @Resource ServiceItemService serviceItemService;
    @Resource UserInfoService userInfoService;
	@InitBinder("barberObj")
	public void initBinderbarberObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("barberObj.");
	}
	@InitBinder("serviceItemObj")
	public void initBinderserviceItemObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("serviceItemObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("userOrder")
	public void initBinderUserOrder(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userOrder.");
	}
	/*跳转到添加UserOrder视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new UserOrder());
		/*查询所有的Barber信息*/
		List<Barber> barberList = barberService.queryAllBarber();
		request.setAttribute("barberList", barberList);
		/*查询所有的ServiceItem信息*/
		List<ServiceItem> serviceItemList = serviceItemService.queryAllServiceItem();
		request.setAttribute("serviceItemList", serviceItemList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "UserOrder_add";
	}

	/*客户端ajax方式提交添加用户预约信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated UserOrder userOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        userOrderService.addUserOrder(userOrder);
        message = "用户预约添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*客户端ajax方式提交添加用户预约信息*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(UserOrder userOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		UserInfo userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		userOrder.setUserObj(userObj);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		userOrder.setAddTime(sdf.format(new java.util.Date()));
		
		userOrder.setShzt("待审核");
		
		userOrder.setReplyContent("--");
		
		
        userOrderService.addUserOrder(userOrder);
        message = "用户预约添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*ajax方式按照查询条件分页查询用户预约信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("barberObj") Barber barberObj,@ModelAttribute("serviceItemObj") ServiceItem serviceItemObj,String orderDate,String shzt,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (orderDate == null) orderDate = "";
		if (shzt == null) shzt = "";
		if (addTime == null) addTime = "";
		if(rows != 0)userOrderService.setRows(rows);
		List<UserOrder> userOrderList = userOrderService.queryUserOrder(barberObj, serviceItemObj, orderDate, shzt, userObj, addTime, page);
	    /*计算总的页数和总的记录数*/
	    userOrderService.queryTotalPageAndRecordNumber(barberObj, serviceItemObj, orderDate, shzt, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = userOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = userOrderService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(UserOrder userOrder:userOrderList) {
			JSONObject jsonUserOrder = userOrder.getJsonObject();
			jsonArray.put(jsonUserOrder);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询用户预约信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<UserOrder> userOrderList = userOrderService.queryAllUserOrder();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(UserOrder userOrder:userOrderList) {
			JSONObject jsonUserOrder = new JSONObject();
			jsonUserOrder.accumulate("orderId", userOrder.getOrderId());
			jsonArray.put(jsonUserOrder);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询用户预约信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("barberObj") Barber barberObj,@ModelAttribute("serviceItemObj") ServiceItem serviceItemObj,String orderDate,String shzt,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (orderDate == null) orderDate = "";
		if (shzt == null) shzt = "";
		if (addTime == null) addTime = "";
		List<UserOrder> userOrderList = userOrderService.queryUserOrder(barberObj, serviceItemObj, orderDate, shzt, userObj, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    userOrderService.queryTotalPageAndRecordNumber(barberObj, serviceItemObj, orderDate, shzt, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = userOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = userOrderService.getRecordNumber();
	    request.setAttribute("userOrderList",  userOrderList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("barberObj", barberObj);
	    request.setAttribute("serviceItemObj", serviceItemObj);
	    request.setAttribute("orderDate", orderDate);
	    request.setAttribute("shzt", shzt);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("addTime", addTime);
	    List<Barber> barberList = barberService.queryAllBarber();
	    request.setAttribute("barberList", barberList);
	    List<ServiceItem> serviceItemList = serviceItemService.queryAllServiceItem();
	    request.setAttribute("serviceItemList", serviceItemList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "UserOrder/userOrder_frontquery_result"; 
	}
	
	
	/*前台按照查询条件分页查询用户预约信息*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("barberObj") Barber barberObj,@ModelAttribute("serviceItemObj") ServiceItem serviceItemObj,String orderDate,String shzt,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (orderDate == null) orderDate = "";
		if (shzt == null) shzt = "";
		if (addTime == null) addTime = "";
		
		userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		 
		
		List<UserOrder> userOrderList = userOrderService.queryUserOrder(barberObj, serviceItemObj, orderDate, shzt, userObj, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    userOrderService.queryTotalPageAndRecordNumber(barberObj, serviceItemObj, orderDate, shzt, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = userOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = userOrderService.getRecordNumber();
	    request.setAttribute("userOrderList",  userOrderList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("barberObj", barberObj);
	    request.setAttribute("serviceItemObj", serviceItemObj);
	    request.setAttribute("orderDate", orderDate);
	    request.setAttribute("shzt", shzt);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("addTime", addTime);
	    List<Barber> barberList = barberService.queryAllBarber();
	    request.setAttribute("barberList", barberList);
	    List<ServiceItem> serviceItemList = serviceItemService.queryAllServiceItem();
	    request.setAttribute("serviceItemList", serviceItemList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "UserOrder/userOrder_userFrontquery_result"; 
	}
	

     /*前台查询UserOrder信息*/
	@RequestMapping(value="/{orderId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer orderId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键orderId获取UserOrder对象*/
        UserOrder userOrder = userOrderService.getUserOrder(orderId);

        List<Barber> barberList = barberService.queryAllBarber();
        request.setAttribute("barberList", barberList);
        List<ServiceItem> serviceItemList = serviceItemService.queryAllServiceItem();
        request.setAttribute("serviceItemList", serviceItemList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("userOrder",  userOrder);
        return "UserOrder/userOrder_frontshow";
	}

	/*ajax方式显示用户预约修改jsp视图页*/
	@RequestMapping(value="/{orderId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer orderId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键orderId获取UserOrder对象*/
        UserOrder userOrder = userOrderService.getUserOrder(orderId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonUserOrder = userOrder.getJsonObject();
		out.println(jsonUserOrder.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新用户预约信息*/
	@RequestMapping(value = "/{orderId}/update", method = RequestMethod.POST)
	public void update(@Validated UserOrder userOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			userOrderService.updateUserOrder(userOrder);
			message = "用户预约更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "用户预约更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除用户预约信息*/
	@RequestMapping(value="/{orderId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer orderId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  userOrderService.deleteUserOrder(orderId);
	            request.setAttribute("message", "用户预约删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "用户预约删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条用户预约记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String orderIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = userOrderService.deleteUserOrders(orderIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出用户预约信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("barberObj") Barber barberObj,@ModelAttribute("serviceItemObj") ServiceItem serviceItemObj,String orderDate,String shzt,@ModelAttribute("userObj") UserInfo userObj,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(orderDate == null) orderDate = "";
        if(shzt == null) shzt = "";
        if(addTime == null) addTime = "";
        List<UserOrder> userOrderList = userOrderService.queryUserOrder(barberObj,serviceItemObj,orderDate,shzt,userObj,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "UserOrder信息记录"; 
        String[] headers = { "预约id","预约维修人员","维修项目","预约服务日期","预约时间","预约用户","提交时间","审核状态"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<userOrderList.size();i++) {
        	UserOrder userOrder = userOrderList.get(i); 
        	dataset.add(new String[]{userOrder.getOrderId() + "",userOrder.getBarberObj().getName(),userOrder.getServiceItemObj().getItemName(),userOrder.getOrderDate(),userOrder.getOrderTime(),userOrder.getUserObj().getName(),userOrder.getAddTime(),userOrder.getShzt()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"UserOrder.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
