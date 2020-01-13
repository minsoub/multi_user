<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<body>
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
                        <c:param name="left_depth_1" value="8"></c:param>
                        <c:param name="left_depth_2" value="5"></c:param>
                        <c:param name="left_depth_3" value="8"></c:param>
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
                    <div class="nav-title">반출입대장</div>
                </div>
                <form id="frm" name="frm" method="post" action="/admin/notebookCheckList.do" onSubmit="return false;">
                <input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
                <input type="hidden" id="APPNO" name="APPNO"> 
                <input type="hidden" id="EQNO" name="EQNO">
                <input type="hidden" id="mng_Gbn" name="mng_Gbn" value="">
                <div class="searchArea_con" style="width:1000px;">
                    <fieldset>
                    <div class="search-box">
                        <div class="form-group">
                            <legend>검색영역</legend>
                            <select name="GBCD" onchange="javascript:checkList()" style="width:140px;">
                            	<option value="">전체</option>
                            	<option value="001" ${paging.GBCD == '001' ? 'selected' : ''}>NB - 대여용 노트북</option>
                            	<option value="018" ${paging.GBCD == '018' ? 'selected' : ''}>EB - 행사용 노트북</option>
                            </select>
                            <input type="text" name="sch_strdt" id="sch_strdt" readonly value='${sch_strdt}'
                            style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
                            ~
                            <input type="text" name="sch_enddt" id="sch_enddt" readonly value="${sch_enddt}"
                            style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
                            
                            <input type="text" name="sch_text" value="${sch_text}" style="width: 158px;height:15px;font-size:12px;color:#666;" placeholder="검색어를 입력하세요.">
                            <input type="button" style="cursor: pointer;" onclick="javascript:checkList();" class="search_btn" value="검색">
                            <input type="button" style="cursor: pointer; width: 70px;" onclick="javascript:funExportXls();" class="search_btn" value="엑셀저장">
                        </div>
                    </div>
                    </fieldset>
            	</div>
            	<div class="basic-list">
	            	<div class="insrtfrom-framebox">
		                <div class="insert-step1-box">
			                <div class="form-step1">
			                	<fieldset>
			                        <div class="row-group">
			                        	<dl class="insert_ready">
			                        		<dt class="must-option" style="width:100px;"><label>대여관리자</label></dt>
			                        		<dd style="width:100px">
		                                    	<input type="text" id="managernm" name="managernm" value='오기영' readonly style="vertical-align:top; color:#787878; width:106px;border: 0px;" onfocus="this.blur();">
		                                    	<input type="hidden" id="managerno" name="managerno" value='ex190121'>
			                        		</dd>
			                        		<dt class="must-option" style="width:100px;"><label>한전담당자</label></dt>
			                        		<dd style="width:150px" class="btn-zone">
			                        			<div class="up_mng">
				                        			<input type="hidden" class="upmng" name="upmanagernm" id="upmanagernm" value="" />
				                                    <input type="hidden" name="upmanagerno" id="upmanagerno" value="" />
			                                        <input type="text" style="width: 50%" class="schword" id="valchk1" value="">
			                                        <input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색">
			                        			</div>
			                        		</dd>
			                        		<dt class="must-option" style="width:100px;"><label>한전파트장</label></dt>
			                        		<dd style="width:150px" class="btn-zone">
			                        			<div class="part_mng">
				                        			<input type="hidden" class="partmng" name="partmanagernm" id="partmanagernm" value="" />
				                                    <input type="hidden" name="partmanagerno" id="partmanagerno" value="" />
			                                        <input type="text" style="width: 50%" class="schword" id="valchk2" value="" />
			                                        <input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색">
			                        			</div>
			                        		</dd>
			                        		<dd class="must-option btn-zone" style="width:100px;">
		                        				<input type="button" style="cursor: pointer; height:27px;" onclick="setRegistParts();" class="search_btn" value="저장">
	                        				</dd>
			                        	</dl>
			                        </div>
			                	</fieldset>
			                </div>
		                </div>
	                </div>
	            </div>
				<div id="tablelist" class="basic-list2" style="margin-top:5px;">
	                <table id="listTable" summary="">
	                    <caption>멀티미디어센터 보안조치현황</caption>
	                    <colgroup>
	                    	<col style="width:3%">
	                    	<col style="width:3%">
	                        <col style="width:8%">
	                        <col style="width:8%">
	                        <col />
	                        <col />
	                        <col style="width:7%">
	                        <col style="width:7%">
	                        <col style="width:7%">
	                        <col style="width:7%">
	                        <col style="width:7%">
	                        <col style="width:7%">
	                        <col style="width:8%">
	                        <col style="width:8%">
	                        <col style="width:7%">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                        	<th scope="col">
	                        		<input type="checkbox" id="all" />
	                        	</th>
	                        	<th scope="col">구분</th>
	                            <th scope="col">대여일<br />대여자</th>
	                        	<th scope="col">반납일<br />반납자</th>
	                            <th scope="col">제조사/모델명</th>
	                            <th scope="col">관리번호</th>
	                            <th scope="col">CMOS PW<br />설정여부</th>
	                            <th scope="col">로그온 PW<br />설정여부</th>
	                            <th scope="col">공유 폴더<br />삭제여부</th>
	                            <th scope="col">주요 문서<br />삭제여부</th>
	                            <th scope="col">운영체제<br />업데이트여부</th>
	                            <th scope="col">V3백신<br />업데이트여부</th>
	                            <th scope="col">대여관리자</th>
	                            <th scope="col">한전담당자</th>
	                            <th scope="col">한전파트장</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach var="notebookCheckList" items="${notebookCheckList}" varStatus="x">
	                        <tr onclick="javascript:funDetail('${notebookCheckList.APPNO}','${notebookCheckList.EQNO }');" style="cursor: pointer;">
	                        	<td onclick="event.cancelBubble = true;">
	                        		<input type="checkbox" name="appnos" id="appnos" value="${notebookCheckList.APPNO}, ${notebookCheckList.EQNO}"
	                        			${notebookCheckList.MANAGERNM ne null && notebookCheckList.MANAGERNM ne ''
	                        			&& notebookCheckList.UPMANAGERNM ne null && notebookCheckList.UPMANAGERNM ne ''
	                        			&& notebookCheckList.PARTMANAGERNM ne null && notebookCheckList.PARTMANAGERNM ne '' ? 'disabled="disabled"' : ''}
	                        		/>
	                        	</td>
	                        	<td>${notebookCheckList.gbcd == '001' ? 'NB' : 'EB'}</td>
	                            <td>${cha:todate(notebookCheckList.strdt, '-', '3')}<br />${notebookCheckList.appenm}</td>
	                        	<td>${cha:todate(notebookCheckList.enddt, '-', '3')}<br />${notebookCheckList.banpnm}</td>
	                            <td>${notebookCheckList.mdnm}</td>
	                            <td>${notebookCheckList.eqalias}</td>
	                            <td>${notebookCheckList.CMOSPWYN}</td>
	                            <td>${notebookCheckList.LOGONPWYN}</td>
	                            <td>${notebookCheckList.SHAREFOLDERDELYN}</td>
	                            <td>${notebookCheckList.DOCUMENTDELYN}</td>
	                            <td>${notebookCheckList.OSUPDATEYN}</td>
	                            <td>${notebookCheckList.V3UPDATEYN}</td>
	                            <td>${notebookCheckList.MANAGERNM}</td>
	                            <td>${notebookCheckList.UPMANAGERNM}</td>
	                            <td>${notebookCheckList.PARTMANAGERNM}</td>
	                        </tr>
	                        </c:forEach>
	                        <c:if test="${fn:length(notebookCheckList) == 0}">
	                        <tr>
	                            <td align="center" colspan="15">등록된 데이터가 없습니다.</td>
	                        </tr>
	                        </c:if>
	                    </tbody>
	                </table>
            	</div>
            	<div style="width:1000px;">
            	<c:import url="/resource/common/include/paging.jsp" />
            	</div>
            	</form>
            </div>
            <input type="hidden" id="user_data" name="user_data">
            <input type="hidden" id="user_appno" name="user_appno">
            <!--content end-->
            <div id="loading" style="display:none; position:absolute; left:150px; top:450px; text-align:center; width:100%; z-index:9999"><img src="/resource/images/pre-loader.gif" /></div>
        </div>
    </div>

    <div class="popup_view_box view1" id="apDiv" style="display:none;">
    </div>
</body>
<iframe id="ifrm" name="ifrm" style="display: none;" ></iframe> 
<script type="text/javascript" src="/resource/common/js/jquery.fileDownload.js"></script>
<script language="javascript">
$(document).ready(function() {
	 load_fnc('4', '0', '0'); //menu script
	 
    $("#sch_strdt, #sch_enddt").datepicker();

    $(document).on("keypress",".schword",function(e){
    	if(e.keyCode == 13)
        {
            var key = $('.schword').index($(this));
            $('.schbtn').eq(key).trigger('click');
            return false;
        }
    });

    $(".schbtn").click(function(e) {
    	searchMember(e, this);
    });

    /* 전체 체크부분 disabled */
	$('#all').prop('disabled', true);
    
    $('#all').bind('click',function(){
    	if($(this).is(':checked')){
    		$('input[name=appnos]:not(:disabled)').prop('checked', true);
    	}else{
    		$('input[name=appnos]:not(:disabled)').prop('checked', false);
	   		$('input[name="appnos"]').each(function(i){
				var upmanagerChk = $('tbody tr').eq(i).children().eq(13).text();
				var partChk = $('tbody tr').eq(i).children().eq(14).text();
				if((partChk != '' && partChk != null) && (upmanagerChk != '' && upmanagerChk != null)){
					$('tbody tr').eq(i).find('input[name="appnos"]').prop('disabled', true);
				} else {
					$('tbody tr').eq(i).find('input[name="appnos"]').prop('disabled', false);
				}
			});
   	    	$('#all').prop('disabled', true);
    	}
    })
    
    /* $('input[name=appnos]').bind('click', function(){
    	var chkCnt = $('input[name=appnos]:not(:disabled)').length;
    	if($('input[name=appnos]:checked:not(:disabled)').length == chkCnt){
    		$('#all').prop('checked', true);
    	}else{
    		$('#all').prop('checked', false);
    	}
    }) */
    
    /* 체크 클릭시 동적 작용 */
   	$('input[name="appnos"]').on("click",function(){
   		
   		var managerChk = $(this).parents('tr').children().eq(12).text();
   		var upmanagerChk = $(this).parents('tr').children().eq(13).text();
   		var partChk = $(this).parents('tr').children().eq(14).text();
   		
   		if($('input[name=appnos]:checked').length == 0){
   			if($('input[name=appnos]:disabled').length > 0){
	   	    	$('#all').prop('disabled', true);
	   	    }else{
	   	    	$('#all').prop('disabled', false);
	   	    }
   			$(".up_mng").find("input").prop("disabled", false);
		    $(".part_mng").find("input").prop("disabled", false);
   			$('input[name="appnos"]').each(function(i){
				var searchChk = $('tbody tr').eq(i).children().eq(14).text();
				if(searchChk != '' && searchChk != null){
					$('tbody tr').eq(i).find('input[name="appnos"]').prop('disabled', true);
				} else {
					$('tbody tr').eq(i).find('input[name="appnos"]').prop('disabled', false);
				}
			});
   		}else{
   			$('input[name="appnos"]').each(function(i){
				var mngsearch = $('tbody tr').eq(i).children().eq(12).text();
   				var upsearch = $('tbody tr').eq(i).children().eq(13).text();
   				var partsearch = $('tbody tr').eq(i).children().eq(14).text();
   				
				if(upmanagerChk != '') {
					$('#all').prop('disabled', false);
					//한전담당자 까지 등록된경우
					$(".up_mng").find("input").prop("disabled", true);
				    $(".part_mng").find("input").prop("disabled", false);
				    $("#mng_Gbn").val("part_mng");
				    $("#valchk1").val('');
				    $("#upmanagerno").val('');
				    $("#upmanagernm").val('');
					if(upsearch == '' || upsearch == null) {
						$('tbody tr').eq(i).find('input[name="appnos"]').prop('disabled', true);
					}
				} else if(managerChk != '') {
					$('#all').prop('disabled', false);
					//대여관리자 까지 등록된 경우
					$(".up_mng").find("input").prop("disabled", false);
					$(".part_mng").find("input").prop("disabled", true);
					$("#mng_Gbn").val("up_mng");
	   			 	$("#partmanagernm").val('');
				    $("#partmanagerno").val('');
				    $("#valchk2").val('');
					if((mngsearch != '' && mngsearch != null) && (upsearch != '' && upsearch != null)) {
						$('tbody tr').eq(i).find('input[name="appnos"]').prop('disabled', true);
					}else if(mngsearch == '' || mngsearch == null) {
						if(upsearch != null) {
							$('tbody tr').eq(i).find('input[name="appnos"]').prop('disabled', true);
						}
					}
				} else {
					$('#all').prop('disabled', false);
					//대여관리자도 없는 경우
					$(".up_mng").find("input").prop("disabled", true);
	   				$("#valchk2").val('');
	   				$("#upmanagerno").val('');
				    $("#upmanagernm").val('');
	   			    $(".part_mng").find("input").prop("disabled", true);
	   			 	$("#partmanagernm").val('');
				    $("#partmanagerno").val('');
				    $("#valchk2").val('');
					if(mngsearch != null && mngsearch != ''){
						$('tbody tr').eq(i).find('input[name="appnos"]').prop('disabled', true);
					}
				}
   			});
   		}
   	})
});

