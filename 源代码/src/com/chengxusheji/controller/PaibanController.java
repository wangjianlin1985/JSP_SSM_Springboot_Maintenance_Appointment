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
import com.chengxusheji.service.PaibanService;
import com.chengxusheji.po.Paiban;
import com.chengxusheji.service.BarberService;
import com.chengxusheji.po.Barber;

//Paiban管理控制层
@Controller
@RequestMapping("/Paiban")
public class PaibanController extends BaseController {

    /*业务层对象*/
    @Resource PaibanService paibanService;

    @Resource BarberService barberService;
	@InitBinder("barberObj")
	public void initBinderbarberObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("barberObj.");
	}
	@InitBinder("paiban")
	public void initBinderPaiban(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("paiban.");
	}
	/*跳转到添加Paiban视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Paiban());
		/*查询所有的Barber信息*/
		List<Barber> barberList = barberService.queryAllBarber();
		request.setAttribute("barberList", barberList);
		return "Paiban_add";
	}

	/*客户端ajax方式提交添加维修人员排班信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Paiban paiban, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        paibanService.addPaiban(paiban);
        message = "维修人员排班添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询维修人员排班信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("barberObj") Barber barberObj,String paibanDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (paibanDate == null) paibanDate = "";
		if(rows != 0)paibanService.setRows(rows);
		List<Paiban> paibanList = paibanService.queryPaiban(barberObj, paibanDate, page);
	    /*计算总的页数和总的记录数*/
	    paibanService.queryTotalPageAndRecordNumber(barberObj, paibanDate);
	    /*获取到总的页码数目*/
	    int totalPage = paibanService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = paibanService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Paiban paiban:paibanList) {
			JSONObject jsonPaiban = paiban.getJsonObject();
			jsonArray.put(jsonPaiban);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询维修人员排班信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Paiban> paibanList = paibanService.queryAllPaiban();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Paiban paiban:paibanList) {
			JSONObject jsonPaiban = new JSONObject();
			jsonPaiban.accumulate("paibanId", paiban.getPaibanId());
			jsonArray.put(jsonPaiban);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询维修人员排班信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("barberObj") Barber barberObj,String paibanDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (paibanDate == null) paibanDate = "";
		List<Paiban> paibanList = paibanService.queryPaiban(barberObj, paibanDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    paibanService.queryTotalPageAndRecordNumber(barberObj, paibanDate);
	    /*获取到总的页码数目*/
	    int totalPage = paibanService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = paibanService.getRecordNumber();
	    request.setAttribute("paibanList",  paibanList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("barberObj", barberObj);
	    request.setAttribute("paibanDate", paibanDate);
	    List<Barber> barberList = barberService.queryAllBarber();
	    request.setAttribute("barberList", barberList);
		return "Paiban/paiban_frontquery_result"; 
	}

     /*前台查询Paiban信息*/
	@RequestMapping(value="/{paibanId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer paibanId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键paibanId获取Paiban对象*/
        Paiban paiban = paibanService.getPaiban(paibanId);

        List<Barber> barberList = barberService.queryAllBarber();
        request.setAttribute("barberList", barberList);
        request.setAttribute("paiban",  paiban);
        return "Paiban/paiban_frontshow";
	}

	/*ajax方式显示维修人员排班修改jsp视图页*/
	@RequestMapping(value="/{paibanId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer paibanId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键paibanId获取Paiban对象*/
        Paiban paiban = paibanService.getPaiban(paibanId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonPaiban = paiban.getJsonObject();
		out.println(jsonPaiban.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新维修人员排班信息*/
	@RequestMapping(value = "/{paibanId}/update", method = RequestMethod.POST)
	public void update(@Validated Paiban paiban, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			paibanService.updatePaiban(paiban);
			message = "维修人员排班更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "维修人员排班更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除维修人员排班信息*/
	@RequestMapping(value="/{paibanId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer paibanId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  paibanService.deletePaiban(paibanId);
	            request.setAttribute("message", "维修人员排班删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "维修人员排班删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条维修人员排班记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String paibanIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = paibanService.deletePaibans(paibanIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出维修人员排班信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("barberObj") Barber barberObj,String paibanDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(paibanDate == null) paibanDate = "";
        List<Paiban> paibanList = paibanService.queryPaiban(barberObj,paibanDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Paiban信息记录"; 
        String[] headers = { "排班id","维修人员","排班时间","工作时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<paibanList.size();i++) {
        	Paiban paiban = paibanList.get(i); 
        	dataset.add(new String[]{paiban.getPaibanId() + "",paiban.getBarberObj().getName(),paiban.getPaibanDate(),paiban.getWorkTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Paiban.xls");//filename是下载的xls的名，建议最好用英文 
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
