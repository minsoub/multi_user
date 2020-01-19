<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<script language="javascript">
function update(){
	
	var upmanagernm = $('#valchk1').val();
	var upmanagerno = $('#upmanagerno').val();
	var partmanagernm = $('#valchk2').val();
	var partmanagerno = $('#partmanagerno').val();
	   
	/* if( $.trim(upmanagernm) == '' || $.trim(upmanagernm) == null || $.trim(upmanagerno) == '' || $.trim(upmanagerno) == null )
	{
		alert('한전담당자가 지정되지 않았습니다.');
		$('#valchk1').focus();
		return false;
	}else if( $.trim(partmanagernm) == '' || $.trim(partmanagernm) == null || $.trim(partmanagerno) == '' || $.trim(partmanagerno) == null )
	{
		alert('한전파트장를 입력하여 주십시요.');
		$('#valchk2').focus();
		return false;
	} */
	
    if(confirm('저장하시겠습니까?')){
    	dataString = $("#frm").serialize();
    	
    	$.ajax({
   	       url: "/admin/notebookCheckUpdate.do",
   	       type: "POST",
   	       data: dataString,
   	       dataType: "json",
   	       success: function(msg) {
   				
   	    	   var tmp_result = $.trim(msg);
   	    	   
   	    	   if(tmp_result != 'false'){
   	    		   alert('저장 되었습니다.');
   	    			goList();
   	    		   return true;
   				}else{
   				   alert('오류가 발생했습니다. 관리자에게 문의하시기 바랍니다.');
   				   location.replace(location.href);
   	    		   return false;
   				}
   	 		}
   		});
    }
}
</script>
<body>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="3" var="left_depth_1"/>

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
                        <c:param name="left_depth_1" value="3"></c:param>
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
                    <div class="nav-title">보안조치현황</div>
                </div>
                
                <div class="basic-list">
            <form id="frm" name="frm" action="/admin/notebookCheckUpdate.do" method="post">
                <input type="hidden" name="appno" value="${view.APPNO}"/>
                <input type="hidden" name="eqno" value="${view.EQNO}"/>

                <div class="insrtfrom-framebox">
                <div class="insert-step1-box">
                    <div class="form-step1">
                        <fieldset>
                        <legend>보안조치현황 상세보기</legend>
                            <div class="row-group">
                                <dl class="insert_ready">
                                	<dt class="must-option" style="width:126px;"><label>대여일</label></dt>
                                    <dd style="width:240px">${cha:todate(view.strdt, '-', '3')}</dd>
                                    <dt class="must-option" style="width:126px;"><label>대여자</label></dt>
                                    <dd style="width:240px">${view.appenm}</dd>
                                </dl>
                                <dl class="insert_ready">
                                	<dt class="must-option" style="width:126px;"><label>반납일</label></dt>
                                    <dd style="width:240px">${cha:todate(view.strdt, '-', '3')}</dd> 
                                    <dt class="must-option" style="width:126px;"><label>반납자</label></dt>
                                    <dd style="width:240px">${view.banpnm}</dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option" style="width:126px;"><label>제조사/모델명</label></dt>
                                    <dd style="width:240px">${view.mdnm}</dd>
                                    <dt class="must-option" style="width:126px;"><label>관리번호</label></dt>
                                    <dd style="width:240px">${view.eqalias}</dd>
                                </dl>
                                <dl class="insert_ready">
	                                <dt class="must-option" style="width:126px;"><label>CMOS PW<br />설정여부</label></dt>
                                    <dd style="width:240px">
                                        <input type="radio" name="cmospwyn" value="Y" ${view.CMOSPWYN == "Y" ? "checked" : ""} /> Y
                                        <input type="radio" name="cmospwyn" value="N" ${view.CMOSPWYN == "N" ? "checked" : ""} style="margin-left: 50px;" /> N
                                    </dd>
	                                <dt class="must-option" style="width:126px;"><label>로그온 PW<br />설정여부</label></dt>
                                    <dd style="width:240px">
                                    	<input type="radio" name="logonpwyn" value="Y" ${view.LOGONPWYN == "Y" ? "checked" : ""} /> Y
                                        <input type="radio" name="logonpwyn" value="N" ${view.LOGONPWYN == "N" ? "checked" : ""} style="margin-left: 48px;" /> N
                                    </dd>
                                </dl>
                                <dl class="insert_ready">
                                	<dt class="must-option" style="width:126px;"><label>공유폴더<br />삭제여부</label></dt>
                                    <dd style="width:240px">
                                    	<input type="radio" name="sharefolderdelyn" value="Y" ${view.SHAREFOLDERDELYN == "Y" ? "checked" : ""} /> Y
                                        <input type="radio" name="sharefolderdelyn" value="N" ${view.SHAREFOLDERDELYN == "N" ? "checked" : ""} style="margin-left: 50px;" /> N
                                    </dd>
	                                <dt class="must-option" style="width:126px;"><label>주요문서<br />삭제여부</label></dt>
                                    <dd style="width:240px">
                                        <input type="radio" name="documentdelyn" value="Y" ${view.DOCUMENTDELYN == "Y" ? "checked" : ""} /> Y
                                        <input type="radio" name="documentdelyn" value="N" ${view.DOCUMENTDELYN == "N" ? "checked" : ""} style="margin-left: 48px;" /> N
                                    </dd>
								</dl>
								<dl class="insert_ready">
	                                <dt class="must-option" style="width:126px;"><label>운영체제<br />업데이트여부</label></dt>
                                    <dd style="width:240px">
                                        <input type="radio" name="osupdateyn" value="Y" ${view.OSUPDATEYN == "Y" ? "checked" : ""} /> Y
                                        <input type="radio" name="osupdateyn" value="N" ${view.OSUPDATEYN == "N" ? "checked" : ""} style="margin-left: 50px;" /> N
                                    </dd>
	                                <dt class="must-option" style="width:126px;"><label>V3백신<br />업데이트여부</label></dt>
                                    <dd style="width:240px">
                                    	<input type="radio" name="v3updateyn" value="Y" ${view.V3UPDATEYN == "Y" ? "checked" : ""} /> Y
                                        <input type="radio" name="v3updateyn" value="N" ${view.V3UPDATEYN == "N" ? "checked" : ""} style="margin-left: 48px;" /> N
                                    </dd>
                                </dl>
                                <%-- 
                                	대여관리자와 한전담당자는 변동이 빈번하지 않으므로 하드코딩으로 우선 진행함
                                	추후 문제 제기시 사람검색(인수자, 반납자 등등) 로직을 적용
                                	update() 함수에서 이름, 사번 validation 체크 한다. 2018 02 21. krh
                                --%>
                                <dl class="insert_ready">
                                    <dt class="must-option" style="width:126px;"><label>대여관리자</label></dt>
                                    <dd style="width:240px">
                                    	<c:if test="${view.MANAGERNM eq null}">
	                                    	<input type="text" id="managernm" name="managernm" value='오기영' readonly style="vertical-align:top; color:#787878; width:106px;border: 0px;" onfocus="this.blur();">
	                                    	<input type="hidden" id="managerno" name="managerno" value='ex190121'>
                                    	</c:if>
                                    	<c:if test="${view.MANAGERNM ne null}">
	                                    	<input type="text" id="managernm" name="managernm" value='${view.MANAGERNM}' readonly style="vertical-align:top; color:#787878; width:106px;border: 0px;" onfocus="this.blur();" >
	                                    	<input type="hidden" id="managerno" name="managerno" value='${view.MANAGERNO}'>
                                    	</c:if>
                                    </dd>
                                    <dt class="must-option" style="width:126px;"><label>한전담당자</label></dt>
                                    <dd style="width:240px" class="btn-zone">
                                    	<c:if test="${view.UPMANAGERNM eq null}">
	                                    	<input type="hidden" class="upmng" name="upmanagernm" id="upmanagernm" value="" />
		                                    <input type="hidden" name="upmanagerno" id="upmanagerno" value="" />
	                                        <input type="text" style="width: 50%" class="schword" id="valchk1" value="">
	                                        <input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색">
	                                    </c:if>
                                    	<c:if test="${view.UPMANAGERNM ne null}">
                                    		<input type="hidden" class="upmng" name="upmanagernm" id="upmanagernm" value="${view.UPMANAGERNM}" />
		                                    <input type="hidden" name="upmanagerno" id="upmanagerno" value="${view.UPMANAGERNO}" />
	                                        <input type="text" style="width: 50%" class="schword" id="valchk1" value="${view.UPMANAGERNM}">
	                                        <input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색">
	                                    </c:if>
                                    </dd>
                                </dl>
                                
                                <dl class="insert_ready">
                                    <dt class="must-option" style="width:126px;"><label>한전파트장</label></dt>
                                    <dd style="width:240px" class="btn-zone">
                                    	<c:if test="${view.MANAGERNM eq null}">
	                                    	<input type="hidden" class="partmng" name="partmanagernm" id="partmanagernm" value="" />
		                                    <input type="hidden" name="partmanagerno" id="partmanagerno" value="" />
	                                        <input type="text" style="width: 50%" class="schword" id="valchk2" value="" onkeyup="fnKeyUp(this)">
	                                        <input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색">
                                    	</c:if>
                                    	<c:if test="${view.MANAGERNM ne null}">
	                                    	<input type="hidden" class="partmng" name="partmanagernm" id="partmanagernm" value="${view.PARTMANAGERNM}" />
		                                    <input type="hidden" name="partmanagerno" id="partmanagerno" value="${view.PARTMANAGERNO}" />
	                                        <input type="text" style="width: 50%" class="schword" id="valchk2"  value="${view.PARTMANAGERNM}">
	                                        <input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색">
                                    	</c:if>
                                    </dd>
	                                <dt class="must-option" style="width:126px;">&nbsp;</dt>
                                    <dd style="width:240px">&nbsp;</dd>
                                </dl>
                                
                                <dl class="insert_ready">
                                    <dt class="must-option" style="width:126px;"><label>비고</label></dt>
                                    <dd><textarea class="textarea-style" rows="10" cols="88" id="bigo" name="bigo" style="width: 618px;">${view.BIGO}</textarea></dd>
                                </dl>
                    </div>
                    <div class="btn-zone">
                        <ul>
                            <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:update();" value="저장"></li>
                            <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:goList();" value="목록"></li>
                        </ul>
                    </div>
                </fieldset>


                </div>
            </div>
            </div>
            </form>
            </div>
            <!--content end-->
        </div>
    </div>
</div>
<form id="srhFrm" name="srhFrm" style="display: none;">
${srhFrm }
</form>
<script type="text/javascript">
function goList(){
	$('#srhFrm').attr('action','/admin/notebookCheckList.do').attr('method', 'post').attr('target', '_self').submit();
}

$(".schbtn").click(function(e) {
	searchMember(e, this);
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

$(document).on("keypress",".schword",function(e){
	if(e.keyCode == 13)
    {
        var key = $('.schword').index($(this));
        $('.schbtn').eq(key).trigger('click');
        return false;
    }
});

$(document).ready(function() {
	$('#valchk1').on('change',function(){
		if($.trim($(this).val()) != $.trim($('#upmanagernm').val())){
			$('#upmanagerno').val('');
			$('#upmanagernm').val('');
		}
	})
	
	$('#valchk2').on('change',function(){
		if($.trim($(this).val()) != $.trim($('#partmanagernm').val())){
			$('#partmanagerno').val('');
			$('#partmanagernm').val('');
		}
	})
});



</script>
<c:import url="/resource/common/include/bottom.jsp" />