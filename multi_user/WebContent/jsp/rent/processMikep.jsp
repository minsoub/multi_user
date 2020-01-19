<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<script language="javascript">
	function processMikep(){
	
		var doc_title = document.getElementById("doc_title").innerHTML;
		var doc_purpose = document.getElementById("doc_purpose").innerHTML;
		var doc_period = document.getElementById("doc_period").innerHTML;
		var doc_amount = document.getElementById("doc_amount").innerHTML;
		var doc_user = document.getElementById("doc_user").innerHTML;	
		var link_key = document.getElementById("link_key").innerHTML;
		//var emp_id = document.getElementById("emp_id").innerHTML;
		var emp_id = document.getElementById("emp_id").value;

		var doc_context = doc_title + "|" + doc_purpose + "|" + doc_period + "|" + doc_amount + "|" + doc_user + "|" + link_key + "|" + emp_id;
	
		document.ActiveX_ID.TestFunction(doc_context);
		
		window.location.href = "/equipRentList.do";
	}
	
	function processCancel() {
		var appno = ${mikep_appno};
		
		if(!appno)
		{
			alert('잘못된 접근입니다.');
			return false;
		}

		if(confirm('취소 하시겠습니까?'))
		{
			var newForm = $('<form>', {
				'action' : '/rentSignCancel.do',
				'method' : 'post',
				'target' : '_top'
			}).append($('<input>', {
				'name' : 'appno',
				'value' : appno,
				'type' : 'hidden'
			})).appendTo('body'); 

			newForm.submit();
		}
	}
</script>
<body>
	<object classid="clsid:7E0F0A37-738E-48C5-8D2E-19C93F86816E" codebase="/resource/ActiveX_Hwp.cab#version=1,0,0,21" width="0" height="0" id="ActiveX_ID"></object>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="2" var="left_depth_1"/>

    <c:set var="empno" value="${sessionScope.SESS_EMPNO }"/>
    <c:set var="userNm" value="${sessionScope.SESS_USER_NAME }"/>

    <c:set var="telno" value="${sessionScope.SESS_USER_INFO['telno'] }"/>
    <c:set var="mailno" value="${sessionScope.SESS_USER_INFO['mailno'] }"/>

    <div id="contents" class="learn-frame-area">
        <div class="contents-framebox" id="contents_id">
            <!-- leftmenu -->
            <div class="contents-header-framebox">
                <div class="learn-tit-framebox">
                    <c:import url="/resource/common/include/leftMenu_01.jsp">
                        <c:param name="left_depth_1" value="3"></c:param>
                        <c:param name="left_depth_2" value="2"></c:param>
                    </c:import>
                </div>
            </div>
            <!-- leftmenu end-->

            <!--content-->
            <div class="contents-con-framebox">
                <div class="nav-box">
                    <div class="nav-img"><img alt="" src="./resource/images/sub/sub8_tit_img.png"></div>
                    <div class="nav-list">
                        <img alt="" src="./resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">설비현황</b>
                    </div>
                    <div class="nav-title">설비현황</div>
                </div>

                <div class="sub-nav-title">장비신청 내부결재</div>
				<div class="insrtfrom-framebox">
                    <div class="insert-step1-box">
                        <div class="form-step1">
                            <fieldset>
				               <div class="row-group">
				               		<dl class="insert_ready">
					                    <dt class="must-option">
					                        <label>제목</label>
					                    </dt>
					                    <dd style="width: 600px;">
					                        <span id="doc_title"><%-- ${mikep_title} --%>업무용 멀티미디어 설비 장기대여 신청</span>
					                    </dd>
				                    </dl>
				                    <dl class="insert_ready">
					                    <dt class="must-option">
					                        <label>사용목적</label>
					                    </dt>
					                    <dd style="width: 600px;">
					                        <span id="doc_purpose">${mikep_purpose}</span>
					                    </dd>
				                    </dl>
				                    <dl class="insert_ready">
					                    <dt class="must-option">
					                        <label>사용기간</label>
					                    </dt>
					                    <dd style="width: 600px;">
					                        <span id="doc_period">${mikep_period}</span>
					                    </dd>
				                    </dl>
				                    <dl class="insert_ready">
					                    <dt class="must-option">
					                        <label>대여수량</label>
					                    </dt>
					                    <dd style="width: 188px;">
					                        <span id="doc_amount">${mikep_amount}</span>
					                        <span id="link_key" hidden>${mikep_linkkey}</span>
					                    </dd>
				                    </dl>
				                    <dl class="insert_ready">
					                    <dt class="must-option">
					                        <label>사용자</label>
					                    </dt>
					                    <dd style="width: 600px;">
					                        <span id="doc_user">${mikep_user}</span>
					                    </dd>
				                    </dl>
				                    <dl class="insert_ready">
					                    <dt class="must-option">
					                        <label>사원번호</label>
					                    </dt>
					                    <dd style="width: 600px;">
					                        <!--span id="emp_id">${mikep_empno}</span-->
					                        <input type="text" id="emp_id" value="${mikep_empno}" />
					                    </dd>
				                    </dl>
							   </div>
						   </fieldset>
	                    </div>
	                </div>
                </div>
			   <div class="btn-zone">
					<ul>
						<li><input type="button" class="search_btn" onclick="processMikep();" value="결재"></li>
						<li><input type="button" class="search_btn" onclick="processCancel();" value="취소"></li>
					</ul>
				</div>
            </div>
            <!--content end-->
        </div>
    </div>

    <div class="popup_view_box view1" id="apDiv" style="display:none;">
    </div>
</body>

<script type="text/javascript">
    </script>
<c:import url="/resource/common/include/bottom.jsp" />