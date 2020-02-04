package kr.co.neodreams.multi_user.common;

import java.io.File;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;


public class Constants {
	
	//krh local
	
    public static boolean TEST_MODE = true;
    public static String localIP = "220.126.231.124";
    public static String callPowerWebUrl = "192.168.100.140:8180";
    public static String callCustom_displayWebUrl = "192.168.100.140";
    //public static final String WEBAPP_ROOT = "E:\\workspace\\neodreams\\multi_user";
	public static final String WEBAPP_ROOT = "D:\\workspace\\multi_user";
	public static String custom_displayWebUrlPage = callCustom_displayWebUrl+File.separator+"/weekly_report.asp";
	public static String getQueryXml = "E:/workspace/neodreams/multi_user/WebContent/WEB-INF/config/query_local.xml";
    public static String VOD_POPUP = "220.126.231.124:8088/fc/interfaces/movieinfoGM.asp";
    public static String VOD_CROSS_DOMAIN = "220.126.231.124:8088/crossdomain.xml";
    public static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static String url = "jdbc:sqlserver://220.126.231.124:1433;databasename=NEWMEDIA";
    public static String user = "sa";
    public static String password = "spdh901()!";
    public static String url_nomu = "jdbc:sqlserver://220.126.231.124:1433;databasename=NEWMEDIA";
    public static String user_nomu = "sa";
    public static String password_nomu = "spdh901()!";
	public static String driver_socket = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	public static String url_socket = "jdbc:sqlserver://220.126.231.124;databasename=NEWMEDIA";
	public static String user_socket = "sa";
	public static String password_socket = "spdh901()!";
    public static String mailHtmlPath = "C:/2009media/rent_sign/";
    public static String sms_senderEmpno = "13105294";
    public static String ASP_DOMAIN = "http://220.126.231.124:82/";
    public static final String WEB_URL = "http://" + localIP;	//운영계는 도메인으로 변경
    public static final String FILE_ROOT_PATH = "D:" + File.separator  + "project_upload_test"  + File.separator + "multi_user"; //50번 경로
    public static final String KUBE_UPLOAD_IMG_PHY_PATH = FILE_ROOT_PATH  + File.separator + "kube" + File.separator  + "thumb";
    public static final String KUBE_UPLOAD_VIDEO_TMP_PATH = FILE_ROOT_PATH  + File.separator + "kube" + File.separator  + "video_tmp"; //50번 영상 임시 저장
    
    //영상은 100.1.48.20에 저장되므로 운영계에서 경로 잘 맞춰줘야 합니다
    public static final String STORAGE_SERVER_FILE_ROOT_PATH = "E:" + File.separator  + "project_upload_test"  + File.separator + "multi_user"; //20번 경로
    public static final String KUBE_UPLOAD_VIDEO_PHY_PATH = STORAGE_SERVER_FILE_ROOT_PATH  + File.separator + "kube" + File.separator  + "video";
    public static final String KUBE_VIDEO_THUMB_PHY_PATH = STORAGE_SERVER_FILE_ROOT_PATH  + File.separator + "kube" + File.separator  + "video_thumb";
    public static final String KUBE_UPLOAD_ASP_IP = "http://220.126.231.124:82";
    public static final String KUBE_UPLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + "/interface/kube/kube_video_write_pro.asp";
    public static final String MULTI_UPLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + "/interface/kube/multimedia_Notice_Write.asp";
    public static final String MULTI_DOWNLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + ":82/interface/kube/multimedia_Notice_Download.asp";
    public static final String IMGBRD_UPLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + "/interface/kube/multimedia_ImgBrd_Write.asp";
    public static final String IMGBRD_DOWNLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + "/interface/kube/multimedia_ImgBrd_Download.asp";
    //20190613 콘텐츠파일 ASP파일 경로 추가  
    public static final String CONTENTS_ASP_CALL = KUBE_UPLOAD_ASP_IP + ":82/interface/kube/contents_upload_Write.asp";
    public static final String CONTENTS_DOWNLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + ":82/interface/kube/contents_download_Detail.asp";
    public static final String DISPLAY_ASP_CALL = KUBE_UPLOAD_ASP_IP + ":82/interface/kube/display_upload_Write.asp";
    public static final String DISPLAY_DOWNLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + ":82/interface/kube/display_download_Detail.asp";
    // 20200204 공통게시판 ASP파일 경로 추가
    public static final String COMMON_UPLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + "/interface/kube/common_upload_write.asp";
    public static final String COMMON_DOWNLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + "/interface/kube/common_download.asp";    
    
    
    public static final int SMS_PORT = 13139; 
    public static final String SMS_HOST = "220.126.231.120";
    public static final String SMS_CLASS_CODE = "00094";
    public static final String SMS_PASSCODE = "0094";
    public static final String SMS_CALLBACK = "0613456266";
    
