<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />

<div id="contents">
                        
    <div class="m_title_01" style="margin:10px 0 30px 0">관리자</div> 
    
    <div class="tab_box">
        <ul class="equip">
            <li id="1"><a href="javascript:;">메인화면 관리</a></li>
            <li id="2"><a href="javascript:;">카테고리 관리</a></li>
            <li id="3"><a href="javascript:;">신고영상 관리</a></li>
            <li id="6"><a href="javascript:;">영상 관리</a></li>
            <li id="4"><a href="javascript:;">사용자 관리</a></li>
            <li id="5" class="active"><a href="javascript:;">운영자 관리</a></li>
            <li id="7"><a href="javascript:;">e-러닝 관리</a></li>
        </ul>
    </div>
    
    <div class="m_title_02 fl_left" style="margin-bottom:10px">전체 : <fmt:formatNumber value="${fn:length(saList)}" pattern="#,###,###,###" />건</div>
    <table class="table-list" style="margin-top:10px">
        <colgroup>
            <col width="10%" />
            <col width="16%" />
            <col width="10%" />
            <col width="10%" />
            <col />                                
            <col width="13%" />
            <col width="16%" />
            <col width="10%" />
        </colgroup>
        <thead>
            <tr>
                <th>운영자명</th>
                <th>부서</th>
                <th>직급</th>
                <th>운영자 구분</th>
                <th>이메일</th>
                <th>전화번호(내선)</th>
                <th>핸드폰번호</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach var="saList" items="${saList }" >				
				<tr>
					<td>${saList.name }</td>
					<td>${saList.dept_name1 }<br/>${saList.dept_name2 }</td>
                    <td>${saList.levelnm }</td>
                    <td>${saList.adm_gubun == 'S' ? '전체 운영자' : 'e-러닝 운영자' }</td>
                    <td>${saList.mailno }</td>
                    <td>${fn:trim(saList.telno) != '' && fn:trim(saList.telno) != 'null' ? saList.telno : ''}</td>
                    <td>${fn:trim(saList.hp) != '' && fn:trim(saList.hp) != 'null' ? saList.hp : ''}</td>
                    <td>
                    	<button type="button" class="btn_orange img_pointer" onclick="javascript:funSaAct('${saList.empno}', 'D');">삭제</button>
                    </td>
				</tr>
			</c:forEach>
        </tbody>
    </table>
    <div class="fl_right" style="margin:15px 0">
        <button type="button" onclick="javascript:funSaAct('', 'C');" class="btn_black img_pointer">등록</button> 
    </div>
    
</div>
<script type="text/javascript">
$(document).ready(function() {
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
	}else if(menu == 7){
		linkUrl = '/kubeElearnStat.do';
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
		    		   
		    		   location.replace(location.href);
			    		   
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
<c:import url="/resource/common/include/kube_bottom.jsp" />