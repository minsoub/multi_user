<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="9"></c:param>
			</c:import> 
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리자</b>
				</div>
				<div class="nav-title">카테고리 관리</div>
			</div>
            
            <div style="margin-bottom:10px;">
                <ul class="equip">
                    <li id="1"><a href="javascript:;">메인화면 관리</a></li>
                    <li id="2" class="active"><a href="javascript:;">카테고리 관리</a></li>
                    <li id="3"><a href="javascript:;">신고영상 관리</a></li>
                    <li id="6"><a href="javascript:;">영상 관리</a></li>
                    <li id="4"><a href="javascript:;">사용자 관리</a></li>
                    <li id="5"><a href="javascript:;">운영자 관리</a></li>
                </ul>
            </div>
            
            <form id="frm" name="frm" method="post">
	            <div class="sub-nav-title-sm">1차 카테고리</div>	

				<div class="basic-list">
					<div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>1차 카테고리</legend>
								<div class="row-group">	
	                            	<dl class="insert_ready">
	                            		<c:forEach var="category" items="${kubeLeftMenu}" varStatus="status">
	                            			<c:if test="${category.p_code_seq == 0}">
												<dd>
			                                        <div class="checks small" style="width:105px">
			                                        	<a href="javascript:;" onclick="javascript:funModCode('1', '${category.p_code_seq}', '${category.code_seq}');">${category.code_desc }</a>
			                                        </div>
			                                    </dd>
			                                </c:if>
		                                </c:forEach>
									</dl>
								</div>
							</fieldset>
						</div>
	                </div>
	                </div>
				</div>
	            
	            <div class="btn-zone" style="margin-top:-25px">
	                <ul>
	                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funRegCode('1');" value="등록"></li>
	                </ul>
	            </div>
	            
	            <div class="sub-nav-title-sm" style="clear:both; margin-top: 55px;">2차 카테고리</div>		
	
				<div class="basic-list">
					<div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>2차 카테고리</legend>
								<div class="row-group">	
                            		<c:set var="categoryCnt" value="0" />
                            		<c:forEach var="category" items="${kubeLeftMenu}" varStatus="status">
                            			<c:if test="${category.p_code_seq == 0}">
                            				<c:if test="${status.index != 0}">
                            						<c:if test="${categoryCnt == 0}">
                            							<dd></dd>
                            						</c:if>
                           							<c:set var="categoryCnt" value="0" />
	                            				</dl>
	                            			</c:if>
                            			<dl class="insert_ready">
                            				<dt class="must-option"><label for="">${category.code_desc }</label></dt>
		                                </c:if>
		                                <c:if test="${category.p_code_seq != 0}">
			                                <dd>
		                                        <div class="checks small" style="width:105px">
		                                        	<c:if test="${category.p_code_seq !=  5}">
														<a href="javascript:;" onclick="javascript:funModCode('2', '${category.p_code_seq}', '${category.code_seq}');">${category.sub_code_desc }</a>
													</c:if> 
													<c:if test="${category.p_code_seq ==  5}">
														<a href="javascript:;" onclick="javascript:alert('사업소 카테고리는 수정할 수 없습니다');">${category.sub_code_desc }</a>
													</c:if>
		                                        </div>
		                                    </dd>
		                                    <c:set var="categoryCnt" value="${categoryCnt + 1}" />
	                                    </c:if>
	                                    <c:if test="${status.last }">
	                                    	<c:if test="${categoryCnt == 0}">
                           							<dd></dd>
                           						</c:if>
                            				</dl>
	                                    </c:if>
	                                </c:forEach>
								</div>
							</fieldset>
						</div>
	                </div>
                </div>
                
                <div class="btn-zone" style="margin-top:-25px">
	                <ul>
	                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funRegCode('2');" value="등록"></li>
	                </ul>
	            </div>
	            
                <div class="sub-nav-title-sm" style="clear: both; margin-top: 55px;">신고 카테고리</div>  	

				<div class="basic-list">
					<div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>신고 카테고리</legend>
								<div class="row-group">	
	                            	<dl class="insert_ready">
	                            		<c:forEach var="category" items="${codeList}" varStatus="status">
											<dd>
		                                        <div class="checks small" style="width:105px">
		                                        	<a href="javascript:;" onclick="javascript:funModCode('14', '${category.p_code_seq}', '${category.code_seq}');">${category.code_desc }</a>
		                                        </div>
		                                    </dd>
		                                </c:forEach>
									</dl>
								</div>
							</fieldset>
						</div>
	                </div>
	                </div>
				</div>
	            
	            <div class="btn-zone" style="margin-top:-25px">
	                <ul>
	                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funRegCode('14');" value="등록"></li>
	                </ul>
	            </div>
			</div>
			</form>
            
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
});

$('.equip > li').click(function (){
	var menu = $(this).attr('id');
	var linkUrl = '/kubeMainMgmt.do';
	
    if(menu == 2){
    	linkUrl = '/kubeCategoryMgmt.do';
	}else if(menu == 3){
		linkUrl = '/kubeReportMgmt.do';
	}else if(menu == 4){
		linkUrl = '/kubeUserMgmt.do';
	}else if(menu == 5){
		linkUrl = '/kubeSaMgmt.do';
	}else if(menu == 6){
		linkUrl = '/kubeVideoMgmt.do';
	}
	
    goUrl(linkUrl);
});
 
function funRegCode(gubun){
	window.open('/kubeCategoryPop.do?ct=' + gubun, 'reg_category_pop','width=400px,height=370px,left=550px,top=300px');
}

function funModCode(gubun, p_code_seq, code_seq){
	window.open('/kubeCategoryPop.do?ct=' + gubun + '&p=' + p_code_seq + '&s=' + code_seq,'category_pop','width=400px,height=370px,left=550px,top=300px');
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />