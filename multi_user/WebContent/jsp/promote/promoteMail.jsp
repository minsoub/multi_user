<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />

<body>
<c:if test="${mail_p_status == '1' }">
	<c:set var="status" value="신청"></c:set>
</c:if>
<c:if test="${mail_p_status == '2' }">
	<c:set var="status" value="승인"></c:set>
</c:if>
<c:if test="${mail_p_status == '3' }">
	<c:set var="status" value="반려"></c:set>
</c:if>
<div class="email_box">
    <div>
        <div class="top-logo" style="margin-bottom:25px"><a href="http://media.hq" target="_new"><img alt="" src="/resource/images/logo.png"></a></div>
        <h3 style="color:#fff; text-align:center; font-size:20px;">31층 에너지밸리 홍보시스템 ${status } </h3>
    </div>
    
    <div style="margin:35px 0 20px 0; line-height:25px; text-align:center;">
        31층 에너지밸리 홍보시스템 이용 <strong>${status }</strong> 알림 메일입니다. 
        <br><a href="http://media.hq" target="_new"><strong>http://media.hq</strong></a>에서 내용을 확인해주세요
    </div>
    
    <div style="border:1px solid #e7e7e7; width:100%; border-radius:5px; padding:15px 15px 60px 15px; box-sizing: border-box;">
        <div class="sub-nav-title-sm">신청자 정보</div>
        <div class="basic-list">
            <form>				
                <div class="insrtfrom-framebox">
                <div class="insert-step1-box">
                    <div class="form-step1">
                        <fieldset>
                        <legend>신청자 정보</legend>
                            <div class="row-group">	
                                <dl class="insert_ready">
                                    <dt class="must-option"><strong>신청부서</strong></dt>
                                    <dd style="width:200px">${promoteDetail.dept_name }</dd>
                                    <dt class="must-option"><strong>신청자</strong></dt>
                                    <dd style="width:200px">${promoteDetail.name }</dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><strong>전화번호</strong></dt>
                                    <dd style="width:200px">${promoteDetail.telno }</dd>
                                    <dt class="must-option"><strong>이메일</strong></dt>
                                    <dd style="width:200px">${promoteDetail.mailno }@kepco.co.kr</dd>
                                </dl>
                            </div>
                        </fieldset>
                    </div>
                </div>
                </div>
            </form>
        </div>
        
        <div class="sub-nav-title-sm">행사정보</div>		

			<div class="basic-list">
                <form>				
                    <div class="insrtfrom-framebox">
                    <div class="insert-step1-box">
                        <div class="form-step1">
                            <fieldset>
                            <legend>행사정보</legend>
                                <div class="row-group">	
                                    <dl class="insert_ready">
                                        <dt class="must-option"><label for="" id="">행사명</label></dt>
                                        <dd>${promoteDetail.p_title }</dd>
                                    </dl>
                                    <dl class="insert_ready">
                                        <dt class="must-option"><strong>행사일</strong></dt>
                                        <dd style="width:100px">${cha:todate(promoteDetail.p_date, '-', '3') }</dd>
                                        <dt class="must-option"><strong>행사시간</strong></dt>
                                        <dd style="width:100px">${cha:todate(promoteDetail.start_time, '', '5') } ~ ${cha:todate(promoteDetail.end_time, '', '5') }</dd>
                                    </dl>
                                    <dl class="insert_ready">
                                        <dt class="must-option"><label for="" id="">행사주체</label></dt>
                                        <dd>${cha:pTarget(promoteDetail.p_target_code, promoteDetail.p_target_desc)}</dd>
                                    </dl>
                                    <dl class="insert_ready">
                                        <dt class="must-option"><label for="" id="">에너지밸리 홍보설명</label></dt>
                                        <dd>${promoteDetail.energy_flag == '0' ? '미신청' : '신청' }</dd>
                                    </dl>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                    </div>
                </form>
			</div>
            <div class="btn-zone">
                <ul>
                   	<li><input type="button" name="" class="search_btn" value="바로가기" onclick="javascript:goDetail();" style="width:120px; height:40px"></li>
                </ul>
           </div>
    </div>     	
</div>
<form id="frm" name="frm" method="post">
<input type="hidden" id="p_seq" name="p_seq" value="${mail_p_seq }">
<input type="hidden" id="left_depth_2" name="left_depth_2" value="${link_gubun }">
</form>
<script>
function goDetail(){
	funIfrmSubmit('http://media.hq/promote/promoteDetail.do');
}
</script>
</body>
</html>
