<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="8" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="8"></c:param>
				<c:param name="left_depth_2" value="5"></c:param>
				<c:param name="left_depth_3" value="5"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub8_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리메뉴</b>
				</div>
				<div class="nav-title">설정관리</div>
			</div>
			
            <div class="sub-nav-title">관리자</div>
            
            <div class="basic-list" style="margin-top:5px;">
				<table id="listTable" summary="">
					<caption>설정관리</caption>
					<colgroup>
						<col style="width:8%">
						<col style="width:8%">
						<col style="width:15%">
						<col style="width:15%">
                        <col style="">
						<col style="width:25%">
					</colgroup>
					<thead>
						<tr>
                       		<th scope="col">
                            <div class="checks small">
								<input type="checkbox" class="check_all" id="check_all"> 
								<label for="check_all"></label> 
							</div>
                            </th>
							<th scope="col">번호</th>
                            <th scope="col">사번</th>
                            <th scope="col">성명</th>
                            <th scope="col">부서</th>
                            <th scope="col">메일수신</th>                     					
						</tr>
					</thead>
					<tbody>
						<c:set var="admListLength" value="${fn:length(adminList)}"></c:set>
						<c:forEach var="adminList" items="${adminList}" varStatus="x">
						<tr>
                            <td>
                            <div class="checks small">
								<input type="checkbox" class="empno" id="empno_${x.count}" value="${adminList.EMP_ID}"> 
								<label for="empno_${x.count}"></label> 
							</div>
                            </td>
							<td>${admListLength - x.index}</td>
                            <td>${adminList.EMP_ID}</td>
                            <td>${adminList.EMP_NM}</td> 
                            <td>${adminList.DEPT_NM}</td>
                            <td>
                            <input type="radio" id="" name="receipt_${adminList.EMP_ID}" value="Y" empId="${adminList.EMP_ID}" class="checks small is_receipt" ${adminList.GET_MAIL == 'Y' ? 'checked' : ''}> 
							<label for="">사용</label>
                            <input type="radio" id="" name="receipt_${adminList.EMP_ID}" value="N" empId="${adminList.EMP_ID}" class="checks small is_receipt" ${adminList.GET_MAIL == 'N' ? 'checked' : ''}>
							<label for="">미사용</label>
                            </td>                      
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
            <div class="btn-zone" style="float:left">
                <ul>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="window.location('/admin/code.do')" value="코드관리" style="width:80px;"></li>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="window.location('/admin/stanModelList.do')" value="모델관리" style="width:80px;"></li>
                </ul>
            </div>
            <div class="btn-zone">
                <ul>
                    <li><input type="button" name="srchDescription" class="search_btn list_del" value="삭제" ></li>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:window.location='/admin/adminRegist.do'" value="등록" ></li>
                </ul>
            </div>
	
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('4', '0', '0'); //menu script
	
	var resultMessage = '<%= session.getAttribute("resultMessage") %>';
	
	if(resultMessage != 'null'){
		alert(resultMessage);
		<% session.removeAttribute("resultMessage"); %>
	}
	
	$('.is_receipt').change(function() {
		
		var is_receipt = $(this).val();
		var empno = $(this).attr('empId');

		if(!is_receipt || !empno)
		{
			alert('error');
			return false;
		}

		$.ajax({
			url : '/admin/isReceipt.do',
			type : 'post',
			data : { 'get_mail' : is_receipt, 'empno' : empno },
			success : function(data) {

				if(data == 'true')
				{
					window.location.reload();
				}
				else
				{
					alert('저장에 실패하였습니다.');
				}

			}
		}); 


	});
	
	//전체 선택
	$('.check_all').click(function() {
		
		if( $(this).is(':checked') )
		{
			$('.empno').prop('checked',true);
		}
		else
		{
			$('.empno').prop('checked',false);
		}

	});
	
	//선택 삭제
	$('.list_del').click(function() {
		
		var empno_arr = $('.empno:checked').map(function() {
			return $(this).val();
		}).get();

		if(!empno_arr.length)
		{
			alert('최소 한개이상 선택하세요.');
			return false;
		}

		if(confirm('삭제하시겠습니까?'))
		{

			$.ajax({
				url : '/admin/deleteAdmin.do',
				type : 'post',
				dataType : 'text',
				data : {'empno_arr' : empno_arr},
				success : function(data) {
					if(data == 'true')
					{
						window.location.reload();
						return false;
					}
				}
			}); 

		}

	});
	
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />