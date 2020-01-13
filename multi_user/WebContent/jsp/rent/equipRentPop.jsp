<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<body>
	
      <div class="contents-framebox" id="contents_id">

            <!--content-->
            <div id="popup" style="width:700px; padding: 20px;">
            <div class="sub-nav-title" style="margin-top: 5px;">나의 대여</div>
          	<div class="basic-list">
				<table id="listTable" summary="">
					<caption>게시판 테이블</caption>
					<colgroup>
						<col style="width: 15%" class="no-td">
						<col style="">
						<col style="width: 25%">
						<col style="width: 15%" class="date-td">
						<col style="width: 15%" class="ref-td">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="no-td">신청번호</th>
							<th scope="col" class="like-td">대여장비</th>
							<th scope="col" class="like-td">대여기간</th>
							<th scope="col" class="date-td">신청일</th>
							<th scope="col" class="like-td">상태</th>
						</tr>
					</thead>
					<tbody>						
						<c:forEach var="equipRentPopList" items="${equipRentPopList}" varStatus="x">
						<tr>
							<td>${equipRentPopList.APPNUM}<input type="hidden" id="APPNO" value="${equipRentPopList.APPNO}"></td>
							<td>${equipRentPopList.GBNM}</td>
							<td>${fn:substring(equipRentPopList.STRDT,0,4)}.${fn:substring(equipRentPopList.STRDT,4,6)}.${fn:substring(equipRentPopList.STRDT,6,8)} ~ ${fn:substring(equipRentPopList.ENDDT,0,4)}.${fn:substring(equipRentPopList.ENDDT,4,6)}.${fn:substring(equipRentPopList.ENDDT,6,8)}</td>						
							<td>${fn:substring(equipRentPopList.REGDT,0,4)}.${fn:substring(equipRentPopList.REGDT,4,6)}.${fn:substring(equipRentPopList.REGDT,6,8)}</td>
							<td>${equipRentPopList.STATUSSTR}</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(equipRentPopList) == 0}">
						<tr>
							<td align="center" colspan="6">등록된 데이터가 없습니다.</td>
						</tr>
						</c:if>
					</tbody>
				</table>
				<div class="btn-zone" style="padding: 10px;">
					<input type="button" class="search_btn" onclick="javascript: self.close();" value="닫기" style="width:50px;">
				</div>	
				
			</div>
			</div>
            <!--content end-->
            
            
      </div>
</body>

<script type="text/javascript">

if ($(window).height() != $("#popup").outerHeight()) {
    setTimeout(function(){
    	$(document).attr("overflow-x","auto");
    	$(document).attr("overflow-y","auto");

    	var wrapWidth = $("#popup").outerWidth();
    	var wrapHeight = $("#popup").outerHeight();

    	var w1 = $(window).width();
    	var h1 = $(window).height() - 30;

    	// 크롬의 문제로 W, H 값을 따로 설정
    	window.resizeBy(wrapWidth - w1, wrapHeight-h1);
    	//window.resizeBy(wrapWidth- w1, 0);
    	//window.resizeBy(0, wrapHeight - h1);
    	//창 크기 자동 조절 E
    	
    }, 100);
    $(window).focus();
}

</script>
