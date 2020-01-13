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
				<c:param name="left_depth_2" value="4"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub8_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">장바구니</b>
				</div>
				<div class="nav-title">장바구니</div>
			</div>

			<div class="basic-list">
				<table id="listTable" summary="">
					<caption>게시판 테이블</caption>
					<colgroup>
						<col style="width: 10%" class="no-td">
						<col style="">
						<col style="width: 15%">
						<col style="width: 25%">
						<col style="width: 10%">
						<col style="width: 15%" >
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="no-td">
                            <div class="checks small">
								<input type="checkbox" class="check_all" id="check_all"> 
								<label for="check_all"></label> 
							</div>
                            </th>
							<th scope="col" class="like-td">장비구분</th>
							<th scope="col" class="like-td">모델명</th>
                            <th scope="col" class="like-td">대여기간</th>
							<th scope="col" class="like-td">수량</th>
                            <th scope="col" class="ref-td">비고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${list}" varStatus="x">
							<tr>
								<td class="no-td">
	                            <div class="checks small">
									<input type="checkbox" class="bskno" id="bskno_${x.count}" value="${list.bskno}"> 
									<label for="bskno_${x.count}"></label> 
								</div>
	                            </td>
								<td class="like-td">${list.gbnm}</td>
	                            <td class="like-td">${list.mdnm}</td>
								<td class="date-td">
								${fn:substring(list.strdt,0,4)}.${fn:substring(list.strdt,4,6)}.${fn:substring(list.strdt,6,8)} ~ ${fn:substring(list.enddt,0,4)}.${fn:substring(list.enddt,4,6)}.${fn:substring(list.enddt,6,8)}   
								</td>
								<td class="like-td">${list.amount}</td> 
								<td>
	                            <img alt="" class="cursor_pointer" src="resource/images/btn/app.png" onclick="javascript:go_rent('${list.bskno}');">
	                            <img alt="" class="cursor_pointer basket_del" src="resource/images/btn/del.png" onclick=";">
	                            </td>
							</tr>
						
						</c:forEach>						
					</tbody>
				</table>
			</div>
           
            <div class="btn-zone">
				<ul>
					<li><input type="button" name="srchDescription" class="search_btn list_del" value="선택삭제" style="width:80px;"></li>
					<li><input type="button" name="srchDescription2" class="search_btn" onclick="javascript:go_rent(false);" value="대여신청" style="width:80px;"></li>
				</ul>
			</div>	
            		
		</div>
		<!--content end-->
		
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	load_fnc('4', '0', '0'); //menu script
	
	$("#sch_strdt, #sch_enddt").datepicker();
	
	$('#apDiv1').dialog({
		autoOpen : false,
		resizable : true,
		draggable : true,
		/* position : ['center', 'center'], */
		width : 700,
		height: 400,
		title : "신청내역 상세보기",
		open : function() {
			
			var modal_appno = $("#APPNO").val();
			alert("modal_appno : " + modal_appno);
			
			if(!modal_appno)
			{
				alert('error');
				return false;
			}

			$.ajax({
				url : '/loadAppModel.do',
				type : 'post',
				dataType : 'json',
				data : {'appno' : modal_appno},
				success : function(data) {
					
					alert("data!!! : " + data.APPNO);								

					var html = '',
						sign_html = '';

					if(data.model_list)
					{
						$.each(data.model_list, function() {
							html += "<tr class='newel'>";
							html += "<td class='list01'>"+this.gbnm+"</td>";
							html += "<td align='center' class='list02'>"+this.mdnm+"</td>";
							html += "<td align='center' class='list02'>"+this.amount+"</td>";
							html += "</tr>";
						});
						$('#apDiv1 #model_list tr:last').parent().append(html);
					}

					if(data.sign)
					{
						$('#apDiv1 #sign_list, #apDiv1 #sign_title').css('display','');
						$.each(data.sign, function() {
							sign_html += "<tr class='newel'>";
							sign_html += "<td class='list02' align='center'>"+this.status+"</td>";
							sign_html += "<td class='list02' align='center'>"+this.name+"</td>";
							sign_html += "<td class='list02' align='center'>"+this.reg_sign+"</td>";
							sign_html += "</tr>";
						});
						$('#apDiv1 #sign_list tr:last').parent().append(sign_html);
					}

				}
			});

		},
		buttons : {
			'닫기' : function() {
				$(this).dialog('close');
			}
		},
		show : {
			effect : 'blind',
			duration : 200
		},
		hide : {
			effect : 'blind',
			duration : 200
		},
		modal : true
	});
	
	$('.check_all').click(function() {
		
		if( $(this).is(':checked') )
		{
			$('.bskno').prop('checked',true);
		}
		else
		{
			$('.bskno').prop('checked',false);
		}

	});
	
	
	//선택 삭제
	$('.list_del').click(function() {
		
		var bskno = $('.bskno:checked').map(function() {
			return $(this).val();
		}).get();

		if(!bskno.length)
		{
			alert('최소 한개이상 선택하세요.');
			return false;
		}

		if(confirm('삭제하시겠습니까?'))
		{

			$.ajax({
				url : '/deleteBasket.do',
				type : 'post',
				dataType : 'text',
				data : {'bskno' : bskno},
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
	
	
	//삭제
	$('.basket_del').click(function() {
		
		var key = $('.basket_del').index($(this));
		var bskno = $('.bskno').eq(key).val();
		
		if(!bskno)
		{
			alert('error');
			return false;
		}

		bskno = $.makeArray(bskno);
		
		if(confirm('삭제하시겠습니까?'))
		{

			$.ajax({
				url : '/deleteBasket.do',
				type : 'post',
				dataType : 'text',
				data : {'bskno' : bskno}, 
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


//대여신청
function go_rent(bskno)
{

	var bskno_arr = [];

	if(!bskno) //대여신청버튼
	{
		bskno_arr = $('.bskno:checked').map(function() {
			return $(this).val();
		}).get();
	}
	else //각개별신청
	{
		bskno_arr.push(bskno);
	}

	if(!bskno_arr.length)
	{
		alert('선택된 데이터가 없습니다.');
		return false;
	}

	window.location.href = "/equipRentRegist.do?bskno="+bskno_arr;

}

</script>
<c:import url="/resource/common/include/bottom.jsp" />