function searchMember(e, this_obj){
	e.preventDefault();

    var obj = $(this_obj);
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
            
            if(data_len)
            {
            	$('#mem_list_layer').remove();
                var html = "<div id='mem_list_layer'><table width='450'>";
                html += "<colgroup><col width='100' /><col width='100' /><col width='300 /></colgroup>";
                html += "<tr id='_title'><th height='30' class='titbg'>사번</th>";
                html += "<th class='titbg'>이름</th>";
                html += "<th class='titbg'>소속</th></tr>";

                $.each(parse_data, function() {
                	arr.deptno = this.deptno;
                    arr.empno = this.empno;
                    arr.name = this.name;
                    arr.dept_nm = (this.dept_nm_depth1 == '' ? this.dept_nm : this.dept_nm_depth1);
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
                return false;
            }
        }
    }); //end of ajax
	
}

function userSetData(arr) {
	
    if ($('.schword').eq(arr.key).siblings().hasClass('upmng')) {
        $("input[name='upmanagernm']").val(arr.name);
        $("input[name='upmanagerno']").val(arr.empno);
    } else if ($('.schword').eq(arr.key).siblings().hasClass('partmng')) {
        $("input[name='partmanagernm']").val(arr.name);
        $("input[name='partmanagerno']").val(arr.empno);
    }

    $('.schword').eq(arr.key).val(arr.name);
    
    $('#mem_list_layer').slideUp('fast').remove();
}

function funDetail(appno, eqno){
	$('#APPNO').val(appno);
	$('#EQNO').val(eqno);
	
	funSubmit('/admin/notebookCheckView.do');
}

function checkList(code, mode){
    var frm = document.frm;
	
    var strdt = $("#sch_strdt").val();
    var enddt = $("#sch_enddt").val();

    if( (strdt && !enddt) || (!strdt && enddt) )
    {
        alert('날짜를 모두 선택하세요.');
        return false;
    }
    if(strdt > enddt)
    {
        alert('검색날짜를 다시 선택하세요.');
        return false;
    }
    
    frm.target="_self";
    frm.action="/admin/notebookCheckList.do";
    frm.submit();
};

var xlsDown = true;

function funExportXls(){
	
	if(xlsDown){
		xlsDown = false;
		
		$('#frm').attr('action','/admin/checkExcelDownload.do').attr('method', 'post').attr('target', 'ifrm').submit();
		
		$.fileDownload($("#frm").prop('action'),{
			httpMethod: "POST",  
			data:jQuery("#frm").serialize(),   
			successCallback: function (url) {
				xlsDown = true;
			},
			failCallback: function(responesHtml, url){
				alert('다운로드 오류 발생. 관리자에게 문의 하시기 바랍니다.');
				xlsDown = true;
			}
		}); 
	}else{ 
		alert('${totalCnt}건 다운로드 진행 중 입니다.\n데이터 양이 많을수록 엑셀 처리 속도가 지연됩니다.(약 50건/초)\n화면 이동시 진행중인 다운로드는 취소됩니다.');
	}
}

function setRegistParts(){
	if($('input[name=appnos]:checked').length <= 0){
		alert('저장하실 항목을 선택해주세요.');
		return false;
	}
	
	if($("#mng_Gbn").val() == 'up_mng'){
		if($.trim($('#upmanagernm').val()) == '' || $.trim($('#upmanagerno').val()) == ''){
			alert('한전담당자를 선택해주세요.');
			return false;
		}
	}else if($("#mng_Gbn").val() == 'part_mng'){
		if($.trim($('#partmanagernm').val()) == '' || $.trim($('#partmanagerno').val()) == ''){
			alert('한전파트장을 선택해주세요.');
			return false;
		}
	}
	var checkVal_arry = new Array();
	$('input[name=appnos]:checked').each(function() {
		checkVal_arry.push(this.value);
    });
	jQuery.ajaxSettings.traditional = true;
	
	$.ajax({
        url : '/admin/notebookPartsUpdate.do',
        type : 'post',
        data : { 
        	'checkVal_arry' : checkVal_arry,
        	'managernm':$.trim($('#managernm').val()),
        	'managerno':$.trim($('#managerno').val()),
        	'upmanagernm':$.trim($('#upmanagernm').val()),
        	'upmanagerno':$.trim($('#upmanagerno').val()),
        	'partmanagernm':$.trim($('#partmanagernm').val()),
        	'partmanagerno':$.trim($('#partmanagerno').val())
        },
        success : function(data) {
        	if(data){
        		alert('저장되었습니다.')
        	}else{
        		alert('저장이 실패하였습니다.')
        	}
        	var f = document.frm;
        	f.action = '/admin/notebookCheckList.do';
        	f.submit();
        }
    }); //end of ajax
    
}
	
</script>
<c:import url="/resource/common/include/bottom.jsp" />