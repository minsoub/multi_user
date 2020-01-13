package kr.co.neodreams.multi_user.controller;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.neodreams.multi_user.base.controller.BaseController;
import kr.co.neodreams.multi_user.common.Constants;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.dto.PowerstatusDto;
import kr.co.neodreams.multi_user.service.PowerstatusService;

import org.eclipse.jdt.internal.compiler.impl.Constant;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PowerstatusController extends BaseController{

    @Autowired
    PowerstatusService powerstatusService;

    @RequestMapping("/powerStatus.do")
    public ModelAndView PowerStatus(HttpServletRequest request){
        ModelAndView mv = new ModelAndView();

        try{
            String urlString = "";

            String acc_url = "http://" + Constants.callPowerWebUrl + "/view/view.action";

            try{

                //시연용 가라 empno 사용하기 위한 파라메터
                String empno = request.getParameter("empno");

                if(StringUtil.isEmpty(empno)){
                    empno = SESS_EMPNO;
                }

                PowerstatusDto dept_nameDto = powerstatusService.getDeptNameInfo(empno);

                if(dept_nameDto != null){
                    String dept_name_1depth = dept_nameDto.getDept_name_1depth();
                    String dept_name_2depth = dept_nameDto.getDept_name_2depth();

                    BufferedReader fileReader = new BufferedReader(new InputStreamReader(new FileInputStream(Constants.POWERLOCATION_JSON_FILE),"UTF-8"));

                    JSONParser p = new JSONParser();

                    JSONObject jsonObj   = (JSONObject)p.parse(fileReader);

                    JSONArray locationGroup = (JSONArray) jsonObj.get("location");

                    if(locationGroup != null
                            && locationGroup.size() > 0){

                        int locationGroupSize = locationGroup.size();

                        boolean dept_2depthChk = false;

                        for(int i = 0; i < locationGroupSize; i++){

                            JSONObject locationinfo = (JSONObject) locationGroup.get(i);

                            //충남대전지역은 아산전력지사도 있으므로 2depth url을 콜해야 한다.
                            if(!dept_2depthChk){

                                if(locationinfo.get("name").equals(dept_name_1depth)){
                                    acc_url = "http://" + Constants.callPowerWebUrl + "/view/" + locationinfo.get("url") + ".action?location=" + locationinfo.get("location_code");
                                }

                                if(locationinfo.get("name").equals(dept_name_2depth)){
                                    acc_url = "http://" + Constants.callPowerWebUrl + "/view/" + locationinfo.get("url") + ".action?location=" + locationinfo.get("location_code");

                                    dept_2depthChk = true;
                                }
                            }
                        }
                    }
                }
            }catch(Exception e){
                e.printStackTrace();
            }

            mv.setViewName("/powerstatus/powerStatus");
            mv.addObject("acc_url", acc_url);
        }catch(Exception e){
            e.printStackTrace();
            mv.setViewName("/error/error");
        }

        return mv;
    }

    /*
    * 미사용
    */
    @RequestMapping("/myPowerStatus.do")
    @ResponseBody
    public void myPowerStatus(HttpServletRequest request, HttpServletResponse response){

        String urlString = "";

        String acc_url = "http://" + Constants.callPowerWebUrl + "/view/view.action";

        try{

            //시연용 가라 empno 사용하기 위한 파라메터
            String empno = request.getParameter("empno");

            if(StringUtil.isEmpty(empno)){
                empno = SESS_EMPNO;
            }

            PowerstatusDto dept_nameDto = powerstatusService.getDeptNameInfo(empno);

            if(dept_nameDto != null){
                String dept_name_1depth = dept_nameDto.getDept_name_1depth();
                String dept_name_2depth = dept_nameDto.getDept_name_2depth();

                BufferedReader fileReader = new BufferedReader(new InputStreamReader(new FileInputStream(Constants.POWERLOCATION_JSON_FILE),"UTF-8"));

                JSONParser p = new JSONParser();

                JSONObject jsonObj   = (JSONObject)p.parse(fileReader);

                JSONArray locationGroup = (JSONArray) jsonObj.get("location");

                if(locationGroup != null
                        && locationGroup.size() > 0){

                    int locationGroupSize = locationGroup.size();

                    boolean dept_2depthChk = false;

                    for(int i = 0; i < locationGroupSize; i++){

                        JSONObject locationinfo = (JSONObject) locationGroup.get(i);

                        //충남대전지역은 아산전력지사도 있으므로 2depth url을 콜해야 한다.
                        if(!dept_2depthChk){

                            if(locationinfo.get("name").equals(dept_name_1depth)){
                                acc_url = "http://" + Constants.callPowerWebUrl + "/view/" + locationinfo.get("url") + ".action?location=" + locationinfo.get("location_code");
                            }

                            if(locationinfo.get("name").equals(dept_name_2depth)){
                                acc_url = "http://" + Constants.callPowerWebUrl + "/view/" + locationinfo.get("url") + ".action?location=" + locationinfo.get("location_code");

                                dept_2depthChk = true;
                            }
                        }
                    }

                    urlString = this.getPowerWebPage(acc_url);

                    urlString = urlString.replaceAll("30000", "9999999").replaceAll("\"/", "\"http://" + Constants.callPowerWebUrl + "/")
                            .replaceAll("\'/", "'http://" + Constants.callPowerWebUrl + "/")
                            .replaceAll("10000","9999999")
                            .replaceAll("//timeLoop","timeLoop"); //대전 init 스크립트 내부 호출 함수 주석 해제

                }else{
                    urlString = this.getPowerWebPage(acc_url);

                    urlString = urlString.replaceAll("30000", "9999999").replaceAll("\"/", "\"http://" + Constants.callPowerWebUrl + "/")
                            .replaceAll("\'/", "'http://" + Constants.callPowerWebUrl + "/");

                    System.out.println("powerstatus err........" + SESS_EMPNO);
                }
            }else{
                urlString = this.getPowerWebPage(acc_url);

                urlString = urlString.replaceAll("30000", "9999999").replaceAll("\"/", "\"http://" + Constants.callPowerWebUrl + "/")
                        .replaceAll("\'/", "'http://" + Constants.callPowerWebUrl + "/");

                System.out.println("powerstatus err........" + SESS_EMPNO);
            }

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try {
                response.setCharacterEncoding("utf-8");
                response.getWriter().write(urlString);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }

    private String getPowerWebPage(String acc_url){

        String urlString = "";

        try{
            URL url = new URL(acc_url); //"http://" + Constants.callPowerWebUrl + "/view/view.action?location=gangwon");

            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();

            HttpURLConnection connection = null;

            if(urlConnection instanceof HttpURLConnection){
                connection = (HttpURLConnection) urlConnection;
            }else{
                System.out.println("Please enter an HTTP URL.");
            }

            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));

            String current;

            while((current = in.readLine()) != null){
                urlString += current + "\n\r";
            }
        }catch(Exception e){
            e.printStackTrace();

            urlString = "";
        }

        return urlString;
    }

    @RequestMapping("/businessLocation.do")
    public ModelAndView BusinessLocation(){
        ModelAndView mv = new ModelAndView();

        try{
            BufferedReader fileReader = new BufferedReader(new InputStreamReader(new FileInputStream(Constants.POWERLOCATION_JSON_FILE),"UTF-8"));

            JSONParser p = new JSONParser();

            JSONObject jsonObj   = (JSONObject)p.parse(fileReader);

            JSONArray locationGroup = (JSONArray) jsonObj.get("location");

            mv.setViewName("/powerstatus/businessLocation");
            mv.addObject("locationGroup", locationGroup);

        }catch(Exception e){
            e.printStackTrace();
        }

        return mv;
    }
    
    @RequestMapping(value={"/dustLocation{pageSize}.do"})
    public ModelAndView DustLocation(HttpServletRequest req, HttpServletResponse res, @PathVariable String pageSize){
        ModelAndView mv = new ModelAndView();
        
        try{
        		String getJson = Constants.DUSTLOCATION_JSON_FILE;
        		String setPage = "/powerstatus/dustLocation";
        		
        		if("1024".equals(pageSize)) {
        			getJson = Constants.DUSTLOCATION_JSON_FILE_1024;
        			setPage = "/powerstatus/dustLocation_1024";
        		}
        
            BufferedReader fileReader = new BufferedReader(new InputStreamReader(new FileInputStream(getJson),"UTF-8"));
            JSONParser p = new JSONParser();
            JSONObject jsonObj   = (JSONObject)p.parse(fileReader);

            JSONArray locationGroup = (JSONArray) jsonObj.get("dustLocation");

            mv.setViewName(setPage);
            mv.addObject("locationGroup", locationGroup);

        }catch(Exception e){
            e.printStackTrace();
        }

        return mv;
    }

}
