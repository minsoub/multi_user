package kr.co.neodreams.multi_user.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.neodreams.multi_user.common.DateUtil;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.common.TableDataInit;

/**
 * 1. 스케줄을 통해 dataGet() 실행. 
 * 2. 한전 open db(oracle) 에서 가져온 데이터를 임시 테이블에 delete, insert 
 * 3. data_set_log 테이블에 일자별 성공, 실패 로그 남김
 * 4. 스케줄을 통해 dataSet() 실행
 * 5. 최종 일자가 성공인 경우, 임시 테이블 데이터를 실제 테이블에 insert 한다  
 */
public class DataSchedule {
	
	@Autowired
	private CommonService commonService;
	
	public synchronized void dataGet() throws Exception{		
		
		System.out.println("#######################dataGet() start#######################");
		System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
		System.out.println("#######################dataGet() start#######################");
		
		HashMap<String, String> hashMap = new HashMap<String, String>();
		String outString = "";
		String result = "N";
		
		hashMap.put("schedule_date", DateUtil.getCurrentDateTime());
		
		try{
			TableDataInit init = new TableDataInit();
			
			ArrayList<String> values = init.getDept_Data("dept_select");

			if(values != null){
				
				commonService.deleteDeptTMP();
				
				for(int i = 0; i < values.size(); i++){
					commonService.insertDeptTMP(values.get(i));
				}
				
                outString = "dept_tmp success!!! 33% process";
                
                System.out.println(outString);
                
                values = init.getUser_Data("user_select");
                
                if(values != null){
                    
                    commonService.deleteUserTMP();
                    
                    for(int i = 0; i < values.size(); i++){
                        commonService.insertUserTMP(values.get(i));
                    }
                    
                    outString = "user_tmp success!!! 66% process";
                    
                    System.out.println(outString);
                    
                    values = init.getDetail_Data("detail_select");
                    
                    if(values != null){
                        
                        commonService.deleteDetailTMP();
                        
                        for(int i = 0; i < values.size(); i++){
                            commonService.insertDetailTMP(values.get(i));
                        }
                        
                        outString = "detail_tmp success!!! 100% process";
                        
                        System.out.println(outString);
                        
                        result = "Y";
                    }
				}
			}
		}catch (Exception e){
			e.printStackTrace();
			outString = e.toString();
			result = "N";
		}finally{
			
			try{
				System.out.println("#######################dataGet() end#######################");
				System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
				System.out.println("#######################dataGet() end#######################");
				
				hashMap.put("log_desc", outString);
				hashMap.put("result_value", result);
				
				commonService.insertDataSetResult(hashMap);
				
			}catch(Exception e){
				e.printStackTrace();
				
			}finally{
				hashMap.clear();
			}				
		}
	}
	
	public synchronized void dataSet() throws Exception{
		
		System.out.println("#######################dataSet() start#######################");
		System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
		System.out.println("#######################dataSet() start#######################");
		
		String outString = "false";
		
		try{
			String result = commonService.getDataSetLastLog();
			
			if(StringUtil.isEmpty(result)
					|| "Y".equals(result)){
				commonService.insertAllDept_User_Data();
				
				outString = "success";
				
				try{
					commonService.updateDataSetLastLog();
				}catch(Exception e){
					e.printStackTrace();
				}
			}else{
                if("S".equals(result)){
                    outString = "last data set is Success";
                }else{
                    outString = "last data set is error";
                }
			}
		}catch (Exception e){
			e.printStackTrace();
			outString = "dataSet() process error";
		}finally{
			System.out.println("#######################dataSet() end#######################");
			System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
			System.out.println("#######################dataSet() end#######################");
		}
	}
	
	public synchronized void dataGetNomu() throws Exception{		
		
		System.out.println("#######################dataGetNomu() start#######################");
		System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
		System.out.println("#######################dataGetNomu() start#######################");
		
		HashMap<String, String> hashMap = new HashMap<String, String>();
		String outString = "";
		String result = "N";
		
		hashMap.put("schedule_date", DateUtil.getCurrentDateTime());
		
		try{
			TableDataInit init = new TableDataInit("nomu");
			
			ArrayList<String> values = init.getUser_Data_nomu("user_select_nomu");
			
			if(values != null){
					
				commonService.deleteUserNomuTMP();
				
				for(int i = 0; i < values.size(); i++){
					commonService.insertUserNomuTMP(values.get(i));
				}
				
				outString = "user_nomu_tmp success!!! 100% process";
				
				System.out.println(outString);
				
				result = "Y";
			}
		}catch (Exception e){
			e.printStackTrace();
			outString = e.toString();
			result = "N";
		}finally{
			
			try{
				System.out.println("#######################dataGetNomu() end#######################");
				System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
				System.out.println("#######################dataGetNomu() end#######################");
				
				hashMap.put("log_desc", outString);
				hashMap.put("result_value", result);
				
				commonService.insertDataSetResultNomu(hashMap);
				
			}catch(Exception e){
				e.printStackTrace();
				
			}finally{
				hashMap.clear();
			}				
		}
	}
	
	public synchronized void dataSetNomu() throws Exception{
		
		System.out.println("#######################dataSetNomu() start#######################");
		System.out.println("#######################" + DateUtil.getCurrentDateTime() + "#######################");
		System.out.println("#######################dataSetNomu() start#######################");
		
		String outString = "false";
		
		try{
			String result = commonService.getDataSetLastLogNomu();
			
			if(StringUtil.isEmpty(result)
					|| "Y".equals(result)){
				commonService.insertUser_NomuData();
				
				outString = "success";
				
				try{
					commonService.updateDataSetLastLogNomu();
				}catch(Exception e){
					e.printStackTrace();
				}
			}else{
				if("S".equals(result)){
					outString = "last data set is Success";
				}else{
					outString = "last data set is error";
				}
			}
		}catch (Exception e){
			e.printStackTrace();
			outString = "dataSetNomu() process error";
		}finally{
			System.out.println("#######################dataSetNomu() end#######################");
			System.out.println(DateUtil.getCurrentDateTime() + "::::" + outString);
			System.out.println("#######################dataSetNomu() end#######################");
		}
	}
}
