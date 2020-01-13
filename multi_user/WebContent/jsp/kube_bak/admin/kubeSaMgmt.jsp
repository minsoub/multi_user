<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="9"></c:param>
			</c:import> 
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리자</b>
				</div>
				<div class="nav-title">운영자 관리</div>
			</div>
            
            <div style="margin-bottom:10px;">
                <ul class="equip">
                    <li id="1"><a href="javascript:;">메인화면 관리</a></li>
                    <li id="2"><a href="javascript:;">카테고리 관리</a></li>
                    <li id="3"><a href="javascript:;">신고영상 관리</a></li>
                    <li id="6"><a href="javascript:;">영상 관리</a></li>
                    <li id="4"><a href="javascript:;">사용자 관리</a></li>
                    <li id="5" class="active"><a href="javascript:;">운영자 관리</a></li>
                </ul>
            </div>
            
            <form id="frm" name="frm" method="post">
				<div class="basic-list">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 13%">
							<col >
							<col style="width: 10%">
							<col style="width: 20%">
							<col style="width: 18%" >
	                        <col style="width: 10%" >
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="like-td">운영자명</th>
								<th scope="col" class="like-td">부서</th>
	                            <th scope="col" class="like-td">직급</th>
								<th scope="col" class="like-td">이메일</th>
	                            <th scope="col" class="like-td">연락처</th>
	                            <th scope="col" class="like-td">삭제</th>
							</tr>
						</thead>
						<tbody>			
							<c:forEach var="saList" items="${saList }" >				
								<tr>
									<td class="no-td">${saList.name }</td>
									<td class="like-td">${saList.dept_name1 }<br/>${saList.dept_name2 }</td>
		                            <td class="like-td">${saList.jikyee }</td>
		                            <td class="like-td">${saList.mailno }</td>
		                            <td class="like-td" style="text-align: left;">${fn:trim(saList.telno) != '' ? '내선 : '.concat(saList.telno) : ''}${fn:trim(saList.hp) != '' ? '<br/>HP : '.concat(saList.hp) : ''}</td>
		                            <td>
		                            	<div class="btn-zone" style="float: none; text-align: center;">
							                <ul>
							                    <li style="padding: 0 0 0 10px;"><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funSaAct('${saList.empno}', 'D');" value="삭제"></li>
							                </ul>
							            </div>  
		                            </td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
            </form>
            
            <div class="btn-zone">             
                <ul>         
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funSaAct('', 'C');" value="등록"></li>
                </ul>
            </div>         
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
});

$('.equip > li').click(function (){
	var menu = $(this).attr('id');
	var linkUrl = '/kubeMainMgmt.do';
	
	if(menu == 2){
    	linkUrl = '/kubeCategoryMgmt.do';
	}else if(menu == 3){
		linkUrl = '/kubeReportMgmt.do';
	}else if(menu == 4){
		linkUrl = '/kubeUserMgmt.do';
	}else if(menu == 5){
		linkUrl = '/kubeSaMgmt.do';
	}else if(menu == 6){
		linkUrl = '/kubeVideoMgmt.do';
	}
	
	goUrl(linkUrl);
});

function funSaAct(empno, g){
	var alert_msg = '';
 
	if(g == 'C'){ 
		window.open('/kubeSaRegPop.do', 'reg_sa_pop','width=800px,height=900px,left=250px,top=50px,scrollbars=yes,resizable=yes');		
	}else if(g == 'D'){
		if(confirm('해당 운영자를 삭제하시겠습니까?')){
			var param = {'empno' : empno, 'act_gubun' : g}
			
		    $.ajax({
		       url: "/kube/insertDeleteKubeSa.do",
		       type: "POST",
		       data: param,
		       dataType: "json",
		       success: function(msg) {
		    	   var tmp_result = $.trim(msg);
					
		    	   if(tmp_result != 'false'){
						
		    		   alert('삭제 되었습니다.');
		    		   
		    		   funSubmit(location.href);
			    		   
		    		   return true;
					}else{
		    		   alert("오류가 발생 했습니다");
		    		   
		    		   return false;
					}
		 		}
			});
		}
	}
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />