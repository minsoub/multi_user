<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
					<div id="footer">
                        <div class="fl_left" style="margin-top:10px;">
                            <img alt="kepco" src="/resource/kube_images/logo_bottom.png" style="vertical-align: middle; margin-right:15px;"> 
                            <span class="add" style="margin-top: -7px; position: absolute; padding-top: 0px;">ICT인프라처 통신운영센터 ICT서비스부(061-6385)</span><br />
                            <span class="add" style="margin-top: -7px; margin-left: 87px; position: absolute; padding-top: 0px;">Copyright(c) ICT인프라처 All rights reserved</span>
                        </div>
                        <div class="fl_right">
                            <span class="tel">서비스 문의(☎061-6385)</span>
                            <a href="javascript:;" onclick="javascript:copyrightPop();"><img alt="kepco" src="/resource/kube_images/banner_04.png" style="vertical-align: middle; margin-left:10px;"></a>
                        </div>
                        
   
   
                    </div>
                </div>
            </div>
        </div>
    <form id="manualDownForm" name="manualDownForm" method="post" ></form>
	<script>
		/*topmenu 검색*/
		function funTopSrh(){
			if($.trim($('#srh_keyword_top').val()) == ''){
				alert('검색어를 입력하세요'); 
				$('#srh_keyword_top').focus(); 
				return false;
			} 
			
			funGoPageDetailSetFrm('/kube/channel/search', 'topSrhfrm');
		} 
		
		/*left menu toggle*/
		$(document).ready(function(){
			
			var locationHref = $(location).attr('href');
			
			$('.leftmenu_li').each(function(){
				if(locationHref.indexOf('kube.do') != -1
						|| locationHref.indexOf('kube/channel/recently') != -1
						|| locationHref.indexOf('kube/channel/weekly') != -1
						|| locationHref.indexOf('kube/channel/recommend') != -1
						|| locationHref.indexOf('kube/channel/dept') != -1){
					if(locationHref.indexOf($(this).attr('id')) != -1){        
						$(this).children().eq(0).addClass('selected');
					}
				}else{
					if(locationHref.indexOf('/watch/') != -1){
						if($(this).children().eq(0).attr('id') == $('#p_code_seq').val()){
							$(this).children().eq(0).addClass('selected');
							$(this).find('ul').show();
							
							//하위 li의 a 태그에 addClass
							$(this).find('li').each(function(){
								if($(this).attr('class') == $('#code_seq').val()){
									$(this).children().eq(0).addClass('selected');
								}
							});
						}
					}else{
						if(locationHref.indexOf('hits') != -1
								|| locationHref.indexOf('like') != -1){
							if($(this).attr('id') == 'hits/like'){
								$(this).children().eq(0).addClass('selected');
								$(this).find('ul').show();
								
								//하위 li의 a 태그에 addClass
								$(this).find('li').each(function(){
									if(locationHref.indexOf('/' + $(this).attr('id')) != -1){ 
										$(this).children().eq(0).addClass('selected');
									}
								});
							}
							
						}else{
							if(locationHref.indexOf('/' + $(this).attr('id') + '/') != -1){
								$(this).children().eq(0).addClass('selected');
								$(this).find('ul').show();
								
								//하위 li의 a 태그에 addClass
								$(this).find('li').each(function(){
									if(locationHref.indexOf('/' + $(this).attr('id')) != -1){ 
										$(this).children().eq(0).addClass('selected');
									}
								});
							}
						}
					}
				}
			})
			

		})
		
		$('.leftmenu_li a').on('click',function(){
			
			var style = $(this).next().css('display');
			var elName = $(this).next().get(0).tagName;
			
			if(elName == 'UL'){
				if(style == 'none'){
					$('.leftmenu_li').find('ul').hide();
					$(this).next().show();
				}else{
					$(this).next().hide();
				}
			}
		})
		/*left menu toggle*/
		
		function copyrightPop(){
			window.open('/jsp/kube/copyright_pop.html','copyright','width=530,height=490,left=100,top=100,scrollbars=1');
		}
	</script>
	
<script type="text/javascript">
   var frm;

   /* 인사 정보 표시 레이어 */
   function userLayer(empno) {
       var div_width = 170;
       var div_height = 140;

       linkdiv = $("#userbox");

       if ( linkdiv != null) {
           //user_info.location.href=url_bas+"/brd_user_infom.php?user_id="+user_id;
		//user_info.location.href = "http://daum.net?user_id=" + empno;
           ifrUrl = "http://serv.kepco.co.kr/USER_INFO/user_info_new.php?user_id=" + empno;
           //$("#user_info").attr("src", ifrUrl);
           
           //alert( $("#popiframe").length + '<<<<<popiframe');
           if( $("#userbox").length > 0 ) {
               $("#userbox").remove();
           }
           
		var htmlLayer = '<div id="userbox" style="position: absolute; left: 0; top: 0; width: 220px; height: 140px; visibility: visible; z-index: 1000" onmouseover="overdiv=1;" onmouseout="overdiv=0;setTimeout(\'hideUserLayer()\',200);">'; 
		htmlLayer += '<iframe name="popiframe" id="popiframe" width="99%" height="99%" frameborder="0" scrolling="auto"  marginwidth="0" marginheight="0"></iframe>';
		htmlLayer += '</div>';
		$("body").append(htmlLayer);	//iframeFrm	
		//width set
		
		//pop iframe load
		$("#popiframe").attr("src", ifrUrl);
		
           $("#popiframe").load(function() {
           	var frm = $(this);
            	//ifrContHeight = $(this).prop("scrollHeight");
			//$(this).height(ifrContHeight);
           	//$(this).height($(this).contents().find('body')[0].scrollHeight+30);
           });  			
		

		var sWidth = $(document).clientWidth;
		var sHeight = $(document).clientHeight;		

		var oWidth = $(linkdiv).width();
		var oHeight = $(linkdiv).height();

		// 레이어가 나타날 위치를 셋팅한다.
		var divLeft = event.clientX + (document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft);
		var divTop = event.clientY + (document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop);;			
		divLeft = divLeft + 15;
		divTop = divTop + (-5);

		// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
		if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
		if( divTop + oHeight > sHeight ) divTop -= oHeight;
		
		// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
		if( divLeft < 0 ) divLeft = 0;
		if( divTop < 0 ) divTop = 0;
		
           $('#userbox').css({
            	"top": divTop
            	,"left": divLeft
           	, "position": "absolute"
           	, "visibility": "visible"
		}).show();

       }
       //if end
   }
   
   //사용자 상태조회 test
   function webPresenceUserStatus(usrId) {
       alert(userId + '<<<');
   }

   var overdiv = "0";

   function hideUserLayer() {
       linkdiv = document.all.userbox;
       if (!linkdiv)
           return;

       if (overdiv == "0") {
           linkdiv.style.visibility = "hidden";
           //user_info.location.href = "about:blank";
       }
   }
   
   function funKubeManudalDownAct(){
	   funGoPageDetailSetFrm("/kube/downloadKubeManual.do", "manualDownForm");
   }
</script>
    </body>
</html>