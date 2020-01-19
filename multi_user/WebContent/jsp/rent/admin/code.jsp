<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="3" var="left_depth_1"></c:set>
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
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub8_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리메뉴</b>
				</div>
				<div class="nav-title">설정관리</div>
			</div>
			<div class="red-f">
            * 상위코드가 미사용일경우 하위코드 사용여부를 미사용체크 <br/>
			* 수정시 사용여부 값에 따라 하위코드 모두 업데이트
            </div>
            
            <form name="frm" method="get" action="/admin/code.do" onsubmit="return false;">
            <input type="hidden" id="gbcd" name="gbcd" value="${gbcd}"/>
            <input type="hidden" id="codeLevel" name="codeLevel" value="${codeLevel}"/>
            <input type="hidden" id="upcode" name="upcode" value="${upcode}"/>
            <input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo}"/>
            
            
            <div style="margin-top:10px;">
               <ul class="equip">
                   <li ${codeLevel == '1' ? 'class="active"' : ''}><a href="/admin/code.do?codeLevel=1">코드 (대) 구분 관리</a></li>
                   <li ${codeLevel == '2' ? 'class="active"' : ''}><a href="/admin/code.do?codeLevel=2">코드 (중) 구분 관리</a></li>
                   <li ${codeLevel == '3' ? 'class="active"' : ''}><a href="/admin/code.do?codeLevel=3">코드 (소) 구분 관리</a></li>
                </ul>
             </div>            
			<div class="basic-list">
							
				<div class="insrtfrom-framebox">
				<div class="insert-step1-box">
					<div class="form-step1">
						
						
						<c:choose>
							<c:when test="${codeLevel == '1'}">
							<fieldset>
							<legend>장비신청</legend>
								<div class="row-group">					
									<dl class="insert_ready">
										<dt class="must-option"><label for="" id="">구분명</label></dt>
										<dd><input type="text" name="gbnm" value="${gbnm}"></dd>
	                                    <dt class="must-option"><label for="" id="">사용여부</label></dt>
										<dd>
	                                    <input type="radio" name="gbyn" value="Y" class="checks small" ${gbyn == 'Y' ? 'checked' : ''}> 
										<label for="">사용</label>
	                                    <input type="radio" name="gbyn" value="N" class="checks small" ${gbyn == 'N' ? 'checked' : ''}> 
										<label for="">미사용</label>                            
	                                    </dd>
									</dl>
	                                <dl class="insert_ready">
										<dt class="must-option"><label for="" id="">설비관리번호</label></dt>
										<dd><input type="text" name="eqhno" value='${eqhno}' maxlength="2"></dd>
									</dl>
								</div>
	                            <div class="btn-zone">
	                                <ul>
	                                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:saveData();" value="저장"></li>
	                                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:deleteData();" value="삭제"></li>
	                                </ul>
	                            </div>
							</fieldset>
							</c:when>
							
							<c:when test="${codeLevel == '2'}">
							<fieldset>
							<legend>장비신청</legend>
							<div class="row-group">	
	                            	<dl class="insert_ready">
										<dt class="must-option"><label for="" id="">구분(대)</label></dt>
										<dd>
	                                    <div>
	                                           <p class="inputDesign">
	                                           <select id="codeSelectLv1" onchange="javascript:codeSelector(this.value);">
	                                               <option value="">전체</option>
	                                               <c:forEach var="codeSelectLv1" items="${codeSelectLv1}" varStatus="x">
	                                               <option value="${codeSelectLv1.GBCD}" ${upcode == codeSelectLv1.GBCD ? 'selected' : ''}>${codeSelectLv1.GBNM}</option>
	                                               </c:forEach>
	                                           </select>
	                                           </p>
	                                    </div>
	                                    </dd>
									</dl>				
									<dl class="insert_ready">
										<dt class="must-option"><label for="" id="">구분명</label></dt>
										<dd><input type="text" name="gbnm" value="${gbnm}"></dd>
	                                    <dt class="must-option"><label for="" id="">사용여부</label></dt>
										<dd>
	                                    <input type="radio" name="gbyn" value="Y" class="checks small" ${gbyn == 'Y' ? 'checked' : ''}> 
										<label for="">사용</label>
	                                    <input type="radio" name="gbyn" value="N" class="checks small" ${gbyn == 'N' ? 'checked' : ''}> 
										<label for="">미사용</label>                            
	                                    </dd>
									</dl>                                
								</div>
	                            <div class="btn-zone">
	                                <ul>
	                                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:saveData();" value="저장"></li>
	                                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:deleteData();" value="삭제"></li>
	                                </ul>
	                            </div>
							</fieldset>
							</c:when>
							
							<c:when test="${codeLevel == '3'}">
							<fieldset>
							<legend>장비신청</legend>
							<div class="row-group">	
	                            	<dl class="insert_ready">
										<dt class="must-option"><label for="" id="">구분(대)</label></dt>
										<dd>
	                                    <div>
	                                           <p class="inputDesign">
	                                           <select id="codeSelectLv1" onchange="javascript:codeSelector(this.value);">
	                                               <option value="">전체</option>
	                                               <c:forEach var="codeSelectLv1" items="${codeSelectLv1}" varStatus="x">
	                                               <option value="${codeSelectLv1.GBCD}" ${fn:substring(upcode,0,3) == codeSelectLv1.GBCD ? 'selected' : ''}>${codeSelectLv1.GBNM}</option>
	                                               </c:forEach>                               
	                                           </select>
	                                           </p>
	                                    </div>
	                                    </dd>
	                                    <dt class="must-option"><label for="" id="">구분(중)</label></dt>
										<dd>
	                                    <div>
	                                           <p class="inputDesign">
	                                           <select id="codeSelectLv2" onchange="javascript:codeSelector(this.value);">
	                                               <option value="">전체</option>
	                                               <c:forEach var="codeSelectLv2" items="${codeSelectLv2}" varStatus="x">
	                                               <option value="${codeSelectLv2.GBCD}" ${upcode == codeSelectLv2.GBCD ? 'selected' : ''}>${codeSelectLv2.GBNM}</option>
	                                               </c:forEach>                                 
	                                           </select>
	                                           </p>
	                                    </div>
	                                    </dd>
									</dl>				
									<dl class="insert_ready">
										<dt class="must-option"><label for="" id="">구분명</label></dt>
										<dd><input type="text" name="gbnm" value="${gbnm}"></dd>
	                                    <dt class="must-option"><label for="" id="">사용여부</label></dt>
										<dd>
	                                    <input type="radio" name="gbyn" value="Y" class="checks small" ${gbyn == 'Y' ? 'checked' : ''}> 
										<label for="">사용</label>
	                                    <input type="radio" name="gbyn" value="N" class="checks small" ${gbyn == 'N' ? 'checked' : ''}> 
										<label for="">미사용</label>                            
	                                    </dd>
									</dl>                                
								</div>
	                            <div class="btn-zone">
	                                <ul>
	                                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:saveData();" value="저장"></li>
	                                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:deleteData();" value="삭제"></li>
	                                </ul>
	                            </div>
							</fieldset>
							</c:when>
						
						</c:choose>
						
					</div>
                </div>
                </div>
			</div>
            <div class="basic-list" style="margin-top:5px;">
				<table id="listTable" summary="">
					<caption>설정관리</caption>
					<colgroup>
						<col style="width:15%">
						<col style="">
						<col style="width:25%">
						<col style="width:25%">
					</colgroup>
					<thead>
						<tr>
                       		<th scope="col">구분코드</th>
							<th scope="col">구분명</th>
                            <th scope="col">사용여부</th>
                            <th scope="col">설비관리번호</th>                     					
						</tr>
					</thead>
					<tbody>
					<c:forEach var="list" items="${list}" varStatus="x">
						<tr onclick="javascript:window.location='/admin/code.do?codeLevel=${codeLevel}${list.linkUpcode}&gbcd=${list.gbcd}'" style="cursor: pointer;">
                            <td>${list.gbcd}</td>
							<td>${list.gbnm}</td>
                            <td>
                            	<c:choose>
                            		<c:when test="${list.gbyn == 'Y'}">사용함</c:when>
                            		<c:when test="${list.gbyn == 'N'}">사용안함</c:when>
                            	</c:choose>
                            </td>
                            <td>${list.eqhno}</td>                     
						</tr>
					</c:forEach>
					<c:if test="${fn:length(list) == 0}">
						<tr>
							<td align="center" colspan="4">등록된 데이터가 없습니다.</td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<c:import url="/resource/common/include/paging.jsp" />
			
			
			</form>
			
            <div class="btn-zone" style="float:left">
                <ul>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="window.location('/admin/adminList.do')" value="관리자등록"  style="width:80px;"></li>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="window.location('/admin/stanModelList.do')" value="모델관리"  style="width:80px;"></li>
                </ul>
            </div>
	
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('3', '0', '0'); //menu script
	
	var resultMessage = '<%= session.getAttribute("resultMessage") %>';
	
	if(resultMessage != 'null'){
		alert(resultMessage);
		<% session.removeAttribute("resultMessage"); %>
	}
	
});


