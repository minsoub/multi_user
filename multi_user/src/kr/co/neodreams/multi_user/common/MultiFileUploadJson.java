package kr.co.neodreams.multi_user.common;

import java.io.File;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class MultiFileUploadJson {
	
	public MultiFileUploadJson() {
		// TODO Auto-generated constructor stub
	}
	/**
	 * @Project : 
	 * @Package : kr.co.neodreams.multi_user.common;
	 * @File : MultiFileUpload.java
	 * @Title : 멀티파일 업로드 
	 * @date : 2016-12-09
	 * @author : 박근용
	 * @return 
	 * @return 
	 * @descrption : form 으로 넘어온 이름을 Iterator로  전부 검색하여 업로드 파일명만 추출하여 업로드 후  결과를 json으로 반환
	 */
	public JSONObject MultiFileUploadJson(HttpServletRequest req, String dir_path) {
		 boolean isSuccess = true;
		 JSONObject jsonObject = new JSONObject();
		 JSONArray jsonArray = new JSONArray();
		 
		 String dateFormat = "yyyyMMddHHmmss";
		 Format df = new SimpleDateFormat(dateFormat);
		 String fdate =	df.format(new java.util.Date()).toString();
		 
		 MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)req;  //다중파일 업로드
		    Iterator<String> iter = multipartRequest.getFileNames();
		    while(iter.hasNext()) {
				String uploadFileName = iter.next();
				MultipartFile mFile = multipartRequest.getFile(uploadFileName);
				//System.out.println(mFile);
				String originalFileName = mFile.getOriginalFilename();
				String saveFileName = originalFileName;
				
				
				JSONObject sObject = new JSONObject();
				if(saveFileName != null && !saveFileName.equals("")) {
				//saveFileName = fdate +"_fdata_"+ saveFileName;
					String fileExt = saveFileName.substring(saveFileName.lastIndexOf(".")+1);
					
					saveFileName = UUID.randomUUID().toString()+ "."+ fileExt;
				
				sObject.put("originalFileName", originalFileName); 	//오리지널이름
				sObject.put("saveFileName", saveFileName);			//저장될 이름
				sObject.put("ext", fileExt);							//확장자
				sObject.put("physicalPath", dir_path + saveFileName);	
				sObject.put("logicalPath", dir_path.replace(Constants.FILE_ROOT_PATH, "").replace(File.separator, "/") + saveFileName);
				sObject.put("attributeName", uploadFileName); //attributeName
				jsonArray.add(sObject);
					try {
						jsonObject.put("isSuccess", isSuccess);			//파일 전송 성공여부 true:성공  false:실폐
						jsonObject.put("datas", jsonArray);				//depth2 공간
						mFile.transferTo(new File(dir_path + saveFileName));
					} catch (Exception e) {
						jsonObject.put("isSuccess", isSuccess);
						e.printStackTrace();
						isSuccess = false;
					}
				}else{
					sObject.put("originalFileName", ""); //오리지널이름
					sObject.put("saveFileName", "");			//저장될 이름
					jsonArray.add(sObject);
				}
				
				
				/*기준에 맞게 사용 
				 * if(saveFileName != null && !saveFileName.equals("")) {
				
					//if(new File(dir_path + saveFileName).exists()) {
					saveFileName = fdate +"_fdata_"+ saveFileName;
					//}
					JSONObject sObject = new JSONObject();
					sObject.put("originalFileName", originalFileName); //오리지널이름
					sObject.put("saveFileName", saveFileName);			//저장될 이름
					
					jsonArray.add(sObject);
					try {
						jsonObject.put("isSuccess", isSuccess);			//파일 전송 성공여부 true:성공  false:실폐
						jsonObject.put("datas", jsonArray);				//depth2 공간
						mFile.transferTo(new File(dir_path + saveFileName));
					} catch (Exception e) {
						jsonObject.put("isSuccess", isSuccess);
						e.printStackTrace();
						isSuccess = false;
					}
				}*/
			}
		    return jsonObject;
	}
	
	/**
	 * @Project : 
	 * @Package : kr.co.neodreams.multi_user.common;
	 * @File : MultiFileUpload.java
	 * @Title : 멀티파일 삭제
	 * @date : 2016-12-12
	 * @author : 박근용
	 * @return 
	 * @return 
	 * @descrption : json으로 넘어온 파일 명을 검색하여 삭제.
	 */
	public void MultiFileDelJson(JSONObject jsonObject, String dir_path) {
		/*json 받기 */
		JSONObject jsondepth2 = null;
		JSONArray jsonArr = (JSONArray)jsonObject.get("datas");
		for(int i=0;i<jsonArr.size();i++){
			jsondepth2 = (JSONObject)jsonArr.get(i);
			String filename = jsondepth2.get("saveFileName").toString();
			if(filename != ""){
		    File delfile = new File(dir_path+filename);
		    delfile.delete();
			}
		}
	}

}
