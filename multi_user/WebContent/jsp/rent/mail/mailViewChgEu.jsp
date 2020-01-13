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
								인수자(책임자) 인수인계
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
					<td class="td02" colspan="3">${mailContext.gbnm}</td>
				</tr>
				<tr>
					<td class="td01">모델명</td>
					<td class="td02">${mailContext.mdnm}</td>
					<td class="td01">장비명</td>
					<td class="td02">
					${mailContext.eqnm}
					<c:if test="${mailContext.eqalias != null}">
					<br>${mailContext.eqalias}					
					</c:if>
					</td>
				</tr>

			</table>
		</td>
	</tr>
	<tr>
		<c:choose>
			<c:when test="${mailContext.mode eq 'chgEu'}">
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
			<c:when test="${mailContext.mode eq 'chgEu_adm'}">
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
		var euseq = "${mailContext.euseq}";
		var uhseq = "${mailContext.uhseq}";
		var appueno = "${mailContext.insuno}";
		var appuenm = "${mailContext.insunm}";
		var deptno = "${mailContext.deptno}";
		var dept1Nm = "${mailContext.dept1Nm}";
		
		if(!appno || !euseq || !uhseq || !appueno || !appuenm)
		{
			alert('잘못된 접근입니다.');
			return false;
		}

		if(confirm('승인 하시겠습니까?'))
		{

			$.ajax({
				url : '/signUp.do',
				type : 'post',
				data : { 'mode' : 'chgEuSign' , 'appno' : appno, 'euseq' : euseq, 
						'uhseq' : uhseq, 'appueno' : appueno, 'appuenm' : appuenm, 
						'deptno' : deptno, 'DEPT1NM' : dept1Nm },
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
		var euseq = "${mailContext.euseq}";
		var uhseq = "${mailContext.uhseq}";
		
		if(!appno || !euseq || !uhseq)
		{
			alert('잘못된 접근입니다.');
			return false;
		}

		if(confirm('승인거부를 하시겠습니까?'))
		{

			$.ajax({
				url : '/signUp.do',
				type : 'post',
				data : { 'mode' : 'chgEuReturn', 'appno' : appno, 'euseq' : euseq, 'uhseq' : uhseq },
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