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
import com.chengxusheji.service.ServiceItemService;
import com.chengxusheji.po.ServiceItem;

//ServiceItem管理控制层
@Controller
@RequestMapping("/ServiceItem")
public class ServiceItemController extends BaseController {

    /*业务层对象*/
    @Resource ServiceItemService serviceItemService;

	@InitBinder("serviceItem")
	public void initBinderServiceItem(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("serviceItem.");
	}
	/*跳转到添加ServiceItem视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ServiceItem());
		return "ServiceItem_add";
	}

	/*客户端ajax方式提交添加维修项目信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ServiceItem serviceItem, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			serviceItem.setItemPhoto(this.handlePhotoUpload(request, "itemPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        serviceItemService.addServiceItem(serviceItem);
        message = "维修项目添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询维修项目信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String itemType,String itemName,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (itemType == null) itemType = "";
		if (itemName == null) itemName = "";
		if (addTime == null) addTime = "";
		if(rows != 0)serviceItemService.setRows(rows);
		List<ServiceItem> serviceItemList = serviceItemService.queryServiceItem(itemType, itemName, addTime, page);
	    /*计算总的页数和总的记录数*/
	    serviceItemService.queryTotalPageAndRecordNumber(itemType, itemName, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = serviceItemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = serviceItemService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ServiceItem serviceItem:serviceItemList) {
			JSONObject jsonServiceItem = serviceItem.getJsonObject();
			jsonArray.put(jsonServiceItem);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询维修项目信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ServiceItem> serviceItemList = serviceItemService.queryAllServiceItem();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ServiceItem serviceItem:serviceItemList) {
			JSONObject jsonServiceItem = new JSONObject();
			jsonServiceItem.accumulate("itemId", serviceItem.getItemId());
			jsonServiceItem.accumulate("itemName", serviceItem.getItemName());
			jsonArray.put(jsonServiceItem);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询维修项目信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String itemType,String itemName,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (itemType == null) itemType = "";
		if (itemName == null) itemName = "";
		if (addTime == null) addTime = "";
		List<ServiceItem> serviceItemList = serviceItemService.queryServiceItem(itemType, itemName, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    serviceItemService.queryTotalPageAndRecordNumber(itemType, itemName, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = serviceItemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = serviceItemService.getRecordNumber();
	    request.setAttribute("serviceItemList",  serviceItemList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("itemType", itemType);
	    request.setAttribute("itemName", itemName);
	    request.setAttribute("addTime", addTime);
		return "ServiceItem/serviceItem_frontquery_result"; 
	}

     /*前台查询ServiceItem信息*/
	@RequestMapping(value="/{itemId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer itemId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键itemId获取ServiceItem对象*/
        ServiceItem serviceItem = serviceItemService.getServiceItem(itemId);

        request.setAttribute("serviceItem",  serviceItem);
        return "ServiceItem/serviceItem_frontshow";
	}

	/*ajax方式显示维修项目修改jsp视图页*/
	@RequestMapping(value="/{itemId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer itemId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键itemId获取ServiceItem对象*/
        ServiceItem serviceItem = serviceItemService.getServiceItem(itemId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonServiceItem = serviceItem.getJsonObject();
		out.println(jsonServiceItem.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新维修项目信息*/
	@RequestMapping(value = "/{itemId}/update", method = RequestMethod.POST)
	public void update(@Validated ServiceItem serviceItem, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String itemPhotoFileName = this.handlePhotoUpload(request, "itemPhotoFile");
		if(!itemPhotoFileName.equals("upload/NoImage.jpg"))serviceItem.setItemPhoto(itemPhotoFileName); 


		try {
			serviceItemService.updateServiceItem(serviceItem);
			message = "维修项目更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "维修项目更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除维修项目信息*/
	@RequestMapping(value="/{itemId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer itemId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  serviceItemService.deleteServiceItem(itemId);
	            request.setAttribute("message", "维修项目删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "维修项目删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条维修项目记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String itemIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = serviceItemService.deleteServiceItems(itemIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出维修项目信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String itemType,String itemName,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(itemType == null) itemType = "";
        if(itemName == null) itemName = "";
        if(addTime == null) addTime = "";
        List<ServiceItem> serviceItemList = serviceItemService.queryServiceItem(itemType,itemName,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "ServiceItem信息记录"; 
        String[] headers = { "项目id","项目类型","项目名称","项目图片","项目价格","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<serviceItemList.size();i++) {
        	ServiceItem serviceItem = serviceItemList.get(i); 
        	dataset.add(new String[]{serviceItem.getItemId() + "",serviceItem.getItemType(),serviceItem.getItemName(),serviceItem.getItemPhoto(),serviceItem.getItemPrice(),serviceItem.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"ServiceItem.xls");//filename是下载的xls的名，建议最好用英文 
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
