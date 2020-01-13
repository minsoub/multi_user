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
            <li id="2" class="active"><a href="javascript:;">카테고리 관리</a></li>
            <li id="3"><a href="javascript:;">신고영상 관리</a></li>
            <li id="6"><a href="javascript:;">영상 관리</a></li>
            <li id="4"><a href="javascript:;">사용자 관리</a></li>
            <li id="5"><a href="javascript:;">운영자 관리</a></li>
            <li id="7"><a href="javascript:;">e-러닝 관리</a></li>
        </ul>
    </div>
    
    <form id="frm" name="frm" method="post">
	    <%-- 카테고리가 추가될 경우 열어줌. 현재는 테마별 영상만 운영 됨. 사용자 > 마이페이지 > 메뉴 관리도 같이 작업해야 함. 20171207
	    <div class="m_title_02" style="margin:20px 0 10px 0">1차 카테고리</div>
	    <table class="table-view">
	        <colgroup>
	            <col width="15%" />
	            <col />
	        </colgroup>
	        <tr>
	            <th>카테고리</th>
	            <td class="checks">
	            	<c:forEach var="category" items="${kubeLeftMenuList}" varStatus="status">
						<c:if test="${category.p_code_seq == 0}">
							<span onclick="javascript:funModCode('1', '${category.p_code_seq}', '${category.code_seq}');">${category.code_desc }</span>
                        </c:if>
                    </c:forEach>
	            </td>
	        </tr>
	    </table>
	    
	    <div class="fl_right" style="margin:15px 0">
	        <button type="button" onclick="javascript:funRegCode('1');" class="btn_black img_pointer">등록</button> 
	    </div>
	    
	    <div class="m_title_02" style="margin:40px 0 10px 0">2차 카테고리</div>
	     --%>
	     
	    <div class="m_title_02" style="margin:40px 0 10px 0">테마별 영상</div>
	    <table class="table-view">
	        <colgroup>
	            <col width="15%" />
	            <col />
	        </colgroup>
	        <c:set var="categoryCnt" value="0" />
	        <c:forEach var="category" items="${kubeLeftMenuList}" varStatus="status">
				<c:if test="${category.p_code_seq == 0}">
                	<c:if test="${status.index != 0}">
                    	<c:if test="${categoryCnt == 0}">
                    		<tr>
  						</c:if>
						<c:set var="categoryCnt" value="0" />
								</td>
							</tr>
                     </c:if>
                     
					<th>${category.code_desc }</th>
					<td class="checks">
				</c:if>
		        <c:if test="${category.p_code_seq != 0}">
						<c:if test="${category.p_code_seq !=  5}">
							<span onclick="javascript:funModCode('2', '${category.p_code_seq}', '${category.code_seq}');">${category.sub_code_desc }</span>
						</c:if> 
						<c:if test="${category.p_code_seq ==  5}">
							<span onclick="javascript:alert('사업소 카테고리는 수정할 수 없습니다');">${category.sub_code_desc }</span>
						</c:if>
					<c:set var="categoryCnt" value="${categoryCnt + 1}" />
				</c:if>
	            <c:if test="${status.last }">
	            	<c:if test="${categoryCnt == 0}">
					</c:if>
					</tr>
				</c:if>
	        </c:forEach>
	    </table>
	    
	    <div class="fl_right" style="margin:15px 0">
	        <button type="button" onclick="javascript:funRegCode('2');" class="btn_black img_pointer">등록</button> 
	    </div>         
	    
	    <div class="m_title_02" style="margin:40px 0 10px 0">신고 카테고리</div>
	    <table class="table-view">
	        <colgroup>
	            <col width="15%" />
	            <col />
	        </colgroup>
	        <tr>
	            <th>신고 카테고리</th>
	            <td class="checks">
	            	<c:forEach var="category" items="${codeList}" varStatus="status">
						<span onclick="javascript:funModCode('14', '${category.p_code_seq}', '${category.code_seq}');">${category.code_desc }</span>
                    </c:forEach>
	            </td>
	        </tr>
	    </table>
	    
	    <div class="fl_right" style="margin:15px 0">
	        <button type="button" onclick="javascript:funRegCode('14');" class="btn_black img_pointer">등록</button> 
	    </div>               
    </form>
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
 
function funRegCode(gubun){
	window.open('/kubeCategoryPop.do?ct=' + gubun, 'reg_category_pop','width=400px,height=370px,left=550px,top=300px');
}

function funModCode(gubun, p_code_seq, code_seq){
	window.open('/kubeCategoryPop.do?ct=' + gubun + '&p=' + p_code_seq + '&s=' + code_seq,'category_pop','width=400px,height=370px,left=550px,top=300px');
}
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />