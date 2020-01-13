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
		<input type="hidden" id="target_vc_seq" name="target_vc_seq" value="LX4IaGcnTLA8InG">
		<input type="hidden" id="target_vc_seq_idx" name="target_vc_seq_idx" value="0">
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
	                    <li><a href="/kube/mypage/approveReqList.do">저작권 관리</a></li>
	                    <li class="active"><a href="/kube/mypage/videoCommentList.do">댓글 관리</a></li>
	                </ul>
	            </div>
	            
	            <div style="margin-top:10px;margin-bottom:10px;margin-left:666px;clear:both;display: inline-block;">
	            	<p class="inputDesign"> 
					<select name="selOrder" style="width:90px" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
						<option value="comment_date" ${paging.selOrder == 'comment_date' ? 'selected' : '' }>최신 댓글순</option>
						<option value="reg_date" ${paging.selOrder == 'reg_date' ? 'selected' : '' }>최신순</option>
						<option value="popular_cnt" ${paging.selOrder == 'popular_cnt' ? 'selected' : '' }>인기순</option>
					</select>
	            </div>
				
				<c:set var="tmp_vi_seq" value=""></c:set>
				<%-- videoDetail.jsp 스크립트 그대로 사용하기 위한 더미용 댓글  --%>
				<div style="border-top: 1px solid #cecece;display: none;">
                    <div class="sub-nav-title1" style="margin-top:30px">댓글</div>                
                    <div style="margin-top:5px; padding-top:5px">
                        <textarea class="textarea-style" rows="4" name="comment_desc" style="width:88%; border:1px solid #cfcfcf"></textarea>
                        <input type="button" name="srchDescription" class="btn_down" onclick="javascript:funCommentReg(this, '0')" value="등록" style="width:80px;height:69px;background-color:#0b4894" >
                        <input type="hidden" name="p_vc" value="LX4IaGcnTLA8InG" />
                    </div>
                </div>
                
				<div class="basic-list">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 1px">
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
								
								<tr id="commentTr${cha:seqEncode(tmp_vi_seq) }" style="display: none;">
									<td colspan="4"> 
										 <div class="basic-list">
						                    <table id="listTable" summary="">
						                        <caption>게시판 테이블</caption>
						                        <tbody id="commentTbody${cha:seqEncode(tmp_vi_seq) }">
											   </tbody>
										    </table>
									     </div>
							     	</td>
							    </tr>
							    
								<tr>
							</c:if>			
									<td class="no-td"></td>
									<td class="like-td">
										<img src="${web_url.concat(videoList.thumb_log_path)}" style="cursor: pointer;" class="imgMaxWidth160" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" />
		                            </td>
		                            <td class="like-td" style="text-align:left">
		                                <span class="media_txt01">${videoList.title}</span><br>
		                                <span class="media_txt02">${videoList.p_code_desc}</span><br>
		                                <span class="media_txt02">등록일 : ${cha:todate(videoList.reg_date, '-', '2')}</span>
		                            </td>   
									<td class="like-td" style="text-align:right">
		                                <span class="media_txt02">조회수 : <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> / <font id="totCmmCnt${cha:seqEncode(videoList.vi_seq) }">댓글</font> : <font><fmt:formatNumber value="${videoList.comment_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font> / 다운로드 : <fmt:formatNumber value="${videoList.down_cnt}" pattern="#,###,###,###"></fmt:formatNumber> </span>
		                                <img src="/resource/images/sub/btn_02.png" onclick="javascript:funGetCommentList('${cha:seqEncode(videoList.vi_seq) }');" style="cursor: pointer;" /><br /><br><br> 
		                                <img src="/resource/images/sub/icon_04.png" /> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp;&nbsp;&nbsp;<img src="/resource/images/sub/icon_05.png" /> <fmt:formatNumber value="${videoList.unlike_cnt}" pattern="#,###,###,###"></fmt:formatNumber>
		                            </td>
                           <c:if test="${videoStatus.last}">
						   		</tr>

						   		<tr id="commentTr${cha:seqEncode(videoList.vi_seq) }" style="display: none;">
									<td colspan="4">
										 <div class="basic-list">
						                    <table id="listTable" summary="">
						                        <caption>게시판 테이블</caption>
						                        <tbody id="commentTbody${cha:seqEncode(videoList.vi_seq) }">
											   </tbody>
										    </table>
									     </div>
							     	</td>
							    </tr>   
						   </c:if> 
						   
						   <c:set var="tmp_vi_seq" value="${videoList.vi_seq }"></c:set>
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

<div style="width: 100%;height:100%; position: absolute;top:153px; z-index:1; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div id="report_div" class="popup_view_box1" style="width:650px; background-color: #fff;">
	<h3 style="color:#fff">신고하기</h3>
	    <div class="basic-list" style="margin-top:35px;">
	        <form id="rfrm" name="rfrm" method="post">		
	        <input type="hidden" id="vi_seq_hash_r" name="vi_seq_hash_r">
	        <input type="hidden" id="vc_seq_hash_r" name="vc_seq_hash_r">
			<input type="hidden" id="report_gubun" name="report_gubun">		
	            <div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>화면1</legend>
								<div class="row-group">	                                
	                                <dl class="insert_ready">
										<dt class="must-option"><label for="" id="">신고분류</label></dt>
										<dd>                                    
                                            <fieldset>	
                                                <div class="form-group">
                                                    <legend>신고분류</legend>                        
                                                    <div>
                                                        <p class="inputDesign">
                                                        <select name="selReport" style="width:200px">
                                                            <option value="">선택</option>
                                                            <c:forEach var="codeList" items="${codeList }">
	                                                        	<option value="${codeList.code_seq}">${codeList.code_desc}</option>
															</c:forEach>				                                    
                                                        </select> <b>※ 등록된 신고 내용은 취소가 불가능합니다.</b>
							                        </div>
                                                </div>
                                            </fieldset>
	                                    </dd>
									</dl>
	                                <dl class="insert_ready">
										<dt class="must-option"><label for="" id="">신고사유</label></dt>
										<dd><textarea rows="6" cols="50" id="re_desc" name="re_desc"></textarea></dd>
									</dl>
								</div>
							</fieldset>
						</div>
	                </div>
	            </div>
	        </form>
	    </div>    
	    <div class="btn-zone">
			<ul>
	            <li><input type="button" name="" class="search_btn" onclick="javascript:funReport();" value="신고"></li>
				<li><input type="button" name="" class="search_btn" onclick="javascript:$('#report_div').parent().hide();" value="취소"></li>
			</ul>
		</div>
	</div>
</div>


<script type="text/javascript">
var _submit = true;

$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
	
	funAllChkCtrl();
});

//댓글 동적 리스트
function funGetCommentList(vi_seq_hash){
	
	$('#vi_seq_hash').val(vi_seq_hash);
	
	var param = {'vi_seq_hash' : $('#vi_seq_hash').val(), 'o' : 'R', 'gubun' : 'all'}
	
    $.ajax({
       url: "/kube/getCommentList.do",
       type: "POST",
       data: param,
       dataType: "html",
       success: function(msg) {
    	   var tmp_result = $.trim(msg);
			
    	   if(tmp_result != 'false'){
    		   
    		   if(tmp_result != ''){
    			    $('tbody[id^=commentTbody]').html('');
    			    $('tr[id^=commentTr]').hide();
    			    
					$('#commentTbody' + vi_seq_hash).html(msg);
    			    $('#commentTr' + vi_seq_hash).show();
    		   }
    		   
    		   return true;
			}else{
    		   alert("댓글을 가져오는 중 오류가 발생 했습니다");
    		   
    		   return false;
			}
 		}
	});
}

//각 이벤트 
function funMyAct(obj, vc){
	 
	if(_submit){
		
		_submit = false;
		
		if(vc != undefined){
			$('#target_vc_seq').val(vc);
		}
		//console.log($('#target_vc_seq').val());
		var param = {'vi_seq_hash' : $('#vi_seq_hash').val(), 'ma' : $(obj).attr('name'), 'target_vc_seq' : $('#target_vc_seq').val()} 
		
	    $.ajax({
	       url: "/kube/userActCtrl.do",
	       type: "POST",
	       data: param,
	       dataType: "json",
	       success: function(msg) {
				
	    	   var tmp_result = $.trim(msg);
	    	   if(tmp_result != 'false'){
	    		   
	    		   var idVal = parseInt($(obj).attr('name'));
	    		   var cntVal = parseInt($(obj).next().text().replace(/,/gi, ''));
				   
	    		   if(parseInt(idVal) < 10){
		    		   	//영상 관리
		    		    //2-좋아요 3-좋아요 취소 4-싫어요 5-싫어요 취소 6-즐겨찾기 7-즐겨찾기 취소 8-다운로드 
		    			if(idVal % 2 == 0){
		    				$(obj).attr('name', idVal + 1);
		    				$(obj).next().text(cntVal + 1).number(true);
		    				$(obj).attr('src', $(obj).attr('src').replace(idVal, idVal + 1));
		    			}else{
		    				$(obj).attr('name', idVal - 1);
		    				$(obj).next().text(cntVal - 1).number(true);
		    				$(obj).attr('src', $(obj).attr('src').replace(idVal, idVal - 1)); 
		    			} 
	    		   }else if(parseInt(idVal) > 10){
		    			//댓글 관리
		    			//11-댓글 좋아요 12-댓글 좋아요 취소 13-댓글 싫어요 14-댓글 싫어요 취소
	    			    if(idVal % 2 == 0){
		    				$(obj).attr('name', idVal - 1);
		    				$(obj).next().text(cntVal - 1).number(true);
		    				$(obj).attr('src', $(obj).attr('src').replace(idVal, idVal - 1));
		    			}else{
		    				$(obj).attr('name', idVal + 1);
		    				$(obj).next().text(cntVal + 1).number(true); 
		    				$(obj).attr('src', $(obj).attr('src').replace(idVal, idVal + 1));
		    			}
	    		   }
	    		   
	    		   $('#target_vc_seq').val('LX4IaGcnTLA8InG');

		    	   _submit = true;
		    	   
	    		   return true;
				}else{
	    		   alert("오류가 발생 했습니다");
	    		   
	    		   $('#target_vc_seq').val('LX4IaGcnTLA8InG');

		    	   _submit = true;
		    	   
	    		   return false;
				}
	 		}
		});
	}else{
		alert('요청 처리중 입니다.');
		return false;
	}
}