    public static final String ONESTOP_HOST = "192.168.100.140";
    public static final String ONESTOP_PORT = "7781";
    public static final String ONESTOP_SYSTEMID = "10118";
    public static final String ONESTOP_DOCTYPE = "장비대여";
    
    public static final String ONESTOP_WRITER = "ex190126";
    public static final String ONESTOP_WRITER_NAME = "김종찬";
	
	
    //neo test server
	/*
	public static boolean TEST_MODE = true;
    public static String localIP = "220.126.231.124";
    public static String callPowerWebUrl = "220.126.231.124:8180";
    public static String callCustom_displayWebUrl = "220.126.231.124";
    public static final String WEBAPP_ROOT = "E:\\multi_user";
    public static String custom_displayWebUrlPage = callCustom_displayWebUrl+File.separator+"/jsp.asp";
    public static String getQueryXml = "E:/multi_user/WebContent/WEB-INF/config/query.xml";
    public static String VOD_POPUP = "220.126.231.124:8088/fc/interfaces/movieinfoGM.asp";
    public static String VOD_CROSS_DOMAIN = "220.126.231.124:8088/crossdomain.xml";
    public static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static String url = "jdbc:sqlserver://220.126.231.124:1433;databasename=NEWMEDIA";
    public static String user = "sa";
    public static String password = "spdh901()!";
    public static String url_nomu = "jdbc:sqlserver://220.126.231.124:1433;databasename=NEWMEDIA";
    public static String user_nomu = "sa";
    public static String password_nomu = "spdh901()!";
	public static String driver_socket = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	public static String url_socket = "jdbc:sqlserver://220.126.231.124;databasename=NEWMEDIA";
	public static String user_socket = "sa";
	public static String password_socket = "spdh901()!";
    public static String mailHtmlPath = "C:/2009media/rent_sign/";
    public static String sms_senderEmpno = "13105294";
    public static String ASP_DOMAIN = "http://220.126.231.124/";
    public static final String WEB_URL = "http://" + localIP;	//운영계는 도메인으로 변경
    public static final String FILE_ROOT_PATH = "E:" + File.separator  + "project_upload_test"  + File.separator + "multi_user"; //50번 경로
    public static final String KUBE_UPLOAD_IMG_PHY_PATH = FILE_ROOT_PATH  + File.separator + "kube" + File.separator  + "thumb";
    public static final String KUBE_UPLOAD_VIDEO_TMP_PATH = FILE_ROOT_PATH  + File.separator + "kube" + File.separator  + "video_tmp"; //50번 영상 임시 저장
    
    //영상은 100.1.48.20에 저장되므로 운영계에서 경로 잘 맞춰줘야 합니다
    public static final String STORAGE_SERVER_FILE_ROOT_PATH = "E:" + File.separator  + "project_upload_test"  + File.separator + "multi_user"; //20번 경로
    public static final String KUBE_UPLOAD_VIDEO_PHY_PATH = STORAGE_SERVER_FILE_ROOT_PATH  + File.separator + "kube" + File.separator  + "video";
    public static final String KUBE_VIDEO_THUMB_PHY_PATH = STORAGE_SERVER_FILE_ROOT_PATH  + File.separator + "kube" + File.separator  + "video_thumb";
    public static final String KUBE_UPLOAD_ASP_IP = "http://220.126.231.124";
    public static final String KUBE_UPLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + "/interface/kube/kube_video_write_pro.asp";
    
    public static final int SMS_PORT = 13139;
    public static final String SMS_HOST = "220.126.231.120";
    public static final String SMS_CLASS_CODE = "00094";
    public static final String SMS_PASSCODE = "0094";
    public static final String SMS_CALLBACK = "0613456266";
    */
    

    //hanjeon TEST server ip. 100.1.48.20
    /*
    public static boolean TEST_MODE = true;       //This server is SSO decode file non-set.
    public static String localIP = "100.1.48.20";
    public static String callPowerWebUrl = "pss.kepco.co.kr:20808";
    public static String callCustom_displayWebUrl = "contents.kepco.co.kr";
    public static final String WEBAPP_ROOT = "D:\\workspace2\\multi_user";
    public static String custom_displayWebUrlPage = callCustom_displayWebUrl+File.separator+"/weekly_report.asp";
    public static String getQueryXml = "D:/workspace2/multi_user/WebContent/WEB-INF/config/query.xml";
    public static String VOD_POPUP = "media.hq/GMPlayer/interfaces/movieinfoGM.asp";
    public static String VOD_CROSS_DOMAIN = "media.hq/crossdomain.xml";
    public static String driver = "oracle.jdbc.driver.OracleDriver";
    public static String url = "jdbc:oracle:thin:@100.1.6.60:1521:SERV1";
    public static String user = "inquiry_tdms";
    public static String password = "tdms";
    public static String mailHtmlPath = "C:/2009media/rent_sign/";
    public static String sms_senderEmpno = "13105294";
    public static String ASP_DOMAIN = "http://media.hq/";
	public static final String FILE_ROOT_PATH = "E:" + File.separator  + "project_upload_test"  + File.separator + "dh_solution";
	public static final String UPLOAD_THUMB_PATH = FILE_ROOT_PATH + File.separator  + "thumb";
    public static final String UPLOAD_VIDEO_PATH = FILE_ROOT_PATH + File.separator  + "video";
    
    public static final int SMS_PORT = 7904;
    public static final String SMS_HOST = "100.1.5.169";
    public static final String SMS_CLASS_CODE = "00094";
    public static final String SMS_PASSCODE = "0094";
    public static final String SMS_CALLBACK = "0613456266";
    */
    
