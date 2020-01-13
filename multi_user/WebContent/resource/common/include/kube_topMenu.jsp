<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_meta.jsp" />
<body>
<div id="wrap">
    <div id="header">
        <h1 class="logo fl_left">
            <a href="/kube.do"><img alt="kepco" src="/resource/kube_images/logo.png"></a>
        </h1>
        <div class="search_area fl_left">
            <form id="topSrhfrm" name="topSrhfrm" method="post">
                <label for=""></label>
                <input type="text" title="검색바" id="srh_keyword_top" name="srh_keyword_top" value="${paging.srh_keyword_top}" placeholder="동영상 검색" class="search" onkeydown="javascript:if(event.keyCode == 13){funTopSrh();}">
                <img src="/resource/kube_images/btn_search.png" class="img_pointer" style="margin-top: -4px;" onclick="javascript:funTopSrh();" />
            </form>               
        </div>
        <div class="top fl_right">
            <ul>
                <li><a href="/kube/mypage/bookmarkList.do">마이페이지</a></li>
                <c:if test="${sessionScope.SESS_USER_INFO['kubeAdmin'] != null && sessionScope.SESS_USER_INFO['kubeAdmin'] != ''}">
                	<c:if test="${sessionScope.SESS_USER_INFO['kubeAdminGubun'] == 'S'}">
                		<li><a href="/kubeMainMgmt.do">관리자</a></li> 
                	</c:if>
                	<c:if test="${sessionScope.SESS_USER_INFO['kubeAdminGubun'] == 'E'}">
                		<li><a href="/kubeElearnStat.do">관리자</a></li> 
                	</c:if>
                </c:if>  
            </ul>
        </div>
        <div class="login_info fl_right">${sessionScope.SESS_USER_INFO['second_dept_name'] } ${sessionScope.SESS_USER_INFO['third_dept_name'] } ${sessionScope.SESS_USER_NAME } 님</div>
    </div>
