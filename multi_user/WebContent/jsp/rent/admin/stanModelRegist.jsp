<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="8" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="3"></c:param>
				<c:param name="left_depth_2" value="5"></c:param>
				<c:param name="left_depth_3" value="5"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img src="/resource/images/sub/sub8_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리메뉴</b>
				</div>
				<div class="nav-title">설정관리</div>
			</div>
           
            <div class="sub-nav-title">모델 등록</div>
                      
			<div class="basic-list">
			<form name="frm" action="/admin/saveModel.do" enctype="multipart/form-data" method="post" onsubmit="return check();">
			<input type="hidden" name="gbcd" value="${gbcd}"/>				
			<input type="hidden" name="mdseq" value="${mdseq}"/>				
				<div class="insrtfrom-framebox">
				<div class="insert-step1-box">
					<div class="form-step1">
						<fieldset>
						<legend>장비신청</legend>
							<div class="row-group">	
							
							
                            	<dl class="insert_ready">
									<dt class="must-option"><label>모델번호</label></dt>
									<dd style="width: 200px;"><input type="text" name="mdno" value='${data.mdno}'></dd>
                                    <dt class="must-option"><label>모델명</label></dt>
									<dd style="width: 200px;"><input type="text" name="mdnm" value='${data.mdnm}'></dd>
								</dl>	
								
								
								<dl class="insert_ready">
								
								<c:forEach var="subCodeLv2" items="${subCodeLv2}" varStatus="x">
								
									<c:if test="${x.index != 0 && x.index % 2 == 0}">
										</dl><dl class="insert_ready">
									</c:if>
								
									<dt class="must-option"><label>${subCodeLv2.GBNM}</label></dt>
									<!-- <dd><input type="text" id="" name="" title="" placeholder="" value=''></dd> -->
									<dd style="width: 200px;">
                                           <c:set var="selectCnt" value="0"/>
                                           <c:set var="optionVal" value="0"/>
                                           <c:forEach var="subCodeLv3Each" items="${subCodeLv3}" varStatus="y">
                                           <c:if test="${ (fn:substring(subCodeLv3Each.GBCD, 0,6) == subCodeLv2.GBCD) }">
                                           		<c:if test="${selectCnt == 0}">
                                           		<div>
	                                           		<p class="inputDesign">
		                                           		<select name="${subCodeLv2.GBCD}" style="width: 197px;">
		                                        </c:if>
		                                           		<option value="${subCodeLv3Each.GBCD}" ${view[subCodeLv2.GBCD] == subCodeLv3Each.GBCD ? "selected" : ""}>${subCodeLv3Each.GBNM}</option>
		                                           		<c:set var="selectCnt" value="${selectCnt+1}"/>
		                                           		<c:set var="optionVal" value="1"/>
		                                        <c:if test="${fn:substring(subCodeLv3[y.count].GBCD,0,6) != subCodeLv2.GBCD}">
														</select> 
													</p>
                                    			</div>                                          		
                                           		</c:if>
                                           </c:if>
                                           </c:forEach>   
                                           <c:if test="${optionVal == 0}">
                                           		<input type="text" name="${subCodeLv2.GBCD}" value='${view[subCodeLv2.GBCD]}'>
                                           </c:if>                               
                                    </dd>
                                    
                                </c:forEach>
                                
                                </dl>
								
                                <dl class="insert_ready">
									<dt class="must-option"><label>출시년월</label></dt>
									<dd>
                                    <div>
                                           <p class="inputDesign">
                                           <c:set var="today" value="<%=new java.util.Date()%>" />
                                           <select name="lch_year">
												<fmt:formatDate value="${today}" pattern="yyyy" var="start"/> 
												<c:forEach begin="0" end="20" var="idx" step="1">
												<option ${fn:substring(data.lchdt,0,4) == (start - idx) ? 'selected=\"selected\"' : ''} value="<c:out value="${start - idx}"/>">
												<c:out value="${start - idx}년" /></option>
												</c:forEach>
											</select>
											
											<select name="lch_month">
												<c:forEach begin="1" end="12" var="idx" step="1">
												<fmt:formatNumber var="no" minIntegerDigits="2" value="${idx}"/>
												<option ${fn:substring(data.lchdt,4,6) == no ? 'selected=\"selected\"' : ''} value="<c:out value="${no}" />">
												<c:out value="${no}월" /></option>
												</c:forEach>
											</select>
                                           </p>
                                    </div>
                                    </dd>
								</dl> 
                                <dl class="insert_ready">
									<dt class="must-option">
                                    <label>특징(상세설명)</label>
                                    </dt>
									<dd>
                                    <textarea class="textarea-style" rows="3" cols="88" name="mdtxt">${data.mdtxt}</textarea>
                                    </dd>
								</dl>
                                <dl class="insert_ready">
									<dt class="must-option">
                                    <label>비고</label>
                                    </dt>
									<dd>
                                    <textarea class="textarea-style" rows="3" cols="88" name="mdbg">${data.mdbg}</textarea>
                                    </dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label>이미지</label></dt>
									<dd>
										<c:if test="${imgFileList != null}">
										<div>
											<c:forEach var="imgFileList" items="${imgFileList}" varStatus="x">
												${imgFileList.FILENM}  <img src="/resource/images/btn/btn_del.png" style="cursor: pointer;" class="img_del" id="ref_${imgFileList.FILENO}"> <br/>
											</c:forEach>
										</div>
										</c:if>
                                    	<div class="filebox">
 											<input type="text" id="I_attFileName" class="upload-name" value="파일선택" disabled="disabled">
  											<label for="I_attFile">업로드</label> 
											<input type="file" class="upload-hidden" id="I_attFile" name="I_attFile" onchange="javascript:chkFile(this);document.getElementById('I_attFileName').value = this.value"/>
										</div>
                                    </dd>
								</dl>
                                <dl class="insert_ready">
									<dt class="must-option"><label>첨부파일</label></dt>
									<dd>
										<c:if test="${fileList != null}">
										<div>
											<c:forEach var="fileList" items="${fileList}" varStatus="x">
												${fileList.FILENM}  <img src="/resource/images/btn/btn_del.png" style="cursor: pointer;" class="file_del" id="ref_${fileList.FILENO}"> <br/>
											</c:forEach>
										</div>
										</c:if>
                                    	<div class="filebox">
 											<input type="text" id="F_attFileName" class="upload-name" value="파일선택" disabled="disabled">
  											<label for="F_attFile">업로드</label> 
											<input type="file" class="upload-hidden" id="F_attFile" name="F_attFile" onchange="javascript:document.getElementById('F_attFileName').value = this.value"/>
										</div>
                                    </dd>
								</dl>                              
							</div>
                            <div class="btn-zone">
                                <ul>
                                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:stanModelRegist();" value="저장"></li>
                                    <c:if test="${mdseq ne null}">
                                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:model_delete('${mdseq}');" value="삭제"></li>
                                    </c:if>
                                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:window.location='/admin/stanModelList.do'" value="목록"></li>
                                </ul>
                            </div>
						</fieldset>
					</div>
                </div>
                </div>
			</form>
			</div>

	
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('4', '0', '0'); //menu script
	
	var resultMessage = '<%= session.getAttribute("resultMessage") %>';
	
	if(resultMessage != 'null'){
		alert(resultMessage);
		<% session.removeAttribute("resultMessage"); %>
	}
	
	//파일삭제
	$('.img_del, .file_del').click(function() {

		var split_id = $(this).attr('id').split('_');
		
		if(!split_id[1])
		{
			alert('error');
			return false;
		}
		
		var type;

		if($(this).hasClass('img_del'))
		{
			type = 'I';
		}
		else
		{
			type = 'F';
		}

		if(confirm('파일을 삭제하시겠습니까?'))
		{
			
			$.ajax({
				url : '/admin/delFile.do',
				type : 'post',
				data : {'fileNo':split_id[1], 'type':type},
				success : function(data) {
					if(data == 'success')
					{
						window.location.reload();
					}
				}
			});

		}

	});
	
});

function model_delete(mdseq)
{
	if(!mdseq)
	{
		alert('error');
		return false;
	}

	if(confirm('삭제하시겠습니까?'))
	{

		var newForm = $('<form>', {
			'name' : 'delete_form',
			'action' : '/admin/deleteModel.do',
			'method' : 'post',
			'target' : '_top'
		}).append($('<input>', {
			'name' : 'mdseq',
			'value' : mdseq,
			'type' : 'hidden'
		})).append($('<input>', {
			'name' : 'gbcd',
			'value' : "${gbcd}",
			'type' : 'hidden'
		})).appendTo('body');

		newForm.submit();

	}
}

function chkFile(obj){
	if($(obj).val() != "" ){
		var ext = $(obj).val().split('.').pop().toLowerCase();
		
	    if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
	    	alert('[' + $(obj).attr('title') + '] 이미지 파일(gif,png,jpg,jpeg)만 업로드 할수 있습니다.');
	    	$(obj).val('');
		 	return;
	    }
	}
}

function stanModelRegist(){
	var frm = document.frm;
	
	if(confirm('저장하시겠습니까?')){
		frm.submit();
	}
	
}

</script>
<c:import url="/resource/common/include/bottom.jsp" />