<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui" />
<title>멀티미디어 장비대여 반납 시스템 - 관리자 팝업</title>
<link rel="stylesheet" href="/resource/common/css/sign.css" /> 
<script src="/resource/common/js/jquery-1.9.1.js"></script>
</head>
<body>
<form id="frm" name="frm" method="post">
	<input type="hidden" id="appno" name="appno" value="${appno}" />
</form>
<div id="mail_form">
	<div id="retal_detail_div">
	    <div>
			<div id="print_div" style="box-sizing: border-box;padding: 0;margin: 0;">
		       <div>      
		          <table style="border-collapse: collapse;table-layout: fixed;border: 3px solid #ac7a61;font-size: 13px;margin: 0px;width: 1203px;">           
		          <colgroup>
		               <col class="" width="13%" />
		               <col class="">
		          </colgroup>   
		              <tr>
		                  <th style="height: 20px;background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;color: #4c2f22;">신청인</th>
		                  <td style="height: 20px;background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;color: #414141;padding: 7px 10px;" colspan="5">${view.appss} <span style="color: blue;font-weight: bold;">${view.appenm }</span> 님</td>
		              </tr>           
		              <tr>
		                  <th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">장비목록</th>
		                  <td colspan="5" style="padding: 0px 0px;background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;">             
		                  	<table style="margin-left:9px;width:100%;table-layout: fixed;">
			                  <c:forEach var="list" items="${modelList }" varStatus="sts">
			                  	<tr>
			                  		<c:if test="${!sts.last }">
				                  		<td style="border-right: 0;">
				                  	</c:if>
				                  	<c:if test="${sts.last }">
				                  		<td style="border-bottom: 0;border-right: 0;">
				                  	</c:if>
			                  	${list.gbnm }
			                  		<c:choose>
										<c:when test="${view.status eq '1' && view.status eq '3' }">
											(${list.mdnm })
										</c:when>
										<c:otherwise>
											<span>(${list.mdnm })</span>
										</c:otherwise>
									</c:choose> 수량 <span style="color: red;font-weight: bold;"><c:out value="${list.amount} / ${list.assignedAmount}" /></span>대
									<%-- 화면 넘쳐서 주석처리. 최종적으로 스크린샷 뜰때 스크롤 발생 문제가 생김 
									배정 <c:forEach var="asMap" items="${assignedMap }" varStatus="vsts">
										<c:if test="${vsts.index eq sts.index }">
											<c:forEach var="v" items="${asMap.value }" varStatus="vsts">
												${v.eqnm }<br>${v.eqalias}
											</c:forEach>
										</c:if>
									</c:forEach>
									 --%>
									</td>
								</tr>
			                  </c:forEach>
			              	</table>
		                  </td>
		              </tr>
		              <tr>
		                  <th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">대여기간</th>
		                  <td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" colspan="5">
		                  	<fmt:parseDate value="${view.strdt}" var="parseStrdt" pattern="yyyyMMdd" />
							<fmt:parseDate value="${view.enddt}" var="parseEnddt" pattern="yyyyMMdd" />
							<fmt:formatDate value="${parseStrdt}" pattern="yyyy년 MM월 dd일" />
							~
							<fmt:formatDate value="${parseEnddt}" pattern="yyyy년 MM월 dd일" /> <!-- (<span class="red">2</span>일) -->
						 </td>
		              </tr>
		              
		              <c:if test="${view.status eq '3' && view.approval eq '2'}">
			              <tr>
			              	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">인수자</th>
			              	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" id="insunm" colspan="2"></td>
			              	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">인수일</th>
			              	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" colspan="2" id="insudt"></td>
			              </tr>
					  </c:if>
		              <c:if test="${view.status eq '4' && view.approval eq '2'}">
			              <tr>
			              	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">반납자</th>
			              	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" id="banpnm"></td>
			              	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">반납일</th>
			              	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" id="banpdt"></td>
			              	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">반납처리</th>
			              	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" id="banpst"></td>
			              </tr>
					  </c:if>
					  <tr id="bigo_tr">
					  	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">특이사항</th>
					  	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" id="bigo" colspan="5"></td>
					  </tr>
					  <tr>
					  	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">서명</th>
					  	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" colspan="5"><font id="act_name"></font><img id="sign_img_data_complete" style="width:177px;height:100px;vertical-align: middle;margin:0;margin-left: 15px;">(인)</td>
					  </tr>
		          </table>               
		       </div>
			</div>
	       <div id="closeDiv" class="btn03" style="margin-top: 10px;display: none;">
	           <a href="javascript:;" onclick="javascript:self.close();"><img src="/resource/images/sign/btn_09.png" style="width: 150px; height: 70px;"></a>
	       </div>
	   </div>
	</div>
</div>


<div id="sign_input_div" style="display: none;">
	<div id="main" style="width: 1200px;">
		<div class="text03" style="padding-top: 10px;padding-left: 10px;"><img src="/resource/images/sign/text_07.png"></div>
		<div class="box" style="padding-top:60px;margin:0px;width: 1200px;">
			<div class="sign" style="width:1150px;padding-top: 0px;margin-left: 20px;"><img id="sign_img_data" style="width: 100%; height: 100%;"></div> 
		</div>
		<div class="btn03">
		    <a href="javascript:;" onclick="javascript:funAdminChk();"><img src="/resource/images/sign/btn_07.png" style="width: 150px; height: 70px;"></a>
		</div>
	</div>
</div>   	

<script type="text/javascript">
$(document).ready(function(){
	opener.setFormValue('admin');
	console.log($('html')[0].outerHTML);
});

function popupFormSync(){
	$('#retal_detail_div').hide();
	$('#sign_input_div').show();
}

function funAdminChk(){
	$('#retal_detail_div').show();
	$('#sign_input_div').hide();
	$('#sign_img_data_complete').show();
	$('#bigo_tr').hide();
	
	opener.funAdminChk();
  
	var mail_form = '<!DOCTYPE html>\n'
					+ '<html>\n'
					+ '<head>\n'
					+ '<meta charset="euc-kr" />\n'
					+ '<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />\n'
					+ '<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui" />\n'
					+ '<title>멀티미디어 장비대여 반납 시스템</title>\n'
					+ '</head>\n'
					+ '<body style="box-sizing: border-box;padding: 0;margin: 0;font-size: 100%;font-family:sans-serif;height: 100%;">\n'
					+ $('#print_div').html() + '\n'
					+ '</body>\n</html>';
	
	$.ajax({
	       url: "/admin/saveImgSendMail.do",
	       type: "POST",
	       data: {'appno' : $('#appno').val()
	    	   		, 'mail_form' : mail_form
	    	   		, 'status' : '${view.status}'},
	       dataType: "json",
	       success: function(msg) {
	    	   $('#bigo_tr').show();
	    	   $('#closeDiv').show();
	       }
	});
}
</script>	
</body>
</html>