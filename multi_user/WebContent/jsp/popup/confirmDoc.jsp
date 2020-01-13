<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<jsp:useBean id="today" class="java.util.Date" />
<c:set var="newLine" value="\n" />

<body>
<br />
<br />
<div id="confirm_area">

<table width="690" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
        <td>

            <table width="690" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="399" height="25" valign="top">
                        <table width="100%" border="0" class="top_title">
                            <tr>
                                <td><span style="font-size: 16px; font-weight:bold; font-style: normal; text-decoration: underline;">멀티미디어장비 대여 신청/ 반출/ 반납 확인증</span></td>
                            </tr>
                            <tr>
                                <td height="10"></td>
                            </tr>
                            <tr>
                                <td><span>처리부서 :</span> &nbsp;IT인프라처 IT서비스팀/ 멀티미디어센터 </td>
                            </tr>
                            <tr>
                                <td><span>처리일자 :</span> &nbsp;<fmt:formatDate value="${today}" type="DATE" dateStyle="FULL" /></td>
                            </tr>
                            <tr>
                                <td><span>담&nbsp;당&nbsp;자&nbsp; :</span> </td>
                            </tr>
                        </table>
                    </td>

                    <td width="291" align="right" class="confirm_data">
                        <table width="270" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                            <tr>
                                <td width="30" rowspan="2" align="center" bgcolor="#F7FAFF"><strong>결<br><br>재</strong></td>
                                <td width="120" height="25" align="center" bgcolor="#F7FAFF"><strong>담 당</strong></td>
                                <td width="120" align="center" bgcolor="#F7FAFF"><strong>차 장</strong></td>
                            </tr>
                            <tr>
                                <td height="60" bgcolor="#FFFFFF">&nbsp;</td>
                                <td bgcolor="#FFFFFF">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
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
                <tr>
                    <td width="150" height="24" align="right" bgcolor="#F7FAFF">
                    <img src='/resource/images/btn/arrow_04.gif' align='absmiddle'>신청번호&nbsp;</td>
                    <td width="195" bgcolor="#FFFFFF" style="padding-left:5px;"><strong>${view.appnum}</strong></td>
                    <td width="150" align="right" bgcolor="#F7FAFF" style="padding-left:5px;">
                    <img src='/resource/images/btn/arrow_04.gif' align='absmiddle'>서비스 구분&nbsp;</td>
                    <td width="195" bgcolor="#FFFFFF" style="padding-left:5px;">멀티미디어 장비대여</td>
                </tr>
                <tr>
                    <td height="24" align="right" bgcolor="#F7FAFF">
                    <img src='/resource/images/btn/arrow_04.gif' align='absmiddle'>사용자 서비스상태&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;">${appstArr[view.status]}&nbsp;</td>
                    <td align="right" bgcolor="#F7FAFF" style="padding-left:5px;">
                    <img src='/resource/images/btn/arrow_04.gif' align='absmiddle'>승인 상태&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;">${approvalArr[view.approval]}</td>
                </tr>
                <tr>
                    <td height="24" align="right" bgcolor="#F7FAFF">
                    <img src='/resource/images/btn/arrow_04.gif' align='absmiddle'>신청일시&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;">
                    <c:if test="${!empty(view.regdt) }">
                        <fmt:parseDate value="${view.regdt}" var="PARSE_REGDT" pattern="yyyyMMddHHmmss" />
                        <fmt:formatDate value="${PARSE_REGDT}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </c:if>
                    &nbsp;
                    </td>
                    <td align="right" bgcolor="#F7FAFF" style="padding-left:5px;">
                    <img src='/resource/images/btn/arrow_04.gif' align='absmiddle'>신청 수량&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;">${appAmount}</td>
                </tr>
                <tr>
                    <td align="right" bgcolor="#F7FAFF" style="padding-left:5px;">
                    <img src='/resource/images/btn/arrow_04.gif' align='absmiddle'>신청부서 (*)&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;" colspan="3"><span class="istoDay" style="font-weight:bold;">${view.appss}</span></td>
                </tr>
                <tr>
                    <td height="24" align="right" bgcolor="#F7FAFF">신청자 사번 (*)&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;">${view.appeno}</td>
                    <td align="right" bgcolor="#F7FAFF" style="padding-left:5px;">
                    <img src='/resource/images/btn/arrow_04.gif' align='absmiddle'>신청자명 (*)&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;"><span class="istoDay" style="font-weight:bold;">${view.appenm }</span></td>
                </tr>
                <tr>
                    <td height="24" align="right" bgcolor="#F7FAFF">전화번호 (*)&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;">${view.apptel }</td>
                    <td align="right" bgcolor="#F7FAFF" style="padding-left:5px;">휴대전화번호 (*)&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;">${view.apphp }</td>
                </tr>
                <tr>
                    <td height="24" align="right" bgcolor="#F7FAFF">이메일&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;">${view.appmail }</td>
                    <td align="right" bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;</td>
                    <td bgcolor="#FFFFFF" style="padding-left:5px;">&nbsp;</td>
                </tr>
                <tr>
                    <td height="24" align="right" bgcolor="#F7FAFF">사용 기간 (*)&nbsp;</td>
                    <td colspan="3" bgcolor="#FFFFFF" style="padding-left:5px;">
                        <span style="font-weight:bold;">
                            <c:if test="${!empty(view.strdt) && !empty(view.enddt)}">
                            <fmt:parseDate value="${view.strdt}" var="PARSE_STRDT" pattern="yyyyMMdd" />
                            <fmt:parseDate value="${view.enddt}" var="PARSE_ENDDT" pattern="yyyyMMdd" />
                            <fmt:formatDate value="${PARSE_STRDT}" pattern="yyyy년 MM월 dd일" /> ~
                            <fmt:formatDate value="${PARSE_ENDDT}" pattern="yyyy년 MM월 dd일" />
                            </c:if>
                        </span>
                    </td>
                </tr>

                <tr>
                    <td height="24" align="right" bgcolor="#F7FAFF">신청 장비 (*)&nbsp;</td>
                    <td colspan="3" bgcolor="#FFFFFF" style="padding-left:5px;">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="equip_data">
                            <tr>
                                <td height="1" colspan="5" bgcolor="#ACACAC"></td>
                            </tr>
                            <tr>
                                <td width="90" height="24" align="center" bgcolor="#F0F0F0" class="tabledot"><strong>구분</strong></td>
                                <td width="150" align="center" bgcolor="#F0F0F0" class="tabledot"><strong>모델명</strong></td>
                                <td width="80" align="center" bgcolor="#F0F0F0" class="tabledot"><strong>신청 수량</strong></td>
                                <td width="80" align="center" bgcolor="#F0F0F0" class="tabledot"><strong>비고</strong></td>
                                <td align="center" bgcolor="#F0F0F0" class="tabledot">&nbsp;</td>
                            </tr>

                            <c:forEach var="list" items="${modelList}" varStatus="idx" >
                                <tr>
                                    <td width="90" height="24" align="center" bgcolor="#F9F9F9">
                                        <span style="font-weight:bold;">${list.gbnm }<span>
                                    </td>
                                    <td width="150" style="padding-left:10px;">${list.mdnm }</td>
                                    <td width="80" align="right" style="padding-right:20px;">${list.amount }</td>
                                    <td colspan="2" align="left">
                                    <span class='sltDC'>
                                        ${list.eqnm}
                                        <c:if test="${idx.count % 3 == 0 }">
                                            <br>
                                        </c:if>
                                    </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="1" colspan="5" bgcolor="#D8D8D8"></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${fn:length(modelList) == 0}">
                                <tr><td class='list02 nodata' colspan='4'>등록된 데이터가 없습니다.</td></tr>
                            </c:if>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td height="24" align="right" bgcolor="#F7FAFF"><img src="/resource/images/btn/arrow_05.gif" align="absmiddle"> 반납 예정일시&nbsp;</td>
                    <td colspan="3" bgcolor="#FFFFFF" style="padding-left:5px;">
                        <c:if test="${!empty(view.banpdt) }">
                            <fmt:parseDate value="${view.banpdt}" var="PARSE_BANPDT" pattern="yyyyMMddHHmmss" />
                            <fmt:formatDate value="${PARSE_BANPDT}" pattern="yyyy-MM-dd HH:mm:ss" />
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <td align="right" bgcolor="#F7FAFF">사용 용도 (*)&nbsp;</td>
                    <td height="120" colspan="3" valign="top" bgcolor="#FFFFFF" style="padding-left:5px;">
                        ${fn:replace(view.useobj, newLine, "<br />") }
                    </td>
                </tr>
                <tr>
                    <td align="right" bgcolor="#F7FAFF">특이사항&nbsp;</td>
                    <td height="100" colspan="3" valign="top" bgcolor="#FFFFFF" style="padding-left:5px;">
                        ${fn:replace(view.bigo, newLine, "<br />") }
                    </td>
                </tr>
            </table>
        </td>
    </tr>

    <tr>
        <td>&nbsp;</td>
    </tr>

    <tr>
        <td>
            <table width="690" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center" height="50">
                    <table width="100%" border="0" bgcolor="#FFFFCC">
                    <tr>
                    <td width="30">&nbsp;</td>
                    <td><span style="font-size: 14px; font-weight:bold;">본인은 위 신청내용과 대여 장비에 대한 상태를 확인하였으며, 대여기간을 준수하겠습니다. </span></td>
                    </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right" height="15"></td>
            </tr>
            <tr>
                <td align="right" height="30">
                    <span style="font-size: 14px; font-weight:bold;">반&nbsp;&nbsp;출 :
                        <c:choose>
                            <c:when test="${!empty(view.insudt) }">
                                <fmt:parseDate value="${view.insudt}" var="PARSE_INSUDT" pattern="yyyyMMdd" />
                                <fmt:formatDate value="${PARSE_INSUDT}" pattern="yyyy-MM-dd" />
                            </c:when>
                            <c:otherwise>
                                <fmt:formatDate value="${today}" pattern="yyyy-MM-dd" />
                            </c:otherwise>
                        </c:choose>
                    </span>
                    <span style="margin-left:150px; font-weight:bold;">이&nbsp;&nbsp;름 :&nbsp;&nbsp;${view.insunm}</span>
                    <span style="margin-left:150px;"><img id="insu_sign_img" style="width:100px;height:50px;vertical-align: middle;margin:0;margin-left: 15px;" src="<%= Constants.ASP_DOMAIN %>rent_sign/${view.RENT_IN_SIGN_IMG}">(인)</span>
                </td>
            </tr>
            <tr>
                <td align="right" height="15"></td>
            </tr>
            <tr>
                <td align="center" height="50">
                    <table width="100%" border="0" bgcolor="#FFE1E1">
                        <tr>
                            <td width="30">&nbsp;</td>
                            <td>
                                <span style="font-size: 14px; font-weight:bold; text-decoration: underline;">
                                노트북, 디지털카메라, 캠코더 등 매체에 저장된 자료는 모두 삭제되며, <br>
                                다음 사용자를 위해 초기화 됩니다. 이에 동의하며 대여장비를 반납 합니다.
                                </span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td align="right" height="15"></td>
            </tr>

            <tr>
                <td align="right" height="30">
                    <span style="font-size: 14px; font-weight:bold;">반&nbsp;&nbsp;납 :
                        <c:choose>
                            <c:when test="${!empty(view.banpdt) }">
                            	<fmt:parseDate value="${view.banpdt}" var="PARSE_BANPDT" pattern="yyyyMMddHHmmss" />
                            	<fmt:formatDate value="${PARSE_BANPDT}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </c:when>
                            <c:otherwise>
                                <fmt:formatDate value="${today}" pattern="yyyy-MM-dd" />
                            </c:otherwise>
                        </c:choose>
                    </span>
                    <span style="margin-left:100px; font-weight:bold;">이&nbsp;&nbsp;름 :&nbsp;&nbsp;${view.banpnm}</span>
                    <span style="margin-left:150px;"><img id="banp_sign_img" style="width:100px;height:50px;vertical-align: middle;margin:0;margin-left: 15px;" src="<%= Constants.ASP_DOMAIN %>rent_sign/${view.RENT_OUT_SIGN_IMG}">(인)</span>
                </td>
            </tr>
        </table>
        </td>
    </tr>

</table>

</div>

<br/>
<br/>
<br/>
<br/>
</body>

<script src="/resource/common/js/jquery-printThis.js"></script>
<script type="text/javascript">
    $(window).load(function() {
        print();
    });
</script>