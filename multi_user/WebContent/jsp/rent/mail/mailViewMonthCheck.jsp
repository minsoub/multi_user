<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
.td01{padding: 5px;}
</style>
<c:set var="long_ins" value="${monthApproval_Info.long_ins_cnt }"></c:set>
<c:set var="long_ban" value="${monthApproval_Info.long_ban_cnt }"></c:set>
<c:set var="short_ins" value="${monthApproval_Info.short_ins_cnt }"></c:set>
<c:set var="short_ban" value="${monthApproval_Info.short_ban_cnt }"></c:set>

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
					<td class="td01">날짜</td>
					<td class="td02">${cha:todate(monthApproval_Info.app_month, '-', '3')} ~ ${cha:todate(cha:monthLastDate(monthApproval_Info.app_month), '-', '3')}</td>
					<td class="td01">전체 반입/반출</td>
					<td class="td02">${long_ins + short_ins} / ${long_ban + short_ban} 건</td>
				</tr>
				<tr>
					<td class="td01">장기 반입/반출 </td>
					<td class="td02">${long_ins } / ${long_ban } 건</td>
					<td class="td01">단기 반입/반출</td>
					<td class="td02">${short_ins } / ${short_ban } 건</td>
				</tr>
				<tr>
					<td class="td01">파트장</td>
					<td class="td02">${monthApproval_Info.app_emp_name2 } (${monthApproval_Info.app_empno2 })</td>
					<td class="td01">부서장</td>
					<td class="td02">${monthApproval_Info.app_emp_name3 } (${monthApproval_Info.app_empno3 })</td>
				</tr>
			</table>
		</td>
	</tr> 
	<tr>
		<td height="105" align="center" valign="top" background="/resource/images/mail/bottom.jpg">
			<input type="button" class="askBtn" value="점검대장 관리" onclick="javascript:window.open('<%= Constants.ASP_DOMAIN %>admin/checkAppMonthApproval.do?target_date=<%=request.getParameter("apm") %>', 'checkAppMonthList', '')">
		</td>
	</tr>
</table>


