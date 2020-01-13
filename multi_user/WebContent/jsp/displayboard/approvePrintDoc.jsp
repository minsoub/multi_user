<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<jsp:useBean id="today" class="java.util.Date" />
<c:set var="newLine" value="\n" />
<style>
	tr td p{
		color: #666 !important;
	}
	.confirm_data tr{
		height: 34px;
	}
</style>
<head>

<c:forEach items="${displayDetail}" var ="displayDetail" >
<c:set var="SM_SEQ" 	value="${displayDetail.SM_SEQ}"/>
<c:set var="SM_NO" 		value="${displayDetail.SM_NO}"/>
<c:set var="SM_DATE" 	value="${displayDetail.SM_DATE}"/>
<c:set var="SM_SVC2"	value="${displayDetail.SM_SVC2}"/>
<c:set var="SM_MEMPNO"	value="${displayDetail.SM_MEMPNO}"/>
<c:set var="SM_MCCD"	value="${displayDetail.SM_MCCD}"/>
<c:set var="SM_MC1CD"	value="${displayDetail.SM_MC1CD}"/>
<c:set var="SM_MC1NAME"	value="${displayDetail.SM_MC1NAME}"/>
<c:set var="SM_MC2CD"	value="${displayDetail.SM_MC2CD}"/>
<c:set var="SM_MC2NAME"	value="${displayDetail.SM_MC2NAME}"/>
<c:set var="SM_MDNAME"	value="${displayDetail.SM_MDNAME}"/>
<c:set var="SM_MTCD"	value="${displayDetail.SM_MTCD}"/>
<c:set var="SM_MTNAME"	value="${displayDetail.SM_MTNAME}"/>
<c:set var="SM_MNAME"	value="${displayDetail.SM_MNAME}"/>
<c:set var="SM_MTEL"	value="${displayDetail.SM_MTEL}"/>
<c:set var="SM_MCEL"	value="${displayDetail.SM_MCEL}"/>
<c:set var="SM_MEMAIL"	value="${displayDetail.SM_MEMAIL}"/>
<c:set var="SM_TITLE"	value="${displayDetail.SM_TITLE}"/>
<c:set var="SM_TEXT"	value="${displayDetail.SM_TEXT}"/>
<c:set var="SM_LSTATE"	value="${displayDetail.SM_LSTATE}"/>
<c:set var="SM_FSTATE"	value="${displayDetail.SM_FSTATE}"/>
<c:set var="SM_ISSIGN"	value="${displayDetail.SM_ISSIGN}"/>
<c:set var="SM_WDATE"	value="${displayDetail.SM_WDATE}"/>
<c:set var="SM_UDATE"	value="${displayDetail.SM_UDATE}"/>

<c:set var="SDP_SEQ"	value="${displayDetail.SDP_SEQ}"/>
<c:set var="SDP_DIV1"	value="${displayDetail.SDP_DIV1}"/>
<c:set var="SDP_FDATE"	value="${displayDetail.SDP_FDATE}"/>
<c:set var="SDP_TDATE"	value="${displayDetail.SDP_TDATE}"/>
<c:set var="SDP_FNAME1"	value="${displayDetail.SDP_FNAME1}"/>
<c:set var="SDP_FNAME2"	value="${displayDetail.SDP_FNAME2}"/>
<c:set var="SDP_FNAME3"	value="${displayDetail.SDP_FNAME3}"/>

<c:set var="SSTART"			value="${displayDetail.SSTART}"/>
<c:set var="MULTIPAGE"		value="${displayDetail.MULTIPAGE}"/>
<c:set var="MULTITIME"		value="${displayDetail.MULTITIME}"/>
<c:set var="MULTITIMEOUT"	value="${displayDetail.MULTITIMEOUT}"/>

<c:set var="SDP_APPROVER_FST_DEPTNAME"	value="${displayDetail.SDP_APPROVER_FST_DEPTNAME}"/>
<c:set var="SDP_APPROVER_FST_NAME"	value="${displayDetail.SDP_APPROVER_FST_NAME}"/>
<c:set var="SDP_APPROVER_FST_EMPNO"	value="${displayDetail.SDP_APPROVER_FST_EMPNO}"/>
<c:set var="SDP_APPROVER_FST_DATE"	value="${displayDetail.SDP_APPROVER_FST_DATE}"/>
<c:set var="SDP_APPROVER_SND_DEPTNAME"	value="${displayDetail.SDP_APPROVER_SND_DEPTNAME}"/>
<c:set var="SDP_APPROVER_SND_NAME"	value="${displayDetail.SDP_APPROVER_SND_NAME}"/>
<c:set var="SDP_APPROVER_SND_EMPNO"	value="${displayDetail.SDP_APPROVER_SND_EMPNO}"/>
<c:set var="SDP_APPROVER_SND_DATE"	value="${displayDetail.SDP_APPROVER_SND_DATE}"/>
<c:set var="SDP_PLANDATE"	value="${displayDetail.SDP_PLANDATE}"/>
<c:set var="SDP_worker"	value="${displayDetail.SDP_worker}"/>
</c:forEach>
<title>확인증</title>
</head>