	//hanjeon real server
	/*public static boolean TEST_MODE = false;
	public static String localIP = "100.1.48.50";
	public static String callPowerWebUrl = "pss.kepco.co.kr:20808";
	public static String callCustom_displayWebUrl = "contents.kepco.co.kr";
	public static final String WEBAPP_ROOT = "D:\\workspace\\multi_user";
	public static String custom_displayWebUrlPage = callCustom_displayWebUrl+File.separator+"/weekly_report.asp";
	public static String getQueryXml = "D:/workspace/multi_user/WebContent/WEB-INF/config/query.xml";
	public static String VOD_POPUP = "media.hq/GMPlayer/interfaces/movieinfoGM.asp";
	public static String VOD_CROSS_DOMAIN = "media.hq/crossdomain.xml";
    public static String driver = "oracle.jdbc.driver.OracleDriver";
    public static String url = "jdbc:oracle:thin:@100.1.6.60:1521:SERV1";
    public static String user = "inquiry_tdms";
    public static String password = "tdms";
    public static String url_nomu = "jdbc:oracle:thin:@100.1.5.174:1521:DBA";
    public static String user_nomu = "opnuser02";
    public static String password_nomu = "opnusr02!#";
	public static String driver_socket = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	public static String url_socket = "jdbc:sqlserver://100.1.48.50:23143;databasename=NEWMEDIA";
	public static String user_socket = "media";
	public static String password_socket = "mediahq";
    public static String mailHtmlPath = "C:/2009media/rent_sign/";
    public static String sms_senderEmpno = "13105294";
    public static String ASP_DOMAIN = "http://media.hq/";
    
    public static final String WEB_URL = "http://" + localIP;	//운영계는 도메인으로 변경
    public static final String FILE_ROOT_PATH = "C:" + File.separator  + "2009media"; //50번 경로
    public static final String KUBE_UPLOAD_IMG_PHY_PATH = FILE_ROOT_PATH  + File.separator + "kube_file" + File.separator  + "thumb";
    public static final String KUBE_UPLOAD_VIDEO_TMP_PATH = FILE_ROOT_PATH  + File.separator + "kube_file" + File.separator  + "video_tmp"; //50번 영상 임시 저장. 사용 안함
    
    //영상은 100.1.48.20에 저장되므로 운영계에서 경로 잘 맞춰줘야 합니다
    public static final String STORAGE_SERVER_FILE_ROOT_PATH = "E:" + File.separator + "VOD"; //20번 경로
    public static final String KUBE_UPLOAD_VIDEO_PHY_PATH = STORAGE_SERVER_FILE_ROOT_PATH  + File.separator + "KUBE" + File.separator  + "video";
    public static final String KUBE_VIDEO_THUMB_PHY_PATH = STORAGE_SERVER_FILE_ROOT_PATH  + File.separator + "KUBE" + File.separator  + "video_thumb";
    public static final String KUBE_UPLOAD_ASP_IP = "http://100.1.48.20";
    
    public static final String KUBE_UPLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + ":8099/kube_video_write_pro.asp";
    public static final String MULTI_UPLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + ":8099/multimedia_Notice_Write.asp";
    public static final String MULTI_DOWNLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + ":8099/multimedia_Notice_Download.asp";
    public static final String IMGBRD_UPLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + ":8099/multimedia_ImgBrd_Write.asp";
    public static final String IMGBRD_DOWNLOAD_ASP_CALL = KUBE_UPLOAD_ASP_IP + ":8099/multimedia_ImgBrd_Download.asp";
    //20190613 콘텐츠파일 ASP파일 경로 추가
    public static final String CONTENTS_UPLOAD_ASP_DOMAIN = "http://media.hq/kubeUpload";
    public static final String CONTENTS_ASP_CALL = CONTENTS_UPLOAD_ASP_DOMAIN + "/contents_upload_Write.asp";
    public static final String CONTENTS_DOWNLOAD_ASP_CALL = CONTENTS_UPLOAD_ASP_DOMAIN + "/contents_download_Detail.asp";
	public static final String DISPLAY_ASP_CALL = CONTENTS_UPLOAD_ASP_DOMAIN + "/display_upload_Write.asp";
    public static final String DISPLAY_DOWNLOAD_ASP_CALL = CONTENTS_UPLOAD_ASP_DOMAIN + "/display_download_Detail.asp";
    
    public static final int SMS_PORT = 7904;
    public static final String SMS_HOST = "100.1.5.169";  
    public static final String SMS_CLASS_CODE = "00094";
    public static final String SMS_PASSCODE = "0094";
    //public static final String SMS_CALLBACK = "0613456266";
    public static final String SMS_CALLBACK = "0613456383";
    
    public static final String ONESTOP_HOST = "100.1.6.152";
    public static final String ONESTOP_PORT = "7781";
    public static final String ONESTOP_SYSTEMID = "10118";
    public static final String ONESTOP_DOCTYPE = "멀티미디어 장비대여";
    
    public static final String ONESTOP_WRITER = "ex190126";
    public static final String ONESTOP_WRITER_NAME = "김종찬";*/
    
    
    //common
    public static final String WEBAPP_HOME = WEBAPP_ROOT + "\\WebContent";

    public static final String CONFIG_HOME = WEBAPP_HOME + "\\WEB-INF\\config";

    public static final String POWERLOCATION_JSON_FILE = CONFIG_HOME+File.separator+"powerLocation.json";
    
    //20190422 미세먼지 현황 추가
    public static String callDustWebUrl = "100.1.48.209";
    public static final String DUSTLOCATION_JSON_FILE = CONFIG_HOME+File.separator+"dustLocation.json";
    public static final String DUSTLOCATION_JSON_FILE_1024 = CONFIG_HOME+File.separator+"dustLocation_1024.json";

    public static final String CUSTOM_DISPLAY_JSON_FILE = CONFIG_HOME+File.separator+"custom_display.json";
    
    public static final String IMGBRD_OPEN_USER_JSON_FILE = CONFIG_HOME+File.separator+"imgBrdOpenList.json";

    public static final String dir_contents_path = "C:/2009media/SERVICE/DOC/CONTENTS/"; //CONTENTS 업로드 파일 경로
    public static final String dir_display_path = "C:/2009media/SERVICE/DOC/DISPLAY/"; //DISPLAY 업로드 파일 경로

