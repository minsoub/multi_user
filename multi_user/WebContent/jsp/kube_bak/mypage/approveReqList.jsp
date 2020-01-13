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
		<input type="hidden" id="app_empno" name="app_empno">
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
	                    <li><a href="/kube/mypage/videoMgmtList.do">동영상 관리</a></li>
	                    <li class="active"><a href="/kube/mypage/approveReqList.do">저작권 관리</a></li>
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
	                            <option value="45">전체 승인</option>
	                            <option value="46">전체 거절</option>								                                    
	                        </select>
	                </div>
	            </div>
	            <div style="margin-top:10px;margin-bottom:10px;margin-left:477px;clear:both;display: inline-block;">
	            	<p class="inputDesign"> 
					<select name="selOrder" style="width:90px" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
						<option value="approve_date" ${paging.selOrder == 'approve_date' ? 'selected' : '' }>최근요청순</option>
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
						<c:set var="tmp_vi_seq" value=""></c:set>	
						<c:set var="tmp_app_vi_seq" value=""></c:set>	
						<c:forEach var="videoList" items="${videoList}" varStatus="videoStatus">
							<c:if test="${videoStatus.first}">
								<tr style="border-top:2px solid #a9abae">
							</c:if>
							<c:if test="${!videoStatus.first}">
								<tr>
							</c:if>			
									<td class="no-td">
		                                <div class="checks small">
		                                    <input type="checkbox" id="chk${cha:seqEncode(videoList.vi_seq)}" name="videoChk" value="${cha:seqEncode(videoList.vi_seq) }"> 
		                                    <label for="chk${cha:seqEncode(videoList.vi_seq)}"></label> 
		                                </div>
		                            </td>
									<td class="like-td">
										<img src="${web_url.concat(videoList.thumb_log_path)}" style="cursor: pointer;" class="imgMaxWidth160" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" />
		                            </td>
		                            <td class="like-td" style="text-align:left">
		                                <span class="media_txt01">${videoList.title}</span><br>
		                                <span class="media_txt02">${videoList.p_code_desc}</span><br>
		                                <span class="media_txt02">등록일 : ${cha:todate(videoList.reg_date, '-', '3')}</span>
										<span class="media_txt02">승인자만 다운로드</span>
		                            </td>   
									<td class="like-td" style="text-align:right">
		                                <span class="media_txt02">조회수 : <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> / 댓글 : <fmt:formatNumber value="${videoList.comment_cnt}" pattern="#,###,###,###"></fmt:formatNumber> / 다운로드 : <fmt:formatNumber value="${videoList.down_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span><br />                                
	                                	<c:if test="${videoList.approve_cnt > 0}"> 
		                                	<span class="media_txt02" style="cursor: pointer;text-decoration: underline;" onclick="javascript:$('.approveSubTr${videoList.vi_seq}').toggle();">다운요청 수 :
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
						   		</tr>
						   <c:forEach var="approveList" items="${approveList }" varStatus="approveStatus">
						   		<c:if test="${videoList.vi_seq == approveList.vi_seq}">
									<c:if test="${fn:trim(targetVi_seq) != '' && fn:trim(targetVi_seq) != null}">
										<tr class="approveSubTr${approveList.vi_seq }" style="${targetVi_seq != cha:seqEncode(approveList.vi_seq) ? 'display: none;' : ''}">
									</c:if>
									<c:if test="${fn:trim(targetVi_seq) == '' || fn:trim(targetVi_seq) == null}">
										<tr class="approveSubTr${approveList.vi_seq }">
									</c:if>
											<td colspan="4" style="background-color:#f7f7f7;padding-left:20px;">
				                                <table class="table_sm" style="width:97%">
				                                    <colgroup>
				                                        <col style="width: 5%" class="no-td">
				                                        <col style="width: 45%;">
				                                        <col style="">
				                                        <col style="width: 26%">   
				                                    </colgroup>
				                                    <tr>
				                                        <td><img src="/resource/images/sub/icon_reply.png" /></td>
				                                        <td style="text-align: left;">${approveList.dept_name1 }<br /> ${approveList.dept_name2 } ${approveList.name }</td>
				                                        <td>신청일 : ${cha:todate(approveList.approve_date, '-', '2') }</td>
				                                        <td>  
				                                        	<c:if test="${approveList.va_status == 44}">
				                                        		<img src="/resource/images/sub/btn_03.png" style="cursor: pointer;" onclick="javascript:funTaskAct('${cha:seqEncode(approveList.vi_seq) }', '${approveList.app_empno}', '45');" /> <img src="/resource/images/sub/btn_04.png" style="cursor: pointer;" onclick="javascript:funTaskAct('${cha:seqEncode(approveList.vi_seq) }', '${approveList.app_empno}', '46');" />
				                                        	</c:if>
				                                        	<c:if test="${approveList.va_status == 45}">
				                                        		<span style="color:#0069d6"><b>승인완료</b></span>
				                                        	</c:if>
				                                        	<c:if test="${approveList.va_status == 46}">
				                                        		<span style="color:#da1f00"><b>승인거절</b></span>
				                                        	</c:if>
				                                        </td>
				                                    </tr>
												</table>
											</td>
										</tr>
								</c:if>
							</c:forEach>
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
	
	funAllChkCtrl();
});

function funTaskAct(obj, app_empno, g){
	
	var selectedVal	= '';
	
	if(g != undefined){
		$('#chk' + obj).prop("checked", true);
		selectedVal	= g;
	}else{
		selectedVal	= $(obj).val();
	}
	
	if(selectedVal != ''){
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
			return false;
		}else{
			var alert_msg = '';
			
			if(selectedVal == '45'){
				alert_msg = '선택하신 요청 건을 승인 하시겠습니까?';
			}else if(selectedVal == '46'){
				alert_msg = '선택하신 요청 건을 거절 하시겠습니까?';
			}
			
			if(confirm(alert_msg)){
				
				if(g != undefined){
					$('#app_empno').val(app_empno);
					$('#vi_seq_hash').val(obj);
				}
				
				dataString = $("#frm").serialize();

			    $.ajax({
			       type: "POST",
			       url: "/kube/mypage/updateMyVideoApproveFlag.do",
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
								$('#chk' + obj).prop("checked", false);
								$('#app_empno').val('');
								$('#vi_seq_hash').val('');
							}else{
								$(obj).val('');
								$(obj).jqTransSelect(); 
							}
			    		   return false;
						}
			 		}             
				}); 
			}else{
				if(g != undefined){ 
					$('#chk' + obj).prop("checked", false);
					$('#app_empno').val('');
					$('#vi_seq_hash').val('');
				}else{
					$(obj).val('');
					$(obj).jqTransSelect();
				}
				return false;
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