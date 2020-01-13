<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<style>
#modal-background {
   display: none;
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background-color: black;
   opacity: .10;
   -webkit-opacity: .1;
   -moz-opacity: .1;
   filter: alpha(opacity=10);
   z-index: 1000;
}
</style>
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="/resource/common/js/jquery.datetimepicker.full.min.js"></script>
<body>
	<div id="modal-background"></div>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="2" var="left_depth_1"/>

    <div id="contents" class="learn-frame-area">
        <div class="contents-framebox" id="contents_id">
            <!-- leftmenu -->
            <div class="contents-header-framebox">
                <div class="learn-tit-framebox">
                    <c:import url="/resource/common/include/leftMenu_01.jsp">
                        <c:param name="left_depth_1" value="8"></c:param>
                        <c:param name="left_depth_2" value="5"></c:param>
                        <c:param name="left_depth_3" value="2"></c:param>
                    </c:import>
                </div>
            </div>
            <!-- leftmenu end-->
            
            <div id="sendInfo_pop_confirm" title="신청자 취소알림 처리" style="display: none;">
			  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 6px 6px 0;"></span>신청자에게 취소알림 SMS 및 메일을 전송하시겠습니까?</p>
			</div>
			            
            <!--content-->
            <div class="contents-con-framebox">
                <div class="nav-box">
                    <div class="nav-img"><img alt="" src="/resource/images/sub/sub8_tit_img.png"></div>
                    <div class="nav-list">
                        <img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리메뉴</b>
                    </div>
                    <div class="nav-title">접수현황</div>
                </div>

                <div class="sub-nav-title">장비신청</div>

                <div class="basic-list">
                    <form id="frm" name="frm" action="/admin/recUpdate.do" method="post" enctype="multipart/form-data" onsubmit="return check();">
                        <input type="hidden" name="appno" value="${appno}" />
                        <input type="hidden" name="mode" value="recUpdate" />
                            <!-- 신청자사번 -->

                            <div class="insrtfrom-framebox">
                                <div class="insert-step1-box">
                                    <div class="form-step1">
                                        <fieldset>
                                            <legend>장비신청</legend>
                                            <div class="row-group">

                                                <dl class="insert_ready">
                                                    <dt class="must-option">
                                                        <label>신청부서</label>
                                                    </dt>
                                                    <dd style="width: 200px;">
                                                        <input type="text" name="appss" value="${view.appss}" readonly="readonly">
                                                    </dd>
                                                    <dt class="must-option">
                                                        <label>신청자</label>
                                                    </dt>
                                                    <dd class="btn-zone" style="width: 250px;">
                                                        <input type="hidden" name="appeno" class="appeno" value="${view.appeno}"/>
                                                        <input type="hidden" name="appenm" class="appenm" value="${view.appenm}" />
                                                        <input type="hidden" name="deptno" class="deptno" value="${view.deptno}" />
                                                        <input type="text" class="box100 schword" value="${view.appenm}" style="width: 50%">
                                                        <input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn" value="검색">
                                                        <span class="help">*이름/사번</span>
                                                        <!-- <input type="text" name="appeno" value='홍길동' >-->
                                                    </dd>
                                                </dl>
                                                <dl class="insert_ready">
                                                    <dt class="must-option">
                                                        <label>연락처</label>
                                                    </dt>
                                                    <dd style="width: 200px;">
                                                        <input type="text" id="apptel" name="apptel" value="${view.apptel}">
                                                    </dd>
                                                    <dt class="must-option">
                                                        <label>E-MAIL</label>
                                                    </dt>
                                                    <dd style="width: 250px;">
                                                        <input type="text" id="appmail" name="appmail" value="${view.appmail}">
                                                    </dd>
                                                </dl>

                                                <%-- <dl class="insert_ready">
                                                    <dt class="must-option">
                                                        <label>사용자</label>
                                                    </dt>
                                                    <dd class="btn-zone">
                                                        <input type="hidden" name="appueno" class="appueno"
                                                            value="${view.appueno }" />
                                                        <input type="hidden" name="appuenm" class="appuenm"
                                                            value="${view.appuenm }" />
                                                        <input type="text" class="schword" value="${view.appuenm }"
                                                            style="width: 50%">
                                                        <input type="button" style="cursor: pointer; height: 27px;"
                                                            class="search_btn schbtn" value="검색">
                                                        <span class="help">*이름/사번</span>
                                                    </dd>
                                                </dl> --%>

                                                <dl class="insert_ready">
                                                    <dt class="must-option">
                                                        <label for="" id="">신청정보</label>
                                                    </dt>
                                                    <dd>
                                                        <div style="width: 600px" class="red-f">
                                                            <span>
                                                                ○ 대여기간 :
                                                                <fmt:parseDate value="${view.strdt}" var="parseStrdt"
                                                                    pattern="yyyyMMdd" />
                                                                <fmt:parseDate value="${view.enddt}" var="parseEnddt"
                                                                    pattern="yyyyMMdd" />
                                                                <fmt:formatDate value="${parseStrdt}"
                                                                    pattern="yyyy년 MM월 dd일" />
                                                                ~
                                                                <fmt:formatDate value="${parseEnddt}"
                                                                    pattern="yyyy년 MM월 dd일" />
                                                            </span>
                                                            <c:choose>
                                                                <c:when test="${view.status eq '4' }">
                                                                    &nbsp;
                                                                    <input type="button" class="btn_small go_extend dateUpdate" value="기간 연장하기"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:if test="${view.approval eq '2' && (view.status eq '1' || view.status eq '3')}">
                                                                    &nbsp;
                                                                    <input type="button" class="btn_small go_period_modify dateUpdate" value="기간 수정하기"/>
                                                                    </c:if>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </dd>
                                                    <dd>
                                                        <div class="basic-list1">
                                                            <table id="listTable">
                                                                <caption>게시판 테이블</caption>
                                                                <colgroup>
                                                                	<c:choose>
		                                                                <c:when test="${btnStatus eq '6'}">
																			<col style="width: 14%">
																			<col style="width: 20%">
																			<col />
																			<col style="width: 28%">
																			<col style="width: 23%">
		                                                                </c:when>
		                                                                <c:otherwise>
		                                                                	<col style="width: 14%">
		                                                                    <col style="width: 22%">
		                                                                    <col style="width: 35%">
		                                                                    <col style="width: 25%">
		                                                                    <col style="width: 17%">
		                                                                </c:otherwise>
		                                                            </c:choose>
                                                                </colgroup>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col" class="like-td">장비구분</th>
                                                                        <th scope="col" class="like-td">모델명</th>
                                                                        <th scope="col" class="ref-td">배정(별칭)</th>
                                                                        <th scope="col" class="ref=td">사용자</th>
                                                                        <c:choose>
			                                                                <c:when test="${btnStatus eq '6'}">
																				<th scope="col" class="ref-td">반납</th>
			                                                                </c:when>
			                                                                <c:otherwise>
			                                                                	<th scope="col" class="ref-td">배정/취소</th>
			                                                                </c:otherwise>
			                                                            </c:choose>    
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${modelList eq null}">
                                                                        <tr><td class='list02 nodata' colspan='4'>등록된 데이터가 없습니다.</td></tr>
                                                                    </c:if>
                                                                    <c:set var="listCnt" value="0"/>
                                                                    <c:set var="takingOverChk" value="false"/>
                                                                    <c:set var="en_chk">N</c:set>
                                                                    <c:set value="false" var="gbcdValChk"></c:set>
                                                                    <c:forEach var="list" items="${modelList}" varStatus="sts">
	                                                                    <c:if test="${fn:contains(list.gbcd, '001') }">
								                                    		<c:set value="true" var="gbcdValChk"></c:set>
								                                    	</c:if>
                                                                    	<c:if test="${list.amount > 0}">
                                                                    	<%-- <c:forEach varStatus="mList" begin="0" end="${list.amount -1}" step="1"> --%>
                                                                        <tr>
                                                                            <td>
                                                                                <div>
                                                                                	${list.gbnm}
                                                                                	<%-- 행사용 노트북은 반출시 메일 전송 안함 --%>
                                                                                	<c:if test="${en_chk == 'N' && list.gbcd == '018'}">
                                                                                		<c:set var="en_chk">Y</c:set>
                                                                                		<input type="hidden" id="en_chk" name="en_chk" value="Y" />
                                                                                	</c:if>
                                                                                </div>
                                                                            </td>
                                                                            <td class="like-td">
                                                                                    <c:choose>
                                                                                        <c:when test="${view.status < 4 && view.status ne 2 }">
                                                                                            <span class="mdnm"
                                                                                                style="text-decoration: underline; color: #0000ff; cursor: pointer;"
                                                                                                data-gbcd="${list.gbcd}"
                                                                                                data-mdseq="${list.mdseq}"
                                                                                                data-amount="${list.amount}"
                                                                                                data-euseq="${list.euseq}">${list.mdnm}</span>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <span>${list.mdnm}</span>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                            </td>
                                                                            <td>
                                                                            	<div>
                                                                                    <c:forEach var="asMap" items="${assignedMap}" varStatus="vsts">
                                                                                    	<fmt:formatNumber var="strVsts" value="${vsts.index}" />
                                                                                        <c:if test="${vsts.index eq sts.index}">
                                                                                        	<c:if test="${list.eqno eq assignedMap[strVsts][0].eqno}">
																								${assignedMap[strVsts][0].eqnm} ${assignedMap[strVsts][0].eqalias}
                                                                                        	</c:if>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                            	<c:choose>
                                                                            		<c:when test="${view.status le '4' && view.status ne '2'}">
                                                                            			<c:choose>
                                                                            				<c:when test="${list.euseq != null}">
                                                                            				<c:choose>
                                                                            					<c:when test="${list.mailapproval == '0'}">
                                                                            						<span style="cursor: pointer;" onclick="javascript:cancelChgEu('${list.euseq}','${list.uhseq}')" >${list.ingaenm} > ${list.insunm} <img src="/resource/images/close-window-16.png"/></span>
                                                                            						<div class="btn-zone">
                                                                            							<input type="button" style="cursor: pointer; height: 27px;" class="search_btn" onclick="goSign(this)" 
                                                                            								data-appno="${list.appno }" data-euseq="${list.euseq }" 
                                                                            								data-uhseq="${list.uhseq }" data-appueno="${list.insuno }" 
                                                                            								data-appuenm="${list.insunm }" data-deptno="${list.insuDeptNo }" 
                                                                            								data-deptnm="${list.insuDeptNm }" value="즉시 적용">
                                                                            						</div>
                                                                            					</c:when>
                                                                            					<c:otherwise>
                                                                            						<div class="btn-zone">
	                                                                            					<input type="hidden" class="euseq_arr" name="euseq_arr" value="${list.euseq}"/>
	                                                                            					<input type="hidden" class="appueno_arr" name="appueno_arr" data-mdseq="${list.mdseq}" data-eqno="${list.eqno}" data-uhseq="${list.uhseq}" value="${list.appueno}"/>
	                                                                            					<input type="hidden" class="appuenm_arr" name="appuenm_arr" value="${list.appuenm}"/>
	                                                                            					<input type="hidden" class="deptno_arr" name="deptno_arr" value="${list.deptno }"/>
	                                                                            					<input type="hidden" class="dept_Nm1dept_arr" name="dept_Nm1dept_arr" value="${list.DEPT1NM }"/>
											                                                        <input type="text" class="box100 schword" value="${list.appuenm}" style="width: 60px;">
											                                                        <input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn" value="검색">
											                                                        </div>
                                                                            					</c:otherwise>
                                                                            				</c:choose>
                                                                            				</c:when>
                                                                            				<c:otherwise>
                                                                            					<div class="btn-zone">
										                                                        <input type="text" class="box100 schword" value="${view.appenm}" style="width: 60px;">
										                                                        <input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn" value="검색">
										                                                        </div>
                                                                            				</c:otherwise>
                                                                            			</c:choose>
                                                                            		</c:when>
                                                                            		<c:otherwise>
                                                                            			<c:choose>
                                                                            				<c:when test="${list.euseq != null}">
                                                                            					${list.appuenm}
                                                                            				</c:when>
                                                                            				<c:otherwise>
                                                                            					${view.appenm}
                                                                            				</c:otherwise>
                                                                            			</c:choose>
                                                                            		</c:otherwise>
                                                                            	</c:choose>
                                                                            </td>
                                                                            <td>
                                                                                <c:if test="${view.approval eq '2'}">
                                                                                	<c:choose>
                                                                                		<c:when test="${list.mailapproval == '0'}">
                                                                                			인수인계<br>승인대기
                                                                                		</c:when>
                                                                                		<c:otherwise> 
		                                                                                	<c:if test="${view.status eq '4'}">
		                                                                                		<c:if test="${list.banpflag == '1'}">
			                                                                                		<div class="btn-zone" style="float: none;">
			                                                                                			<input type="hidden" class="partbanp" />
			                                                                                			<input type="hidden" class="partbanp_appno" value="${list.appno}" />
			                                                                                			<input type="hidden" class="partbanp_mdseq" value="${list.mdseq}" />
			                                                                                			<input type="hidden" class="partbanp_eqno" value="${list.eqno}" />
			                                                                                			<input type="text" class="box100 schword" value="" style="width: 60px;">
			                                                                                			<input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn" value="반납">
			                                                                                		</div>
			                                                                                	</c:if>
			                                                                                	<c:if test="${list.banpflag == '6'}">
			                                                                                		<c:choose>
                                                                                						<c:when test="${list.banpdt ne null && list.banpdt ne ''}">
			                                                                                				${list.banpdt}<br />${list.banpnm }
			                                                                                			</c:when>
			                                                                                			<c:otherwise>
			                                                                                				완료
			                                                                                			</c:otherwise>
			                                                                                		</c:choose>
			                                                                                	</c:if>
		                                                                                    </c:if>
		                                                                                    <c:if test="${view.status eq '6'}">
		                                                                                    	<c:choose>
                                                                               						<c:when test="${list.banpdt ne null && list.banpdt ne ''}">
		                                                                                				${list.banpdt}<br />${list.banpnm }
		                                                                                			</c:when>
		                                                                                			<c:otherwise>
		                                                                                				완료
		                                                                                			</c:otherwise>
		                                                                                		</c:choose>
		                                                                                    </c:if>
		                                                                                    <c:if test="${view.status eq '3'}">
		                                                                                    	<img alt=""
		                                                                                            class="cursor_pointer eq_alloc"
		                                                                                            src="/resource/images/btn/assign.png"
		                                                                                            id="alloc_${list.mdseq}_${list.euseq}">
		                                                                                        <img alt=""
		                                                                                            class="cursor_pointer modelCancel"
		                                                                                            id='mdseq_${list.mdseq}_${list.euseq}'
		                                                                                            src="/resource/images/btn/cancel1.png">
		                                                                                    </c:if>
                                                                                		</c:otherwise>
                                                                                	</c:choose>
                                                                                </c:if>
                                                                            </td>
                                                                        </tr>
                                                                        <c:if test="${list.mailapproval == '0' || view.mailapproval == '0'}">
                                                                        <c:set var="takingOverChk" value="true"/>
                                                                        </c:if>
                                                                        <c:set var="listCnt" value="${listCnt + 1}"/>
                                                                        <%-- </c:forEach> --%>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </dd>
                                                </dl>
                                                <c:if test="${view.rent_NB_Gubun ne null && view.rent_NB_Gubun ne ''}">
	                                                <dl class="insert_ready">
					                                    <dt class="must-option"><label>노트북 사용용도</label></dt>
					                                    <dd>
															<input type="radio" id="ex_chk_1" name="rent_NB_Gubun" value="<c:out value="1" />" ${view.rent_NB_Gubun == '1' ? 'checked' : '' }> 
															<label for="ex_chk_1"><c:out value="업무망(사내)" /></label>
															<input type="radio" id="ex_chk_2" name="rent_NB_Gubun" value="<c:out value="2" />" ${view.rent_NB_Gubun == '2' ? 'checked' : '' }> 
															<label for="ex_chk_2"><c:out value="인터넷망(사내)" /></label>
															<input type="radio" id="ex_chk_3" name="rent_NB_Gubun" value="<c:out value="3" />" ${view.rent_NB_Gubun == '3' ? 'checked' : '' }> 
															<label for="ex_chk_3"><c:out value="FA망[설비운영](사내)" /></label>
															<input type="radio" id="ex_chk_4" name="rent_NB_Gubun" value="<c:out value="4" />" ${view.rent_NB_Gubun == '4' ? 'checked' : '' }> 
															<label for="ex_chk_4"><c:out value="인터넷(외부)" /></label> 
					                                    </dd>
					                                </dl>
                                                </c:if>
                                                <dl class="insert_ready">
                                                    <dt class="must-option">
                                                        <label>사용용도</label>
                                                    </dt>
                                                    <dd>
                                                        <input style="width: 618px;" type="text" name="useobj"
                                                            value="${view.useobj}">
                                                    </dd>
                                                </dl>
                                                
                                                <dl class="insert_ready">
                                                    <dt class="must-option">
                                                        <label>상태</label>
                                                    </dt>
                                                    <dd class="btn-zone" style="width: 200px;">
                                                        <c:choose>
                                                            <c:when test="${view.status eq '2'}">
                                                                <span style='color: #FF0000;'>
                                                                    ${appstArr[view.status]} </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${appstArr[view.status]}
                                                        </c:otherwise>
                                                        </c:choose>
                                                    </dd>
                                                    <dt class="must-option">
                                                        <label>승인</label>
                                                    </dt>
                                                    <dd style="width: 250px;">
                                                        <div>${approvalArr[view.approval]}</div>
                                                    </dd>
                                                </dl>

                                                <c:if test="${view.status ge '3' && view.approval eq '2'}">
                                                    <dl class="insert_ready">
                                                        <dt class="must-option">
                                                            <label>인수자</label>
                                                        </dt>
                                                        <c:choose>
                                                        	<c:when test="${view.mailapproval == '0'}">
                                                        	<dd class="btn-zone" style="width: 200px;">
                                           						<span style="cursor: pointer;" onclick="javascript:cancelChgEm('${view.uhseq}')" >${view.ingaenm} > ${view.insunm} <img src="/resource/images/close-window-16.png"/></span>
                                           					</dd>
                                           					</c:when>
                                           					<c:otherwise>
                                           					<dd class="btn-zone" style="width: 200px;">
	                                                        	<input type="hidden" class="insuno" name="insuno" value="${view.appinsuno}" />
	                                                        	<input type="hidden" id="insunm" name="insunm" value="${view.appinsunm }" />
	                                                            <input type="text" id="insunmSch" class="schword" value="${view.appinsunm}" style="width: 40%">
	                                                            <input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn" value="검색">
	                                                            <c:if test="${view.RENT_IN_SIGN_IMG ne null && view.RENT_IN_SIGN_IMG ne ''}">
	                                                            	<input type="image" id="insu_sign_img" style="width:55px;height:27px;vertical-align: middle;margin:0;cursor:default;" src="<%= Constants.ASP_DOMAIN %>rent_sign/${view.RENT_IN_SIGN_IMG}" onclick="return false;">
	                                                            </c:if>
	                                                            <c:if test="${view.RENT_IN_SIGN_IMG eq null || view.RENT_IN_SIGN_IMG eq ''}">
	                                                            	<input type="image" id="insu_sign_img" style="width:55px;height:27px;vertical-align: middle;margin:0;cursor:default;" onclick="return false;">
	                                                            </c:if>
	                                                            <input type="hidden" id="insusigndata" name="insusigndata">
                                                        	</dd>
                                           					</c:otherwise>
                                                        </c:choose>
                                                        <dt class="must-option">
                                                            <label>인수일</label>
                                                        </dt>
                                                        <dd style="width: 250px;">
                                                            <div>
                                                            	<c:set var="fn_insudt" value="value=${fn:substring(view.insudt,0,4)}-${fn:substring(view.insudt,4,6)}-${fn:substring(view.insudt,6,8)}"></c:set>
                                                                <input type="text" name="insudt" ${view.insudt ne null ? fn_insudt : ""} readonly="readonly" style="width: 150px;" />
                                                                <c:if test="${view.status eq '3' && view.approval eq '2'}">
                                                                	<input type="button" class="confirmBtn" onclick="javascript:openUserRentalScreen('signature', '${view.status}');" value="서명 팝업" style="height:25px;" />
                                                                </c:if>
                                                            </div>
                                                        </dd>
                                                    </dl>
                                                </c:if>
                                                <c:if test="${view.status ge '4' && view.approval eq '2'}">
                                                    <dl class="insert_ready">
                                                        <dt class="must-option">
                                                            <label>반납자</label>
                                                        </dt>
                                                        <dd class="btn-zone" style="width: 200px;">
                                                        	<input type="hidden" class="banpno" name="banpno" value="${fn:trim(view.banpno) eq '' ? view.appinsuno : view.banpno}" />
                                                        	<input type="hidden" id="banpnm" name="banpnm" value="${fn:trim(view.banpnm) eq '' ? view.appinsunm : view.banpnm}" />
                                                            <input type="text" id="banpnmSch" class="schword" value="${fn:trim(view.banpnm) eq '' ? view.appinsunm : view.banpnm}" style="width: 40%">
                                                            <input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn" value="검색">
                                                            <c:if test="${view.RENT_OUT_SIGN_IMG ne null && view.RENT_OUT_SIGN_IMG ne ''}">
                                                            	<input type="image" id="banp_sign_img" style="width:55px;height:27px;vertical-align: middle;margin:0;cursor:default;" src="<%= Constants.ASP_DOMAIN %>rent_sign/${view.RENT_OUT_SIGN_IMG}" onclick="return false;">
                                                            </c:if>
                                                            <c:if test="${view.RENT_OUT_SIGN_IMG eq null || view.RENT_OUT_SIGN_IMG eq ''}">
                                                            	<input type="image" id="banp_sign_img" style="width:55px;height:27px;vertical-align: middle;margin:0;cursor:default;" onclick="return false;">
                                                            </c:if>
                                                            <input type="hidden" id="banpsigndata" name="banpsigndata">
                                                        </dd>
                                                        <dt class="must-option">
                                                            <label>반납일</label>
                                                        </dt>
                                                        <dd style="width: 250px;">
                                                            <div>
                                                            	<c:set var="fn_banpdt" value="value=${fn:substring(view.banpdt,0,4)}-${fn:substring(view.banpdt,4,6)}-${fn:substring(view.banpdt,6,8)}&nbsp;${fn:substring(view.banpdt,8,10)}:${fn:substring(view.banpdt,10,12)}"></c:set>
                                                                <%-- <fmt:parseDate value="${view.banpdt}" var="parseBanpdt" pattern="yyyyMMddHHmm" />
                                                                <fmt:formatDate value="${parseBanpdt}" var="viewBanpdt" pattern="yyyy년 MM월 dd일" /> --%>
                                                                <input type="text" id="banpdt" name="banpdt" ${view.banpdt ne null ? fn_banpdt : ""} readonly="readonly" style="width: 150px;" />
                                                                <c:if test="${view.status eq '4' && view.approval eq '2'}">
                                                                	<input type="button" class="confirmBtn" onclick="javascript:openUserRentalScreen('signature', '${view.status}');" value="서명 팝업" style="height:25px;"/>
                                                                </c:if>
                                                            </div>
                                                        </dd>
                                                    </dl>
                                                    <dl class="insert_ready">
                                                        <dt class="must-option">
                                                            <label>반납</label>
                                                        </dt>
                                                        <dd>
                                                            <c:forEach var="banp" items="${banpArr}" varStatus="cnt">
                                                                <c:choose>
                                                                    <c:when test="${view.banpst ne null}">
                                                                        <label>
                                                                            <input type="radio" name="banpst"
                                                                                value="${banp.key}" ${banp.key eq view.banpst? "checked" : ""}>
                                                                            ${banp.value}
                                                                        </label>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <label>
                                                                            <input type="radio" name="banpst"
                                                                                value="${banp.key}" ${cnt.count eq 1? "checked" : ""}>
                                                                            ${banp.value}
                                                                        </label>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                        </dd>
                                                    </dl>
                                                </c:if>

                                                <dl class="insert_ready">
                                                    <dt class="must-option">
                                                        <label for="SM_TEXT" id="SM_TEXT_label">비고(비공개)</label>
                                                    </dt>
                                                    <dd>
                                                        <textarea class="textarea-style" rows="10" cols="88" id="bigo" name="bigo" style="width: 618px;">${view.bigo}</textarea>
                                                    </dd>
                                                </dl>

                                                <c:if test="${view.status ge '3' && view.approval eq '2'}">
                                                    <dl class="insert_ready">
                                                        <dt class="must-option">
                                                            <label>확인증첨부</label>
                                                        </dt>
                                                        <dd>
                                                            <div class="file_list_area"
                                                                style="width: 618px; margin-bottom: 5px;">
                                                                <c:forEach var="file" items="${fileList }">
                                                                    <span
                                                                        style="margin-right: 10px;">
                                                                        <a href="/download2.do?path=${file.pathNm }&fileName=${file.fileNm}" style="text-decoration: underline;">${file.fileNm}</a>
                                                                        <img
                                                                            src="/resource/images/btn/btn_del.png"
                                                                            id="ref_${file.fileNo }"
                                                                            class="vam hand file_del" style="cursor: pointer;" />
                                                                    </span>
                                                                </c:forEach>
                                                            </div>
                                                            <input type="file" name="C_attFile" onchange="javascript:chkFile(this);" title="확인증 첨부" />
                                                        </dd>
                                                    </dl>
                                                </c:if>
                                                <c:if test="${sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 && gbcdValChk == 'true'}">
	                                                <dl class="insert_ready">
	                                                	<dt class="must-option">
															<label>보안서약서</label>
														</dt>
														<dd class="changeNode">
															<c:choose>
																<c:when test="${rentSecurityFile.RENT_SECURITY_orgFileName != null}">
																	<span style="margin-right: 10px;">
																		<a href="/securityDownload.do?path=${rentSecurityFile.RENT_SECURITY_phycalPath }&fileName=${rentSecurityFile.RENT_SECURITY_orgFileName}" style="text-decoration: underline;">${rentSecurityFile.RENT_SECURITY_orgFileName }</a>
																		<img src="/resource/images/btn/btn_del.png" style="cursor: pointer;" onclick="godel('${rentSecurityFile.RENT_SECURITY_SEQ }', this, '${rentSecurityFile.appno }')" />
																	</span>
																</c:when>
																<c:otherwise>
																	<input type="file" name="file_attach" id="file_attach" value="" >
																</c:otherwise>
															</c:choose>
														</dd>
	                                                </dl>
                                                </c:if>
                                            </div>

                                            <div class="btn-zone">

                                                <table>
                                                    <tr>
                                                        <td height="30" valign="bottom" style="border: 0; text-align: left;">
                                                            <input type="button" name="srchDescription" class="search_btn"
                                                                onclick="javascript:goToRecList();" value="목록">
                                                            
                                                                <span class="btn_green">
                                                                    <input type="button" class="confirmBtn" onclick="window.open('confirmDoc.do?appno=${appno}', 'confirm', 'width=1000px, height=900px, scrollbars=yes');" value="확인증출력" />
                                                                    <!--input type="button" class="confirmBtn" onclick="javascript:dualMonitor_user_popup_set('${view.status}');" value="서명 팝업" /-->
                                                                    <c:if test="${(view.status eq '3' || view.status eq '4') && view.approval eq '2'}">
                                                                    	<input type="button" class="confirmBtn" onclick="javascript:openUserRentalScreen('signature', '${view.status}');" value="서명 팝업" />
                                                            		</c:if>
                                                                </span>
                                                        </td>

                                                        <td align="center" valign="bottom" style="border: 0; text-align: center;">
                                                            <c:choose>
                                                                <c:when test="${btnStatus eq '2'}">
                                                                    <span class="approval" aVal='2'>
                                                                        <input type="button" class="centerBtn" value="승인" />
                                                                    </span>
                                                                    <span class="approval" aVal='3'>
                                                                        <input type="button" class="centerBtn" value="반려" />
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${btnStatus eq '4'}">
                                                                    <span class='status' aVal='4'>
                                                                        <input type="button" class="centerBtn" value="반출" />
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${btnStatus eq 'N'}">
                                                                    <span class='status' aVal='N'>
                                                                        <input type="button" class="centerBtn" value="반출" />
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${btnStatus eq '6'}">
                                                                    <span class="status" aVal='6'>
                                                                        <input type="button" class="centerBtn" aVal='6' value="반납" />
                                                                    </span>
                                                                </c:when>
                                                            </c:choose>
                                                        </td>

                                                        <td align="right" valign="bottom" style="border: 0; text-align: right;">
                                                            <input type="submit" class="hand updateBtn" value="수정" />
                                                            <c:if test="${cancelView}">
                                                                <input type="button" class="btn_blue app_cancel cancelBtn" value="사용자취소" />
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </table>

                                            </div>
                                        </fieldset>

                                    </div>
                                </div>
                            </div>
                        </form>
                </div>

            </div>
            <div>
            	<span>사용자 화면 상태 : </span><span id="userscreen"></span><img id="sign_img" style="width:177px;height:100px;vertical-align: middle;margin:0;margin-left: 15px;">
            </div>
            <!--content end-->
        </div>
    </div>
    <div id="loading" style="display:none; position:absolute; top:400px; text-align:center; width:100%; z-index:9999"><img src="/resource/images/pre-loader.gif" /></div>

    <!-- 기간연장 레이어 -->
    <div id="apDiv" style="display:none;">
        <br />
         <input type="hidden" autofocus="autofocus" />
        <fmt:parseDate value="${view.strdt}" var="parseStrdt" pattern="yyyyMMdd" />
        <fmt:formatDate value="${parseStrdt}" pattern="yyyy년 MM월 dd일" />~
        <input type="text" class="box" size="10" id="extend_enddt" value="${view.enddt}" readonly="readonly" tabindex="-1"  />
        <div style="width:100%; margin-top:10px; margin-bottom:10px; border-bottom:1px solid #D2E9FF;"></div>
        <div id="extend_msg"></div>
    </div>

    <!-- 기간수정 레이어 -->
    <div id="apDiv_modify" style="display:none;">
        <br />
        <input type="text" class="box" size="10" id="modify_strdt" value="${view.strdt}" readonly="readonly" tabindex="-1" /> ~
        <input type="text" class="box" size="10" id="modify_enddt" value="${view.enddt}" readonly="readonly" tabindex="-1" />
        <div style="width:100%; margin-top:10px; margin-bottom:10px; border-bottom:1px solid #D2E9FF;"></div>
        <div id="modify_msg"></div>
    </div>

    <!-- 모델수량 변경 레이어 -->
    <div id="mArea" style="display:none;">
        <table width="100%" class="table01">
            <colgroup>
                <col width="120px" />
                <col width="*" />
            </colgroup>

            <tr>
                <td class="td01" style="height:30px;">모델명</td>
                <td class="td02 pop_model_area"></td>
            </tr>

            <tr>
                <td class="td01" style="height:30px;">대여가능</td>
                <td class="td02 pop_amount_area"></td>
            </tr>
        </table>
    </div>
