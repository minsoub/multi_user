<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
.jqTransformSelectWrapper {
    float: left;
    position: relative;
    width: 106px;
    height: 27px;
    background: url("/resource/images/btn/select_bg.gif") no-repeat top left;
    margin-right: 0px;
}
</style>
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
		<form id="frm" name="frm" method="post">
		<input type="hidden" id="code_seq" name="code_seq">
		<input type="hidden" id="p_code_seq" name="p_code_seq">
		<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
		<input type="hidden" id="right_gubun" name="right_gubun">
		   
			<div class="contents-con-framebox">
				<div class="nav-box">
	                <div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
					<div class="nav-list">
						<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">마이페이지</b>
					</div>
					<div class="nav-title">마이페이지</div>
				</div>
	            
	            <div style="margin-bottom:10px;">
	                <ul class="equip">
	                    <li class="active"><a href="/kube/mypage/bookmarkList.do">즐겨찾기</a></li>
	                    <li><a href="/kube/mypage/downloadReqList.do">다운로드 신청목록</a></li>
	                    <li><a href="/kube/mypage/videoMgmtList.do">동영상 관리</a></li>
	                    <li><a href="/kube/mypage/approveReqList.do">저작권 관리</a></li>
	                    <li><a href="/kube/mypage/videoCommentList.do">댓글 관리</a></li>
	                </ul>
	            </div>
	            
	            <div style="margin-top:10px;margin-bottom:10px; float:left">
	                <div class="checks small" style="float:left; margin-top:5px">
	                    <input type="checkbox" id="chk0" name="videoChk" value="all"> 
	                    <label for="chk0"></label> 
	                </div>
	                <div>
	                    <p class="inputDesign">
	                        <select name="selTask" onchange="javascript:funTaskAct(this);" style="width:150px">
	                            <option value="">작업선택</option>								                                    
	                            <option value="1">영상 반복재생</option>
	                            <option value="2">즐겨찾기 제거</option>								                                    
	                        </select>
	                </div>
	            </div>
	                  
	            <div style="margin-top:10px;margin-bottom:10px;margin-left:477px;clear:both;display: inline-block;">
	            	<p class="inputDesign"> 
					<select name="selOrder" style="width:90px" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
						<option value="reg_date" ${paging.selOrder == 'reg_date' ? 'selected' : '' }>최신순</option>
						<option value="popular_cnt" ${paging.selOrder == 'popular_cnt' ? 'selected' : '' }>인기순</option>
					</select>
	            </div>
				
				<c:forEach var="videoList" items="${videoList}" varStatus="videoStatus">
					<c:if test="${videoStatus.first}">
						<div class="media-box" style="clear:both">
					</c:if>
					<c:if test="${!videoStatus.first && videoStatus.index % 4 == 0}">
						</div>
						
						<div style="clear:both"></div> 
	            
	            		<div class="media-box" style="margin-top:95px;">
					</c:if>
		                <div class="media-box01" style="float:left; ${videoStatus.index % 4 != 0 ? 'margin-left:13px' : ''}">
		                    <div style="float:left">
		                    	<div class="checks small" style="position: absolute; padding: 15px;">
		                            <input type="checkbox" id="chk${videoStatus.count }" name="videoChk" value="${cha:seqEncode(videoList.vi_seq) }"> 
		                            <label for="chk${videoStatus.count }" style="margin-right: -6px;"></label> 
		                        </div>
		                        <div class="media-time" style="margin-top:80px; margin-left:134px">
		                            ${cha:secToHour(videoList.duration)}
		                        </div>
		                        <img src="${web_url.concat(videoList.thumb_log_path)}" style="cursor: pointer;" class="imgMaxWidth180" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" />
		                    </div>                
		                    <span class="media_txt01">${cha:splitStr(videoList.title, '20')}</span><br>
		                    <!-- <span class="media_txt02">한전 NEWS</span><br> -->
		                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
		                </div>
					<c:if test="${videoStatus.last}">
						</div>
						
						<div style="clear:both;"></div>
					</c:if> 
	            </c:forEach>
	            <c:if test="${fn:length(videoList) == 0}">
	            	<div class="none_srh_result" style="clear:both">
	            		조회 결과가 없습니다.
	            	</div>
	            	
	            	<div style="clear:both"></div>
	            </c:if>
	                    
	            <div style="margin-bottom: 250px;margin-top: -170px;"></div>  
				<c:import url="/resource/common/include/kube_paging.jsp" />
				</div> 
			</form>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
	
	funAllChkCtrl();
});

function funTaskAct(obj){
	var selectedVal = $(obj).val();
	
	if(selectedVal != ''){
		var chkCnt = 0;
		
		$('input[name=videoChk]').each(function(){
			if($(this).is(":checked")){
				chkCnt = chkCnt + 1;
			}
		});
		
		if(chkCnt == 0){
			alert('1개 이상의 영상을 선택해야 합니다.');
			$(obj).val('');
			$(obj).jqTransSelect();
			return false;
		}else{
			if(selectedVal == '1'){
				
				$('input[name=chkVideoSeqArr]').remove();
				
				$('input[name=videoChk]').each(function(){
					if($(this).is(":checked")){  
						if($(this).val() != 'all'){  
							$('#frm').append('<input type="hidden" name="chkVideoSeqArr" value="' + $(this).val() + '" />');
						}
					}
				});
				
				$('#right_gubun').val('M');
				
				funGoPageDetail('/kube/watch/' + $('input[name=chkVideoSeqArr]').eq(0).val());
				return true;
			}else if(selectedVal == '2'){
				if(confirm('선택하신 영상을 즐겨찾기 목록에서 제거 하시겠습니까?')){
					dataString = $("#frm").serialize();
	
				    $.ajax({
				       type: "POST",
				       url: "/kube/mypage/deleteMyBookMarkVideo.do",
				       data: dataString,
				       dataType: "json",
				       success: function(msg) {
				    	   
				    	   var tmp_result = $.trim(msg);
				    	   if(tmp_result != 'false'){
							   location.replace('/kube/mypage/bookmarkList.do');
							   
				    		   return true;
							}else{
				    		   alert("오류가 발생 했습니다");
				    		   $(obj).val('');
							   $(obj).jqTransSelect();
				    		   return false;
							}
				 		}
					});
				}else{
					$(obj).val('');
					$(obj).jqTransSelect();
					
					return false;
				}
			}
		}
	}
}

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />