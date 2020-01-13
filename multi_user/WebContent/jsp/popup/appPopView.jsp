<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:set var="dto" value="${equipDto}" />

<table>
    <colgroup>
        <col width="50px" />
        <col width="70px" />
        <col width="50px" />
        <col width="*" />
    </colgroup>
    <tr>
        <td colspan="2" bgcolor="#FFFFFF" style="padding:8px;">

            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="equip-photo">
                    <c:if test="${dto.imageUrl eq ''}">
                        <img alt="No Image" src="/resource/images/sub/noimg.png">
                    </c:if>
                    <c:if test="${dto.imageUrl ne ''}">
                        <img alt="model Image" src="<%= Constants.ASP_DOMAIN %>multi_user_jsp/rent/${fn:replace(dto.imageUrl,'/OCFSFILES/data01/www/DATA/APPS/apply/rent/','')}" >
                        <!-- <img alt="model Image" src="http://cfile9.uf.tistory.com/image/2577C9365521500608916E" > -->
                    </c:if>
                </td>
                <td width="20"></td>
                <td valign="top">
                <div class="equip-table basic-list1">
                    <table id="listTable" class="table01">
                        <colgroup>
                            <col width="120px" />
                            <col width="*" />
                        </colgroup>

                    <c:if test="${subTreeMapSize != 0}">
                        <c:forEach items="${subTreeMap}" var="list" varStatus="loop">
                            <c:set var="dtoItem" value="${fn:split(dto.item, '|')}" />
                            <c:set var="firstKey" value="${list.key}" />
                            <c:set var="firstVal" value="${list.value}" />
                            <c:set var="firstSize" value="${fn:length(firstVal)}" />
                            <c:set var="itemCnt" value="${fn:length(dtoItem)}" />
                            <tr>
                                <th>${firstVal['gbnm']}</td>
                                <td>${dtoItem[loop.index]}</td>
                            </tr>
                        </c:forEach>
                    </c:if>

                    <c:if test="${dto.lchdt ne null}" >
                        <tr>
                            <th class="td01">출시년월</td>
                            <td class="td02">${dto.lchdt}</td>
                        </tr>
                    </c:if>

                    <!-- 첨부파일 -->
                    <c:set var="fileSize" value="${fn:length(fileList)}" />
                    <c:if test="${fileSize > 0}" >
                        <tr>
                            <th class="td01">첨부파일</td>
                            <td class="td02">
                                <c:forEach items="${fileList}" var="file">
                                    <a href="file_download?fileno=${file.fileNo}">${file.fileNm}</a>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                    </table>
                </div>
                </td>
                </tr>

            </table>

            <br />
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-top:1px solid #E8E8E8;">
                <tr><td style="height:10px;"></td></tr>
                <tr>
                    <td>○ ${dto.mdtxt}</td>
                </tr>
            </table>

        </td>
    </tr>
</table>

