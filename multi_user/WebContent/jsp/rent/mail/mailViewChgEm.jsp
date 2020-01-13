<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
.td01{padding: 5px;}
</style>
<table width="700" border="0" cellspacing="0" cellpadding="0">
	<tr>
	<td height="140" background="/resource/images/mail/top_chgUsr.jpg">&nbsp;</td>
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
					<td class="td01">신청번호</td>
					<td class="td02">${mailContext.appnum}</td>
					<td class="td01">요청날짜</td>
					<td class="td02">${mailContext.regdt}</td>
				</tr>
				<tr>
					<td class="td01">내용</td>
					<td class="td02">
						<c:choose>
							<c:when test="${mailContext.mailmode eq '1'}">
								장비사용자 인수인계
							</c:when>
							<c:when test="${mailContext.mailmode eq '2'}">
								장비담당자(인수자) 인수인계
							</c:when>
							<c:otherwise>
								인수인계
							</c:otherwise>
						</c:choose>
					</td>
					<td class="td01">대여기간</td>
					<td class="td02">${mailContext.strdt} ~ ${mailContext.enddt}</td>
				</tr>
				<tr>
					<td class="td01">인계자 </td>
					<td class="td02">${mailContext.ingaenm}(${mailContext.ingaeno})</td>
					<td class="td01">인수자</td>
					<td class="td02">${mailContext.insunm}(${mailContext.insuno})</td>
				</tr>
				<tr>
					<td class="td01">대여장비</td>
					<td class="td02">${mailContext.gbnm}</td>
					<td class="td01">수량</td>
					<td class="td02">${mailContext.amount}</td>
				</tr>

			</table>
		</td>
	</tr>
	<tr>
		<c:choose>
			<c:when test="${mailContext.mode eq 'chgEm'}">
				<c:choose>
					<c:when test="${mailContext.mailapproval eq '0' }">
					<td height="105" align="center" valign="top" background="/resource/images/mail/bottom.jpg">
						<input type="button" class="signupBtn" id="btn_signup" value="승인하기" >
						<input type="button" class="refuseBtn" id="btn_return" value="승인거부" >
					</td>
					</c:when>
					<c:when test="${mailContext.mailapproval eq '6' }">
					<td height="105" align="center" valign="top" background="/resource/images/mail/bottom.jpg">
						<span class="signupBtn">승인완료</span>
					</td>
					</c:when>
					<c:when test="${mailContext.mailapproval eq '7' }">
					<td height="105" align="center" valign="top" background="/resource/images/mail/bottom.jpg">
						<span class="refuseBtn">승인거부</span>
					</td>
					</c:when>
					<c:when test="${mailContext.mailapproval eq '9' }">
					<td height="105" align="center" valign="top" background="/resource/images/mail/bottom.jpg">
						<span class="refuseBtn">진행취소</span>
					</td>
					</c:when>
					<c:otherwise>
					<td height="105" align="center" valign="top" background="/resource/images/mail/bottom.jpg">
						<span class="refuseBtn">기간만료</span>
					</td>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:when test="${mailContext.mode eq 'chgEm_adm'}">
				<td height="105" align="center" valign="top" background="/resource/images/mail/bottom.jpg">
					<input type="button" class="askBtn" value="요청내용 보기" onclick="javascript:window.open('${mailContext.btnLink}', 'equipView', '')">
				</td>
			</c:when>
		</c:choose> 
	</tr>
</table>

<script>

$(function() {


	//승인하기
	$("#btn_signup").click(function() {
		
		var appno = "${mailContext.appno}";
		var uhseq = "${mailContext.uhseq}";
		var insuno = "${mailContext.insuno}";
		var insunm = "${mailContext.insunm}";
		
		if(!appno || !uhseq || !insuno || !insunm)
		{
			alert('잘못된 접근입니다.');
			return false;
		}

		if(confirm('승인 하시겠습니까?'))
		{

			$.ajax({
				url : '/signUp.do',
				type : 'post',
				data : { 'mode' : 'chgEmSign' , 'appno' : appno,
						'uhseq' : uhseq, 'insuno' : insuno, 'insunm' : insunm },
				success : function(data) {
					
					if(data == 'success')
					{
						alert('승인 되었습니다.');
					}else
					{
						alert('승인에 실패하였습니다.');
					}
					
					window.location.reload();

				}
			}); 
		}

	});


	//반송하기
	$("#btn_return").click(function() {
		
		var appno = "${mailContext.appno}";
		var uhseq = "${mailContext.uhseq}";
		
		if(!appno || !uhseq)
		{
			alert('잘못된 접근입니다.');
			return false;
		}

		if(confirm('승인거부를 하시겠습니까?'))
		{

			$.ajax({
				url : '/signUp.do',
				type : 'post',
				data : { 'mode' : 'chgEmReturn', 'appno' : appno, 'uhseq' : uhseq },
				success : function(data) {
					
					if(data == 'success')
					{
						alert('거부 처리 되었습니다.');
					}else
					{
						alert('반송에 실패하였습니다.');
					}
					
					window.location.reload();

				}
			}); 
		}

	});



});



</script>