    public static final String rent_dir_path = "C:/2009media/multi_user_jsp/rent/"; //장비 첨부파일
    public static final String rent_security_path = "C:/2009media/multi_user_jsp/rent/security"; //장비 첨부파일

    public static final String KUBE_SEQ_SALT = "KUBESEQENcDEc";
    
    public static int getPoint(String DirName){
        int point = 0;

        if("세미나/교육동영상".equals(DirName)){
            point = 2;
        }else if("어학동영상".equals(DirName)){
            point = 1;
        }else if("사내홍보동영상".equals(DirName)){
            point = 1;
        }else if("kepcn-news".equals(DirName)){
            point = 1;
        }else if("ebs".equals(DirName)){
            point = 2;
        }else if("직원개인동영상".equals(DirName)){
            point = 3;
        }else if("참여마당".equals(DirName)){
            point = 5;
        }else if("comment".equals(DirName)){
            point = 2;
        }

        return point;
    }

    public static HashMap<String, String> getMultiUrl(String Rs_num, String Rs_dir01){

        //서버에 실제로 만들어야 하는 디렉토리입니다.

        //스토리지 용량부족으로 수정
        //IF    Rs_num>7650 THEN
        //    dir_folder = "E:\VOD\"
        //    mmsURL_folder ="VOD_2/"
        //    h_264_folder = "\F_H264\VOD"

        int Rs_Num = Integer.parseInt(Rs_num);
        String dir_folder = "";
        String mmsURL_folder = "";
        String h_264_folder = "";
        String ip = "";
        String DIR_URL = "";
        String WEBDIR_URL = "";
        String strDirectory = "";
        String strDirectory1 = "";
        String FileURL = "";
        String mmsURL = "";
        String photoURL = "";

        if(Rs_Num > 14574){
            dir_folder = "E:\\VOD\\";
            mmsURL_folder = "";
            h_264_folder="";
        //    mmsURL_folder ="VOD_2/"
        //    h_264_folder = "\F_H264\VOD"
        }else if(Rs_Num > 7650 && Rs_Num < 14575){
            dir_folder = "E:\\VOD\\";
            mmsURL_folder ="VOD_2/";
            h_264_folder = "\\F_H264\\VOD";
        }else{
            dir_folder = "E:\\VOD\\";
            mmsURL_folder = "";
            h_264_folder = "";
        }

        ip = CommonUtil.getIPAddr();

        if("168".equals(ip.substring(0, 3))){
            DIR_URL = "168.78.201.142";
            WEBDIR_URL = "168.78.201.141";
        }else if("100".equals(ip.substring(0, 3))){
            DIR_URL = "100.1.48.20";
            WEBDIR_URL = "100.1.48.50";
        }else{
            DIR_URL = "203.248.44.142";
            WEBDIR_URL = "203.248.44.141";
        }

        switch (Rs_dir01.trim()) {
            case "1" :
                    strDirectory = dir_folder + "VOD1\\";
                    strDirectory1 = h_264_folder + "\\VOD1\\";
                    FileURL = "http://" + DIR_URL + "/VOD1/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD1/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD1/";
                    break;
            case  "17" :
                    strDirectory = dir_folder + "VOD1\\";
                    strDirectory1 = h_264_folder + "\\VOD1\\";
                    FileURL = "http://" + DIR_URL + "/VOD1/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD1/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD1/";
                    break;
            case "2" :
                    strDirectory = dir_folder + "VOD2\\";
                    strDirectory1 = h_264_folder + "\\VOD2\\";
                    FileURL = "http://" + DIR_URL + "/VOD2/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD2/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD2/";
                    break;
            case "3" :
                    strDirectory = dir_folder + "VOD3\\";
                    strDirectory1 = h_264_folder + "\\VOD3\\";
                    FileURL = "http://" + DIR_URL + "/VOD3/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD3/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD3/";
                    break;
            case "4" :
                    strDirectory = dir_folder + "VOD4\\";
                    strDirectory1 = h_264_folder + "\\VOD4\\";
                    FileURL = "http://" + DIR_URL + "/VOD4/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD4/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD4/";
                    break;
            case "5" :
                    strDirectory = dir_folder + "VOD5\\";
                    strDirectory1 = h_264_folder + "\\VOD5\\";
                    FileURL = "http://" + DIR_URL + "/VOD5/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD5/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD5/";
                    break;
            case "6" :
                    strDirectory = dir_folder + "VOD6\\";
                    strDirectory1 = h_264_folder + "\\VOD6\\";
                    FileURL = "http://" + DIR_URL + "/VOD6/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD6/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD6/";
                    break;
            case "7" :
                    strDirectory = dir_folder + "VOD7\\";
                    strDirectory1 = h_264_folder + "\\VOD7\\";
                    FileURL = "http://" + DIR_URL + "/VOD7/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD7/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD7/";
                    break;
            case "8" :
                    strDirectory = dir_folder + "VOD8\\";
                    strDirectory1 = h_264_folder + "\\VOD8\\";
                    FileURL = "http://" + DIR_URL + "/VOD8/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD8/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD8/";
                    break;
            case "9" :        //kep-cn
                strDirectory1 = h_264_folder + "\\KEPCN\\";
                        strDirectory  = dir_folder + "KEPCN\\";
                        FileURL = "http://" + DIR_URL + "/KEPCN/";
                        mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "KEPCN/";
                        photoURL = "http://" + DIR_URL + "/VOD_PHOTO/KEPCN/";
                    break;
            case "11" :    // 모토딕
                    strDirectory = dir_folder + "VOD11\\";
                    strDirectory1 = h_264_folder + "\\VOD11\\";
                    FileURL = "http://" + DIR_URL + "/VOD11/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD11/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD11/";
                    break;
            case "12" :     // 엔터테이먼트 _ 메인
                    strDirectory = dir_folder + "H_264_M\\";
                    strDirectory1 = h_264_folder + "\\H_264_M\\";
                    FileURL = "http://" + DIR_URL + "/H_264_M/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "H_264_M/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/H_264_M/";
                    break;
            case "13" :     // 엔터테이먼트 _ 메인
                    strDirectory =dir_folder + "VOD13\\";
                    strDirectory1 = h_264_folder + "\\VOD13\\";
                    FileURL = "http://" + DIR_URL + "/VOD13/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD13/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD13/";
                    break;
            case "14" :     // MPPS 프리젠테이션
                    strDirectory = dir_folder + "test_vod\\";
                    strDirectory1 = h_264_folder + "\\test_vod\\";
                    FileURL = "http://" + DIR_URL + "/test_vod/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "test_vod/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/test_vod/";
                    break;
            case "15" :     // 직원개인동영상
                    strDirectory = dir_folder + "VOD15\\";
                    strDirectory1 = h_264_folder + "\\VOD15\\";
                    FileURL = "http://" + DIR_URL + "/VOD15/";
                    mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "VOD15/";
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/VOD15/";
                    break;
            case "16" :    // 참여마당
                    //서버에 실제로 만들어야 하는 디렉토리입니다.
                    strDirectory = "d:\\FILES\\garden\\";
                    FileURL = "http://" + WEBDIR_URL + "/FILES/garden/";
                    photoURL = "http://" + DIR_URL + "/FILES/photo/";
                    break;
            case "notice" :    // 공지사항
                    //서버에 실제로 만들어야 하는 디렉토리입니다.
                    strDirectory = "d:\\FILES\\BOARD\\pds\\";
                    FileURL = "http://" + WEBDIR_URL + "/FILES/BOARD/pds/";
                    break;
            case "0" :    // 신 영화
                    photoURL = "http://" + DIR_URL + "/VOD_PHOTO/MovieFile/";
                    break;
            default:

                    //# 2009.05.28 modify
                    //if right(Trim(Rs("pdsFile")),3) <> "avi" Then                        //wmv , asf
                    //        strDirectory1 = h_264_folder&"\KEPCN\"
                    //        strDirectory  = dir_folder&"KEPCN\"
                    //        FileURL = "http://"&DIR_URL&"/KEPCN/"
                    //        mmsURL = "mms://"&DIR_URL&"/"&mmsURL_folder&"KEPCN/"
                    //        photoURL = "http://"&DIR_URL&"/VOD_PHOTO/KEPCN/"

                    //Else    // avi 고해상 동영상
                            strDirectory  = dir_folder + "Movies\\";
                            strDirectory1 = h_264_folder + "\\Movies\\";
                            FileURL = "http://" + DIR_URL + "/Movies/";
                            mmsURL = "mms://" + DIR_URL + "/" + mmsURL_folder + "Movies/";
                            photoURL = "http://" + DIR_URL + "/VOD_PHOTO/KEPCN/";  //통일염원 사업소릴레이
                    //End if
                    break;
        }

        HashMap<String, String> multiUrlMap = new HashMap<>();

        multiUrlMap.put("strDirectory", strDirectory);
        multiUrlMap.put("strDirectory1", strDirectory1);
        multiUrlMap.put("FileURL", FileURL);
        multiUrlMap.put("mmsURL", mmsURL);
        multiUrlMap.put("photoURL", photoURL);
        multiUrlMap.put("FileURL", FileURL);

        return multiUrlMap;
    }

