package kr.co.neodreams.multi_user.controller;

import java.io.File;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.DownloadView;
@Controller
public class DownloadController implements ApplicationContextAware{
	
	@Autowired
	DownloadView downloadView;
	
	@RequestMapping("/download.do")
	public ModelAndView download(@RequestParam("path")String path, 
            @RequestParam("fileName")String fileName){
		
		fileName = fileName.replaceAll("& #40;", "(");
		fileName = fileName.replaceAll("& #41;", ")");
		
		String thisPath = "C:/2009media/SERVICE/DOC/"+path;
		String fullPath = thisPath + "\\" + fileName;
		//String fullPath = path + "\\" + fileName;
		File file = new File(fullPath);
		return new ModelAndView("downloadView", "downloadFile", file);
	}
	
	@RequestMapping("/download2.do")
	public ModelAndView download2(@RequestParam("path")String path, 
			@RequestParam("fileName")String fileName){
		
		fileName = fileName.replaceAll("& #40;", "(");
		fileName = fileName.replaceAll("& #41;", ")");
		
		String thisPath = Constants.rent_dir_path.replace("/rent/", "") + path;
		String fullPath = thisPath;
		//String fullPath = path + "\\" + fileName;
		File file = new File(fullPath);
		return new ModelAndView("downloadView", "downloadFile", file);
	}
	
	@RequestMapping("/securityDownload.do")
	public ModelAndView download3(@RequestParam("path")String path, 
			@RequestParam("fileName")String fileName){
		ModelAndView mv = new ModelAndView();
		
		fileName = fileName.replaceAll("& #40;", "(");
		fileName = fileName.replaceAll("& #41;", ")");
		
		String fullPath = path;
		//String fullPath = path + "\\" + fileName;
		File downloadFile = new File(fullPath);
 		mv.setView(downloadView);
		mv.addObject("fileName", fileName);
		mv.addObject("downloadFile", downloadFile);
		return mv;
	}
	
	@Override
	public void setApplicationContext(ApplicationContext arg0)
			throws BeansException {
		// TODO Auto-generated method stub
		
	}
}