</body>

<script type="text/javascript">

    var code1 = $('#selectCode').val();
    var modal_eq = '';
    
    $(document).ready(function() {
        load_fnc('4', '0', '0'); //menu script
        
        var today = new Date();
        var getYear, getMonth, getDate, getHour, banapDate;
        
        getYear = today.getFullYear();
        getMonth = parseInt(today.getMonth() + 1);
        getMonth = getMonth < 10 ? '0'+ getMonth : getMonth;
        
        getDate = today.getDate();
        getDate = getDate < 10 ? '0'+ getDate : getDate;
        
        getHour = parseInt(today.getHours() +1);
        banapDate = getYear+'-'+getMonth+'-'+getDate+' '+getHour+':00';
        
        if($('#banpdt').val() == ''){
        	$('#banpdt').val(banapDate);
        }
        
        $("#strdt").datepicker();
        $("#enddt").datepicker();
        
        $("#modify_strdt, #modify_enddt").datepicker({
            showOn : 'both',
            buttonImage : '/resource/images/calendar.gif',
            buttonImageOnly : true,
            showButtonPanel : true,
            changeMonth : true,
            changeYear : true,
            closeText : '닫기',
            currentText : '오늘날짜',
            dateFormat : 'yymmdd',
            dayNamesMin : ['일', '월', '화', '수', '목', '금', '토']
        });
        
        $("#modify_strdt, #modify_enddt, #extend_enddt").on("focus", function(){
        	this.blur();
        	$('.hasDatepicker').off("focus");
        	$('.hasDatepicker').on("click", function(event){
        		$(this).datepicker( "show" );
        	});
        });
        
        $("#extend_enddt").datepicker({
            showOn : 'both',
            buttonImage : '/resource/images/calendar.gif',
            buttonImageOnly : true,
            showButtonPanel : true,
            changeMonth : true,
            changeYear : true,
            closeText : '닫기',
            currentText : '오늘날짜',
            dateFormat : 'yymmdd',
            dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
            onSelect : function() {
            	
                var appno = "${appno}";
                var strdt = "${view.strdt}";
                var enddt = "${view.enddt}";

                if(!appno)
                {
                    alert('잘못된 접근입니다.');
                    return false;
                }
                else if( $(this).val() <= strdt )
                {
                    alert('연장할 날짜를 다시 선택해주세요.');
                    $('#extend_enddt').val(enddt);
                    return false;
                }

                $.ajax({
                    url : '/admin/extendPeriodMsg.do',
                    type : 'post',
                    dataType : 'json',
                    data : { 'appno' : appno, 'extendEnddt' : $(this).val() },
                    success : function(data) {

                        if(data.appnum.length)
                        {
                            var html = '';
                            var eq = [];

                            html += "선택한 기간으로 연장할 경우";
                            $.each(data.appnum, function(i) {
                                html += " <p>- 접수번호 [<span style='color:#FF0000'>" + this.appnum + "</span>] 에 배정된 설비 [<span style='color:#FF0000'>";
                                /* eq = [];
                                $.each(this[0].eqnm, function(j) {
                                    eq[j] = this[0].eqnm;
                                });

                                html += eq.join(', ') + "</span>]</p>"; */
                                html += this.eqnm + "</span>]</p>";
                            });

                            html += " 가 배정취소 됩니다.";
                            $('#extend_msg').empty().append(html);
                        }
                        else
                        {
                            $('#extend_msg').empty();
                        }

                        isSeletedExtend = true;
                    }
                });
            }
        });
    });
    
    $(window).load(function() {

        $('#mArea').dialog({
            autoOpen : false,
            resizable : true,
            draggable : true,
            /* position : ['center', 'center'], */
            width : 500,
            height: 300,
            open : function() {
                $("span.ui-dialog-title").html("모델 변경");
                var appno = "${appno}";
                var strdt = "${view.strdt}";
                var enddt = "${view.enddt}";

                var gbcd = $('#mArea').data('gbcd');
                var mdseq = $('#mArea').data('mdseq');
                var amount = $('#mArea').data('amount');

                var sub_model = $('.mdnm').map(function() {
                        return $(this).data('mdseq').toString();
                }).get();

                if(!gbcd || !mdseq)
                {
                    alert('error');
                    $(this).dialog('close');
                    return false;
                }

                $.ajax({
                    url : '/rentLoad.do',
                    type : 'post',
                    data : {'mode':'load_model', 'gbcd':gbcd},
                    success : function(data) {

                        var html = '';
                        if(data != 'error')
                        {
                            var option = $.parseJSON(data);
                            if(option.length)
                            {
                                var selected = '';
                                html = "<select class='pop_sel_model' style='width:180px;'><option value=''>...</option>";
                                $.each(option, function() {

                                    if(this.mdseq == mdseq)
                                        selected = " selected='selected'";
                                    else
                                        selected = '';

                                    //중복 모델 continue..
                                    if( $.inArray(this.mdseq, sub_model) != -1 && this.mdseq != mdseq )
                                    {
                                        return;
                                    }

                                    html += "<option value='"+this.mdseq+"' "+selected+">"+this.mdnm+"</option>";
                                });
                                html += "</select>";
                            }
                        }
                        
                        $.when($('.pop_model_area').empty().append(html)).then(function() {
                     		load_amount(mdseq, strdt, enddt);                       			
                        });

                        $('.pop_sel_model').jqTransSelect();
                        eventInit();
                    }
                });

            },
            buttons : {
                '저장' : function() {
                    if( !$('.pop_sel_model').val() || !$('.pop_sel_amount').val() )
                    {
                        alert('대여가능한 장비를 선택하세요.');
                        return false;
                    }

                    if(confirm('선택하신 모델로 변경하시면 기존모델로 \n\n배정되어있는 설비가 취소됩니다. \n\n변경 하시겠습니까?'))
                    {
                        $.ajax({
                            url : '/admin/changeAssignedEquip.do',
                            type : 'post',
                            dataType : 'text',
                            data : {
                                    'appno' : "${appno}",
                                    'currMdseq' : $('#mArea').data('mdseq'), 'currAmount' : $('#mArea').data('amount'), 'euseq' : $('#mArea').data('euseq'),
                                    'strdt' : "${view.strdt}", 'enddt' : "${view.enddt}",
                                    'mdseq' : $('.pop_sel_model').val(), 'amount' : $('.pop_sel_amount').val()
                                    },
                            success : function(data) {
                                if(data == 'success')
                                {
                                    window.location.reload();
                                }
                                else
                                {
                                    alert(data);
                                    return false;
                                }
                            }
                        });
                    }
                },
                '닫기' : function() {
                    $(this).dialog('close');
                }
            },
            show : {
                effect : 'blind',
                duration : 200
            },
            hide : {
                effect : 'explode',
                duration : 200
            },
            modal : true
        });

        //모델 변경
        $('.mdnm').click(function() {
            $('#mArea').data( {'gbcd':$(this).data('gbcd'), 'mdseq':$(this).data('mdseq'), 'amount':$(this).data('amount'), 'euseq':$(this).data('euseq')} );
            $('#mArea').dialog('open');
        });


        $('#mArea').on('change', $('.pop_sel_model').parent().children('div a.jqTransformSelectOpen'), function() {
            var strdt = "${view.strdt}";
            var enddt = "${view.enddt}";

            load_amount($(this).val(), strdt, enddt);
        });


        $('.file_del').click(function() {

            var split_id = $(this).attr('id').split('_');
            
            if(!split_id[1])
            {
                alert('error');
                return false;
            }

            if(confirm('파일을 삭제하시겠습니까?')) {
 
                $.ajax({
                    url : '/admin/delFile.do',
                    type : 'post',
                    data : { 'mode':'file_delete', 'fileNo':split_id[1], 'type':'C' },
                    success : function(data) {
                        if(data == 'success')
                        {
                            window.location.reload();
                        }
                    }
                });
            }
        });

        $('#apDiv').dialog({
            autoOpen : false,
            resizable : true,
            draggable : true,
            /* position : ['center', 'center'], */
            width : 500,
            height: 300,
            focus: function(event, ui) {
            	event.preventDefault();
                $('input:visible:first-child' , $(this)).blur();
            },
            open : function() {
                $("span.ui-dialog-title").html("<span style='color:#000;'>대여기간 연장하기</span>");
                isSeletedExtend = false;
                $('#extend_enddt').val("${view.enddt}");
                $('#extend_msg').empty();
            },
            buttons : {
                '저장' : function() {

                    var appno = "${appno}";
                    var strdt = "${view.strdt}";
                    var enddt = "${view.enddt}";
                    var extend_enddt = $('#extend_enddt').val();

                    if(!appno || !extend_enddt)
                    {
                        alert('error');
                        isSeletedExtend = false;
                        return false;
                    }
                    else if( extend_enddt <= strdt )
                    {
                        alert('연장할 날짜를 다시 선택해주세요.');
                        $('#extend_enddt').val(enddt);
                        isSeletedExtend = false;
                        return false;
                    }
                    else if(!isSeletedExtend)
                    {
                        alert('대여기간을 다시 선택하세요.');
                        return false;
                    }

                    if(confirm('대여기간을 변경 하시겠습니까?'))
                    {
                        $.ajax({
                            url : '/admin/extendPeriodUpdate.do',
                            type : 'post',
                            dataType : 'text',
                            data : {'appno' : appno, 'extendEnddt' : extend_enddt },
                            success : function(data) {
                                if(data == 'success')
                                {
                                    alert('대여기간이 변경 되었습니다.');
                                    window.location.reload();
                                }
                                else
                                {
                                    alert('대여기간 변경에 실패하였습니다.');
                                }
                            }
                        });
                    }

                },
                '닫기' : function() {
                    $(this).dialog('close');
                }
            },
            show : {
                effect : 'blind',
                duration : 200
            },
            hide : {
                effect : 'explode',
                duration : 200
            },
            modal : true
        });


        $('.go_extend').click(function() {

            //전역변수 저장
            //var idx = $('.equip').index($(this));
            //modal_appno = $(this).attr('data-appnum');

            $('#apDiv').dialog('open');

        });



        $('#apDiv_modify').dialog({
            autoOpen : false,
            resizable : true,
            draggable : true,
            /* position : ['center', 'center'], */
            width : 500,
            height: 300,
            open : function() {
                $("span.ui-dialog-title").html("<span style='color:#000;'>대여기간 수정하기</span>");
                $('#modify_strdt').val("${view.strdt}");
                $('#modify_enddt').val("${view.enddt}");
                $('#modify_msg').empty();
            },
            buttons : {
                '저장' : function() {

                    var appno = "${appno}";
                    var strdt = "${view.strdt}";
                    var enddt = "${view.enddt}";
                    var modify_strdt = $('#modify_strdt').val();
                    var modify_enddt = $('#modify_enddt').val();
                    var confirm_msg = '';

                    if(!modify_strdt || !modify_enddt)
                    {
                        alert('기간을 빠짐없이 입력하세요.');
                        return false;
                    }
                    else if(strdt == modify_strdt && enddt == modify_enddt)
                    {
                        alert('기간을 변경후 저장 가능합니다.');
                        return false;
                    }
                    else if( modify_enddt < modify_strdt )
                    {
                        alert('기간을 다시 선택해주세요.');
                        return false;
                    }

                    if(modify_enddt <= enddt && strdt <= modify_strdt)
                    {
                        confirm_msg = '대여기간을 변경하시겠습니까?';
                    }
                    else
                    {
                        confirm_msg = '대여기간을 변경하시면\n\n배정된 설비가 모두 취소됩니다.\n\n변경하시겠습니까?';
                    }

                    if(confirm(confirm_msg))
                    {

                        $.ajax({
                            url : '/admin/modifyPeriodUpdate.do',
                            type : 'post',
                            dataType : 'text',
                            data : { 'appno' : appno, 'modifyStrdt' : modify_strdt, 'modifyEnddt' : modify_enddt },
                            success : function(data) {
                                if(data == 'success')
                                {
                                    window.location.reload();
                                }
                                else if(data == 'amount error')
                                {
                                    alert('변경하신 기간에\n\n대여가능한 설비가 부족하거나 없습니다.');
                                    return false;
                                }
                                else
                                {
                                    alert(data);
                                    return false;
                                }
                            }
                        });

                    }
                },
                '닫기' : function() {
                    $(this).dialog('close');
                }
            },
            show : {
                effect : 'blind',
                duration : 200
            },
            hide : {
                effect : 'explode',
                duration : 200
            },
            modal : true
        });


        //기간수정하기
        $('.go_period_modify').click(function() {
            $('#apDiv_modify').dialog('open');
        });



        //상태, 승인값 변경
        $('.status, .approval').click(function(e) {
        	
            e.preventDefault();

            var mode,
                msg = '';
            var appno = "${appno}";
            var aval = $(this).attr('aVal');
            var url = "";

            var dt = { 'appno' : appno, 'aval' : aval };

            if(!appno || !aval)
            {
                alert('잘못된 접근입니다');
                return false;
            }


            if($(this).hasClass('status')) //접수완료, 배정완료, 반출, 반납
            {

            	//사인 submit 문제 있어서 하드코딩. 삭제하지 마시오~
                //url = "http://media.hq:8080/admin/appStatusChangeStatus.do";
                url = "/admin/appStatusChangeStatus.do";
                //console.log(dt);
                if(aval == 'N')
                {
                    alert('배정이 완료되지 않았습니다.');
                    return false;
                }
                else if(aval == '3') //접수
                {
                    msg = '접수완료 하시겠습니까?';
                }
                else if(aval == '4') //반출
                {
                    if( !$.trim($("input[name='insunm']").val()) )
                    {
                        alert('인수자를 입력하세요.');
                        $("input[name='insunm']").focus();
                        return false;
                    }
                    else if( !$.trim($("input[name='insudt']").val()) )
                    {
                        alert('인수일을 입력하세요.');
                        $("input[name='insudt']").focus();
                        return false;
                    }

                    dt.insunm = $.trim($("input[name='insunm']").val());
                    dt.insudt = $.trim($("input[name='insudt']").val());
                    dt.insuno = $.trim($("input[name='insuno']").val());
                    dt.insusigndata = $("#insusigndata").val();
                    
                    if($('#en_chk').val() != undefined){
                    	dt.en_chk = $('#en_chk').val();
                    }
                    
                    msg = '반출 하시겠습니까?';
                }
                else if(aval == '6') //반납
                {
                    if( !$.trim($("input[name='banpnm']").val()) )
                    {
                        alert('반납자를 입력하세요.');
                        $("input[name='banpnm']").focus();
                        return false;
                    }
                    else if( !$.trim($("input[name='banpdt']").val()) )
                    {
                        alert('반납일을 입력하세요.');
                        $("input[name='banpdt']").focus();
                        return false;
                    }
                    else if( !$("input[name='banpst']:checked").val() )
                    {
                        alert('반납을 선택하세요.');
                        $("input[name='banpst']").focus();
                        return false;
                    }

                    dt.banpno = $.trim($("input[name='banpno']").val());
                    dt.banpnm = $.trim($("input[name='banpnm']").val());
                    dt.banpdt = $.trim($("input[name='banpdt']").val());
                    dt.banpst = $("input[name='banpst']:checked").val();
                    dt.banpsigndata = $("#banpsigndata").val()
                    
                    var takingOverChk = ${takingOverChk};
                    
                    if(takingOverChk){
                    	msg = '지금 반납을 처리하시면 진행중인 인수인계는 강제종료 됩니다. \n반출 장비를 이상없이 받으셨는지 확인이 필요합니다. \n그래도 반납완료 진행을 하시겠습니까?';
                    }else{
                    	msg = '반납완료 하시겠습니까?';	
                    }
                }
            }

            else if($(this).hasClass('approval')) //승인, 반려
            {
            	//사인 submit 문제 있어서 하드코딩. 삭제하지 마시오~
                //url = "http://media.hq:8080/admin/appStatusChangeApproval.do";
                url = "/admin/appStatusChangeApproval.do";
                if(aval == '2')
                {
                    msg = '승인 하시겠습니까?';
                }
                else if(aval == '3')
                {
                    msg = '반려 하시겠습니까?';
                }
            }

            else
            {
                alert('error');
                return false;
            }

            if(confirm(msg))
            {
            	if(aval == '4') {
            		//사용자 팝업 상태 완료 화면으로 전환
            		openUserRentalScreen('finish');
            	} else if(aval == '6') {
            		//사용자 팝업 상태 완료 화면으로 전환
            		openUserRentalScreen('finish');
            	}
            	
                $.ajax({
                    url : url,
                    type : 'post',
                    data : dt,
                    success : function(data) {
                        if(data == 'success')
                        {
                            window.location.reload();
                        }
                        else
                        {
                            alert('업데이트에 실패하였습니다.');
                            return false;
                        }
                    }
                });
            }

        });



        $("input[name='insudt']").datepicker({
            lang:'ch',
            timepicker:false,
            format:'Y-m-d'
        });


        $("input[name=banpdt]").datetimepicker({
            format:'Y-m-d H:i',
            defaultTime:'17:00',
            timepickerScrollbar:false
        });
        
        //인수일/반납일 오늘 날짜로 자동 입력
        if( !$.trim($("input[name='insudt']").val()) )
        	$("input[name='insudt']").datepicker("setDate", "today");


        //배정
        $('.eq_alloc').click(function() {

            var appno = "${appno}";
            
            
            var amount = "1";
            var idx = $('.eq_alloc').index($(this));
            var split_info = $(this).attr('id').split('_');

            if(!appno || !split_info[1] || !split_info[2])
            {
                alert('잘못된 접근입니다.');
                return false;
            }

            window.open('/admin/equipAllocation.do?appno='+appno+'&mdseq='+split_info[1]+'&euseq='+split_info[2]+'&amount='+amount, 'alloc', 'width=820px, height=400px, scrollbars=yes');
        });


        //신청수량변경
        $('.amount').change(function() {

            if(confirm('신청수량을 변경하시겠습니까?'))
            {

                var newForm = $('<form>', {
                    'action' : '/admin/recUpdate.do',
                    'method' : 'post',
                    'target' : '_top'
                }).append($('<input>', {
                    'name' : 'appno',
                    'value' : '${appno}',
                    'type' : 'hidden'
                })).append($('<input>', {
                    'name' : 'mdseq',
                    'value' : $(this).attr('mdSeq'),
                    'type' : 'hidden'
                })).append($('<input>', {
                    'name' : 'amount',
                    'value' : $(this).val(),
                    'type' : 'hidden'
                })).append($('<input>', {
                    'name' : 'mode',
                    'value' : 'amountChange',
                    'type' : 'hidden'
                })).appendTo('body');

                newForm.submit();
            }

        });

        //신청취소
        $('.app_cancel').click(function() {
        	
        	
        	$( "#sendInfo_pop_confirm" ).dialog({
       	      resizable: false,
       	      height: "auto",
       	      width: 400,
       	      modal: true,
       	      buttons: {
       	        "SMS,메일 전송": function() {
       	        	$( this ).dialog( "close" );
       	        	rentAppCancel("Y");
       	        	return false;
       	        },
       	        "SMS,메일 미전송": function() {
       		    	$( this ).dialog( "close" );
       		    	rentAppCancel("N");
       		    	return false;
       		    },
       	        "취소": function() {
       	        	$( this ).dialog( "close" );
       	       		return false;
       	        }
       	      }
       	    });
        	


        });
        
        function rentAppCancel(sendInfoChk){
        	
        	 if(confirm('취소하시겠습니까?'))
             {
                 var newForm = $('<form>', {
                     'action' : '/admin/recUpdate.do',
                     'method' : 'post',
                     'target' : '_top'
                 }).append($('<input>', {
                     'name' : 'appno',
                     'value' : '${appno}',
                     'type' : 'hidden'
                 })).append($('<input>', {
                     'name' : 'sendInfoChk',
                     'value' : sendInfoChk,
                     'type' : 'hidden'
                 })).append($('<input>', {
                     'name' : 'mode',
                     'value' : 'appCancel',
                     'type' : 'hidden'
                 })).appendTo('body');

                 newForm.submit();
             }
        	
        }



        //모델 취소
        $('.modelCancel').click(function() {
        	
        	if($('.modelCancel').length < 2){
        		return false;
        	}

            var split_key = $(this).attr('id').split('_');
            var mdseq = split_key[1];
            var euseq = split_key[2];

            if(!mdseq || !euseq)
            {
                alert('잘못된 접근입니다.');
                return false;
            }

            if(confirm('해당 모델을 삭제하시겠습니까?'))
            {

                var newForm = $('<form>', {
                    'action' : '/admin/recUpdate.do',
                    'method' : 'post',
                    'target' : '_top'
                }).append($('<input>', {
                    'name' : 'appno',
                    'value' : '${appno}',
                    'type' : 'hidden'
                })).append($('<input>', {
                    'name' : 'mode',
                    'value' : 'modelCancel',
                    'type' : 'hidden'
                })).append($('<input>', {
                    'name' : 'mdseq',
                    'value' : mdseq,
                    'type' : 'hidden'
                })).append($('<input>', {
                    'name' : 'euseq',
                    'value' : euseq,
                    'type' : 'hidden'
                })).appendTo('body');

                newForm.submit();

            }

        });


        $(".schword").keypress(function(e) {
            if(e.keyCode == 13)
            {
                var key = $('.schword').index($(this));
                $('.schbtn').eq(key).trigger('click');
                return false;
            }
        });


        //신청자, 사용자 검색
        $(".schbtn").click(function(e) {
        	
        	$('#mem_list_layer').slideUp('fast').remove();
            e.preventDefault();
            var obj = $(this);
            var schword = obj.siblings('.schword');
            
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

                    if(!data_len)
                    {
                        alert('검색된 데이터가 없습니다.');
                        $("input[name='empno'], input[name='empnm'], input[name='deptnm'], input[name='keyword']").val('');
                        return false;
                    }
                    else if(data_len)
                    {
                        var html = "<div id='mem_list_layer'><table width='450'>";
                        html += "<colgroup><col width='100' /><col width='100' /><col width='300 /></colgroup>";
                        html += "<tr id='_title'><th class='titbg'>사번</th>";
                        html += "<th class='titbg'>이름</th>";
                        html += "<th class='titbg'>소속</th></tr>";

                        $.each(parse_data, function() {
                        	arr.deptno = this.deptno;
                            arr.empno = this.empno;
                            arr.name = this.name;
                            if($.trim(this.dept_nm_depth1) == ''){
                            	arr.dept_nm = this.dept_nm;
                            }else{
                            	arr.dept_nm = this.dept_nm_depth1;
                            }
                            
                            arr.telno = this.telno;

                            html += "<tr>";
                            html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.empno+"</a></td>";
                            html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.name+"</a></td>";
                            html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.dept_nm+"</a></td>";
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

        });

        var n = $('.jqTransformSelectWrapper').length;
        $(".jqTransformSelectWrapper").each(function(i) {
            $(this).css("z-index", n-i);
        });

        if('${rfid_empno}' != null
                && '${rfid_empno}' != ''){

            if("${view.status}" == "3" && "${view.approval}" == "2"){

                $('#insunmSch').val('${rfid_empno}');
                $('#insunmSch').next().click();
            }

            if("${view.status}" == "4" && "${view.approval}" == "2"){
                $('#banpnmSch').val('${rfid_empno}');
                $('#banpnmSch').next().click();  
            }
        }
    });

    function eventInit() {
        $('#mArea .pop_sel_model').parent().children('ul').children('li').children('a').off('click', selEvent);
        $('#mArea .pop_sel_model').parent().children('ul').children('li').children('a').on('click', selEvent);
    }

    function selEvent()
    {
        var v = $('.pop_sel_model').val();

        var strdt = "${view.strdt}";
        var enddt = "${view.enddt}";
        
        if(v != '' ){
        	load_amount(v, strdt, enddt);        	
        }
    }

    function userSetData(arr)
    {
    	var status = "${view.status}";
    	
        if( $('.schword').eq(arr.key).siblings().hasClass('appeno') )
        {
            $("input[name='deptno']").val(arr.deptno);
            $("input[name='appeno']").val(arr.empno);
            $("input[name='appenm']").val(arr.name);
            $("input[name='appss']").val(arr.dept_nm);
            $("input[name='apptel']").val(arr.telno);
            $("input[name='appmail']").val(arr.empno+'@kepco.co.kr');
        }
        else if( $('.schword').eq(arr.key).siblings().hasClass('appueno') )
        {
            $("input[name='appueno']").val(arr.empno);
            $("input[name='appuenm']").val(arr.name);
        } 
        else if ($('.schword').eq(arr.key).siblings().hasClass('appueno_arr')) {
        	
        	var dept_arr = arr.dept_nm.split(" ");
        	
        	var eu_mode = '';
        	if(status == '4'){
        		if(!confirm("선택된 장비를 ["+dept_arr+"/"+arr.name+"]님께 인수인계 하시겠습니까? \n해당 인수자에게 메일이 발송되고 승인되기 전까지 배정정보를 변경하실 수 없습니다.")){
        			$('#mem_list_layer').slideUp('fast').remove();
        			/* window.location.reload(); */
        			return false;
        		}
        		eu_mode = 'change_equipuser';
        	}else if(status == '3'){
        		if(!confirm("선택된 장비의 사용자를 ["+dept_arr+"/"+arr.name+"]님으로 수정하시겠습니까?")){
        			$('#mem_list_layer').slideUp('fast').remove();
        			/* window.location.reload(); */
        			return false;
        		}
        		eu_mode = 'edit_equipuser';
        	}
        	var ingaeno = $('.schword').eq(arr.key).siblings("input[name='appueno_arr']").val();
        	var ingaenm = $('.schword').eq(arr.key).siblings("input[name='appuenm_arr']").val();
        	
        	$('.schword').eq(arr.key).siblings("input[name='appueno_arr']").val(arr.empno);
        	$('.schword').eq(arr.key).siblings("input[name='appuenm_arr']").val(arr.name);
        	$('.schword').eq(arr.key).siblings("input[name='deptno_arr']").val(arr.deptno);
        	$('.schword').eq(arr.key).siblings("input[name='dept_Nm1dept_arr']").val(arr.dept_nm);
        	
        	if(status == '3' || status == '4'){
        		
        		var mdseq = $('.schword').eq(arr.key).siblings("input[name='appueno_arr']").data("mdseq");
            	var eqno = $('.schword').eq(arr.key).siblings("input[name='appueno_arr']").data("eqno");
            	var uhseq = $('.schword').eq(arr.key).siblings("input[name='appueno_arr']").data("uhseq");
            	
            	var euseq = $('.schword').eq(arr.key).siblings("input[name='euseq_arr']").val();
            	var appno = "${appno}";

            	var data = { 'euseq': euseq, 
              	 	  'appno': appno, 
            	 	  'mdseq': mdseq, 
            	 	  'eqno': eqno, 
            	 	  'uhseq': uhseq,
            	 	  'mode': '1', 
            	 	  'eu_mode' : eu_mode,
            	 	  'insuno': arr.empno, 
            	 	  'insunm': arr.name, 
            	 	  'deptno': arr.deptno, 
            	 	  'DEPT1NM': arr.dept_nm, 
            	 	  'ingaeno': ingaeno, 
            	 	  'ingaenm': ingaenm, 
            	 	  'regeno': ingaeno, 
            	 	  'regenm': ingaenm };
            	
            	changeEquipUser(data);
        	} 
        }
        else if ($('.schword').eq(arr.key).siblings().hasClass('insuno')){
        	var dept_arr = arr.dept_nm.split(" ");
        	var eu_mode = '';
        	if(status == '4'){
        		if(!confirm("현재 모든 장비의 담당을 ["+dept_arr+"/"+arr.name+"]님께 인수인계 하시겠습니까? \n해당 인수자에게 승인여부메일이 발송됩니다.")){
        			$('#mem_list_layer').slideUp('fast').remove();
        			window.location.reload();
        			return false;
        		}
        		eu_mode = 'change_equipmanager';
        	}
        	
        	var ingaeno = $('.schword').eq(arr.key).siblings("input[name='insuno']").val();
        	var ingaenm = $('.schword').eq(arr.key).siblings("input[name='insunm']").val();
        	
        	$('.schword').eq(arr.key).siblings("input[name='insuno']").val(arr.empno);
        	$('.schword').eq(arr.key).siblings("input[name='insunm']").val(arr.name);
        	
        	if(status == '4'){
        		
            	var appno = "${appno}";

            	var data = { 'appno': appno,             	 	  
            	 	  'mode': '2', 
            	 	  'eu_mode' : eu_mode,
            	 	  'insuno': arr.empno, 
            	 	  'insunm': arr.name, 
            	 	  'ingaeno': ingaeno, 
            	 	  'ingaenm': ingaenm, 
            	 	  'regeno': ingaeno, 
            	 	  'regenm': ingaenm };
            	
            	changeEquipUser(data);
        	} 
        	
        }
        else if ($('.schword').eq(arr.key).siblings().hasClass('banpno')){
        	$('.schword').eq(arr.key).siblings("input[name='banpno']").val(arr.empno);
        	$('.schword').eq(arr.key).siblings("input[name='banpnm']").val(arr.name);
        }
        else if ($('.schword').eq(arr.key).siblings().hasClass('partbanp')){
        	
        	$('.schword').eq(arr.key).val(arr.name);
            $('#mem_list_layer').slideUp('fast').remove();
            
        	if(confirm('해당 장비를 반납 처리하시겠습니까?')){
    			$.ajax({
    	           type: "POST",
    	           url : '/admin/partBanp.do',
    		       data: {'ban_appno' : $('.schword').eq(arr.key).siblings('.partbanp_appno').val()
    		    	   		, 'ban_mdseq' : $('.schword').eq(arr.key).siblings('.partbanp_mdseq').val()
    		    	   		, 'ban_eqno' : $('.schword').eq(arr.key).siblings('.partbanp_eqno').val()
    		    	   		, 'ban_empno' : arr.empno
    		    	   		, 'ban_name' : arr.name},
    		       dataType: "json",
                   success : function(data) {
    	        	   var tmp_result = $.trim(data);
    	        	   
    	         	   if(tmp_result != 'false'){
    	         		   $('.schword').eq(arr.key).closest('td').html(getTimeStamp() + '<br />' + arr.name);
    	            	}else{
    	            		alert("부분 반납 처리중 에러가 발생했습니다.");
    	            		return false;
    	            	}
    	            }
    	        });
    		}
        }
        
        $('.schword').eq(arr.key).val(arr.name);
        $('#mem_list_layer').slideUp('fast').remove();
    }
    
    function changeEquipUser(data){
    	
    	var status = "${view.status}";
    	$('#loading').center().fadeIn();
    	$("#modal-background").css("display","block");
    	
    	$.ajax({
            url : '/admin/changeEquipUser.do',
            type : 'post',
            data : data,
            success : function(data) {
            	
            $('#loading').center().fadeOut();
           	
           	 if(status == '3'){
           		 if(data == 'true'){
           			 alert("수정 되었습니다.");
           			$("#modal-background").css("display","none");
           			 return;
           		 }else{
           			 alert("수정중 에러가 발생하였습니다");
           			$("#modal-background").css("display","none");
           			 return;
           		 }
           	 }
           	 if(status == '4'){
           		 if(data == 'true'){
           			 alert("인수자에게 메일을 발송하었습니다.");
           			 window.location.reload();
           			 return;
           		 }else if(data == 'false'){
           			 alert("인수자에게 메일발송도중 에러가 발생하였습니다.");
           			$("#modal-background").css("display","none");
           			 return;
           		 }
           		 
           		 if(data == 'cancel_true'){
           			alert("인수인계 진행이 취소되었습니다.");
          			window.location.reload();
          			return;
           		 }else if(data == 'cancel_false'){
           			alert("인수인계 진행 취소 도중 에러가 발생하였습니다.");
           			$("#modal-background").css("display","none");
          			return;
           		 }
           	 }
           	
           	
            }
		 });
    	
    }
    
    function cancelChgEu(euseq, uhseq){
    	
    	var appno = '${appno}';
    	var eu_mode = 'cancel_equipuser';
    	
    	
    	
    	if(confirm('진행중인 인수인계를 취소하시겠습니까?')){
    		
    		var data = { 'euseq': euseq, 
            	 	  'appno': appno, 
          	 	  'uhseq': uhseq, 
          	 	  'eu_mode' : eu_mode,
          	 	   };
        
    		
          	changeEquipUser(data);
    		
    	}else{
    		return false;
    	}
    }
    
	function cancelChgEm(uhseq){
    	
    	var appno = '${appno}';
    	var eu_mode = 'cancel_equipmanager';
    	
    	if(confirm('진행중인 인수인계를 취소하시겠습니까?')){
    		
    		var data = {'appno': appno, 
          	 	  'uhseq': uhseq, 
          	 	  'eu_mode' : eu_mode,
          	 	   };
          	
          	changeEquipUser(data);
    		
    	}else{
    		return false;
    	}
    }

    function check()
    {

        if( !$.trim($("input[name='appeno']").val()) )
        {
            alert('신청자를 입력하세요.');
            return false;
        }
        else if( !$.trim($("input[name='appss']").val()) )
        {
            alert('신청부서를 입력하세요.');
            return false;
        }


        if(confirm('접수정보를 수정하시겠습니까?'))
        {
            return true;
        }
        else
        {
            return false;
        }


    }


    function load_amount(mdseq, strdt, enddt)
    {

        if(!mdseq || !strdt || !enddt)
        {
            alert('error');
            return false;
        }

        $.ajax({
            url : '/rentLoad.do',
            type : 'post',
            data : {'mode':'load_amount', 'mdseq':mdseq, 'strdt':strdt, 'enddt':enddt},
            success : function(data) {
                var html = '';
                data = data ? parseInt(data) : data;

                if( $('#mArea').data('mdseq') == mdseq )
                {
                    data += parseInt($('#mArea').data('amount'));
                }


                if(data)
                {
                	html = "가능";
                	html += "<input type='hidden' class='pop_sel_amount' value='1'/>";                
                    
                }else{
                	html = "불가";
                }
                $('.pop_amount_area').empty().append(html);
                /* $('.pop_sel_amount').jqTransSelect(); */
                eventInit();
            }
        });
    }

    function goToRecList() {
        var url = "recList.do?${empty(param.param)?'':param.param}";
        window.location.href = url;
    }

	var _showPopup;
	var _showPopupStatus;
    function openUserRentalScreen(val, status) {    	
    	_showPopupStatus = status;
    	var aval = $('.status').attr('aVal');
    	
    	if(_showPopupStatus == 3){
            if( !$.trim($("input[name='insunm']").val()) )
            {
                alert('인수자를 입력하세요.');
                $("input[name='insunm']").focus();
                return false;
            }
            else if( !$.trim($("input[name='insudt']").val()) )
            {
                alert('인수일을 입력하세요.');
                $("input[name='insudt']").focus();
                return false;
            }
            if(aval == 'N')
            {
                alert('배정이 완료되지 않았습니다.');
                return false;
            }
        }else if(_showPopupStatus == 4){
            if( !$.trim($("input[name='banpnm']").val()) )
            {
                alert('반납자를 입력하세요.');
                $("input[name='banpnm']").focus();
                return false;
            }
            else if( !$.trim($("input[name='banpdt']").val()) )
            {
                alert('반납일을 입력하세요.');
                $("input[name='banpdt']").focus();
                return false;
            }
            else if( !$("input[name='banpst']:checked").val() )
            {
                alert('반납을 선택하세요.');
                $("input[name='banpst']").focus();
                return false;
            }

        }
    	
    	var _url;
    	if (val == 'signature') {
    		_url = "/jsp/rent/admin/sign/userRentalScreen.jsp?" + val +"&appno=${appno}&status=${view.status}";    		
    	} else {
    		_url = "/jsp/rent/admin/sign/userRentalScreen.jsp?" + val;
    	}
   		    		
    	_showPopup = window.open(_url,"_showPopup","width=1920, height=1080");
    	_showPopup.focus();
    }
    
    function syncSignature(data) {
    	document.getElementById('sign_img').src = data;
    	
    	var status = ${view.status};
    	if (status == '4') { //상태가 사용중일때 반납자 싸인을 받는다.
    		document.getElementById('banp_sign_img').src = data;
    		$("#banpsigndata").val(data);
    	} else if (status =='3') { //상태가 접수완료일때 인수자 싸인을 받는다.
    		document.getElementById('insu_sign_img').src = data;
    		$("#insusigndata").val(data);
    	}
    }
    
    function getInfomation() {
    	//팝업창에 DB에 없는 값 세팅. parameter 전달하지 않는다
        if(_showPopupStatus == 3){
        	_showPopup.document.getElementById("insunm").innerHTML= $.trim($("input[name='insunm']").val());
        	_showPopup.document.getElementById("insudt").innerHTML= $.trim($("input[name='insudt']").val());
        	_showPopup.document.getElementById("bigo").innerHTML= '<pre>' + $('#bigo').val() + '</pre>';
        	_showPopup.document.getElementById("act_name").innerHTML= $.trim($("input[name='insunm']").val());

        }else if(_showPopupStatus == 4){
        	_showPopup.document.getElementById("banpnm").innerHTML= $.trim($("input[name='banpnm']").val());
        	_showPopup.document.getElementById("banpdt").innerHTML= $.trim($("input[name='banpdt']").val());
        	_showPopup.document.getElementById("act_name").innerHTML= $.trim($("input[name='banpnm']").val());

            var chkVal = $("input[name='banpst']:checked").val();
            var radioVal = "";

            if(chkVal == 1){
                radioVal = "정상 반납";
            }else if(chkVal == 2){
                radioVal = "고장 반납";
            }else if(chkVal == 3){
                radioVal = "분실 미반납";
            }else if(chkVal == 4){
                radioVal = "분실 대체 반납";
            }else if(chkVal == 5){
                radioVal = "기타";
            }

            _showPopup.document.getElementById("banpst").innerHTML= radioVal;
            _showPopup.document.getElementById("bigo").innerHTML= '<pre>' + $('#bigo').val() + '</pre>';
        }
        _showPopup.document.getElementById('sign_img_data_complete').src = document.getElementById('sign_img').src;
    }

    var _rental_user_sign_popup_admin;
    var _rental_user_sign_popup;
    var approval_tmp;

    function dualMonitor_user_popup_set(approval){

        approval_tmp = approval;

        if(approval_tmp == 3){
            if( !$.trim($("input[name='insunm']").val()) )
            {
                alert('인수자를 입력하세요.');
                $("input[name='insunm']").focus();
                return false;
            }
            else if( !$.trim($("input[name='insudt']").val()) )
            {
                alert('인수일을 입력하세요.');
                $("input[name='insudt']").focus();
                return false;
            }
        }else if(approval_tmp == 4){
            if( !$.trim($("input[name='banpnm']").val()) )
            {
                alert('반납자를 입력하세요.');
                $("input[name='banpnm']").focus();
                return false;
            }
            else if( !$.trim($("input[name='banpdt']").val()) )
            {
                alert('반납일을 입력하세요.');
                $("input[name='banpdt']").focus();
                return false;
            }
            else if( !$("input[name='banpst']:checked").val() )
            {
                alert('반납을 선택하세요.');
                $("input[name='banpst']").focus();
                return false;
            }

        }

        _rental_user_sign_popup = window.open("/admin/signRentalDetail.do?appno=${appno}&popup_gubun=user&","_rental_user_sign_popup","width=1920, height=1080");
        _rental_user_sign_popup_admin = window.open("/admin/signRentalDetail.do?appno=${appno}&popup_gubun=admin","_rental_user_sign_popup_admin","width=1200, height=1000, left=0, top=0");

        _rental_user_sign_popup_admin.focus();
    }

    function setFormValue(call){

        if('user' == call){
            //팝업창에 DB에 없는 값 세팅. parameter 전달하지 않는다
            if(approval_tmp == 3){
                _rental_user_sign_popup.document.getElementById("insunm").innerHTML= $.trim($("input[name='insunm']").val());
                _rental_user_sign_popup.document.getElementById("insudt").innerHTML= $.trim($("input[name='insudt']").val());
                _rental_user_sign_popup.document.getElementById("act_name").innerHTML= $.trim($("input[name='insunm']").val());
            }else if(approval_tmp == 4){

                _rental_user_sign_popup.document.getElementById("banpnm").innerHTML= $.trim($("input[name='banpnm']").val());
                _rental_user_sign_popup.document.getElementById("banpdt").innerHTML= $.trim($("input[name='banpdt']").val());
                _rental_user_sign_popup.document.getElementById("act_name").innerHTML= $.trim($("input[name='banpnm']").val());

                var chkVal = $("input[name='banpst']:checked").val();
                var radioVal = "";

                if(chkVal == 1){
                    radioVal = "정상 반납";
                }else if(chkVal == 2){
                    radioVal = "고장 반납";
                }else if(chkVal == 3){
                    radioVal = "분실 미반납";
                }else if(chkVal == 4){
                    radioVal = "분실 대체 반납";
                }else if(chkVal == 5){
                    radioVal = "기타";
                }

                _rental_user_sign_popup.document.getElementById("banpst").innerHTML= radioVal;
            }
        }else if('admin' == call){
            //팝업창에 DB에 없는 값 세팅. parameter 전달하지 않는다
            if(approval_tmp == 3){
                _rental_user_sign_popup_admin.document.getElementById("insunm").innerHTML= $.trim($("input[name='insunm']").val());
                _rental_user_sign_popup_admin.document.getElementById("insudt").innerHTML= $.trim($("input[name='insudt']").val());
                _rental_user_sign_popup_admin.document.getElementById("bigo").innerHTML= '<pre>' + $('#bigo').val() + '</pre>';
                _rental_user_sign_popup_admin.document.getElementById("act_name").innerHTML= $.trim($("input[name='insunm']").val());

            }else if(approval_tmp == 4){
                _rental_user_sign_popup_admin.document.getElementById("banpnm").innerHTML= $.trim($("input[name='banpnm']").val());
                _rental_user_sign_popup_admin.document.getElementById("banpdt").innerHTML= $.trim($("input[name='banpdt']").val());
                _rental_user_sign_popup_admin.document.getElementById("act_name").innerHTML= $.trim($("input[name='banpnm']").val());

                var chkVal = $("input[name='banpst']:checked").val();
                var radioVal = "";

                if(chkVal == 1){
                    radioVal = "정상 반납";
                }else if(chkVal == 2){
                    radioVal = "고장 반납";
                }else if(chkVal == 3){
                    radioVal = "분실 미반납";
                }else if(chkVal == 4){
                    radioVal = "분실 대체 반납";
                }else if(chkVal == 5){
                    radioVal = "기타";
                }

                _rental_user_sign_popup_admin.document.getElementById("banpst").innerHTML= radioVal;
                _rental_user_sign_popup_admin.document.getElementById("bigo").innerHTML= '<pre>' + $('#bigo').val() + '</pre>';
            }
        }
    }


    function chkFile(obj){
        if($(obj).val() != "" ){
            var ext = $(obj).val().split('.').pop().toLowerCase();

            if($.inArray(ext, ['gif','png','jpg','jpeg','pdf','hwp']) == -1) {
                alert('[' + $(obj).attr('title') + '] 이미지 파일(gif,png,jpg,jpeg) 또는 PDF, 한글(HWP)만 업로드 할수 있습니다.');
                $(obj).val('');
                return;
            }
        }
    }


    function popupFormSync(){
        _rental_user_sign_popup_admin.popupFormSync();
    }

    function signImageSync(data){

        _rental_user_sign_popup_admin.document.getElementById('sign_img_data').src = data;
        _rental_user_sign_popup_admin.document.getElementById('sign_img_data_complete').src = data;
    }

    function popupAdminClose(){
        _rental_user_sign_popup_admin.self.close();
        alert('사용자가 진행을 취소했습니다.');
    }

    function funAdminChk(){
        _rental_user_sign_popup.funAdminChk();
    }
    
    jQuery.fn.center = function () {
	    this.css("position","absolute");
	    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	    return this;
	};
	
	//부분 반납
	function funBanpAct(obj, appno, mdseq, eqno){
		
		var obj = $(obj);
        var schword = obj.siblings('.schword');
        
        if( !$.trim(schword.val()) )
        {
            return false;
        }
	}
	
	/* 파일삭제 */
	function godel(seq, obj, val){
		var param = {"RENT_SECURITY_SEQ":seq, "appno":val};
		var targetId = $(".changeNode").contents();
		
		var html = '';
		if(confirm('파일을 삭제하시겠습니까?')){
			$.ajax({
				type : 'post',
				url : '/removeRentFile.do',
				dataType : 'text',
				data : param,
				success : function(result){
					if(result == 'true'){
						targetId.remove();
						html += '<input type="file" name="file_attach" id="file_attach" value="" style="width: 618px;">'; 
						alert('삭제되었습니다.');
						$(".changeNode").append(html);
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
	
	$("#file_attach").change(function(){
		   if($(this).val() != ''){
			   var ext = $(this).val().split(".").pop().toLowerCase();
			   if($.inArray(ext, ["pdf","gif","png","jpg","jpeg"]) == -1 ){
					alert("pdf, gif, png, jpg, jpeg 파일만 업로드 가능합니다.");
					$(this).val('');
				}
		   }
	})
	
	
	function goSign(obj){
		var appno = $(obj).data('appno');
		var euseq = $(obj).data('euseq');
		var uhseq = $(obj).data('uhseq');
		var appueno = $(obj).data('appueno');
		var appuenm = $(obj).data('appuenm');
		var deptno = $(obj).data('deptno');
		var dept1Nm = $(obj).data('deptnm');
		
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
	}
	
</script>
<c:import url="/resource/common/include/bottom.jsp" />