//댓글 입력
function funCommentReg(obj, idx){ 
	var s 		= $('input[name=p_vc]').eq(idx).val();	//댓글 순서. db 기준(삭제로 인해 순서 이빨 나감)
	
	if($.trim($('textarea[name=comment_desc]').eq(idx).val()) == ''){
		alert('내용을 입력하시기 바랍니다');
		$('textarea[name=comment_desc]').eq(idx).focus();
		return false;
	}
	
	if(confirm('등록 하시겠습니까?')){
		
		if(_submit){
			
			_submit = false;
		
			$('#target_vc_seq').val(s);
			$('#target_vc_seq_idx').val(idx);
			
			dataString = $("#frm").serialize();
			
		    $.ajax({
		       url: "/kube/insertUserComment.do",
		       type: "POST",
		       data: dataString,
		       dataType: "html",
		       success: function(msg) {
					
		    	   var tmp_result = $.trim(msg);
		    	   if(tmp_result != '99999999'){
	
		    		   $('textarea[name=comment_desc]').eq(idx).val('');
		    		   
		    		   if(s == 'LX4IaGcnTLA8InG'){
		    			   //여기선 사용 안함. 무조건 대댓글로 작성 됨
		    			   //댓글 신규는 최근 작성 글 보여주자. 등록 글 확인용
		    		   	   funGetCommentList('R');
		    			   
		    		   	   $('#totCmmCnt' + $('#vi_seq_hash').val()).next().text(parseInt($('#totCmmCnt' + $('#vi_seq_hash').val()).next().text().replace(/,/gi, '')) + 1).number(true);
		    		   }else{  
		    			   //대댓글은 사이에 잘 끼어넣어준다 
		    			   var param = {'vi_seq_hash' : $('#vi_seq_hash').val(), 'vc_seq' : msg, 'pCnt' : idx, 'gubun' : 'one'} 
		    				
		    			    $.ajax({
		    			       url: "/kube/getCommentList.do",
		    			       type: "POST",
		    			       data: param,
		    			       dataType: "html",
		    			       success: function(msg) {
		    			    	   
		    			    	   var tmp_result = $.trim(msg);
		    			    	   if(tmp_result != 'false'){
		    			    		   
		    			    		   $(obj).parent().parent().parent().after(msg);  
		    			    		   
		    			    		   //기존 작성 폼 삭제
		    			    		   //대댓글 없는 경우와 있는 경우, 폼이 다름
		    			    		   var comment_cnt = parseInt($('#subCmTotCnt' + idx).children().eq(0).text().replace(/,/gi, ''));
		    			    		   
		    			    		   if(comment_cnt == 0){
		    			    			   $(obj).parent().parent().parent().remove();
		    			    		   }else if(comment_cnt > 0){
		    			    			   if($(obj).parent().prev().get(0) == undefined){
		    			    				   $(obj).parent().parent().parent().remove(); 
		    			    			   }else{       
				    			    		   $(obj).parent().prev().remove();
				    			    		   $(obj).parent().remove();
		    			    			   }
		    			    		   }  
	
		    			    		   //댓글 카운트 증가
		    			    		   $('#subCmTotCnt' + idx).children().eq(0).text(comment_cnt + 1).number(true)
		    			    		   $('#totCmmCnt' + $('#vi_seq_hash').val()).next().text(parseInt($('#totCmmCnt' + $('#vi_seq_hash').val()).next().text().replace(/,/gi, '')) + 1).number(true);
		    			    		    
		    			    		   return true;
		    						}else{
		    			    		   alert("신규 등록된 댓글을 가져오는 중 오류가 발생 했습니다");
		    			    		   
		    			    		   return false;
		    						}
		    			 		}
	    					});
		    		   }
		    		   
		    		   $('#target_vc_seq').val('LX4IaGcnTLA8InG');
		    		   $('#target_vc_seq_idx').val('0');
		    		   
			    	   _submit = true;
			    	   
		    		   return true;
					}else{
		    		   alert("오류가 발생 했습니다");
		    		   
		    		   $('#target_vc_seq').val('LX4IaGcnTLA8InG');
		    		   $('#target_vc_seq_idx').val('0');

			    	   _submit = true;
			    	   
		    		   return false;
					}
		    	   
		 		}
			});
		}else{
			alert('요청 처리중 입니다.');
			return false;
		}
	}
}

