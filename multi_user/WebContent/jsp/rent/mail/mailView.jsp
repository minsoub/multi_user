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
			<input type="button" class="askBtn" value="요청내용 보기" onclick="javascript:window.open('${mailContext.btnLink}', 'equipView', '')">
		</td>
	</tr>
</table>