<body>
<br />
<br />

	<div id="confirm_area">
		<table width="690" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td>
					<table width="690" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="399px;" height="25px;" valign="top">
								<table style="width:100%" >
									<tr>
										<td>
										<span style="font-size: 16px; font-weight:bold; font-style: normal; text-decoration: underline;">전광판게시에 대한 인수·인계 확인서</span>
										</td>
									</tr>
									<tr>
										<td height="10"></td>
									</tr>
									<tr>
										<td><span style="font-size: 12px;">처리부서 :</span> &nbsp;ICT인프라처 ICT서비스부/ 멀티미디어센터</td>
									</tr>
									<tr>
										<td><span style="font-size: 12px;">신 청 일 :</span> &nbsp;<%-- <fmt:formatDate value="${today }" dateStyle="FULL"/> --%>${SSTART}</td>
									</tr>
									<tr>
										<td><span style="font-size: 12px;">처리완료 :</span> &nbsp;${SDP_PLANDATE}</td>
									</tr>
								</table>
							</td>
							<!-- <td width="291" align="right" class="confirm_data">
								<table width="270" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
									<tr>
										<td width="30" rowspan="2" align="center" bgcolor="#F7FAFF"><strong>결<br><br> 재</strong></td>
										<td width="120" height="25" align="center" bgcolor="#F7FAFF"><strong>담 당</strong></td>
										<td width="120" align="center" bgcolor="#F7FAFF"><strong>차 장</strong></td>
									</tr>
									<tr>
										<td height="60" bgcolor="#FFFFFF">&nbsp;</td>
										<td bgcolor="#FFFFFF">&nbsp;</td>
									</tr>
								</table>
							</td> -->
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="10"></td>
			</tr>
			
			<tr>
				<td>
					<table width="690" cellpadding="0" cellspacing="1" bgcolor="#D5D5D5" class="confirm_data">
					<colgroup>
						<col style="width: 18%">
						<col style="width: 32%">
						<col style="width: 18%">
						<col style="width: 32%">
					</colgroup>
						<tr>
							<td width="150" height="24" align="right" bgcolor="#F7FAFF">
							신청번호&nbsp;</td>
							<td width="195" bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;<strong>${SM_NO }</strong> </td>
							<td align="right" bgcolor="#F7FAFF" style="padding-left:5px;">
							작업자&nbsp;</td>
							<td width="195" bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;${SDP_worker}</td>
						</tr>
						<tr>
							<td height="24" align="right" bgcolor="#F7FAFF">
							신청부서&nbsp;</td>
							<td bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;${SM_MDNAME }</td>
							<td align="right" bgcolor="#F7FAFF" style="padding-left:5px;">
							신청자&nbsp;</td>
							<td bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;${SM_MNAME}</td>
						</tr>
						<tr>
							<td height="24" align="right" bgcolor="#F7FAFF">
							전화번호&nbsp;</td>
							<td bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;${SM_MTEL}</td>
							<td align="right" bgcolor="#F7FAFF" style="padding-left:5px;">
							E-MAIL&nbsp;</td>
							<td bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;${SM_MEMAIL}</td>
						</tr>
						<tr>
							<td height="24" align="right" bgcolor="#F7FAFF">서비스 요청일&nbsp;</td>
							<td colspan="3" bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;${SSTART}</td>
						</tr>
						<tr>
							<td align="right" bgcolor="#F7FAFF" style="padding-left:5px;">${SM_LSTATE == '3095' ? '완료일' : '완료예정일'}&nbsp;</td>
							<td bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;${SDP_PLANDATE}</td>
							<td width="150" align="right" bgcolor="#F7FAFF" style="padding-left:5px;">
							사용자 서비스상태&nbsp;</td>
							<td width="195" bgcolor="#FFFFFF" style="padding-left:5px;">${cha:codeStatus(SM_LSTATE) }</td>
						</tr>
						<tr>
							<td height="24" align="right" bgcolor="#F7FAFF">제목&nbsp;</td>
							<td colspan="3" bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;${SM_TITLE}</td>
						</tr>
						<tr>
							<td height="24" align="right" bgcolor="#F7FAFF">게시장소&nbsp;</td>
							<td colspan="3" bgcolor="#FFFFFF" style="padding-left:5px;">
							<c:set var="SVC2_SPLIT" value="${fn:split(SM_SVC2,',')}"/>
							<c:set var="displayCnt" value="0"></c:set>
								<c:forEach items="${SVC2_SPLIT }" var="SVC2_SPLIT_FOR" varStatus="SVC2_SPLIT_status" >
									<c:set var="SVC2_SPLIT_INDEX" value="${SVC2_SPLIT_status.index}" />
									<c:if test="${SVC2_SPLIT_INDEX ne 0 }">,</c:if>
									<c:out value="${cha:svc2NameDisplay(SVC2_SPLIT_FOR)}" />
									
									<c:set var="displayCnt" value="${displayCnt + 1}"></c:set>
									<c:if test="${displayCnt % 5 == 0}"><span style="display: block;margin-top: 1px;"></span></c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td height="24" align="right" bgcolor="#F7FAFF">게시일시&nbsp;</td>
							<td colspan="3" bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;<c:out value="${cha:changday2(SDP_FDATE)}" /> ~ <c:out value="${cha:changday2(SDP_TDATE)}" /></td>
						</tr>
						<tr>
							<td align="right" bgcolor="#F7FAFF">제작요청 내용&nbsp;</td>
		                    <td height="160" colspan="3" valign="top" bgcolor="#FFFFFF" style="padding-left:5px;"><pre style="font-family: 돋음,dotum; white-space:pre-wrap; word-break:break-all; "><c:out value="${SM_TEXT}"></c:out></pre>
	                    	</td>
						</tr>
						<%-- <tr>
							<td height="24" align="right" bgcolor="#F7FAFF">첨부파일&nbsp;</td>
							<td colspan="3" bgcolor="#FFFFFF" style="padding-left:5px;">
								<c:forEach var="displayFileList" items="${displayFileList }" varStatus="sts">
									<img alt="" src="/resource/images/file.gif">&nbsp;${displayFileList.SDP_orgFileName }
								</c:forEach>	
							</td>
						</tr>
						<c:if test="${SM_LSTATE == '3095' }">
							<tr>
								<td height="24" align="right" bgcolor="#F7FAFF">완료파일&nbsp;</td>
								<td colspan="3" bgcolor="#FFFFFF" style="padding-left:5px;">
								<c:forEach items="${completeFileList }" var="completeFileList" varStatus="sts">
									${completeFileList.SDP_orgFileName }
								</c:forEach>
								</td>
							</tr>
						</c:if> --%>
					</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
					<table style="width:690px;">
						<tr>
							<td align="center" height="30"><span style="font-size: 16px; font-weight:bold;">상기 품목의 인수·인계를 확인 합니다. </span></td>
						</tr>
						<tr>
							<td align="center" height="20"></td>
						</tr>
						<tr>
							<td align="center" height="20"><span style="font-size: 16px; font-weight:bold;">&lt;인수자&gt;</span></td>
						</tr>
						<tr>
							<td>
							<!-- 인수자 확인 sign -->
								<table style="width:100%; ">
								<tr>
									<td width="406" align="right"><span style="font-size: 15px; font-weight:bold;">날&nbsp;&nbsp;짜 :</span></td>
									<td width="250" align="left"><span style="font-size: 14px; font-weight:bold;">&nbsp;&nbsp;<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></span></td>
									<td width="20">&nbsp;</td>
								</tr>
								<tr>
									<td align="right"><span style="font-size: 15px; font-weight:bold;">소&nbsp;&nbsp;속 :</span></td>
									<td align="left"><span style="font-size: 13px; font-weight:bold;">&nbsp; ${SM_MC1NAME } ${SM_MC2NAME } ${SM_MDNAME }</span></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td align="right"><span style="font-size: 15px; font-weight:bold;">이&nbsp;&nbsp;름 :</span></td>
									<td align="left"><span style="font-size: 15px; font-weight:bold;">&nbsp;&nbsp;${SM_MNAME}</span></td>
									<td>&nbsp;</td>
								</tr>
								</table>
							</td>
						</tr>
					</table>
				<!-- //인수자 확인 sign-->
				</td>
			</tr>
			<tr>
				<td height="10"></td>
			</tr>
		</table>
	</div>
</body>

<script src="/resource/common/js/jquery-printThis.js"></script>
<script type="text/javascript">
	$(window).load(function() {
		print();
	});
</script>
