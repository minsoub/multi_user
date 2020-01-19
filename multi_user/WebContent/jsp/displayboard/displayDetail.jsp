<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />

<style>
	.searchArea_con table{
		border: 3px solid #B6C0E3;
		text-align: center;
		font-weight: bold;
	}
	
	.searchArea_con table span{
		writing-mode:tb-rl;
		color: #000000
	}
	
	.searchArea_con table tr:first-child td{
		text-align: center;
		background-color:#ECF0FB;
		border-right: 1px solid #B6C0E3;
		border-bottom: 1px solid #B6C0E3;
		font-weight: bold; 
	}
	
	.searchArea_con table tr:last-child td{
		border-right: 1px solid #B6C0E3;
	}
	
	.approvalUser{
		font-family: serif;
		font-size: 30px;
		font-weight: bold;
		color : blue;
	}
</style>

<c:set var="path" value="DISPLAY" />
<c:set var="sessEmpno" value="${sessEmpno}" />
<c:choose>
	<c:when test="${mode eq 0 }">
	<c:set var="modeNum" value="2"/>
	<c:set var="modeNum2" value="2"/>
	</c:when>
	<c:when test="${mode eq 1 }">
	<c:set var="modeNum" value="4"/>
	<c:set var="modeNum2" value="2"/>
	</c:when>
</c:choose>

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
<c:set var="SM_MC2NAME"	value="${displayDetail.SM_MDCD}"/>
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







<body>

<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="2" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
			<div class="learn-tit-framebox">
				<c:import url="/resource/common/include/leftMenu_01.jsp">
					<c:param name="left_depth_1" value="${modeNum }"></c:param>
					<c:param name="left_depth_2" value="${modeNum2 }"></c:param>
				</c:import>
			</div> 
		</div>
		<!-- leftmenu end-->
		<!--content-->
		<div class="contents-con-framebox">
			
		<c:choose>
		<c:when test="${mode eq 0 }">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub3_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;전광판게시  &nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">진행상황</b>
				</div>
				<div class="nav-title">전광판 게시 <small class="sub2">진행상황</small></div>
			</div>
			
			<div class="tabNav sub2">
				<li><a href="/displayBoardInfo.do">이용안내</a></li>
				<li><a href="/displayBoardRequest.do">게시신청</a></li>
				<li><a href="#" class="active">진행사항</a></li>
			</div>
		</c:when>
		<c:when test="${mode eq 1 }">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub4_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;마이페이지&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">전광판게시 신청내역</b>
				</div>
				<div class="nav-title">전광판게시 신청내역</div>
			</div>
		</c:when>
		</c:choose>

			<c:if test="${SM_LSTATE ne '3093' && SM_LSTATE ne '3097'}">
				<div class="searchArea_con" style="float:right;">
					<table>
						<colgroup>
							<col width="30px;">
							<col width="100px;">
							<col width="100px;">
							<col width="100px;">
						</colgroup>
						<tr style="height:30px;">
							<td rowspan="2"><span>제&nbsp;작&nbsp;승&nbsp;인</span></td>
							<td>담당자</td>
							<td>파트장</td>
						</tr>
						<tr style="height:100px;">
							<td>
								<c:if test="${SDP_APPROVER_FST_DATE eq null || empty SDP_APPROVER_FST_DATE}">
									<c:if test="${sessionScope.SESS_EMPNO eq SDP_APPROVER_FST_EMPNO}">
										<a href="javascript:;" onclick="javascript:funAppProc('${SM_NO}','FST');" style="text-decoration: underline;">${SDP_APPROVER_FST_NAME}</a>
									</c:if>
									<c:if test="${sessionScope.SESS_EMPNO ne SDP_APPROVER_FST_EMPNO }">${SDP_APPROVER_FST_NAME }</c:if>
								</c:if>
								<c:if test="${SDP_APPROVER_FST_DATE ne null && !empty SDP_APPROVER_FST_DATE}">
									<p class="approvalUser">${SDP_APPROVER_FST_NAME }</p>
								</c:if>
							</td>
							<td>
								<c:if test="${SDP_APPROVER_SND_DATE eq null || empty SDP_APPROVER_SND_DATE}">
									<c:if test="${sessionScope.SESS_EMPNO eq SDP_APPROVER_SND_EMPNO && (SDP_APPROVER_FST_DATE ne null && !empty SDP_APPROVER_FST_DATE)}">
										<a href="javascript:;" onclick="javascript:funAppProc('${SM_NO}','SND');" style="text-decoration: underline;">${SDP_APPROVER_SND_NAME}</a>
									</c:if>
									<c:if test="${sessionScope.SESS_EMPNO eq SDP_APPROVER_SND_EMPNO && (SDP_APPROVER_FST_DATE eq null && empty SDP_APPROVER_FST_DATE)}">
										${SDP_APPROVER_SND_NAME }
									</c:if>
									<c:if test="${sessionScope.SESS_EMPNO ne SDP_APPROVER_SND_EMPNO }">${SDP_APPROVER_SND_NAME }</c:if>
								</c:if>
								<c:if test="${SDP_APPROVER_SND_DATE ne null && !empty SDP_APPROVER_SND_DATE}">
									<p class="approvalUser">${SDP_APPROVER_SND_NAME }</p>
								</c:if>
							</td>
						</tr>
					</table>
				</div>
				<div style="clear:both;"></div>
			</c:if>
			
			<c:choose>
				<c:when test="${empty mode2}"><div class="sub-nav-title">게시신청 상세보기</div></c:when>
				<c:otherwise><div class="sub-nav-title">게시신청 수정하기</div></c:otherwise>
			</c:choose>
	
			<div class="basic-list">
			<form:form name="frm" id="frm" action="/displayBoard/Modify.do" method="post"  modelAttribute="frm" enctype="multipart/form-data" >
				<input type="hidden" id="SHSEQNUM" 	name="SHSEQNUM" value="${cha:seqEncode(SM_SEQ)}">
				<input type="hidden" name="SM_SEQ" value="${SM_SEQ}">
				<input type="hidden" name="SM_NO" value="${SM_NO}"/>
				<input type="hidden" name="SM_MEMPNO" 	value='<c:out value="${SM_MEMPNO}" />'><!-- 신청자사번 -->
				<input type="hidden" name="s1"            value='<c:out value="${paging.s1}" />'>
    			<input type="hidden" name="s2"            value='<c:out value="${paging.s2}" />'>
    			<input type="hidden" id="fileSeq_1" name="fileSeq_1">
				<input type="hidden" id="fileSeq_2" name="fileSeq_2">
				<input type="hidden" id="fileSeq_3" name="fileSeq_3">
				<input type="hidden" id="fileSeq_4" name="fileSeq_4">
				
				<div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>제작요청</legend>
								<div class="row-group">
									<dl class="insert_ready3">
										<dt class="must-option"><label for="SM_MDNAME" id="SM_MDNAME_label">신청번호</label></dt>
										<dd>
											${SM_NO }
										</dd>
										<dt class="must-option"><label for="SDP_worker" id="">작업자</label></dt>
										<dd>
											${SDP_worker }
										</dd>
									</dl>
									<dl class="insert_ready3">
										<dt class="must-option"><label for="SM_MDNAME" id="SM_MDNAME_label">신청부서</label></dt>
										<dd>
											<c:choose>
												<c:when test="${empty mode2}">${SM_MDNAME}</c:when>
												<c:otherwise>
													<input type="text" id="SM_MDNAME" name="SM_MDNAME" title="" placeholder="" value='<c:out value="${SM_MDNAME }"></c:out>' readonly="readonly">
												</c:otherwise>
											</c:choose>
										</dd>
										<dt class="must-option"><label for="SM_MNAME" id="SM_MNAME_label">신청자</label></dt>
										<c:choose>
											<c:when test="${empty mode2}">
												<dd>${SM_MNAME}</dd>
											</c:when>
											<c:otherwise>
												<dd>
													<input type="text" id="SM_MNAME" name="SM_MNAME" title="" placeholder="" value='<c:out value="${SM_MNAME }"></c:out>' readonly="readonly">
												</dd>
											</c:otherwise>
										</c:choose>
									</dl>
									<dl class="insert_ready3">
										<dt class="must-option"><label for="SM_MTEL" id="SM_MTEL_label">전화번호</label></dt>
										<dd>
											<c:choose>
												<c:when test="${empty mode2}">${SM_MTEL}</c:when>
												<c:otherwise>
													<input type="text" id="SM_MTEL" name="SM_MTEL" title="" placeholder="" value='<c:out value="${SM_MTEL }"></c:out>' readonly="readonly">
												</c:otherwise>
											</c:choose>
										</dd>
										<dt class="must-option"><label for="SM_MEMAIL" id="SM_MEMAIL_label">E-MAIL</label></dt>
										<c:choose>
											<c:when test="${empty mode2}">
												<dd>${SM_MEMAIL}</dd>
											</c:when>
											<c:otherwise>
												<dd>
													<input type="text" id="SM_MEMAIL" name="SM_MEMAIL" title="" placeholder="" value='<c:out value="${SM_MEMAIL }"></c:out>' readonly="readonly">
												</dd>
											</c:otherwise>
										</c:choose>
									</dl>
									
									<dl class="insert_ready3">
										<dt class="must-option"><label for="SSTART" id="SSTART_label">서비스 요청일</label></dt>
										<dd>
											<c:choose>
												<c:when test="${empty mode2}">${SSTART}</c:when>
												<c:otherwise>
													<input type="text" id="datepicker" name="SSTART" value='${SSTART}' readonly="readonly">
												</c:otherwise>
											</c:choose>
										</dd>
									</dl>
									<dl class="insert_ready3">
										<dt class="must-option"><label for="ServiceName" id="ServiceName_label">제목</label></dt>
										<dd class="must-option2-dd">
											<c:choose>
												<c:when test="${empty mode2}">${SM_TITLE}</c:when>
												<c:otherwise>
													<input type="text" id="SM_TITLE" name="SM_TITLE" title="" placeholder="" value="${SM_TITLE}">
												</c:otherwise>
											</c:choose>
										</dd>
									</dl>
									<dl class="insert_ready3">
										<dt class="must-option" ><label for="ServiceName" id="ServiceName_label">게시장소</label></dt>
										<dd style="width: 100%">
										<c:choose>
											<c:when test="${empty mode2}">
												<c:set var="SVC2_SPLIT" value="${fn:split(SM_SVC2,',')}"/>
												<c:set var="displayCnt" value="0"></c:set>
												<c:forEach items="${SVC2_SPLIT }" var="SVC2_SPLIT_FOR" varStatus="SVC2_SPLIT_status" >
													<c:set var="SVC2_SPLIT_INDEX" value="${SVC2_SPLIT_status.index}" />
													<c:if test="${SVC2_SPLIT_INDEX ne 0 }">,</c:if>
													<c:out value="${cha:svc2NameDisplay(SVC2_SPLIT_FOR)}" />
													
													<c:set var="displayCnt" value="${displayCnt + 1}"></c:set>
													<c:if test="${displayCnt % 5 == 0}"><span style="display: block;margin-top: 1px;"></span></c:if>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:forEach items="${categoreyList}" var ="categoreyList" varStatus="cstatis">
													<div class="checks small">
														<input type="checkbox" id="ex_chk_${categoreyList.CD2_CODE}" name="SM_SVC2" value="<c:out value="${categoreyList.CD2_CODE}" />"> 
														<label for="ex_chk_${categoreyList.CD2_CODE}"><c:out value="${categoreyList.CD2_NAME}" /></label> 
													</div>
												</c:forEach>
											</c:otherwise>
										</c:choose>
										</dd>	
									</dl>
									
									<dl class="insert_ready3">
										<dt class="must-option" ><label for="SM_MTEL" id="SM_MTEL_label">게시일시</label></dt>
										<dd>
											<c:choose>
												<c:when test="${empty mode2}">
													<c:out value="${cha:changday2(SDP_FDATE)}" /> ~ <c:out value="${cha:changday2(SDP_TDATE)}" />
												</c:when>
												<c:otherwise>
													
												
													<input type="text" name="STIME1" id="STIME1"
													style="width: 120px;height:15px;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;" 
													value="${fn:substring(SDP_FDATE,0,4)}-${fn:substring(SDP_FDATE,4,6)}-${fn:substring(SDP_FDATE,6,8)}">
													<select name="STIME2" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
													<option value="">시</option>
													<c:forEach var="i" begin="7" end="19" step="1" varStatus="i_status">
														<c:set var="i_num" value=""/>
														<c:if test="${i_status.index < 10}">
															<c:set var="i_num" value="0"/>
														</c:if>
														<c:set var="iNumAll" value="${i_num}${i}" />
														<option value="${iNumAll}" <c:if test="${fn:substring(SDP_FDATE,8,10) eq iNumAll}">selected="selected"</c:if>>${i}</option>
													</c:forEach>
													</select>
													<select name="STIME3" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
													<option value="">분</option>
													<c:forEach var="j" begin="0" end="50" step="10" varStatus="j_status">
														<c:set var="j_num" value=""/>
														<c:if test="${j_status.index < 10}">
															<c:set var="j_num" value="0"/>
														</c:if>
														<c:set var="jNumAll" value="${j_num}${j}" />
														<option value="${jNumAll}" <c:if test="${fn:substring(SDP_FDATE,10,12) eq jNumAll}">selected="selected"</c:if>>${j}</option>
													</c:forEach>
													</select>
													
													
													<input type="text" name="ETIME1" id="ETIME1" 
													style="width: 120px;height:15px;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;"
													value="${fn:substring(SDP_TDATE,0,4)}-${fn:substring(SDP_TDATE,4,6)}-${fn:substring(SDP_TDATE,6,8)}">
													<select name="ETIME2" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
													<option value="">시</option>
													<c:forEach var="i" begin="7" end="19" step="1" varStatus="i_status">
														<c:set var="i_num" value=""/>
														<c:if test="${i_status.index < 10}">
															<c:set var="i_num" value="0"/>
														</c:if>
														<c:set var="iNumAll" value="${i_num}${i}" />
														<option value="${iNumAll}" <c:if test="${fn:substring(SDP_TDATE,8,10) eq iNumAll}">selected="selected"</c:if>>${i}</option>
													</c:forEach>
													</select>
													<select name="ETIME3" style="width:50px;" class="listbox" onchange="javascript:$(this).blur();">
													<option value="">분</option>
													<c:forEach var="j" begin="0" end="50" step="10" varStatus="j_status">
														<c:set var="j_num" value=""/>
														<c:if test="${j_status.index < 10}">
															<c:set var="j_num" value="0"/>
														</c:if>
														<c:set var="jNumAll" value="${j_num}${j}" />
														<option value="${jNumAll}" <c:if test="${fn:substring(SDP_TDATE,10,12) eq jNumAll}">selected="selected"</c:if>>${j}</option>
													</c:forEach>
													</select>
												</c:otherwise>
											</c:choose>
										</dd>
										<c:if test="${SM_LSTATE ne '3093' || SM_LSTATE ne '3097' }">
											<c:choose>
												<c:when test="${SM_LSTATE eq '3095' }">
													<dt class="must-option"><label for="SM_TEXT" id="SM_TEXT_label">완료일</label></dt>
												</c:when>
												<c:otherwise>
													<dt class="must-option"><label for="SM_TEXT" id="SM_TEXT_label">완료 예정일</label></dt>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${!empty mode2 && SM_LSTATE eq '3093'}">
												<dd>
													<c:out value="${SDP_PLANDATE}"></c:out>
												</dd>
												</c:when>
												<c:when test="${!empty mode2 }">
													<dd>
														<input type="text" name="SDP_PLANDATE" id="SDP_PLANDATE" value="${SDP_PLANDATE }"
														style="width: 120px;height:15px;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
													</dd>												
												</c:when>
												<c:otherwise>
												<dd>
													<c:out value="${SDP_PLANDATE}"></c:out>
												</dd>
												</c:otherwise>
											</c:choose>
										</c:if>
									</dl>
									<dl class="insert_ready3">
										<dt class="must-option"><label for="SM_TEXT" id="SM_TEXT_label">제작요청 내용</label></dt>
										<c:choose>
											<c:when test="${empty mode2}">
												<dd style="width:260px;"><div style="height:250px; width:760px;overflow-y: scroll;padding-right: 5px;"><pre style="font-family: 돋음,dotum;"><c:out value="${SM_TEXT}"></c:out></pre></div></dd>
											</c:when>
											<c:otherwise>
											<dd><textarea rows="10" cols="88" name="SM_TEXT"><c:out value="${SM_TEXT}"></c:out></textarea></dd>
											</c:otherwise>
										</c:choose>
									</dl>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
			</form:form>
					
			<form id="file_frm" name="file_frm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="SDP_SEQ" name="SDP_SEQ" value="0" />
			<input type="hidden" id="target_file" name="target_file" value=""/>
			<input type="hidden" id="tmp_EMPNO" name="tmp_EMPNO" value="${SM_MEMPNO }"/>
				<div class="insrtfrom-framebox1">
					<div class="insert-step1-box">
						<div class="form-step1">
							<div class="row-group">
							<c:set var="fileCount" value="${fn:length(contentFileList) }" />
								<c:if test="${empty mode2 }">
									<c:forEach begin="0" end="2" varStatus="sts">	
										<dl class="insert_ready3">
											<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일${sts.count }</label></dt>
											<dd class="must-option2-dd">
												<c:choose>
													<c:when test="${(SM_MEMPNO eq sessEmpno || sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 || sessionScope.SESS_EMPNO eq SDP_APPROVER_FST_EMPNO || sessionScope.SESS_EMPNO eq SDP_APPROVER_SND_EMPNO || sessionScope.SESS_EMPNO eq SDP_APPROVER_FST_EMPNO) && contentFileList[sts.index].SDP_status eq 'U'}">
														<a href="#" onclick="goDown('${contentFileList[sts.index].SDP_SEQ}')" style="cursor: pointer;">${contentFileList[sts.index].SDP_orgFileName }</a>
													</c:when>
													<c:when test="${(SM_MEMPNO ne sessEmpno || sessionScope.SESS_SERVICE_ADMIN_INFO lt 1)  && contentFileList[sts.index].SDP_status eq 'U'}">
															첨부파일은 신청자 본인에게만 공개되어 있습니다.
													</c:when>
													<c:otherwise>
													</c:otherwise>
												</c:choose>
											</dd>
										</dl>
									</c:forEach>
									<c:forEach items="${completeFileList }" var="completeFileList">
										<c:if test="${(completeFileList.SDP_orgFileName ne '' && completeFileList.SDP_orgFileName ne null)}">
											<dl class="insert_ready3">
												<dt class="must-option"><label for="ServiceName" id="ServiceName_label" style="color: red;">완료파일</label></dt>
												<dd class="must-option2-dd" >
													<c:choose>
														<c:when test="${SM_MEMPNO eq sessEmpno || sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 || sessionScope.SESS_EMPNO eq SDP_APPROVER_FST_EMPNO || sessionScope.SESS_EMPNO eq SDP_APPROVER_SND_EMPNO || sessionScope.SESS_EMPNO eq SDP_APPROVER_FST_EMPNO}">
															<a href="#" onclick="goDown('${completeFileList.SDP_SEQ}')" style="cursor: pointer;">${completeFileList.SDP_orgFileName }</a>
														</c:when>
														<c:otherwise>첨부파일은 신청자 본인에게만 공개되어 있습니다.</c:otherwise>
													</c:choose>
												</dd>
											</dl>
										</c:if>
									</c:forEach>
								</c:if>	
								<c:if test="${mode2 == '0'}">
									<c:forEach begin="0" end="2" varStatus="sts">
										<dl class="insert_ready3">
											<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일${sts.count }</label></dt>
											<dd class="must-option2-dd">
												<c:choose>
													<c:when test="${(SM_MEMPNO eq sessEmpno || sessionScope.SESS_SERVICE_ADMIN_INFO >= 1) && contentFileList[sts.index].SDP_status eq 'U'}">
														<div class="filebox">
															<input class="upload-name" value="${contentFileList[sts.index].SDP_orgFileName }" disabled="disabled">
															<label for="files${sts.count }" id="files${sts.count }" onclick="godel('${contentFileList[sts.index].SDP_SEQ }', this , '${sts.count }')" >삭제</label> 
														</div>
													</c:when>
													<c:when test="${(SM_MEMPNO ne sessEmpno || sessionScope.SESS_SERVICE_ADMIN_INFO < 1)  && contentFileList[sts.index].SDP_status eq 'U'}">
															첨부파일은 신청자 본인에게만 공개되어 있습니다.
													</c:when>
													<c:otherwise>
														<div class="filebox">
															<input class="upload-name" value="파일선택" disabled="disabled">
															<label for="files${sts.count }">업로드</label> 
															<input class="upload-hidden" name="uploadFile${sts.count }" id="files${sts.count }" type="file" value="" />
															<progress id="progressBar_${sts.count }" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
															&nbsp<span id="progressT_${sts.count }" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_${sts.count }">0</font>%</span>
														</div>
													</c:otherwise>
												</c:choose>
											</dd>
										</dl>
									</c:forEach>	
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</form>
			<c:if test="${sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 && SM_LSTATE eq '3093' &&  mode eq 0 && empty mode2}">
			<form method="post" id="subFrm" name="subFrm">
				<input type="hidden" name="SM_NO" value="${SM_NO}"/>
				<input type="hidden" name="SM_MEMPNO" 	value='<c:out value="${SM_MEMPNO}" />'><!-- 신청자사번 -->
				<input type="hidden" name="SHSEQNUM" 	value='<c:out value="${SM_SEQ}" />'>
				<div class="insrtfrom-framebox" style="margin-top: 20px;">
					<div class="insert-step1-box">
					<div class="sub-nav-title">추가입력 사항 </div>
						<div class="form-step1">
							<div class="row-group">
								<dl class="insert_ready3">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">담당자 부서</label></dt>
									<dd>
										<input type="hidden" id="SDP_APPROVER_FST_DEPTCODE" name="SDP_APPROVER_FST_DEPTCODE" title="" style="width: 100%" value="">
										<input type="text" id="SDP_APPROVER_FST_DEPTNAME" name="SDP_APPROVER_FST_DEPTNAME" title="" style="width: 100%" value="" readonly="readonly">
									</dd>
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">담당자</label></dt>
									<dd class="btn-zone" >
										<input type="hidden" id="SDP_APPROVER_FST_EMPNO" name="SDP_APPROVER_FST_EMPNO" title="" style="width: 40%" value="">
										<input type="text" id="SDP_APPROVER_FST_NAME" name="SDP_APPROVER_FST_NAME" title="" class="schword"  style="width: 40%" value="">
										<input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색"><span class="help" style="color:#666; ">*이름/사번</span>
									</dd>
								</dl>
								<dl class="insert_ready3">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">파트장 부서</label></dt>
									<dd>
										<input type="hidden" id="SDP_APPROVER_SND_DEPTCODE" name="SDP_APPROVER_SND_DEPTCODE" title="" style="width: 100%" value="">
										<input type="text" id="SDP_APPROVER_SND_DEPTNAME" name="SDP_APPROVER_SND_DEPTNAME" title="" style="width: 100%" value="" readonly="readonly">
									</dd>
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">파트장</label></dt>
									<dd class="btn-zone" >
										<input type="hidden" id="SDP_APPROVER_SND_EMPNO" name="SDP_APPROVER_SND_EMPNO" title="" style="width: 40%" placeholder="" value="">
										<input type="text" id="SDP_APPROVER_SND_NAME" name="SDP_APPROVER_SND_NAME" title="" class="schword"  style="width: 40%" placeholder="" value="">
										<input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색"><span class="help" style="color:#666; ">*이름/사번</span>
									</dd>
								</dl>
								<dl class="insert_ready3">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">완료예정일</label></dt>
									<dd>
										<input type="text" name="SDP_PLANDATE" id="SDP_PLANDATE" value=""
										style="width: 120px;height:15px;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
									</dd>
									<dt class="must-option"><label for="ServiceName" id="">작업자</label></dt>
									<dd>
										<input type="text" name="SDP_worker" id="SDP_worker" value="">
									</dd>
								</dl>
							</div>
						</div>
					</div>
				</div>
			</form>
			</c:if>
			
			<!-- 약관동의 내용 -->
			<div style="margin-top: 10px; margin-bottom: 20px;">
				<c:if test="${fn:length(AC_CONTENTS1) != 0 }">
					<div style="width: 100%; height: 100px;border: 1px solid #a9abae;overflow-y:auto;word-break: break-all">
						<c:out value="${AC_CONTENTS1 }" escapeXml="false"></c:out>
					</div>
				</c:if>
			</div>
			
			<c:if test="${SM_LSTATE eq '3099' && sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 && empty mode2}">
			<form name="frm_complefile" id="frm_complefile" method="post"  enctype="multipart/form-data">
			<input type="hidden" name="target_file" id="complete_file" value="">
			<input type="hidden" id="tmp_EMPNO1" name="tmp_EMPNO" value="${SM_MEMPNO }"/>
				<div class="insrtfrom-framebox" style="margin-top: 20px;">
					<div class="insert-step1-box">
						<div class="sub-nav-title">추가입력 사항</div>
						<div class="form-step1">
							<div class="row-group">
								<dl class="insert_ready">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">완료일</label></dt>
									<dd class="must-option2-dd">
									<input type="text" name="SDP_PLANDATE" id="SDP_PLANDATE" value=""
										style="height:15px;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat; cursor: pointer;">
									</dd>
								</dl>
								<dl class="insert_ready">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">완료 첨부파일</label></dt>
									<dd class="must-option2-dd">
										<div class="filebox">
											<input class="upload-name" value="파일선택" disabled="disabled">
											<label for="files4">업로드</label> 
											<input class="upload-hidden" name="uploadFile4" id="files4" type="file" />
											&nbsp<progress id="progressBar_4" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
											<span id="progressT_4" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_4">0</font>%</span>
										</div>
									</dd>
								</dl>
							</div>
						</div>
					</div>
				</div>
			</form>
			</c:if>
		</div>
		
					
		<div class="btn-zone">
			<ul>
				<c:choose>
				<c:when test="${empty mode2}">
					<c:if test="${(SM_LSTATE eq '3093' || SM_LSTATE eq '3094' || SM_LSTATE eq '3099' ) && (sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 || SM_MEMPNO eq sessEmpno )}">
						<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:doDetail(0);" value="수정"></li>
						<li><input type="button" name="srchDescription2" class="search_btn" style="width:63px;" onclick="javascript:doDetail(1);" value="신청취소"></li>
					</c:if>
					<c:if test="${(sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 ) && SM_LSTATE eq '3093'}">
						<li><input type="button" style="width:72px;" name="srchDescription2" class="search_btn" onclick="javascript:goAcceptDisp();" value="접수 완료"></li>
					</c:if>
					<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:goToDetPrg();" value="목록"></li>
				</c:when>
				<c:otherwise>
					<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:save(0);" value="저장"></li>
				</c:otherwise>
				</c:choose>
				<c:if test="${SM_LSTATE eq '3099' && sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 && empty mode2}">
				<li><input type="button" name="srchDescription2" class="search_btn1" onclick="javascript:doComplete('${SM_SEQ}');" value="완료저장"></li>
				</c:if>
			</ul>
		</div>
		<div class="btn-zone" style="margin-bottom: 50px; float: left;">
			<ul>
				<li><input type="button" class="search_btn1" onclick="window.open('displayPrint.do?strID=${SM_SEQ}', 'displayPrint', 'width=1000px, height=900px, scrollbars=yes');" value="내용 출력" /></li>
			</ul>
		</div>
		<div style="clear: both;" >
			<div class="text_box" style="top: 15px;">
				<div class="test_box_layer">
				<p>컨텐츠 제작 관리 부서 : ICT인프라처 ICT서비스부 / 컨텐츠 제작 : 멀티미디어센터 (본관 3층)</p>
				<p>원본 데이터(자료) 및 변환자료의 형태(DVD,CD,자료전송), 수량, 작업일정 등에 따라 소요시간이 달라지므로, 완료일이 중요할 경우</p>
				<p>반드시 담당자와 통화하시기 바랍니다. </p>
				<p>PPT/이미지제작 (061-6381,6384)  영상,DVD제작 (061-6386)</p>
				</div>
			</div>
		</div>
	</div>
		<!--content end-->
	</div>
</div>


<form id="FormDetail" name="FormDetail" action="" method="post">
	<input type="hidden" id="SHSEQNUM" 	name="SHSEQNUM" value="${cha:seqEncode(SM_SEQ)}">
	<input type="hidden" id="mode"		name="mode" 	value="${mode}"/>
	<input type="hidden" id="mode2" 	name="mode2" 	value=""/>
    <input type="hidden" name="categoreyList" value="${categoreyList }"/>
    <input type="hidden" name="SM_WDATE_FROM"         value="${paging.SM_WDATE_FROM }"/>
    <input type="hidden" name="SM_WDATE_TO"         value="${paging.SM_WDATE_TO }"/>
    <input type="hidden" name="pageNo"        value="${paging.pageNo }"/>
    <input type="hidden" name="s1"            value='<c:out value="${paging.s1}" />'>
    <input type="hidden" name="s2"            value='<c:out value="${paging.s2}" />'>
    <input type="hidden" name="s3"            value='<c:out value="${paging.s3}" />'>
    <input type="hidden" name="s4"            value='<c:out value="${paging.s4}" />'>
</form>
</body>

<script type="text/javascript" src="/resource/common/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.number.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.1-ui.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.jqtransform.js"></script>     
<script type="text/javascript" src="/resource/common/js/jquery.form.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.caret.min.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.tag-editor.min.js"></script>    
<script type="text/javascript">
$(document).ready(function() {
	if('${mode}' == 1){
		load_fnc('6', '0', '0'); //menu script
	}else{
		load_fnc('3', '0', '0'); //menu script
	}
	/* $("#datepicker").datepicker(); */
	$("#STIME1").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
		onClose: function( selectedDate ) {
			// 시작일(fromDate) datepicker가 닫힐때
			// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
			$("#ETIME1").datepicker( "option", "minDate", selectedDate );
		}
	});
	$("#ETIME1").datepicker({
		dateFormat: "yy-mm-dd",
		minDate: 0, // 오늘 이전 날짜 선택 불가
		onClose: function( selectedDate ) {
			// 종료일(toDate) datepicker가 닫힐때
			// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정
			$("#STIME1").datepicker( "option", "maxDate", selectedDate );
		}
	});
	/* 
	$("#MULTIPAGE").width(350);
	$(".giTaBox").show();
	$(".workView_btn").hide();
	 */
	//수정 페이지 초기화
	var SM_SVC2 = "<c:out value='${SM_SVC2}' />";
	smCodeArray = SM_SVC2.split(",");
	
	for(var i=0; i < smCodeArray.length; i++){
		$("#ex_chk_"+smCodeArray[i].replace(/(\s*)/g,"")+"").prop("checked", true);
	}
	
	
	if($('#SDP_PLANDATE').length == 1){
		$('#SDP_PLANDATE').datepicker({
			dateFormat: "yy-mm-dd"
		 });
	}
	
	$('.schword').keydown(function(key){
		if(key.keyCode == 13){
			$(this).siblings('.schbtn').trigger('click');
		}
	})
	
	
});

$(document).on('change', ".filebox .upload-hidden" , function(){  // 값이 변경되면
  if(window.FileReader){  // modern browser
    var filename = $(this)[0].files[0].name;
  }else{  // old IE
    var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
  }
  $(this).siblings('.upload-name').val(filename); // 추출한 파일명 삽입
});

function save(){
	if (document.frm.SM_MDNAME.value == "" ) {
		alert("신청부서를 입력 하십시오.");
		document.frm.SM_MDNAME.focus();
		return false;
	}
	if (document.frm.SM_MNAME.value == "" ) {
		alert("신청자 이름을 입력 하십시오.");
		document.frm.SM_MNAME.focus();
		return false;
	}
	if (document.frm.SM_MTEL.value == "") {
		alert("전화번호를 입력 하십시오.");
		document.frm.SM_MTEL.focus();
		return false;
	}
	var SM_MEMAIL = document.frm.SM_MEMAIL.value;
	// 정규식 - 이메일 유효성 검사
    var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if (!regEmail.test(SM_MEMAIL)){
			alert("이메일 형식에 맞게 입력 하십시오.");
			document.frm.SM_MEMAIL.focus();
			return false;
	}
	if(document.frm.SM_TITLE.value == ""){
		alert("제목을 입력 하십시오.");
		document.frm.SM_TITLE.focus();
		return false;
	}
	/* 
	if (document.frm.MULTIPAGE.value == "" ){
		alert("서비스 세부내용을 입력 하십시오.");
		document.frm.MULTIPAGE.focus();
		return false;
	}
	 */
	var ckBox = $("input:checkbox[name='SM_SVC2']").is(":checked");
	if (ckBox == false) {
		alert("게시 신청할 장소를 하나 이상 선택 하십시오.");
		return false;
	}
	if(document.frm.STIME1.value == ""){
		alert("게시 시작일자를 선택 하십시오.");
		document.frm.STIME1.focus();
		return false;
	}
	if(document.frm.STIME2.value == ""){
		alert("시간을 선택 하십시오.");
		document.frm.STIME2.focus();
		return false;
	}
	if(document.frm.STIME3.value == ""){
		alert("시간의 '분'을 선택 하십시오.");
		document.frm.STIME3.focus();
		return false;
	}
	if(document.frm.ETIME1.value == ""){
		alert("게시 종료일자를 선택 하십시오.");
		document.frm.ETIME1.focus();
		return false;
	}
	if(document.frm.ETIME2.value == ""){
		alert("시간을 선택 하십시오.");
		document.frm.ETIME2.focus();
		return false;
	}
	if(document.frm.ETIME3.value == ""){
		alert("시간의 '분'을 선택 하십시오.");
		document.frm.ETIME3.focus();
		return false;
	}
	if (document.frm.SM_TEXT.value == "" ) {
		alert("게시 내용 또는 문구를 입력 하십시오.");
		document.frm.SM_TEXT.focus();
		return false;
	}
	
	if(confirm('수정사항을 저장하시겠습니까?')){
		$('#frm').submit();
	}
}

