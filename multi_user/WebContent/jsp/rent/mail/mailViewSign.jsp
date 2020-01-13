<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
.td01{padding: 5px;}
</style>
<table width="700" border="0" cellspacing="0" cellpadding="0">
	<tr>
	<td height="140" background="/resource/images/mail/top.jpg">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" background="/resource/images/mail/middle.jpg">
			<table width="600">
				<colgroup>
					<col width="110px" />
					<col width="220px" />
					<col width="110px" />
					<col width="*" />
				</colgroup>

				<tr>
					<td class="td01">대여장비</td>
					<td class="td02">${mailContext.gbnm}</td>
					<td class="td01">신청번호</td>
					<td class="td02">${mailContext.appnum}</td>
				</tr>
				<tr>
					<td class="td01">신청자 </td>
					<td class="td02">${mailContext.appenm}</td>
					<td class="td01">모델명</td>
					<td class="td02">${mailContext.mdnm}</td>
				</tr>
				<tr>
					<td class="td01">대여기간</td>
					<td class="td02">${mailContext.strdt} ~ ${mailContext.enddt}</td>
					<td class="td01">신청수량</td>
					<td class="td02">${mailContext.amount}</td>
				</tr>
				<tr>
					<td class="td01">사용용도</td>
					<td colspan="3" class="td02">${mailContext.useobj}&nbsp;</td>
				</tr>

			</table>
		</td>
	</tr>
	<tr>
		<td height="105" align="center" valign="top" background="/resource/images/mail/bottom.jpg">
			<input type="button" class="signupBtn" id="btn_signup" value="승인하기" >
			<input type="button" class="refuseBtn" id="btn_return" value="반송하기" >
		</td>
	</tr>
</table>

<script>

$(function() {


	//승인하기
	$("#btn_signup").click(function() {
		
		var appno = "${mailContext.appno}";
		var status = "${mailContext.status}";
		
		if(!appno || !status)
		{
			alert('잘못된 접근입니다.');
			return false;
		}

		if(confirm('승인 하시겠습니까?'))
		{

			$.ajax({
				url : '/signUp.do',
				type : 'post',
				data : { 'mode' : 'sign' , 'appno' : appno, 'status' : status },
				success : function(data) {
					
					if(data == 'success')
					{
						alert('승인 되었습니다.');
					}
					else if(data == 'cancel')
					{
						alert('취소된 결재 입니다.');
					}
					else if(data == 'final')
					{
						alert('최종 승인된 결재 입니다.');
					}
					else if(data == 'dup')
					{
						alert('이미 승인하였습니다.');
					}
					else if(data == 'return')
					{
						alert('반송된 결재 입니다.');
					}
					else
					{
						alert('승인에 실패하였습니다.');
					}

				}
			}); 
		}

	});


	//반송하기
	$("#btn_return").click(function() {
		
		var appno = "${mailContext.appno}";
		var status = "${mailContext.status}";
		if(!appno || !status)
		{
			alert('잘못된 접근입니다.');
			return false;
		}

		if(confirm('반송 하시겠습니까?'))
		{

			$.ajax({
				url : '/signUp.do',
				type : 'post',
				data : { 'mode' : 'return', 'appno' : appno, 'status' : status },
				success : function(data) {
					
					if(data == 'success')
					{
						alert('반송 처리 되었습니다.');
					}
					else if(data == 'cancel')
					{
						alert('취소된 결재 입니다.');
					}
					else if(data == 'final')
					{
						alert('최종 승인된 결재 입니다.');
					}
					else if(data == 'dup')
					{
						alert('이미 승인된 결재입니다.');
					}
					else if(data == 'return')
					{
						alert('이미 반송된 결재 입니다.');
					}
					else
					{
						alert('반송에 실패하였습니다.');
					}

				}
			}); 
		}

	});



});



</script>