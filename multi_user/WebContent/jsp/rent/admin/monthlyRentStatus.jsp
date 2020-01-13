<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
	.tabList:hover{background-color: lightblue; cursor: pointer;}
/* basic-list2_ */
.basic-list2_ {font-weight: normal;}
.basic-list2_ pre{padding: 2px 0 12px 0;}
.basic-list2_ table th{padding:12px 0 ;border:1px solid #A6A6A6; color:#666666;font-size:90%;background-color:#F7F7F7;}
.basic-list2_ table td{padding:5px 5px; ; border:1px solid #ddd; text-align:center ;font-size:80%; font-weight:normal;min-height: 26px; }
</style>
<body>
<div class="topMenu-bg-img-sub" style="top: 0px;"></div>


<div id="contents" class="learn-frame-area">
	<div id="contents_id" style="padding: 30px;">
		
		
		<!--content-->
		<div class="contents-con-framebox">
		
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub8_tit_img.png"></div>
				<div class="nav-title">월간대여현황 </div>
			</div>

            <form id="frm" name="frm" action="/admin/monthlyRentStatus.do" method="get" onSubmit="return false;" onkeypress="javascript:if(event.keyCode == 13){equipList()}">
            <input type="hidden" id="gbcd" name="gbcd" value="${gbcd}"/>
			<input type="hidden" name="pageNo" id="pageNo"  value="1"/>
			<div class="searchArea_con">
				<fieldset>
				<div class="search-box">		
					<div class="form-group">
						
						<div>
							   <p class="inputDesign">
							   <c:set var="today" value="<%=new java.util.Date()%>" />
							   <select name="sch_year" class="sch_year">
									<fmt:formatDate value="${today}" pattern="yyyy" var="start"/> 
									<c:forEach begin="0" end="10" var="idx" step="1">
									<option ${ ((start+1)-idx) == sch_year ? 'selected=\"selected\"' : ''} value="<c:out value="${(start+1) - idx}"/>">
									<c:out value="${(start+1) - idx}년" /></option>
									</c:forEach>
								</select>
								
								<select name="sch_month" class="sch_month">
									<fmt:formatDate value="${today}" pattern="MM" var="month"/>
									<c:forEach begin="1" end="12" var="idx" step="1">
									<fmt:formatNumber var="no" minIntegerDigits="2" value="${idx}"/>
									<option ${month == no ? 'selected=\"selected\"' : ''} value="<c:out value="${no}" />">
									<c:out value="${no}월" /></option>
									</c:forEach>
								</select>
							   </p>
						</div>
						
						<div id="model_area" style="float:left;">
						   <p class="inputDesign">
						   <select id="mdseq" name="mdseq" style="width: 160px;">
									<option value="9999">전체</option>
								<c:forEach var="modelList" items="${modelList}" varStatus="x">
									<option value="${modelList.MDSEQ}" ${modelList.MDSEQ == equipInfo.MDSEQ ? "selected" : ""}>${modelList.MDNM}</option>	
								</c:forEach>
						   </select>
						   </p>
						</div>
						
						<input type="button" style="cursor: pointer;" id="search_btn" class="search_btn submit_ok"  value="검색">
					</div>
				</div>
				</fieldset>
			</div>
			
			<div class="basic-list2" style="width:100%">
				<table>
					<thead>
						<tr>
							<c:forEach var="codeList" items="${codeList}" varStatus="x">
								<th ${gbcd == codeList.GBCD ? 'style="background-color: lightblue; cursor: pointer;"' : 'class=tabList'} scope="col" onclick="javascript:monthlyRentList('${codeList.GBCD}')" style="cursor: pointer; padding: 6px 0;">${codeList.GBNM}</th>
							</c:forEach>                   					
						</tr>
					</thead>
				</table>
			</div>
			</form>
			
            		
			<div class="basic-list2_" style="margin-top:5px;">
				<table class="listtable" style="width: 100%">
					<tr class='appendhd'></tr>
				</table>
			</div>
			<div id="loading" style="display:none; position:absolute; top:350px; text-align:center; width:100%;"><img src="/resource/images/sub/ajax_loading.gif" /></div>

		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(window).focus();
$(document).ready(function() {
	load_fnc('4', '0', '0'); //menu script
	
	var resultMessage = '<%= session.getAttribute("resultMessage") %>';
	
	if(resultMessage != 'null'){
		alert(resultMessage);
		<% session.removeAttribute("resultMessage"); %>
	}
	
	$('#search_btn').click(function() {

		var gbcd = $("#gbcd").val();
		var year = $('.sch_year').val();
		var month = $('.sch_month').val();
		var mdseq = $('#mdseq').val();
		
		if(!gbcd || !year || !month || !mdseq)
		{
			alert('년,월,모델을 빠짐없이 선택하세요.');
			return false;
		}

		$('.listtable .appendhd, .listtable .appendtr').remove();
		$('#loading').fadeIn();

		$.ajax({
			url : '/admin/getStatDataInfo.do',
			type : 'post',
			dataType : 'json',
			data : {'gbcd':gbcd, 'sch_year':year, 'sch_month':month, 'mdseq':mdseq},
			success : function(data) {
				
				var hdhtml = "<tr class='appendhd'>";
				
				// 메뉴
				if(data.eleList.length > 0)
				{
					hdhtml += "<td class='list03' style='height:20px; padding:5px;text-align:center;'>일</td>";
					$.each(data.eleList, function() {
						if(this.eqmst == '2' || this.eqmst == '3')
						{
							hdhtml += "<td class='list03' style='text-decoration:line-through; color:red;'>"+this.eqnm+"</td>";
						}
						else
						{
							hdhtml += "<td class='list03'>"+this.eqnm+"</td>";
						}
					});
				}
				else
				{
					hdhtml += "<td><span style='font-weight:bold;'>등록된 설비가 없습니다.</span></td>";
				}
				hdhtml += "</tr>";

				
				
				// 한줄 처리
				var html = '';
				if(data.eleList.length > 0)
				{
					var dt = new Date();
					var year = dt.getFullYear();
					var month = dt.getMonth()+1;
					var today = dt.getDate();
					var today_cell_color = '';
					
					$.each(data.dayData, function(i) {
						
						if($('.sch_year').val() == year && $('.sch_month').val() == month && (i+1) == today)
						{
							html += "<tr class='appendtr today'>";
							today_cell_color = ' background-color:#b5ffc8;';
						}
						else
						{
							html += "<tr class='appendtr'>";
							today_cell_color = '';
						}
						html += "<td class='list02' style='text-align:center;"+today_cell_color+"'>"+(i+1)+"</td>";
						
						
						// 가로로 데이터 추가
						if(this)
						{
							$.each(this, function(i) {
								html += "<td class='list02' style='vertical-align:middle;"+today_cell_color+"'>"+this+"</td>";
							});
						}
						html += "</tr>";

					});
				}

				$('#loading').fadeOut();
				$('.listtable tbody:last').append(hdhtml);
				$('.listtable tbody:last').append(html);
			}

		});

	});
	
});

$(window).load(function(){
	$(".submit_ok").click();
});

function monthlyRentList(code){
	var frm = document.frm;
	if(code != undefined){
		$("#gbcd").val(code);	
	}
	$("#pageNo").val("1");
	frm.submit();
}
</script>
