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
		<input type="hidden" id="taskVal" name="taskVal">
		<input type="hidden" id="vi_seq_hash" name="vi_seq_hash">
		   
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
	                    <li><a href="/kube/mypage/bookmarkList.do">즐겨찾기</a></li>
	                    <li><a href="/kube/mypage/downloadReqList.do">다운로드 신청목록</a></li>
	                    <li class="active"><a href="/kube/mypage/videoMgmtList.do">동영상 관리</a></li>
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
	                        	<optgroup label="작업선택">
	                        		<option value="">작업선택</option>
	                        	</optgroup>                            
	                            <optgroup label="공개여부">					           			                                    
		                            <option value="39">공개</option>
		                            <option value="40">비공개</option>
	                            </optgroup>								                                    
	                            <optgroup label="다운로드">								                                    
		                            <option value="41">모두 다운로드 가능</option>
		                            <option value="42">승인자만 다운로드</option>								                                    
		                            <option value="43">다운로드 불가</option>
	                            </optgroup>		
	                            <optgroup label="삭제">								                                    
	                            	<option value="9">삭제</option>
	                            </optgroup>						                                    
	                        </select>
	                </div>
	            </div>
	                  
	            <div style="margin-top:10px;margin-bottom:10px;margin-left:477px;clear:both;display: inline-block;">
	            	<p class="inputDesign"> 
					<select name="selOrder" style="width:90px" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
						<option value="reg_date" ${paging.selOrder == 'reg_date' ? 'selected' : '' }>최신순</option>
						<option value="visit_cnt" ${paging.selOrder == 'visit_cnt' ? 'selected' : '' }>조회순</option>
						<option value="like_cnt" ${paging.selOrder == 'like_cnt' ? 'selected' : '' }>좋아요순</option>
						<option value="down_cnt" ${paging.selOrder == 'down_cnt' ? 'selected' : '' }>다운로드순</option>
					</select>
	            </div>
				
				<div class="basic-list">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 5%" class="no-td">
							<col style="width: 26%">
							<col style="">
							<col style="width: 30%">
						</colgroup>
						<tbody>			
						<c:forEach var="videoList" items="${videoList}" varStatus="videoStatus">
							<c:if test="${videoStatus.first}">
								<tr style="border-top:2px solid #a9abae">
							</c:if>
							<c:if test="${!videoStatus.first}">
								</tr>
																
								<tr>
							</c:if>			
									<td class="no-td">
		                                <div class="checks small">
		                                    <input type="checkbox" id="chk${videoStatus.count }" name="videoChk" value="${cha:seqEncode(videoList.vi_seq) }"> 
		                                    <label for="chk${videoStatus.count }"></label> 
		                                </div>
		                            </td>
									<td class="like-td">
										<img src="${web_url.concat(videoList.thumb_log_path)}" style="cursor: pointer;" class="imgMaxWidth160" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" />
		                            </td>
		                            <td class="like-td" style="text-align:left">  
		                                <span class="media_txt01">${videoList.title}<c:if test="${videoList.conv_flag == '9'}"> (영상 컨버팅 진행 중)</c:if></span><br>
		                                <span class="media_txt02">${videoList.p_code_desc}</span><br>
		                                <span class="media_txt02">등록일 : ${cha:todate(videoList.reg_date, '-', '2')}</span>
		                                <p class="inputDesign">
		                                    <select name="selOpenFlag" style="width:40px" onchange="javascript:funTaskAct(this, '${videoList.open_flag}');">
		                                        <option value="39" ${videoList.open_flag == '39' ? 'selected' : ''}>공개</option>
		                                        <option value="40" ${videoList.open_flag == '40' ? 'selected' : ''}>비공개</option>
		                                    </select>
		                                    <select name="selDownFlag" style="width:150px; margin-left: 10px;" onchange="javascript:funTaskAct(this, '${videoList.download_flag }');">
		                                        <option value="41" ${videoList.download_flag == '41' ? 'selected' : ''}>모두 다운로드 가능</option>
		                                        <option value="42" ${videoList.download_flag == '42' ? 'selected' : ''}>승인자만 다운로드</option>
		                                        <option value="43" ${videoList.download_flag == '43' ? 'selected' : ''}>다운로드 불가</option>
		                                    </select>
		                            </td>   
									<td class="like-td" style="text-align:right">
		                                <span class="media_txt02">조회수 : <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> / 댓글 : <fmt:formatNumber value="${videoList.comment_cnt}" pattern="#,###,###,###"></fmt:formatNumber> / 다운로드 : <fmt:formatNumber value="${videoList.down_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span><br />
		                                <c:if test="${videoList.approve_cnt > 0}"> 
		                                	<span class="media_txt02" style="cursor: pointer;text-decoration: underline;" onclick="javascript:funApproveList('${cha:seqEncode(videoList.vi_seq) }');">다운요청 수 :
		                                		<font style="color: blue; font-weight: bold;"><fmt:formatNumber value="${videoList.approve_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font> / <font style="font-weight: bold;"><fmt:formatNumber value="${videoList.tot_approve_cnt }" pattern="#,###,###,###"></fmt:formatNumber></font>
		                                	</span>
		                                </c:if>
	                                	<c:if test="${videoList.approve_cnt == 0}">
	                                		<span class="media_txt02">다운요청 수 :
		                                		<font style="font-weight: bold;">0</font> / <font style="font-weight: bold;"><fmt:formatNumber value="${videoList.tot_approve_cnt }" pattern="#,###,###,###"></fmt:formatNumber></font>
		                                	</span>
	                                	</c:if>  
		                                <br><br>
		                                <img src="/resource/images/sub/icon_04.png" /> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp;&nbsp;&nbsp;<img src="/resource/images/sub/icon_05.png" /> <fmt:formatNumber value="${videoList.unlike_cnt}" pattern="#,###,###,###"></fmt:formatNumber>
		                            </td>
                           <c:if test="${videoStatus.last}">
						   		</tr>
						   </c:if> 
			            </c:forEach>
						</tbody>
					</table>
				</div>
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
	
	$('select[name=selTask]').prev().css('height','210px');          
	$('select[name=selDownFlag]').parent().css('margin-left','10px');           
	
	funAllChkCtrl();
});

