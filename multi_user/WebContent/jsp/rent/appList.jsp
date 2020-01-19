<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
#modal-background {
   display: none;
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background-color: black;
   opacity: .10;
   -webkit-opacity: .1;
   -moz-opacity: .1;
   filter: alpha(opacity=10);
   z-index: 1000;
}
</style>
<body>
<div id="modal-background"></div>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="3" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="3"></c:param>
				<c:param name="left_depth_2" value="3"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub8_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">마이페이지</b>
				</div>
				<div class="nav-title">마이페이지</div>
			</div>
	
			<form name="frm" method="get" action="/appList.do" onsubmit="return search();">
			<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo}"/>
			<input type="hidden" id="APPNO" value="${rentDto.modal_appno}">
			<div class="searchArea_con">
				<fieldset>
				<div class="search-box">		
					<div class="form-group">
						<legend>검색영역</legend>
                           <div>
                               <p class="inputDesign">
                               <select name="sch_code1">
									<option value="">선택</option>
								<c:forEach var="codeList" items="${codeList}" varStatus="x">
									<c:if test="${codeList.GBCD != '018'}">
										<option value="${codeList.GBCD}" ${rentDto.sch_code1 == codeList.GBCD ? 'selected=\"selected\"' : ''}>${codeList.GBNM}</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<input type="text" id="sch_strdt" name="sch_strdt" readonly="readonly" value="${rentDto.sch_strdt}" 
						style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('./resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;"/>
						~ 
						<input type="text" id="sch_enddt" name="sch_enddt" readonly="readonly" value="${rentDto.sch_enddt}"
						style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('./resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;"/>
						<input type="submit" style="cursor: pointer;" class="search_btn" value="검색">
						<!-- <input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:btnSearFrm();" value="검색"> -->
					</div>
				</div>
				</fieldset>
			</div>
			</form>
	
			<div class="basic-list">
				<table id="listTable">
					<caption>게시판 테이블</caption>
					<colgroup>
						<col style="width: 15%" class="no-td">
						<col style="">
						<col style="width: 25%">
						<col style="width: 15%" class="date-td">
						<col style="width: 15%" class="ref-td">
						<col style="width: 8%" >
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="no-td">신청번호</th>
							<th scope="col" class="like-td">대여장비</th>
							<th scope="col" class="like-td">대여기간</th>
							<th scope="col" class="date-td">신청일</th>
							<th scope="col" class="like-td">상태</th>
                            <th scope="col" class="ref-td">취소</th>
						</tr>
					</thead>
					<tbody>						
						<c:forEach var="appList" items="${appList}" varStatus="x">
						<tr style="cursor: pointer;" class="equip" onclick="$('#APPNO').val('${appList.APPNO}');">
							<td>${appList.APPNUM}</td>
							<td>${appList.GBNM}</td>
							<td>${fn:substring(appList.STRDT,0,4)}.${fn:substring(appList.STRDT,4,6)}.${fn:substring(appList.STRDT,6,8)} ~ ${fn:substring(appList.ENDDT,0,4)}.${fn:substring(appList.ENDDT,4,6)}.${fn:substring(appList.ENDDT,6,8)}</td>						
							<td>${fn:substring(appList.REGDT,0,4)}.${fn:substring(appList.REGDT,4,6)}.${fn:substring(appList.REGDT,6,8)}</td>
							<td>${appList.STATUSSTR}</td>
							<td onclick="event.cancelBubble=true">
								<c:if test="${appList.IS_CANCEL}">
									<img alt="" class="cursor_pointer app_cancel" src="resource/images/btn/cancel1.png" id="app_${appList.APPNO}">
								</c:if>
							</td>
						</tr>
						</c:forEach>
						<c:if test="${fn:length(appList) == 0}">
						<tr>
							<td align="center" colspan="6">등록된 데이터가 없습니다.</td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<c:import url="/resource/common/include/paging.jsp" />
		
		</div>
		<!--content end-->
		
		<div class="popup_view_box view1" id="apDiv1" style="display:none;">
			<div style="margin-top:10px; margin-bottom:5px; font-weight:bold; color:#804000; float:left">
			신청 모델
			</div>			
			<div id="appInfo"></div>
			<div class="basic-list">
				<table id="model_list" summary="">
					<colgroup>
						<col style="width: 20%">
						<col style="width: 25%">
						<col style="width: 25%">
						<col style="width: 30%">						
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="no-td">구분</th>
							<th scope="col" class="like-td">모델명</th>
							<th scope="col" class="like-td">장비명 (배정/별칭)</th>
							<th scope="col" class="like-td">사용자</th>
						</tr>
					</thead>
				</table>
			</div>
			<br/>
			<div id="sign_title" style="margin-bottom:5px; font-weight:bold; color:#804000;">결재 상황</div>
			<div class="basic-list">
				<table id="sign_list">
					<colgroup>
						<col width="100px" />
						<col width="100px" />
						<col width="*" />
					</colgroup>
					<thead>
					<tr id="tid">
						<th class="no-td">상태</th>
						<th class="like-td">이름</th>
						<th class="like-td">승인여부</th>
					</tr>
					</thead>
				</table>
			</div>
		</div>
		
	</div>
	<div id="loading" style="display:none; position:absolute; top:400px; text-align:center; width:100%; z-index:9999"><img src="/resource/images/pre-loader.gif" /></div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	load_fnc('3', '0', '0'); //menu script
	
	var resultMessage = '<%= session.getAttribute("resultMessage") %>';
	
	if(resultMessage != 'null'){
		alert(resultMessage);
		<% session.removeAttribute("resultMessage"); %>
	}

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
					
					var html = '',
						sign_html = '';
						appInfo_html = '';
						
					if(data.appInfo)
					{
						appInfo_html += "<div class='basic-list'>";
						appInfo_html += "<div class='btn-zone' style='padding-bottom:5px;'>";
						appInfo_html += "<input type='hidden' id='appStatus' value='"+data.appInfo.status+"'/>";
						
						if(data.appInfo.status == '4'){
							
							if(data.appInfo.mailapproval == '0'){
								
								appInfo_html += "<span style='cursor: pointer; vertical-align: middle;' onclick='javascript:cancelChgEm("+data.appInfo.uhseq+")'>장비담당자 "+data.appInfo.ingaenm+" > "+data.appInfo.insunm+" <img src='/resource/images/close-window-16.png'/></span>";
								
							} else {
								
								appInfo_html += "<input type='hidden' class='insuno' name='insuno' value='";
								if(data.appInfo.appinsuno){
									appInfo_html += data.appInfo.appinsuno;
								}
								appInfo_html += "' />";
								appInfo_html += "<input type='hidden' id='insunm' name='insunm' value='";
								if(data.appInfo.appinsunm){
									appInfo_html += data.appInfo.appinsunm;
								}
								appInfo_html += "' />";
								
								appInfo_html +=	"장비담당자 "; 
								appInfo_html += "<input type='text' class='schword' value='";
								if(data.appInfo.appinsunm){
									appInfo_html += data.appInfo.appinsunm;
								}
								appInfo_html += "' style='width: 60px;'>";
								appInfo_html += "<input type='button' style='cursor: pointer; height: 30px;' class='search_btn schbtn' value='검색'>";	
								
							}
							
						} else {
							
							if(data.appInfo.appinsunm){
								appInfo_html +=	"장비담당자 "; 
								appInfo_html += data.appInfo.appinsunm;
							};
						}
									
						appInfo_html += "</div>";
						appInfo_html += "</div>";
						
						$('#appInfo').html(appInfo_html);
					}

					if(data.model_list)
					{
						$.each(data.model_list, function() {
							html += "<tr class='newel'>";
							html += "<td class='list01'>"+this.gbnm+"</td>";
							html += "<td align='center' class='list02'>"+this.mdnm+"</td>";
							html += "<td align='center' class='list02'>";
							if(this.eqno != null){
								html += this.eqnm + " " + this.eqalias;
							}
							html += "</td>";
							html += "<td align='center' class='list02'>";
							
							if($("#appStatus").val() == '4'){
								
        						if(this.mailapproval == '0'){
        							
        							html += "<span style='cursor: pointer;' onclick='javascript:cancelChgEu("+this.euseq+","+this.uhseq+")'>"+this.ingaenm+" > "+this.insunm+" <img src='/resource/images/close-window-16.png'/></span>";
        							
        						}else{
        							
        							html += "<div class='btn-zone' style='float:none'>";
    								html += "<input type='hidden' class='euseq_arr' name='euseq_arr' value='"+this.euseq+"'/>";
    								html += "<input type='hidden' class='appueno_arr' name='appueno_arr' data-mdseq='"+this.mdseq+"' data-eqno='"+this.eqno+"' data-uhseq='"+this.uhseq+"' value='"+this.appueno+"'/>";
    								html += "<input type='hidden' class='appuenm_arr' name='appuenm_arr' value='"+this.appuenm+"'/>";
    								html += "<input type='text' class='box100 schword' value='"+this.appuenm+"' style='width: 60px;'>";
    								html += "<input type='button' style='cursor: pointer; height: 30px;' class='search_btn schbtn' value='검색'>";
    								html += "</div>";
        							
        						}
								
							}else{
								html += this.appuenm;
							}
							
							html += "</td>";
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
	
	$('.equip').click(function() {
		
		//전역변수 저장
		var idx = $('.equip').index($(this));
		modal_appno = $(this).attr('data-appnum');
	
		$('#apDiv1 #sign_list, #apDiv1 #sign_title').css('display','none');
		$('#apDiv1 #model_list tr.newel').remove();
		$('#apDiv1 #sign_list tr.newel').remove();
	
		$('#apDiv1').dialog('open');
	
	});
	
	//신청취소
	$('.app_cancel').click(function() {

		var split_key = $(this).attr('id').split('_');
		var appno = split_key[1];
		
		if(!appno)
		{
			alert('잘못된 접근입니다.');
			return false;
		}

		if(confirm('취소 하시겠습니까?'))
		{
			var newForm = $('<form>', {
				'action' : '/appCancel.do',
				'method' : 'post',
				'target' : '_top'
			}).append($('<input>', {
				'name' : 'appno',
				'value' : appno,
				'type' : 'hidden'
			})).appendTo('body'); 

			newForm.submit();
		}

	});
	
	var modal_appno_load = $("#APPNO").val();
	
	if(modal_appno_load != null && modal_appno_load.length > 0){
		$('#apDiv1 #sign_list, #apDiv1 #sign_title').css('display','none');
		$('#apDiv1 #model_list tr.newel').remove();
		$('#apDiv1 #sign_list tr.newel').remove();
		$('#apDiv1').dialog('open');
	}
	
});


	//검색
	function search() {
		var strdt = $("input[name='sch_strdt']").val();
		var enddt = $("input[name='sch_enddt']").val();
	
		if(enddt < strdt)
		{
			alert('날짜를 다시 선택해주세요.');
			return false;
		}
	
		return true;
	};
	
	$(document).on("keypress",".schword",function(e){
        if(e.keyCode == 13)
        {
            var key = $('.schword').index($(this));
            $('.schbtn').eq(key).trigger('click');
            return false;
        }
    });
	
    function userSetData(arr)
    {
    	
    	var status = $("#appStatus").val();
    	
        if( $('.schword').eq(arr.key).siblings().hasClass('appeno') )
        {
            $("input[name='appeno']").val(arr.empno);
            $("input[name='appenm']").val(arr.name);
            $("input[name='appss']").val(arr.dept_nm);
            $("input[name='apptel']").val(arr.telno);
            $("input[name='appmail']").val(arr.empno+'@kepco.co.kr');
        }
        else if( $('.schword').eq(arr.key).siblings().hasClass('appueno') )
        {
            $("input[name='appueno']").val(arr.empno);
            $("input[name='appuenm']").val(arr.name);
        } 
        else if ($('.schword').eq(arr.key).siblings().hasClass('appueno_arr')) {
        	
        	var eu_mode = '';
        	if(status == '4'){
        		if(!confirm("선택된 장비를 ["+arr.name+"]님께 인수인계 하시겠습니까? \n해당 인수자에게 메일이 발송되고 승인되기 전까지 배정정보를 변경하실 수 없습니다.")){
        			/* $('#mem_list_layer').slideUp('fast').remove();
        			window.location.reload(); */
        			return false;
        		}
        		eu_mode = 'change_equipuser';
        	}else if(status == '3'){
        		if(!confirm("선택된 장비의 사용자를 ["+arr.name+"]님으로 수정하시겠습니까?")){
        			/* $('#mem_list_layer').slideUp('fast').remove();
        			window.location.reload(); */
        			return false;
        		}
        		eu_mode = 'edit_equipuser';
        	}
        	
        	var ingaeno = $('.schword').eq(arr.key).siblings("input[name='appueno_arr']").val();
        	var ingaenm = $('.schword').eq(arr.key).siblings("input[name='appuenm_arr']").val();
        	
        	$('.schword').eq(arr.key).siblings("input[name='appueno_arr']").val(arr.empno);
        	$('.schword').eq(arr.key).siblings("input[name='appuenm_arr']").val(arr.name);
        	
        	if(status == '3' || status == '4'){
        		
        		var mdseq = $('.schword').eq(arr.key).siblings("input[name='appueno_arr']").data("mdseq");
            	var eqno = $('.schword').eq(arr.key).siblings("input[name='appueno_arr']").data("eqno");
            	var uhseq = $('.schword').eq(arr.key).siblings("input[name='appueno_arr']").data("uhseq");
            	
            	var euseq = $('.schword').eq(arr.key).siblings("input[name='euseq_arr']").val();
            	var appno = $("#APPNO").val();

            	var data = { 'euseq': euseq, 
              	 	  'appno': appno, 
            	 	  'mdseq': mdseq, 
            	 	  'eqno': eqno, 
            	 	  'uhseq': uhseq,
            	 	  'mode': '1', 
            	 	  'eu_mode' : eu_mode,
            	 	  'insuno': arr.empno, 
            	 	  'insunm': arr.name, 
            	 	  'ingaeno': ingaeno, 
            	 	  'ingaenm': ingaenm, 
            	 	  'regeno': ingaeno, 
            	 	  'regenm': ingaenm };
            	
            	changeEquipUser(data);
        	} 
        }
        else if ($('.schword').eq(arr.key).siblings().hasClass('insuno')){
        	var eu_mode = '';
        	if(status == '4'){
        		if(!confirm("현재 모든 장비의 담당을 ["+arr.name+"]님께 인수인계 하시겠습니까? \n해당 인수자에게 승인여부메일이 발송됩니다.")){
        			$('#mem_list_layer').slideUp('fast').remove();
        			/* window.location.reload(); */
        			return false;
        		}
        		eu_mode = 'change_equipmanager';
        	}else if(status == '3'){
        		if(!confirm("장비 인수자를 ["+arr.name+"]님으로 수정하시겠습니까?")){
        			$('#mem_list_layer').slideUp('fast').remove();
        			/* window.location.reload(); */
        			return false;
        		}
        		eu_mode = 'edit_equipmanager';
        	}
        	
        	var ingaeno = $('.schword').eq(arr.key).siblings("input[name='insuno']").val();
        	var ingaenm = $('.schword').eq(arr.key).siblings("input[name='insunm']").val();
        	
        	$('.schword').eq(arr.key).siblings("input[name='insuno']").val(arr.empno);
        	$('.schword').eq(arr.key).siblings("input[name='insunm']").val(arr.name);
        	
        	if(status == '3' || status == '4'){
        		
        		var appno = $("#APPNO").val();

            	var data = { 'appno': appno,             	 	  
            	 	  'mode': '2', 
            	 	  'eu_mode' : eu_mode,
            	 	  'insuno': arr.empno, 
            	 	  'insunm': arr.name, 
            	 	  'ingaeno': ingaeno, 
            	 	  'ingaenm': ingaenm, 
            	 	  'regeno': ingaeno, 
            	 	  'regenm': ingaenm };
            	
            	changeEquipUser(data);
        	} 
        	
        }
        else if ($('.schword').eq(arr.key).siblings().hasClass('banpno')){
        	$('.schword').eq(arr.key).siblings("input[name='banpno']").val(arr.empno);
        	$('.schword').eq(arr.key).siblings("input[name='banpnm']").val(arr.name);
        }

        $('.schword').eq(arr.key).val(arr.name);
        $('#mem_list_layer').slideUp('fast').remove();
    }
    
    //신청자, 사용자 검색
    $(document).on("click",".schbtn",function(e){
    	
    	$('#mem_list_layer').slideUp('fast').remove();
        e.preventDefault();
        var obj = $(this);
        var schword = obj.siblings('.schword');
        
        if( !$.trim(schword.val()) )
        {
            alert('이름/사번을 입력하여 주십시요.');
            schword.focus();
            return false;
        }

        $.ajax({
            url : '/admin/searchMember.do',
            type : 'post',
            data : { 'mode':'search_member', 'keyword':$.trim(schword.val()) },
            success : function(data) {

                var parse_data = $.parseJSON(data).memberList;
                var data_len = parse_data.length;
                var arr = {};
                arr.key = $('.schbtn').index(obj);

                if(!data_len)
                {
                    alert('검색된 데이터가 없습니다.');
                    $("input[name='empno'], input[name='empnm'], input[name='deptnm'], input[name='keyword']").val('');
                    return false;
                }
                else if(data_len)
                {
                    var html = "<div id='mem_list_layer' style='right:10px;'><table width='350'>";
                    html += "<colgroup><col width='70' /><col width='50' /><col width='250' /></colgroup>";
                    html += "<tr id='_title'><th class='titbg'>사번</th>";
                    html += "<th class='titbg'>이름</th>";
                    html += "<th class='titbg'>소속</th></tr>";

                    $.each(parse_data, function() {
                        arr.empno = this.empno;
                        arr.name = this.name;
                        arr.dept_nm = this.dept_nm_depth1;
                        arr.telno = this.telno;

                        html += "<tr>";
                        html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.empno+"</a></td>";
                        html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.name+"</a></td>";
                        html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.dept_nm+"</a></td>";
                        html += "</tr>";
                    });

                    html += "</table></div>";
                    obj.after(html);
                    $('#mem_list_layer').slideDown();

                }
                else
                {

                    alert('검색된 데이터가 없습니다.');
                    obj.siblings('input').val('');
                    if( obj.siblings().hasClass('appeno') )
                    {
                        $("input[name='appss'], input[name='apptel'], input[name='appmail']").val('');
                    }
                    return false;

                }

            }

        }); //end of ajax

    });
	
    function changeEquipUser(data){
    	
    	
    	var status = $("#appStatus").val();
    	$('#loading').center().fadeIn();
    	$("#modal-background").css("display","block");
    	var insunm = data.insunm;
    	
    	$.ajax({
            url : '/admin/changeEquipUser.do',
            type : 'post',
            data : data,
            success : function(data) {
            	
             $('#loading').center().fadeOut();
           	
           	 if(status == '3'){
           		 if(data == 'true'){
           			alert("수정 되었습니다.");
           			window.location = window.location.pathname + "?modal_appno=" + $("#APPNO").val();
           			$("#modal-background").css("display","none");
           			 return;
           		 }else{
           			 alert("수정중 에러가 발생하였습니다");
           			$("#modal-background").css("display","none");
           			 return;
           		 }
           	 }
           	 if(status == '4'){
           		 if(data == 'true'){
           			 alert("인수자에게 메일을 발송하였습니다.");
           			 window.location = window.location.pathname + "?modal_appno=" + $("#APPNO").val();           			 
           			 return;
           		 }else if(data == 'false'){
           			 alert("인수자에게 메일발송도중 에러가 발생하였습니다.");
           			$("#modal-background").css("display","none");
           			 return;
           		 }
           		 
           		 if(data == 'cancel_true'){
           			alert("인수인계 진행이 취소되었습니다.");
           			window.location = window.location.pathname + "?modal_appno=" + $("#APPNO").val();
          			return;
           		 }else if(data == 'cancel_false'){
           			alert("인수인계 진행 취소 도중 에러가 발생하였습니다.");
           			$("#modal-background").css("display","none");
          			return;
           		 }
           	 }
           	
           	
            }
		 });
    	
    }
	
    function cancelChgEu(euseq, uhseq){
    	
    	var appno = $("#APPNO").val();
    	var eu_mode = 'cancel_equipuser';
    	
    	if(confirm('진행중인 인수인계를 취소하시겠습니까?')){
    		
    		var data = { 'euseq': euseq, 
            	 	  'appno': appno, 
          	 	  'uhseq': uhseq, 
          	 	  'eu_mode' : eu_mode,
          	 	   };
          	
          	changeEquipUser(data);
    		
    	}else{
    		return false;
    	}
    }
    
	function cancelChgEm(uhseq){
    	
		var appno = $("#APPNO").val();
    	var eu_mode = 'cancel_equipmanager';
    	
    	if(confirm('진행중인 인수인계를 취소하시겠습니까?')){
    		
    		var data = {'appno': appno, 
          	 	  'uhseq': uhseq, 
          	 	  'eu_mode' : eu_mode,
          	 	   };
          	
          	changeEquipUser(data);
    		
    	}else{
    		return false;
    	}
    }
	
	jQuery.fn.center = function () {
	    this.css("position","absolute");
	    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");
	    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	    return this;
	};
</script>
<c:import url="/resource/common/include/bottom.jsp" />