function doDetail(mode2){
	//0 수정 , 1삭제
	if(mode2 == 0){
		$("#FormDetail").attr("action","/displayDetail.do");
		$("#mode2").val(mode2);
		$("#FormDetail").submit();
	}else if(mode2 == 1){
		
		 if (confirm("취소 하시겠습니까?")) {
			$("#FormDetail").attr("action","/displayDel.do");
			$("#mode2").val(mode2);
			$("#FormDetail").submit();
	     } else {  
			return false;
	     }  
	}
}

function goToDetPrg() {
	
	if('${mode}' == 1){
		$("#FormDetail").attr("action", "/mypageDisplayBoardList.do");
	    $("#FormDetail").submit();
	}else{
		$("#FormDetail").attr("action", "/displayBoardProgress.do");
	    $("#FormDetail").submit();		
	}
}


$(".schbtn").click(function(e) {
	searchMember(e, this);
});

function searchMember(e, this_obj){
	
	e.preventDefault();

    var obj = $(this_obj);
    var schword = obj.siblings('.schword');
	var target_Name = schword.attr('id');
    if( !$.trim(schword.val()) )
    {
        alert('이름/사번을 입력하여 주십시요.');
        schword.focus();
        return false;
    }

    $.ajax({
        url : '/admin/searchMember.do',
        type : 'post',
        data : { 'mode':'search_member', 'keyword':$.trim(schword.val()) },
        success : function(data) {

            var parse_data = $.parseJSON(data).memberList;
            var data_len = parse_data.length;
            var arr = {};
            arr.key = $('.schbtn').index(obj);

            if(data_len)
            {
            	$('#mem_list_layer').remove();
                var html = "<div id='mem_list_layer'><table width='450'>";
                html += "<colgroup><col width='100' /><col width='100' /><col width='300 /></colgroup>";
                html += "<tr id='_title'><th height='30' class='titbg'>사번</th>";
                html += "<th class='titbg'>이름</th>";
                html += "<th class='titbg'>소속</th></tr>";

                $.each(parse_data, function() {
                	arr.deptno = this.deptno;
                    arr.empno = this.empno;
                    arr.name = this.name;
                    arr.dept_nm = (this.dept_nm_depth1 == '' ? this.dept_nm : this.dept_nm_depth1);
                    arr.telno = this.telno;

                    html += "<tr>";
                    html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData(\""+target_Name+"\","+JSON.stringify(arr)+");'>"+this.empno+"</a></td>";
                    html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData(\""+target_Name+"\","+JSON.stringify(arr)+");'>"+this.name+"</a></td>";
                    html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData(\""+target_Name+"\","+JSON.stringify(arr)+");'>"+this.dept_nm+"</a></td>";
                    html += "</tr>";
                });

                html += "</table></div>";
                obj.after(html);
                $('#mem_list_layer').slideDown();

            }
            else
            {
                alert('검색된 데이터가 없습니다.');
                obj.siblings('input').val('');
                if( obj.siblings().hasClass('appeno') )
                {
                    $("input[name='appss'], input[name='apptel'], input[name='appmail']").val('');
                }
                return false;

            }

        }

    }); //end of ajax
}

function userSetData(target, val){
	var tarName = target;
	var deptName = val.dept_nm;
	var deptCode = val.deptno;
	var name = val.name;
	var empno = val.empno;
	
	if(tarName.indexOf("_FST_") != -1){
		$('#SDP_APPROVER_FST_DEPTCODE').val(deptCode);
		$('#SDP_APPROVER_FST_DEPTNAME').val(deptName);
		$('#SDP_APPROVER_FST_NAME').val(name);
		$('#SDP_APPROVER_FST_EMPNO').val(empno);
	}else if(tarName.indexOf("_SND_") != -1){
		$('#SDP_APPROVER_SND_DEPTCODE').val(deptCode);
		$('#SDP_APPROVER_SND_DEPTNAME').val(deptName);
		$('#SDP_APPROVER_SND_NAME').val(name);
		$('#SDP_APPROVER_SND_EMPNO').val(empno);
	}
    $('#mem_list_layer').slideUp();
}

function goAcceptDisp(){
	
	var fieldChk = true;
	var msg = '';
	
	if($('#SDP_APPROVER_FST_DEPTCODE').val() == ''){
		msg = '부서';
		fieldChk = false;
	}else if($('#SDP_APPROVER_FST_DEPTNAME').val() == ''){
		msg = '부서';
		fieldChk = false;
	}else if($('#SDP_APPROVER_FST_EMPNO').val() == ''){
		msg = '담당자';
		fieldChk = false;
	}else if($('#SDP_APPROVER_FST_NAME').val() == ''){
		msg = '담당자';
		fieldChk = false;
	}else if($('#SDP_APPROVER_SND_DEPTCODE').val() == ''){
		msg = '파트장 부서';
		fieldChk = false;
	}else if($('#SDP_APPROVER_SND_DEPTNAME').val() == ''){
		msg = '파트장 부서';
		fieldChk = false;
	}else if($('#SDP_APPROVER_SND_EMPNO').val() == ''){
		msg = '파트장';
		fieldChk = false;
	}else if($('#SDP_APPROVER_SND_NAME').val() == ''){
		msg = '파트장';
		fieldChk = false;
	}else if($('#SDP_PLANDATE').val() == ''){
		msg = '완료 예정일';
		fieldChk = false;
	}else if($('#SDP_worker').val() == ''){
		msg = '작업자';
		fieldChk = false;
	}
	
	if(fieldChk){
		if(confirm('접수하시겠습니까?')){
			$.ajax({
				url : '/displayBoard/displayAccept.do',
				type : 'post',
				data : $('#subFrm').serialize(),
				success : function(data) {
					if("success" == data){
						alert('접수 되었습니다.');
						$("#FormDetail").attr("action", "/displayDetail.do");
						$("#FormDetail").attr("onSubmit", "");
						$("#FormDetail").submit();
						$("#FormDetail").attr("onSubmit", "return false;");
						/* location.reload(); */
					}else{
						alert('접수가 실패하였습니다.');
					}
				}
			});
		}
	}else{
		alert(msg + '를(을) 입력해주세요.');
		return;
	}
	
}

function funAppProc(smNo, status){
	var SM_SEQ  = ${SM_SEQ};
	
	if(confirm('승인하시겠습니까?')){
		$.ajax({
			url : '/displayBoard/displayApprove.do',
			type : 'post',
			data : {'SM_NO' : smNo, 'approveState': status, 'SHSEQNUM': SM_SEQ},
			success : function(data) {
				if(data == 'success'){
					alert('승인되었습니다.');
					$("#SHSEQNUM").val();
					$("#FormDetail").attr("action", "/displayDetail.do");
					$("#FormDetail").attr("onSubmit", "");
					$("#FormDetail").submit();
					$("#FormDetail").attr("onSubmit", "return false;");
				}
			}
		});
	}
}

/* 파일다운로드 */
function goDown(val){
	$('#SDP_SEQ').val(val);
	$('#file_frm').attr('action', '<%=Constants.DISPLAY_DOWNLOAD_ASP_CALL %>?SDP_SEQ='+val);
	$('#file_frm').submit();
	return false;
}

/* 파일삭제 */
function godel(val, obj, name){
	var param = {"SDP_SEQ":val};
	var targetId = obj.id;
	var targetName = name;
	var par_temp = $("#"+targetId+"").parent();
	
	var html = '';

	if(confirm('파일을 삭제하시겠습니까?')){
		$.ajax({
			type : 'post',
			url : '/removeDisplayFile.do',
			dataType : 'text',
			data : param,
			success : function(result){
				if(result == 'true'){
					html += '<input class="upload-name" value="파일선택" disabled="disabled">';
					html += '<label for="' + targetId + '"> 업로드</label> ';
					html += '<input class="upload-hidden" name="uploadFile' + targetName + '" id="' + targetId + '" type="file" value="" />';
					html +='<progress id="progressBar_'+targetName+'" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>';
					html +='&nbsp<span id="progressT_'+targetName+'" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_'+targetName+'">0</font>%</span>';
					alert('삭제되었습니다.');
					$("#"+targetId+"").parent().empty();
					par_temp.append(html);
				}else{
					alert('관리자에게 문의하시오.');
				}
			},
			error : function(e){
				alert('error.');
			}
		})
	}
	
}

/* 파일업로드 */
$(document).on('change', ".filebox .upload-hidden",function(){
	
	var ua = window.navigator.userAgent;
	var filesId = $(this)[0].id;
	var inputName = $(this)[0].name;
	var filename  = $(this)[0].files[0].name;
	var subFileId = filesId.substring(5,6);

	var formGubun = '';
	if(subFileId == '4'){
		formGubun = 'frm_complefile';
		$('#complete_file').val(inputName);
	}else{
		formGubun = 'file_frm';
		$('#target_file').val(inputName);
	}
	
	
	if(navigator.appName == 'Netscape' && ua.indexOf('Trident/7.0') != -1){
		if(filename != null || filename == ""){
			$('form[name="'+formGubun+'"]').ajaxForm({  
				url: "<%=Constants.DISPLAY_ASP_CALL %>",
				type: "POST",
				crossdomain: true, 
				enctype: "multipart/form-data",
				dataType: "json",
				contentType: "multipart/form-data",
				timeout: 1000 * 60 * 10,
				beforeSend: function() {
					var percentVal = '0%';
					$('span[id^=progressT_'+subFileId+']').show();
				},
				uploadProgress: function(event, position, total, percentComplete) {
					$('progress[id^=progressBar_'+subFileId+']').val(percentComplete);
					$('font[id^=progressBarRate_'+subFileId+']').text(percentComplete);
					//$('#srchDescription').text('업로드 진행 중');
				},
				success: function(msg) {
			    	if(subFileId == '1'){
			    		$("#fileSeq_1").val(msg);
			    	}else if (subFileId == '2'){
			    		$("#fileSeq_2").val(msg);
			    	}else if (subFileId == '3'){
			    		$("#fileSeq_3").val(msg);
			    	}else{
			    		$("#fileSeq_4").val(msg);
			    	}
			    },
			    complete: function(xhr) {
			    },
			    error: function(e){
			    	alert('업로드 중 오류가 발생했습니다\n새로고침 후 다시 진행 하시기 바랍니다');
			    	location.reload();
			    }
			})
			$('form[name="'+formGubun+'"]').submit();
		}
		
	}else{
		alert('IE 최신 브라우저에서 사용 가능합니다.');
	}
} )

/* 완료저장 */
function doComplete(seq){
	var SM_SEQ = seq;
	if ($("#SDP_PLANDATE").val() == '' || $("#SDP_PLANDATE").val() == null) {
		alert("완료일을 입력해 주십시오.");
		return false;
	}
	if ($("#fileSeq_4").val() == '' || $("#fileSeq_4").val() == null) {
		alert("완료된 첨부파일을 등록하십시오.");
		return false;
	}
	var params = {
			'SM_LSTATE':'3095',
			'fileSeq_4':$("#fileSeq_4").val(),
			'SM_MEMPNO':$("input[name='SM_MEMPNO']").val(),
			'SM_NO':$("input[name='SM_NO']").val(),
			'SDP_PLANDATE':$("input[name='SDP_PLANDATE']").val(),
			'SHSEQNUM': SM_SEQ
	}
	$.ajax({
		type:"POST",
		url:"/displayCompleteFile.do",
		data : params,
		dataType : "json",
		success: function(result){
			console.log(result);
			if(result == true ){
				alert('승인되었습니다.');
				$("#SHSEQNUM").val();
				$("#FormDetail").attr("action", "/displayDetail.do");
				$("#FormDetail").attr("onSubmit", "");
				$("#FormDetail").submit();
				$("#FormDetail").attr("onSubmit", "return false;");
			}
		},
		error: function(xhr, status, error) {
			alert(error);
		}
	})
}

</script>
<c:import url="/resource/common/include/bottom.jsp" />