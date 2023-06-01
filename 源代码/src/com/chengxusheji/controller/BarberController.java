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
import com.chengxusheji.service.BarberService;
import com.chengxusheji.po.Barber;

//Barber管理控制层
@Controller
@RequestMapping("/Barber")
public class BarberController extends BaseController {

    /*业务层对象*/
    @Resource BarberService barberService;

	@InitBinder("barber")
	public void initBinderBarber(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("barber.");
	}
	/*跳转到添加Barber视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Barber());
		return "Barber_add";
	}

	/*客户端ajax方式提交添加维修人员信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Barber barber, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			barber.setBarberPhoto(this.handlePhotoUpload(request, "barberPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        barberService.addBarber(barber);
        message = "维修人员添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询维修人员信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String name,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (name == null) name = "";
		if(rows != 0)barberService.setRows(rows);
		List<Barber> barberList = barberService.queryBarber(name, page);
	    /*计算总的页数和总的记录数*/
	    barberService.queryTotalPageAndRecordNumber(name);
	    /*获取到总的页码数目*/
	    int totalPage = barberService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = barberService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Barber barber:barberList) {
			JSONObject jsonBarber = barber.getJsonObject();
			jsonArray.put(jsonBarber);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询维修人员信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Barber> barberList = barberService.queryAllBarber();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Barber barber:barberList) {
			JSONObject jsonBarber = new JSONObject();
			jsonBarber.accumulate("barberId", barber.getBarberId());
			jsonBarber.accumulate("name", barber.getName());
			jsonArray.put(jsonBarber);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询维修人员信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String name,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (name == null) name = "";
		List<Barber> barberList = barberService.queryBarber(name, currentPage);
	    /*计算总的页数和总的记录数*/
	    barberService.queryTotalPageAndRecordNumber(name);
	    /*获取到总的页码数目*/
	    int totalPage = barberService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = barberService.getRecordNumber();
	    request.setAttribute("barberList",  barberList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("name", name);
		return "Barber/barber_frontquery_result"; 
	}

     /*前台查询Barber信息*/
	@RequestMapping(value="/{barberId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer barberId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键barberId获取Barber对象*/
        Barber barber = barberService.getBarber(barberId);

        request.setAttribute("barber",  barber);
        return "Barber/barber_frontshow";
	}

	/*ajax方式显示维修人员修改jsp视图页*/
	@RequestMapping(value="/{barberId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer barberId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键barberId获取Barber对象*/
        Barber barber = barberService.getBarber(barberId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonBarber = barber.getJsonObject();
		out.println(jsonBarber.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新维修人员信息*/
	@RequestMapping(value = "/{barberId}/update", method = RequestMethod.POST)
	public void update(@Validated Barber barber, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String barberPhotoFileName = this.handlePhotoUpload(request, "barberPhotoFile");
		if(!barberPhotoFileName.equals("upload/NoImage.jpg"))barber.setBarberPhoto(barberPhotoFileName); 


		try {
			barberService.updateBarber(barber);
			message = "维修人员更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "维修人员更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除维修人员信息*/
	@RequestMapping(value="/{barberId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer barberId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  barberService.deleteBarber(barberId);
	            request.setAttribute("message", "维修人员删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "维修人员删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条维修人员记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String barberIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = barberService.deleteBarbers(barberIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出维修人员信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String name, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(name == null) name = "";
        List<Barber> barberList = barberService.queryBarber(name);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Barber信息记录"; 
        String[] headers = { "维修人员id","姓名","性别","维修人员年龄","维修人员照片","工作经验"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<barberList.size();i++) {
        	Barber barber = barberList.get(i); 
        	dataset.add(new String[]{barber.getBarberId() + "",barber.getName(),barber.getGender(),barber.getBarberAge() + "",barber.getBarberPhoto(),barber.getWorkYears()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Barber.xls");//filename是下载的xls的名，建议最好用英文 
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