    public static String getMultiUrl(String Rs_dir01){

        String strDirectory = "";

        switch (Rs_dir01.trim()) {
            case "1" :
                    strDirectory = "VOD1";
                    break;
            case  "17" :
                    strDirectory = "VOD1";
                    break;
            case "2" :
                    strDirectory = "VOD2";
                    break;
            case "3" :
                    strDirectory = "VOD3";
                    break;
            case "4" :
                    strDirectory = "VOD4";
                    break;
            case "5" :
                    strDirectory = "VOD5";
                    break;
            case "6" :
                    strDirectory = "VOD6";
                    break;
            case "7" :
                    strDirectory = "VOD7";
                    break;
            case "8" :
                    strDirectory = "VOD8";
                    break;
            case "9" :        //kep-cn
                    strDirectory  = "KEPCN";
                    break;
            case "11" :    // 모토딕
                    strDirectory = "VOD11";
                    break;
            case "12" :     // 엔터테이먼트 _ 메인
                    strDirectory = "H_264_M";
                    break;
            case "13" :     // 엔터테이먼트 _ 메인
                    strDirectory ="VOD13";
                    break;
            case "14" :     // MPPS 프리젠테이션
                    strDirectory = "test_vod";
                    break;
            case "15" :     // 직원개인동영상
                    strDirectory = "VOD15";
                    break;
            case "16" :    // 참여마당
                    //서버에 실제로 만들어야 하는 디렉토리입니다.
                    //strDirectory = "d:\\FILES\\garden\\";
                    break;
            case "notice" :    // 공지사항
                    //서버에 실제로 만들어야 하는 디렉토리입니다.
                    //strDirectory = "d:\\FILES\\BOARD\\pds\\";
                    break;
            case "0" :    // 신 영화
                    //photoURL = "http://" + DIR_URL + "/VOD_PHOTO/MovieFile/";
                    break;
            default:

                    //# 2009.05.28 modify
                    //if right(Trim(Rs("pdsFile")),3) <> "avi" Then                        //wmv , asf
                    //        strDirectory1 = h_264_folder&"\KEPCN\"
                    //        strDirectory  = dir_folder&"KEPCN\"
                    //        FileURL = "http://"&DIR_URL&"/KEPCN/"
                    //        mmsURL = "mms://"&DIR_URL&"/"&mmsURL_folder&"KEPCN/"
                    //        photoURL = "http://"&DIR_URL&"/VOD_PHOTO/KEPCN/"

                    //Else    // avi 고해상 동영상
                    strDirectory  = "Movies";
                    //End if
                    break;
        }

        return strDirectory;
    }

    /*
    ------
    접수정보
    ------
    */

    /*승인상태 코드를 문자로 변환*/
    public static String approvalToStr(String approval){
        String approvalStr = "";
        switch(approval){
            case "1" :
                approvalStr = "승인대기중";
                break;
            case "2" :
                approvalStr = "승인완료";
                break;
            case "3" :
                approvalStr = "반려";
                break;
        }
        return approvalStr;
    }

    /*접수상태 코드를 문자로 변환*/
    public static String appstToStr(String status){
        String appstStr = "";
        switch(status){
            case "1" :
                appstStr = "신청";
                break;
            case "2" :
                appstStr = "사용자취소";
                break;
            case "3" :
                appstStr = "접수완료";
                break;
            case "4" :
                appstStr = "사용중";
                break;
            case "6" :
                appstStr = "반납완료";
                break;
        }
        return appstStr;
    }

    /*
    ------
    대여정보
    ------
    */

    /*설비등록상태 */
    public static HashMap<String, String> getEqrstMap(){
        HashMap<String, String> eqrstStr = new HashMap<String, String>();
        eqrstStr.put("0", "미등록");
        eqrstStr.put("1", "등록");
        return eqrstStr;
    }

    /*설비관리상태 */
    public static HashMap<String, String> getEqmstMap(){
        HashMap<String, String> eqmstStr = new HashMap<String, String>();
        eqmstStr.put("1", "정상");
        eqmstStr.put("2", "고장");
        eqmstStr.put("3", "수리중");
        eqmstStr.put("4", "폐기");
        eqmstStr.put("5", "해지");
        eqmstStr.put("6", "임시보관");
        return eqmstStr;
    }

