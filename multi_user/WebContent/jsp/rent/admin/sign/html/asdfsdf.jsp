<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<title>멀티미디어 관리자용 팝업</title>
<script src="/resource/common/js/jquery-1.9.1.js"></script>
</head>
<body>
<form id="frm" name="frm" method="post"">
	<input type="hidden" name="appno" value="${appno}" />
</form>
<div id="mail_form">
<div id="retal_detail_div">
	대여 신청 내역
	<br>
	<br>
	<br> 신청인 : ${view.appss} ${view.appenm } 님
	<br>
	<br> 사용인 : ${view.appuenm } 님
	<br>
	<br> 신청정보
	<br>○ 장비 목록
	<c:forEach var="list" items="${modelList }" varStatus="sts">
		<td>
			<div>${list.gbnm }</div>
		</td>
		<td class="like-td">
			<div>
				<c:choose>
					<c:when test="${view.status eq '1' && view.status eq '3' }">
						<span class="mdnm"
							style="text-decoration: underline; color: #0000ff; cursor: pointer;"
							data-gbcd="${list.gbcd}" data-mdseq="${list.mdseq }"
							data-amount="${list.amount }"> ${list.mdnm } </span>
					</c:when>
					<c:otherwise>
						<span>${list.mdnm }</span>
					</c:otherwise>
				</c:choose>
			</div>
		</td>
		<td class="like-td">
			<div>
				<c:out value="${list.amount} / ${list.assignedAmount}" />
			</div>
		</td>
		<td>
			<div>
				<c:forEach var="asMap" items="${assignedMap }" varStatus="vsts">
					<c:if test="${vsts.index eq sts.index }">
						<c:forEach var="v" items="${asMap.value }" varStatus="vsts">
                                                                         ${v.eqnm }
                                                                         <br>
                                                                         ${v.eqalias}
                                                                     </c:forEach>
					</c:if>
				</c:forEach>
			</div>
		</td>
	</c:forEach>
	<br>
	<br>
	○ 대여기간 :
	<fmt:parseDate value="${view.strdt}" var="parseStrdt"
		pattern="yyyyMMdd" />
	<fmt:parseDate value="${view.enddt}" var="parseEnddt"
		pattern="yyyyMMdd" />
	<fmt:formatDate value="${parseStrdt}" pattern="yyyy년 MM월 dd일" />
	~
	<fmt:formatDate value="${parseEnddt}" pattern="yyyy년 MM월 dd일" />

	<c:if test="${view.status eq '3' && view.approval eq '2'}">
		<dl class="insert_ready">
			<dt class="must-option">
				<label>인수자</label>
			</dt>
			<dd class="btn-zone" style="width: 200px;">
				<input type="text" class="schword" id="insunm" name="insunm"
					style="width: 50%"> <input
					type="button" style="cursor: pointer; height: 27px;"
					class="search_btn schbtn" value="검색">
			</dd>
			<dt class="must-option">
				<label>인수일</label>
			</dt>
			<dd style="width: 250px;">
				<div>
					<input type="text" id="insudt" name="insudt"
						readonly="readonly" />
				</div>
			</dd>
		</dl>
	</c:if>



	<c:if test="${view.status eq '4' && view.approval eq '2'}">
		<dl class="insert_ready">
			<dt class="must-option">
				<label>반납자</label>
			</dt>
			<dd class="btn-zone" style="width: 200px;">
				<input type="text" class="schword" id="banpnm" name="banpnm" style="width: 50%"> 
			</dd>
			<dt class="must-option">
				<label>반납일</label>
			</dt>
			<dd style="width: 250px;">
				<div>
					<input type="text" id="banpdt" name="banpdt" readonly="readonly" />
				</div>
			</dd>
		</dl>
		<dl class="insert_ready">
			<dt class="must-option">
				<label>반납처리</label>
			</dt>
			<dd>
				<input type="text" id="banpst" name="banpst" readonly="readonly" />
			</dd>
		</dl>
	</c:if>

	<dl class="insert_ready" id="etc_comment_div" style="display: none;">
		<dt class="must-option">
			<label for="SM_TEXT" id="SM_TEXT_label">특이사항</label>
		</dt>
		<dd>
			<textarea class="textarea-style" rows="10" cols="88" id="etc_comment" name="etc_comment" style="width: 618px;"></textarea>
		</dd>
	</dl>
</div>
	<img id="sign_img_data_complete" width="200px;" height="100px;" style="display: none;">
</div>


<div id="sign_input_div" style="display: none;">
<div style="float: left;">Sign</div>
	<div style="border:2px solid #4d6aa6;width:80%;height:195px;margin-left: 8%;">        
		<img id="sign_img_data">
	</div>
	<a href="javascript:;" onclick="javascript:funAdminChk();" style="text-align: right;">확인</a>
</div>

   	
<script type="text/javascript">
$(document).ready(function(){
	opener.setFormValue();
});

function popupFormSync(){
	$('#retal_detail_div').hide();
	$('#sign_input_div').show();
}

function funAdminChk(){
	$('#retal_detail_div').show();
	$('#sign_input_div').hide();
	$('#sign_img_data_complete').show();
	
	opener.funAdminChk();
	
	$.ajax({
	       url: "/admin/saveImgSendMail.do",
	       type: "POST",
	       data: {'mail_form' : $('#mail_form').html()},
	       dataType: "json",
	       success: function(msg) {
	    	   //self.close();	    	   
	       }
	});
}
</script>	
</body>
</html>