function codeSelector(code){
	var frm = document.frm;
	$("#upcode").val(code);
	frm.submit();
}

function saveData(){
	
	if(check() == false){
		return false;
	}
	
	var retVal = false;
	
	if($("#gbcd").val() != ""){
		if(confirm("데이터를 수정하시겠습니까?")){
			retVal = true;
		}
	}else{
		if(confirm("데이터를 등록하시겠습니까?")){
			retVal = true;
		}
	}
	
	if(retVal){
		var frm = document.frm;
		frm.action = '/admin/saveCode.do';
		frm.method = "post";
		frm.submit();
	}

}

function deleteData(){
	
	if(check() == false){
		return false;
	}
	
	var retVal = false;
	
	if($("#gbcd").val() != ""){
		if(confirm("하위코드도 모두 삭제 됩니다. \n정말로 데이터를 삭제하시겠습니까?")){
			retVal = true;
		}
	}else{
		alert("코드를 선택 후 삭제 할 수 있습니다");
		return false;
	}
	
	if(retVal){
		var frm = document.frm;
		frm.action = '/admin/deleteCode.do';
		frm.method = "post";
		frm.submit();
	}
	
}

function check(){
	
	
	if( $("#codeSelectLv1").length > 0 && $('#codeSelectLv1').val() == "" )
	{
		alert('구분(대)를 선택하세요.');
		$("#codeSelectLv1").focus();
		return false;
	}
	else if( $("#codeSelectLv2").length > 0 && $('#codeSelectLv2').val() == "" )
	{
		alert('구분(중)을 선택하세요.');
		$("#codeSelectLv2").focus();
		return false;
	}
	else if( !$.trim($("input[name='gbnm']").val()) ) 
	{
		alert('구분명을 입력하세요.');
		$("input[name='gbnm']").focus();
		return false;
	}
	else if( !$("input[name='gbyn']:checked").val() )
	{
		alert('사용여부를 선택하세요.');
		return false;
	}
	
	return true;
}

</script>
<c:import url="/resource/common/include/bottom.jsp" />