function funTaskAct(obj, g){
	
	var selectedVal	= $(obj).val();
	var pre_selectedVal = '';
	var boolChk = true;
	
	if(g != undefined){
		//같은 상태값으로 변경 불가		
		if(selectedVal != g){
			pre_selectedVal = g;
			$(obj).closest('td').prev().prev().find('input').prop("checked", true);
		}else{
			boolChk = false;
		}
	}
	
	if(selectedVal != '' && boolChk){
		var chkCnt = 0;
		
		$('#taskVal').val(selectedVal);
		
		$('input[name=videoChk]').each(function(){
			if($(this).is(":checked")){
				chkCnt = chkCnt + 1;
			}
		});
		
		if(chkCnt == 0){
			alert('1개 이상의 영상을 선택해야 합니다.');
			$(obj).val('');
			$(obj).jqTransSelect();
			$('select[name=selTask]').prev().css('height','210px'); 
			return false;
		}else{
			var alert_msg = '';
			
			if(selectedVal == '39' || selectedVal == '40' ){
				alert_msg = '공개 상태를 변경하시겠습니까?';
			}else if(selectedVal == '41' || selectedVal == '42' || selectedVal == '43'){
				alert_msg = '다운로드 요청 건이 있는 상태에서 다운로드 권한을 변경할 경우\n기존의 요청은 모두 거절 됩니다.\n\n그래도 다운로드 권한을 변경하시겠습니까?';
			}else if(selectedVal == '9'){
				alert_msg = '영상을 삭제할 경우 복구가 불가능 합니다.\n\n정말 삭제하시겠습니까?';
			}
			
			if(confirm(alert_msg)){
				dataString = $("#frm").serialize();

			    $.ajax({
			       type: "POST",
			       url: "/kube/mypage/updateMyVideoFlag.do",
			       data: dataString,
			       dataType: "json",
			       success: function(msg) {
			    	   
			    	   var tmp_result = $.trim(msg);
			    	   if(tmp_result != 'false'){
			    		   funFrmPagingSubmit2(document.location.href);
						   
			    		   return true;
						}else{
			    		   alert("오류가 발생 했습니다");
			    		   
			    		   if(g != undefined){ 
								$(obj).val(pre_selectedVal);
								$(obj).jqTransSelect();
								$(obj).closest('td').prev().prev().find('input').prop("checked", false);
							}else{
								$(obj).val('');
								$(obj).jqTransSelect(); 
								$('select[name=selTask]').prev().css('height','210px');
							}
			    		   return false;
						}
			 		}             
				}); 
			}else{
				if(g != undefined){ 
					$(obj).val(pre_selectedVal);
					$(obj).jqTransSelect();
					$(obj).closest('td').prev().prev().find('input').prop("checked", false);
				}else{
					$(obj).val('');
					$(obj).jqTransSelect();
					$('select[name=selTask]').prev().css('height','210px');
				}
				return false;
			}
		}
	}
}

function funApproveList(vi_seq_hash){
	$('#vi_seq_hash').val(vi_seq_hash);
	funFrmPagingSubmit2('/kube/mypage/approveReqList.do');
}

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />