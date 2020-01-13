<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<link rel="stylesheet" type="text/css" href="/resource/common/css/basic.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/main.css" />
<title>::: http://media.hq ${Rs_title}</title>

<script type="text/javascript" src="/GMPlayer/jquery-1.8.3.js"></script>
<!-- 브라우져 버전 체크[s] -->
<script type="text/javascript" src="/GMPlayer/browser.js"></script>
<!-- 브라우져 버전 체크[e] -->
<script type="text/javascript">
    var gmplayer = null; //플레이어 객체
    var gmconfig = null; // 플레이어 재생 정보및  플레이어 환경 설정 정보
    
    $(function() {
        objDetectBrowser(); // 브라우져 버전 체크
    });
    
    // 플레이어 로딩 완료
    function GMPlayerCreationComplete() {           
	
    	if (browser != "IE") { // IE11 및 크롬, 사파리, 파이어 폭츠 
        	gmplayer = $("embed[name=GMPlayer]").get(0);

			if(gmplayer == null || gmplayer == "undefined"){
			  gmplayer = document.getElementById("GMPlayer");
			}
	
    	} else { // IE10 이하
			gmplayer = document.getElementById("GMPlayer");
	
	        if(gmplayer == null || gmplayer == "undefined"){
		  		gmplayer = $("embed[name=GMPlayer]").get(0);
			}
        }


        //플레이어 재생 정보 조회(json)
        $.post("http://<%= Constants.VOD_POPUP %>?cid=${contentID}", {
        }, function(data) {   

            gmconfig = data.gmplayerconfig;	

            if(gmconfig.errmsg != ""){
                if(gmconfig.errmsg == "data not found"){
                    alert("영상 콘텐츠가 존재하지 않습니다.\n 관리자에게 문의 부탁드립니다.");
                }else{
                    alert("플레이어 에러 : "+gmconfig.errmsg);
                }
            }else if(gmconfig.playURL == "convering"){
                alert("영상 데이터 변환 중입니다.\n잠시후 다시 접속하십시오.");
            }else{
                
                gmplayer.GMPlayerInit();
            }                

        }, "json");

    }

    //플레이어 재생 정보 전달
    function GMPlayerConfig() {
	
        return{
            isAudio: gmconfig.isAudio, // 오디오 재생 유무(true/false)                
            playURL: gmconfig.playURL, // 플레이어 재생 url(공백일시 변환 진행중)
            autoPlay: true, // 자동 재생 유무(true/false) 
	        logoImage : gmconfig.logoImage,               
            titleImage : gmconfig.titleImage, // 대표 이미지 url
            //playerWidth : gmconfig.playerWidth, // 플레이어 가로 크기
            //playerHeight: gmconfig.playerHeight, // 플레이어 세로 크기               
            playerWidth : 666, // 플레이어 가로 크기
            playerHeight: 623, // 플레이어 세로 크기               
            snakeImage : gmconfig.snakeImage, // 스네이크 이미지 사용 유무(true/false)
            snakeImageURL : gmconfig.snakeImageURL, // 스네이크 이미지 url
            snakeImageWidth : gmconfig.snakeImageWidth, // 스네이크 이미지 가로 크기
            snakeImageHeight : gmconfig.snakeImageHeight, // 스네이크 이미지 세로 크기
            snakeImageRowNum : gmconfig.snakeImageRowNum, // 스네이크 이미지 가로 갯수
            snakeImageCellNum : gmconfig.snakeImageCellNum, // 스네이크 이미지 세로 갯수
            snakeImageTimeInterval : gmconfig.snakeImageTimeInterval, // 스네이크 이미지 추출 시간 
			isLogo : gmconfig.isLogo
        }
    }
    
    // 크로스 도메인 URL 정보 호출
    function getCrossDomain(){
    	return "http://<%= Constants.VOD_CROSS_DOMAIN %>";
    }
    
    // 플레이어 최초 재생 체크
    function gmplayerPlay(){
        //alert("playing");
    }
    
    function go_URL2()
    {
    	window.open("${URL}?dir01=${dir01}&dir02=${dir02}&name=${cat_name}");
    }
    
    function Check_Form2() {
	    var form   = document.form1;
	
	    if (form.k_id.value == "") {
	       alert("아이디가 없습니다.\n\nhttp://media.hq로 접속을 하시거나\n\n http://powernet.hq Top메뉴 [멀티미디어]로 접속하시면 등록이 가능 합니다.");
	       form.k_id.focus();
	       return;
   	  	}
	    
	    if (form.k_id == "") {
	    	alert("아이디가 없습니다.\n\nhttp://media.hq로 접속을 하시거나\n\n http://powernet.hq Top메뉴 [멀티미디어]로 접속하시면 등록이 가능 합니다.");
	    	form.k_id.focus();
	    	return;
	    }
	    
	    if (form.k_title.value == "") {
	    	alert("내부 고객의 소리를 입력해주세요");
	    	form.k_title.focus();
	    	return;
	    }
	
	    $('#f_mode').val("insert");
	    
	    dataString = $("#form1").serialize();
		
	    $.ajax({
	       url: "media_02_ok.do",
	       type: "POST",
	       data: dataString,
	       dataType: "json",
	       success: function(msg) {
				
	    	   var tmp_result = $.trim(msg);
	    	   if(tmp_result != 'false'){
	    		   
	    		   alert("내부 고객의 소리에 참여 하셨습니다.");
	    		   
	    		   var html = '<li><ul><li>' + msg.k_id + '</li>'
	    		   			+ '<li><img alt="" src="/resource/images/palyer/icon_0' + msg.icon + '.png"></li>'
	    		   			+ '<li>' + msg.k_title + '</li>'
	    		   			+ '<li>' + msg.k_date + '&nbsp;&nbsp;<a href="javascript:;" onclick="javascript:k_del(\'' + msg.k_num + '\', this);"><img src="/resource/images/btn/btn_del.png" /></a></li></ul></li>';
	    		   			   			
	    		   $('#comment_ul').prepend(html);
	    		   $('#k_title').val('');
	    		   $('#nodata').remove();
	    		   $('input:radio[name="icon"][value="1"]').prop('checked', true);
	    		   
	    		   return true;
				}else{
	    		   alert("오류가 발생 했습니다");
				   
	    		   return false;
				}
     		}
		});
    }

    function k_edit(k_id,k_title,k_num){
    	document.form1.k_id.value = k_id ;
    	document.form1.k_title.value = k_title ;
    	document.form1.f_mode.value = "edit" ;
    	document.form1.k_num.value = k_num ;
    }
    
    function k_del(k_num, obj){//내부 고객의 소리 삭제
    
    	if (confirm(" 삭제버튼을 클릭하셨습니다. \n\n삭제를 원하시면 확인 버튼을 클릭하세요")){
    		
    		$('#k_num').val(k_num);
    		$('#f_mode').val("del");
    	
    		dataString = $("#form1").serialize();
    		
    	    $.ajax({
    	       url: "/media_02_ok.do",
    	       type: "POST",
    	       data: dataString,
    	       dataType: "json",
    	       success: function(msg) {
    				
    	    	   var tmp_result = $.trim(msg);
    				
    	    	   if(tmp_result != 'false'){
    	    		   alert("삭제되었습니다.");
    	    		   			   			
    	    		   $(obj).parent().parent().parent().remove();
    	    		   
    	    		   return true;
    				}else{
    					alert("id정보가 없습니다.\n\n정상적인 접근이 아니거나 \n\n예외 오류가 발생 했습니다.\n\n관리자에게 문의 바랍니다.[5448]");
    					
    				    return false;
    				}
         		}
    		});
    	}else{
    	    alert("취소하셨습니다.");
    	}
    }
    
    function na_open_window(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable)
    { // 플레이어 open창 열기
      toolbar_str = toolbar ? 'yes' : 'no';
      menubar_str = menubar ? 'yes' : 'no';
      statusbar_str = statusbar ? 'yes' : 'no';
      scrollbar_str = scrollbar ? 'yes' : 'no';
      resizable_str = resizable ? 'yes' : 'no';
      window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
    }
</script>

<link href="/resource/common/css/style.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="popup_player_box">
	<div style="position: absolute;z-index: 999;top: 80px; left: 30px; width: 666px; height: 623px;">
		<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%"
                    id="GMPlayer"
                    codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
                <param name="movie" value="/GMPlayer/player/GMPlayer.swf" /> <!-- 플레이어 swf  경로 설정 -->
                <param name="quality" value="high" />
                <param name="bgcolor" value="#869ca7" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="wmode" value="opaque" />
                <param name="allowFullScreen" value="true" />
                <!-- 플레이어 swf  경로 설정 -->
                <embed src="/GMPlayer/player/GMPlayer.swf" quality="high" bgcolor="#869ca7" 
                       width="100%" height="100%" name="GMPlayer" align="middle"
                       play="true"
                       loop="false"
                       quality="high"
                       wmode ="opaque"
                       allowScriptAccess="sameDomain"
                       allowFullScreen ="true"
                       type="application/x-shockwave-flash"
                       pluginspage="http://www.adobe.com/go/getflashplayer" />
            </object>
    </div>
	<img alt="" src="/resource/images/palyer/player_bg.png">
	<div style="position: absolute;z-index: 999;top: 101px; left: 728px; width: 403px; height: 623px; padding: 10 10 10 10px;white-space: pre-line; word-wrap: break-word;color: #000000;"><pre>${Re_content}</pre></div>
	<div class="popup_player_sub">
		<ul id="popup_player_ul1">
			<li>동영상 시청소감</li>
			<li>
				<c:if test="${vod_info.caption_desc ne null and caption_desc ne '' }">
					<img alt="" src="/resource/images/btn/btn_scenario.png" style="cursor: pointer;" onclick="javascript:na_open_window('scenario', '/scenario.do?num=${Rs_num}', 0, 0, 757, 757, 0, 0, 0, 0, 0);">
				</c:if>
				<img alt="" src="/resource/images/palyer/codec2.png" style="cursor: pointer;" onclick="javascript:na_open_window('video_help', '/jsp/video_help.jsp', 0, 0, 757, 379, 0, 0, 0, 0, 0);">
			</li>
		</ul>
		
		<div id="popup_player_scroll">
			<ul id="comment_ul" ${fn:length(commentList) == 0 ? "style='border-bottom: 0px;'" : ""}>
				<c:forEach var="item" items="${commentList}" varStatus="status">
					<li>
						<ul>
							<li>
								<%-- ${item.k_id} --%>
								${item.name}<br>
								<span style="font-size: 13px;">${fn:split(item.dept_name, " ")[1]} ${fn:split(item.dept_name, " ")[2]}</span>
							</li>
							<li><img alt="" src="/resource/images/palyer/icon_0${item.icon}.png"></li>
							<c:if test="${fn:trim(sess_id) == fn:trim(item.k_id)}">
								<li>${item.k_title}</li>
							</c:if>         
							<c:if test="${fn:trim(sess_id) != fn:trim(item.k_id)}">
								<li>${item.k_title}</li>
							</c:if>         
							<li>${item.k_date}&nbsp;&nbsp;
								<c:if test="${fn:trim(sess_id) == fn:trim(item.k_id)}">
									<a href="javascript:;" onclick="javascript:k_del('${item.k_num}', this);"><img src="/resource/images/btn/btn_del.png" /></a>
								</c:if>
							</li>
						</ul>
					</li>
				</c:forEach>
				<c:if test="${fn:length(commentList) == 0}"><li id="nodata">NO DATA ...</li></c:if>
			</ul>
		</div>
		<form id="form1" name="form1" method="post">
			<input name="Rs_num" type="hidden" id="Rs_num" value="${Rs_num}">
			<input name="f_mode" type="hidden" id="f_mode" value="insert" >
			<input name="k_num" type="hidden" id="k_num" >
			<input name="DirName" type="hidden" id="DirName" value="comment">
			
			<div id="popup_player_write">
				<ul>
					<li>
						<div style="font-size: 15px; font-weight: bold; padding-left: 10px; padding-right: 20px; padding-top: 5px;">${sess_name}</div>
						<input id="k_id" name="k_id" class="player_id" type="hidden" value="${sess_id}" readonly />
					</li>
					<li>
						<input type="radio" class="player_radio" value="1" name="icon" checked="checked">&nbsp;<img alt="" src="/resource/images/palyer/icon_01.png">
						<input type="radio" class="player_radio" value="2" name="icon">&nbsp;<img alt="" src="/resource/images/palyer/icon_02.png">
						<input type="radio" class="player_radio" value="3" name="icon">&nbsp;<img alt="" src="/resource/images/palyer/icon_03.png">
						<input type="radio" class="player_radio" value="4" name="icon">&nbsp;<img alt="" src="/resource/images/palyer/icon_04.png">
					</li>
					<li><input id="k_title" name="k_title" class="player_comment" type="text"/></li>
					<li><a href="javascript:;" onclick="javascript:Check_Form2();"><img alt="" src="/resource/images/palyer/comment.png"></a></li>
				</ul>
			</div>
		</form>
	</div>
</div>
</body>
</html>