    /*대여상태 */
    public static HashMap<String, String> getEqlstMap(){
        HashMap<String, String> eqlstStr = new HashMap<String, String>();
        eqlstStr.put("0", "대기중");
        eqlstStr.put("1", "사용중");
        return eqlstStr;
    }

    /*페이징*/
    /** 페이징 옵셋★{@value} */
    public static final int PAGING_FIRST_OFFSET = 0;
    /** 페이징 한 페이지의 컨텐스 수 ★{@value} */
    public static final int PAGING_CONTENTS_COUNT = 10;
    /** 페이징 기능의 한번에 보여줄 페이징 카운트 ex) << < 1 2 3 4 5 6 7 8 9 10 > >> ★{@value} */
    public static final int PAGING_COUNT_SIZE = 10;

    /* 설정옵션 */
    public static Map<String, Object> getConfigOption() {

        Map<String, Object> config = new HashMap<String, Object> ();
        /*
            -------------------
                        코드관리
            -------------------
         */
        Map<String, Object> gbynArr = new LinkedHashMap<String, Object> ();
        gbynArr.put("Y", "사용");
        gbynArr.put("N", "미사용");
        config.put("gbynArr", gbynArr);

        /*
            -------------------
                        대여설비
            -------------------
         */
        /*설비등록상태*/
        Map<String, Object> eqrstArr = new LinkedHashMap<String, Object> ();
        eqrstArr.put("1", "등록");
        eqrstArr.put("0", "미등록");
        config.put("eqrstArr", eqrstArr);

        /*설비관리상태*/
        Map<String, Object> eqmstArr = new LinkedHashMap<String, Object> ();
        eqmstArr.put("1", "정상");
        eqmstArr.put("2", "고장");
        eqmstArr.put("3", "수리중");
        eqmstArr.put("4", "폐기");
        config.put("eqmstArr", eqmstArr);

        /*대여상태*/
        Map<String, Object> eqlstArr = new LinkedHashMap<String, Object> ();
        eqlstArr.put("1", "등록");
        eqlstArr.put("0", "대기중");
        config.put("eqlstArr", eqlstArr);

        /*
            -------------------
                        접수정보
            -------------------
         */
        /*접수상태*/
        Map<String, Object> appstArr = new LinkedHashMap<String, Object> ();
        appstArr.put("1", "신청");
        appstArr.put("2", "사용자취소");
        appstArr.put("3", "접수완료");
        appstArr.put("4", "사용중");
        appstArr.put("6", "반납완료");
        config.put("appstArr", appstArr);

        /*승인상태*/
        Map<String, Object> approvalArr = new LinkedHashMap<String, Object> ();
        approvalArr.put("1", "승인대기중");
        approvalArr.put("2", "승인완료");
        approvalArr.put("3", "반려");
        config.put("approvalArr", approvalArr);

        /*반납상태*/
        Map<String, Object> banpArr = new LinkedHashMap<String, Object> ();
        banpArr.put("1", "정상반납");
        banpArr.put("2", "고장반납");
        banpArr.put("3", "분실미반납");
        banpArr.put("4", "분실대체반납");
        banpArr.put("5", "기타");
        config.put("banpArr", banpArr);

        return config;
    }
    


    /*전력노조 접근 허용 */
    public static HashMap<String, String> getNojohqMap(){
        HashMap<String, String> nojohq = new HashMap<String, String>();
        nojohq.put("0", "nojohq02");
        nojohq.put("1", "nojohq03");
        return nojohq;
    }
}