//댓글 삭제
function funCommentDel(obj, vc_seq_hash, idx, gubun, vc_seq){ 

	var comment_cnt = parseInt($('#subCmTotCnt' + idx).children().eq(0).text().replace(/,/gi, ''));
	
	if((gubun == 'Y' && comment_cnt == 0) || gubun == 'N'){
		if(confirm('삭제 하시겠습니까?')){
			if(_submit){
				
				_submit = false;
				
				var param = {'vi_seq_hash' : $('#vi_seq_hash').val(), 'vc_seq_hash' : vc_seq_hash}
				
			    $.ajax({
			       url: "/kube/deleteUserComment.do",
			       type: "POST",
			       data: param, 
			       dataType: "json",
			       success: function(msg) {
						
			    	   var tmp_result = $.trim(msg);
			    	   if(tmp_result != 'false'){
			    		   var trObj = $(obj).closest('tr');
			    		   var tdObjChild = $(obj).closest('td').children();   
			    		   
			    		   if(gubun == 'Y'){
			    			   $('.sub_comment_' + vc_seq).remove();
			    		   }
			    		   
			    		   if($(trObj).find('textarea').html() == undefined){
				    		   $(trObj).remove();
			    		   }else{
			    			   var len = $(tdObjChild).length;   
			    			   
			    			   $(tdObjChild).each(function(index){
			    				   if(index < len - 1){
			    			   			$(this).remove();
			    				   }
			    			   }); 
			    		   }
			    		   
						   
			    		   //댓글 카운트 감소
			    		   $('#subCmTotCnt' + idx).children().eq(0).text(comment_cnt - 1).number(true)
			    		   $('#totCmmCnt' + $('#vi_seq_hash').val()).next().text(parseInt($('#totCmmCnt' + $('#vi_seq_hash').val()).next().text().replace(/,/gi, '')) - 1).number(true);

				    	   _submit = true;
				    	   
			    		   return true;
						}else{
			    		   alert("오류가 발생 했습니다");

				    	   _submit = true;
				    	   			    		   
			    		   return false;
						}
			 		}
				});
			}else{
				alert('요청 처리중 입니다.');
				return false;
			}
		}
	}else{
		alert('하위 댓글이 있는 경우 삭제할 수 없습니다.');
		return false;
	}
}

function funReportShow(g, vc_seq_hash){
	$('#vi_seq_hash_r').val('');
	$('select[name=selReport]').val('');
	$('select[name=selReport]').jqTransSelect();
	$('#re_desc').val('');
	
	$('#report_gubun').val(g);
	$('#vc_seq_hash_r').val(vc_seq_hash);
	
	$('#report_div').parent().show();
	layerPopupCenter($('#report_div'));
}

function funReport(){
	
	if($('select[name=selReport]').val() == ''){
		alert('신고 분류를 선택하시기 바랍니다.');
		
		return false;
	}
	
	if($.trim($('#re_desc').val()) == ''){
		alert('신고 사유를 입력하시기 바랍니다.');
		$('#re_desc').focus();
		
		return false;
	}
	
	if(confirm('신고 하시겠습니까?\n신고 내용은 취소가 불가능합니다')){
		$('#vi_seq_hash_r').val($('#vi_seq_hash').val());
		
		var dataString = $("#rfrm").serialize();
		
		$.ajax({
	       url: "/kube/reportReqV_C.do",
	       type: "POST",
	       data: dataString,
	       dataType: "html",
	       success: function(msg) {
	    	   var tmp_result = $.trim(msg);
				
	    	   if(tmp_result != 'false'){
	    		   
	    		   alert('신고 되었습니다.\n관리자 확인 절차를 통해 처리될 예정입니다.');
				   
				   $('#report_div').parent().hide();
	    		   return true;
				}else{
				   alert("오류가 발생 했습니다");
					
	    		   $('#report_div').parent().hide();
	    		   return false;
				}
	 		}
		});
	}
}

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/bottom.jsp" /> 