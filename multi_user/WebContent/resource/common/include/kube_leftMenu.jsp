<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<style>
.leftmenu_li a:HOVER{
	font-weight: bold;
}
</style>
<div id="container">
	<!-- 
	<div id="left">                    
         <div class="lnb">
             <a href=""><img alt="" src="images/btn_upload.png"></a>
             <ul>
                 <li><a class="selected" href="">홈</a></li>
                 <li><a href="">한전 NEWS</a>
                     <ul class="lnb_s">
                         <li><a href="">한전 NEWS 서브 메뉴1</a></li>
                         <li><a href="">한전 NEWS 서브 메뉴2</a></li>
                         <li><a href="">한전 NEWS 서브 메뉴3</a></li>
                     </ul>
                 </li>
                 <li><a href="">교육</a>
                     <ul class="lnb_s">
                         <li><a href="">교육 서브 메뉴1</a></li>
                         <li><a href="">교육 서브 메뉴2</a></li>
                     </ul>
                 </li>
                 <li><a href="">FUN</a></li>
                 <li><a href="">사내 UCC</a></li>
                 <li><a href="">사업소별 영상</a></li>
             </ul>   
         </div>                    
         
         <div class="banner_box">
             <ul>
                 <li><a href=""><img src="images/banner_01.png"></a></li>
                 <li><a href=""><img src="images/banner_02.png"></a></li>
                 <li><a href=""><img src="images/banner_03.png"></a></li>
             </ul>
         </div> 
         
     </div>
     -->
	<div id="left" style="overflow-x: hidden; overflow-y: auto; visibility: hidden;">                    
	    <div class="lnb" style="visibility: visible;">
	        <a href="/videoWrite.do"><img alt="" src="/resource/kube_images/btn_upload.png"></a>
	        <ul>
	            <li class="leftmenu_li" id="kube.do"><a href="/kube.do">홈</a></li>
	            <li class="leftmenu_li" id="kube/channel/recently"><a href="/kube/channel/recently">최신 동영상</a></li>
	            <li class="leftmenu_li" id="hits/like"><a href="javascript:;">인기 동영상</a>
	            	<ul class="lnb_s" style="display: none;">
	            		<li id="hits" onclick="javascript:location.href= $(this).find('a').attr('href');"><a href="/kube/channel/hits">조회수 인기</a></li>
	            		<li id="like" onclick="javascript:location.href= $(this).find('a').attr('href');"><a href="/kube/channel/like">좋아요 인기</a></li>
	            	</ul> 
	            </li> 
	            <li class="leftmenu_li" id="kube/channel/recommend"><a href="/kube/channel/recommend">추천 동영상</a></li> 
	            <c:set var="tmp_p_code_seq" value=""></c:set>
	            <c:set var="dept_menu_chk" value="N"></c:set>
                <c:forEach var="kubeLeftMenu" items="${kubeLeftMenu}" varStatus="status">
                	<c:if test="${kubeLeftMenu.p_code_seq == 0 && kubeLeftMenu.sub_cnt > 0}">
                		<c:if test="${status.index != 0}">
                				<c:if test="${tmp_p_code_seq != '' && tmp_p_code_seq != kubeLeftMenu.p_code_seq}"> 
			                			</ul>
			                	</c:if> 
                			</li>
                		</c:if>
                	</c:if>
                	<c:if test="${kubeLeftMenu.p_code_seq == 0 
                					&& kubeLeftMenu.sub_cnt > 0}">
                		
                		<%-- e-러닝이 최하단으로 위치하면서 예외처리 추가. --%>			
                		<c:if test="${kubeLeftMenu.link_url == 'elearn' }">
                			<c:set var="dept_menu_chk" value="Y"></c:set>
							<li class="leftmenu_li" id="kube/channel/dept"><a href="/kube/channel/dept">사업소별 영상</a></li>                		
                		</c:if>
                		
	                	<li class="leftmenu_li" id="${kubeLeftMenu.link_url}">
	                		<%-- elearn 대메뉴 클릭시 전체 리스트 출력. 20190107 --%> 
	                		<c:if test="${kubeLeftMenu.link_url == 'elearn' }">
                				<a href="javascript:location.href='/kube/channel/${kubeLeftMenu.link_url}/${cha:seqEncode(kubeLeftMenu.code_seq)}/${cha:seqEncode(999999)}';" id="${kubeLeftMenu.code_seq}" >${kubeLeftMenu.code_desc }</a>
                				<img src="/resource/kube_images/btn_edit.png" style="float:right; margin: -37px 58px 0px 0px;cursor: pointer;" onclick="location.href='/kube/mypage/customizeMenu.do'">
	                		</c:if>
	                		<c:if test="${kubeLeftMenu.link_url != 'elearn' }">
                				<a href="javascript:;" id="${kubeLeftMenu.code_seq}" >${kubeLeftMenu.code_desc }<img src="/resource/kube_images/btn_edit.png" style="float:right; margin: 13px 25px 0px 0px;" onclick="location.href='/kube/mypage/customizeMenu.do'"></a>
                				<!-- <a href="/kube/mypage/customizeMenu.do" style="border-bottom: 0px;"><img src="/resource/kube_images/btn_edit.png" style="position:absolute; top:235px;left:110px;"></a> -->
                			</c:if>
	                </c:if>
	                 
	                <c:if test="${kubeLeftMenu.p_code_seq != 0
                					&& ((kubeLeftMenu.m_gubun == 'USER_MENU' && kubeLeftMenu.use_flag == 1) || kubeLeftMenu.m_gubun == 'COMMON_MENU')}">
	                	<c:if test="${tmp_p_code_seq != kubeLeftMenu.p_code_seq}">
				            <ul class="lnb_s" style="display: none;">
		            	</c:if>
						<li id="${cha:seqEncode(kubeLeftMenu.code_seq)}" class="${kubeLeftMenu.code_seq}" onclick="javascript:location.href= $(this).find('a').attr('href');"><a href="/kube/channel/${kubeLeftMenu.link_url}/${cha:seqEncode(kubeLeftMenu.p_code_seq)}/${cha:seqEncode(kubeLeftMenu.code_seq)}">${kubeLeftMenu.sub_code_desc}</a></li>
						<c:set var="tmp_p_code_seq" value="${kubeLeftMenu.p_code_seq}"></c:set>
	                </c:if>
	                <c:if test="${status.last }">
	                			</ul>
                		</li>
	                </c:if>
                </c:forEach>
                <%--e-러닝 메뉴 추가되면서 상단으로 이동하였으나, e-러닝 메뉴 상태에 따라 사업소별 영상 메뉴가 안보일수 있으므로 별도 예외처리 추가함 --%>
                <c:if test="${dept_menu_chk == 'N'}">
                	<li class="leftmenu_li" id="kube/channel/dept"><a href="/kube/channel/dept">사업소별 영상</a></li>
                </c:if>
	        </ul>   
	    </div>
	    <div class="banner_box" style="visibility: visible;">
	        <ul>
	            <!-- <li><a href="/kube/channel/top"><img src="/resource/kube_images/banner_03.png"></a></li> -->
	            <li><a href="javascript:;" onclick="javascript:na_open_window('video_help', '/jsp/video_help.jsp', 0, 0, 757, 379, 0, 0, 0, 0, 0);"><img src="/resource/kube_images/banner_05.png" style="margin-top: 20px;"></a></li>
	            <li><a href="http://serv.kepco.co.kr:8888/WEB2/TBBS/index.php?hpcode=A00189&menuid=0000223152" target="_opinion"><img src="/resource/kube_images/banner_07.png"></a></li>
	            <li><img src="/resource/kube_images/banner_06.png" onclick="javascript:funKubeManudalDownAct();" style="cursor: pointer;"></li>
	        </ul>
	    </div>                    
	</div>
	<div id="right">
