<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="/resource/common/js/jquery.datetimepicker.full.min.js"></script>
<style>
	.imgSty{
	float: left;
	width: 17%;
}
</style>

<body>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="3" var="left_depth_1"/>

    <c:set var="empno" value="${sessionScope.SESS_EMPNO }"/>
    <c:set var="userNm" value="${sessionScope.SESS_USER_NAME }"/>
    <c:set var="dept_No" value="${sessionScope.SESS_USER_INFO['deptno'] }"/>

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
                        <c:param name="left_depth_3" value="4"></c:param>
                    </c:import>
                </div>
            </div>
            <!-- leftmenu end-->

            <!--content-->
        <div class="contents-con-framebox">
            <div class="nav-box">
                <div class="nav-img"><img src="/resource/images/sub/sub8_tit_img.png"></div>
                <div class="nav-list">
                    <img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">설비현황</b>
                </div>
                <div class="nav-title">설비현황</div>
            </div>

            <div class="sub-nav-title">장비신청</div>
			
            <div class="basic-list">
	            <form id="frm" name="frm" action="/admin/recUpdate.do" method="post" onsubmit="return check();" enctype="multipart/form-data" >
	            <input type="hidden" name="mode" value="recInsert" />
	            <input type="hidden" name="gbcdChk" id="gbcdChk" value="" />
					<div class="insrtfrom-framebox">
		                <div class="insert-step1-box">
		                    <div class="form-step1">
		                        <fieldset>
		                        <legend>장비신청</legend>
		                            <div class="row-group">
		                                <dl class="insert_ready">
		                                    <dt class="must-option"><label>신청부서</label></dt>
		                                    <dd style="width: 200px;"><input type="text" name="appss" readonly="readonly" value="${deptName}"></dd>
		                                    <dt class="must-option"><label>신청자</label></dt>
		                                    <dd class="btn-zone" style="width: 250px;">
		                                    <input type="hidden" name="appeno" class="appeno" value="${empno}">
		                                    <input type="hidden" name="appenm" class="appenm" value="${userNm}">
		                                    <input type="hidden" name="deptno" class="deptno" value="${dept_No}">
		                                    <input type="text" class="schword" value="${userNm}" style="width: 50%">
		                                    <input type="button" style="cursor: pointer; height:27px;"
		                                        class="search_btn schbtn" value="검색">
		                                    <span class="help">*이름/사번</span>
		                                    </dd>
		                                </dl>
		                                <dl class="insert_ready">
		                                    <dt class="must-option">
		                                        <label>연락처</label>
		                                    </dt>
		                                    <dd style="width: 200px;">
		                                        <input type="text" name="apptel" value="${telno}"></dd>
		                                    <dt class="must-option">
		                                        <label>E-MAIL</label>
		                                    </dt>
		                                    <dd style="width: 250px;">
		                                        <input type="text" name="appmail" value="${mailno}@kepco.co.kr">
		                                    </dd>
		                                </dl>
		
		                                <dl class="insert_ready">
		                                    <dt class="must-option">
		                                        <label>대여기간</label>
		                                    </dt>
		                                    <dd class="btn-zone">
		                                        <input type="text" name="strdt" readonly="readonly" style="width:91px;"/> ~
		                                        <input type="text" name="enddt" readonly="readonly" style="width:91px;"/>
		                                    </dd>
		                                    <!-- <dt class="must-option"><label>사용자</label></dt>
		                                    <dd class="btn-zone" style="width: 250px;">
		                                    <input type="hidden" name="appueno" class="appueno">
		                                    <input type="hidden" name="appuenm" class="appuenm">
		                                    <input type="text" class="schword" value="" style="width: 50%">
		                                    <input type="button" style="cursor: pointer; height:27px;"
		                                        class="search_btn schbtn" value="검색"> <span>*이름/사번</span>
		                                    </dd> -->
		                                </dl>
		
		                                <dl class="insert_ready">
		                                    <dt class="must-option"><label>신청정보</label></dt>
		                                    <dd>
		                                        <div style="width:600px" class="red-f">
		                                        * 모든장비 배정완료하지 않고 등록시 승인완료(배정) <br/>
		                                        * 모든장비 배정완료, 인수자, 인수일 입력시 반출 <br/>
		                                        * 모든장비 배정완료, 인수자, 인수일, 반납자, 반납일 입력시 반납완료
		                                        </div>
		                                        <div style="float:right">
		                                            <img class="cursor_pointer add_eq" src="/resource/images/sub/icon_plus.png">
		                                        </div>
		                                    </dd>
		                                    <dd>
		                                        <div class="basic-list1">
		                                            <table class="table02 tbl_equip" id="tbl_equip">
		                                                <colgroup>
		                                                    <col style="width: 22%">
		                                                    <col style="width: 35%">
		                                                    <col style="width: 23%">
		                                                    <col style="width: 10%">
		                                                    <col style="width: 16%">
		                                                </colgroup>
		                                                <thead>
		                                                    <tr>
		                                                        <th scope="col" class="like-td">장비구분</th>
		                                                        <th scope="col" class="like-td">모델명</th>
		                                                        <th scope="col" class="like-td">사용자</th>
		                                                        <th scope="col" class="ref-td">배정</th>
		                                                        <th scope="col" class="ref-td">배정/취소</th>
		                                                    </tr>
		                                                </thead>
		                                                <tbody>
		                                                    <tr class="app_tr">
		                                                        <td class="list01 gbcd">
		                                                            <div class="gbcdSel">
		                                                                <p class="inputDesign">
		                                                                    <select name="gbcd[]">
		                                                                        <option value="">...</option>
		                                                                        <c:forEach var="codeList" items="${codeList}">
		                                                                            <option value="${codeList.gbcd}">${codeList.gbnm}</option>
		                                                                        </c:forEach>
		                                                                    </select>
		                                                                </p>
		                                                            </div>
		                                                        </td>
		
		                                                        <td class="list02 model"></td>
		                                                        <td align="center" class="list02 amount"></td>
		                                                        <td align="center" class="list02 alloc_equip_num"></td>
		
		                                                        <td align="center" class="list02">
		                                                            <input type="hidden" name="allocEquip[]" class="alloc_equip" />
		                                                            <img alt=""
		                                                                class="cursor_pointer equip_alloc"
		                                                                src="/resource/images/btn/assign.png">
		                                                            <img alt=""
		                                                                class="cursor_pointer equip_del"
		                                                                src="/resource/images/btn/cancel1.png">
		                                                        </td>
		                                                    </tr>
		                                                </tbody>
		                                            </table>
		                                        </div>
		                                    </dd>
		                                </dl>
		                                <dl class="insert_ready" id="changeStatus">
		                                    <dt class="must-option"><label>노트북 사용용도</label></dt>
		                                    <dd>
												<input type="radio" id="ex_chk_1" name="rent_NB_Gubun" value="<c:out value="1" />"> 
												<label for="ex_chk_1"><c:out value="업무망(사내)" /></label>
												<input type="radio" id="ex_chk_2" name="rent_NB_Gubun" value="<c:out value="2" />"> 
												<label for="ex_chk_2"><c:out value="인터넷망(사내)" /></label>
												<input type="radio" id="ex_chk_3" name="rent_NB_Gubun" value="<c:out value="3" />"> 
												<label for="ex_chk_3"><c:out value="FA망[설비운영](사내)" /></label>
												<input type="radio" id="ex_chk_4" name="rent_NB_Gubun" value="<c:out value="4" />"> 
												<label for="ex_chk_4"><c:out value="인터넷(외부)" /></label> 
		                                    </dd>
		                                </dl>
		                                <dl class="insert_ready">
		                                    <dt class="must-option"><label>사용용도</label></dt>
		                                    <dd><input type="text" name="useobj" value="" style="width: 618px;"></dd>
		                                </dl>
		                                <dl class="insert_ready">
		                                    <dt class="must-option"><label>인수자</label></dt>
		                                    <dd class="btn-zone" style="width: 200px;">
		                                    	<input type="hidden" class="insuno" name="insuno" value="" />
			                                    <input type="hidden" id="insunm" name="insunm" value="" />
		                                        <input type="text" style="width: 50%" class="schword" value="">
		                                        <input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색">
		                                    </dd>
		                                    <dt class="must-option"><label>인수일</label></dt>
		                                    <dd style="width: 250px;"><input type="text" id="insudt" name="insudt" value="" readonly="readonly"></dd>
		                                </dl>
		                                <dl class="insert_ready">
		                                    <dt class="must-option"><label>반납자</label></dt>
		                                    <dd class="btn-zone" style="width: 200px;">
		                                    <input type="hidden" class="banpno" name="banpno" value="" />
		                                    <input type="hidden" id="banpnm" name="banpnm" value="" />
		                                    <input type="text" class="schword" style="width:50%" value="">
		                                    <input type="button" style="cursor: pointer; height:27px;" class="search_btn schbtn" value="검색">
		                                    </dd>
		                                    <dt class="must-option"><label>반납일</label></dt>
		                                    <dd style="width: 250px;">
		                                        <input type="text" id="banpdt" name="banpdt" readonly="readonly" >
		                                    </dd>
		                                </dl>
		
		                                <dl class="insert_ready">
		                                    <dt class="must-option"><label>비고(비공개)</label></dt>
		                                    <dd><textarea class="textarea-style" rows="10" cols="88" name="bigo" style="width: 618px;"></textarea></dd>
		                                </dl>
										 <dl class="insert_ready" id="changeStatus_1">
		                                    <dt class="must-option"><label>보안서약서 업로드</label></dt>
		                                    <dd><input type="file" name="file_attach" id="file_attach" value="" style="width: 618px;"></dd>
		                                </dl>
									</div>
				                    <div  class="filebox" >
										<label class="imgSty" style="background-color: #08a0ce; font-weight: bold; color: white;">
											<img alt="" src="/resource/images/sub/btn_download.png" style="width: 20%" > 보안 서약서 다운로드
										</label>
									</div>
				                    <div class="btn-zone">
				                        <ul>
				                            <li><input type="submit" class="search_btn" value="등록"></li>
				                            <li><input type="button" onclick="javascript:window.location='/admin/recList.do';" class="search_btn" value="목록"></li>
				                        </ul>
				                    </div>
		                		</fieldset>
		                	</div>
						</div>
		            </div>
	            </form>
            </div>
        </div>
        <!--content end-->
        </div>
    </div>

    <div class="popup_view_box view1" id="apDiv" style="display:none;">
    </div>
    <form id="securityDownForm" name="securityDownForm" method="post" ></form>
</body>

<script type="text/javascript">
$.fn.jqTransSelectRefresh = function(){
	   return this.each(function(index){
	      var $select = $(this);
	      var i=$select.parent().find('div,ul').remove().css('zIndex');
	      $select.unwrap().removeClass('jqTransformHidden').jqTransSelect();
	      $select.parent().css('zIndex', i);
	   });
	 }

    var code1 = $('#selectCode').val();
    var modal_eq = '';
    $(document).ready(function() {
        load_fnc('3', '0', '0'); //menu script

        $("input[name='banpdt']").datetimepicker({
            format:'Y-m-d H:i',
            defaultTime:'17:00',
            timepickerScrollbar:false
        });

        var searchVal = '${searchVal}';
        var searchValArr = searchVal.split(',');
        for(var i=0; i<searchValArr.length; i++ ){
            var codeVal = 'sch_' + searchValArr[i].substring(0, 6);
            var codeValReal = searchValArr[i];
            $('input:radio[name="'+codeVal+'"][value="'+codeValReal+'"]').prop('checked', true);
        }
        
        changeNB_Gubun();
    });

    $(window).load(function() {

        var orderBy = $("#orderBy").val();
        if (orderBy){
            if (orderBy.substring(0, 4) == 'best') {
                $('#bestOrderBy').css('color', 'royalblue');
            } else if (orderBy.substring(0,3) == 'lch') {
                $('#lchOrderBy').css('color', 'royalblue');
            }
        }

        $('.add_eq').click(function() {
            var idx = $('.add_eq').index($(this));
            var trIdx = $('.tbl_equip:eq(0) tr.app_tr').length;
            var eq_clone = $('.tbl_equip:eq('+idx+') tr.app_tr:eq('+(trIdx-1)+')').clone(); 
            $('.tbl_equip:eq('+idx+')').append(eq_clone);
            $('.tbl_equip:eq('+idx+') .gbcd:last select').val($('.tbl_equip:eq('+idx+') .gbcd:eq('+(trIdx-1)+') select').val()).jqTransSelect();
            
            if($('select[name="mdseq[]"]').length != 0){
            	$('.tbl_equip:eq('+idx+') .model:last select').val($('.tbl_equip:eq('+idx+') .model:eq('+(trIdx-1)+') select').val()).jqTransSelect();
            }
            
            //$('.tbl_equip:eq('+idx+') .gbcd:last option').removeAttr('selected');
            //$('.tbl_equip:eq('+idx+') .gbcd:last select').jqTransSelect();
            //$('.tbl_equip:eq('+idx+') .model:last, .tbl_equip:eq('+idx+') .amount:last').empty();
            
            $("select[name='gbcd[]']").jqTransSelectRefresh();
            $('.tbl_equip:eq('+idx+') .alloc_equip_num:last').empty();
            $('.tbl_equip:eq('+idx+') .alloc_equip:last').val('');

            eventInit();
        });

        //삭제
        $('.tbl_equip').on('click', 'tr .equip_del', function(e) {

            e.preventDefault();

            if( $(this).parents('table.tbl_equip').find('tr.app_tr').length < 2 )
            {
                return false;
            }
            var key = $('.equip_del').index($(this));
            $('.app_tr').eq(key).remove();
            changeNB_Gubun();

        });


        $("input[name='keyword1'], input[name='keyword2']").keypress(function(e) {
            if(e.keyCode == 13)
            {
                $(".search_btn2").trigger('click');
                return false;
            }
        });

        //배정
        $("#tbl_equip").on('click', "tr img.equip_alloc", function(e) {

            e.preventDefault();

            //모델과 수량은 동적생성
            //var mdseq = $(this).parent().siblings('.model').children().children().children('div').children('select').val();
            var idx = $(this).parents('tr.app_tr').index();
            var mdseq = $('select[name="mdseq[]"]:eq('+idx+')').val()
            var amount = $(this).parent().parent().children('.amount').children('.btn-zone').children("input[name='amount[]']").val();
            
            
            var strdt = $("input[name='strdt']").val();
            var enddt = $("input[name='enddt']").val();
            var alloc_equip = $('.alloc_equip').eq(idx).val();
            var disableEq = "";
            if(!mdseq || !amount || !strdt || !enddt)
            {
                alert('항목을 빠짐없이 선택해주세요.');
                return false;
            }
            
            var cnt = 0;
            $("select[name='mdseq[]'] option:selected").each(function(i){
            	if(alloc_equip != $(".app_tr .alloc_equip").eq(i).val() && $(".app_tr .alloc_equip").eq(i).val() != undefined){
            		if(cnt > 0){
            			disableEq += ",";
            		}
            		disableEq += $(".app_tr .alloc_equip").eq(i).val();
            		cnt++;
            	}
            });
            
            var param = 'mdseq='+mdseq+'&amount='+amount+'&strdt='+strdt+'&enddt='+enddt+'&idx='+idx+'&disableEq='+disableEq;
           
            if(alloc_equip)
            {
                param += '&allocEquip='+alloc_equip;
            }
            window.open('/admin/equipAllocationTemp.do?'+param, 'alloc', 'width=820px, height=400px, scrollbars=yes');

        });


        $(document).on("keypress",".schword",function(e){
        	if(e.keyCode == 13)
            {
                var key = $('.schword').index($(this));
                $('.schbtn').eq(key).trigger('click');
                return false;
            }
        });

        $("input[name='insudt'], input[name='strdt'], input[name='enddt']").datetimepicker({
            lang:'ch',
            timepicker:false,
            format:'Y-m-d'
        });


        /* $("input[name='banpdt']").datetimepicker({
            formatTime:'H:i',
            defaultTime:'17:00',
            timepickerScrollbar:false
        }); */

        eventInit();
});
    
    //신청자, 사용자 검색
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
                    if( obj.siblings().hasClass('appeno') )
                    {
                        $("input[name='appss'], input[name='apptel'], input[name='appmail']").val('');
                    }
                    return false;

                }

            }

        }); //end of ajax
    	
    }



    function eventInit() {
        $(".gbcdSel div ul li a").off('click', gbcdSelEvent);
        $(".mdseqSel div ul li a").off('click', mdseqSelEvent);
        $(".amountSel div ul li a").off('click', amountSelEvent);
        $(".gbcdSel div ul li a").on('click', gbcdSelEvent);
        $(".mdseqSel div ul li a").on('click', mdseqSelEvent);
        $(".amountSel div ul li a").on('click', amountSelEvent);
        $('.gbcdSel div.jqTransformSelectWrapper').css('width','120px');
    }
    

    function gbcdSelEvent(){

        var strdt = $("input[name='strdt']").val();
        var enddt = $("input[name='enddt']").val();
        var selbx = $(this).parent().parent().parent().children('select');
        if(!strdt || !enddt)
        {
            alert('대여기간을 선택하세요.');
            $("input[name='strdt']").focus();
            //$("select[name='gbcd[]'] option").eq(0).attr('selected','selected');  
            selbx.children('option').eq(0).attr('selected', 'selected');
            selbx.siblings('div').children('span').text('...');
            eventInit();
            return false;
        } 
        var idx = $("select[name='gbcd[]']").index(selbx);
        var gbcd = selbx.val();
        
        changeNB_Gubun();
        
        $('.app_tr .amount').eq(idx).empty().append('');
        $('.app_tr .model').eq(idx).empty().append('');
        $('.app_tr .alloc_equip_num').eq(idx).empty();
        $('.app_tr .alloc_equip').eq(idx).val('');


        $.ajax({
            url : '/rentLoad.do',
            type : 'post',
            data : {'mode':'load_model', 'gbcd':gbcd},
            success : function(data) {

                var html = '';
                if(data != 'error')
                {
                    var option = $.parseJSON(data);
                    if(option.length)
                    {
                        html = '<div class="mdseqSel">';
                        html += '<p class="inputDesign">';
                        html += "<select name='mdseq[]' style='width: 180px;'><option value=''>...</option>";
                        $.each(option, function() {
                            html += "<option value='"+this.mdseq+"'>"+this.mdnm+"</option>";
                        });
                        html += "</select>";
                        html += '</p>';
                    }
                }
                $('.app_tr .model').eq(idx).empty().append(html);
                $('.inputDesign').jqTransform();
            }, complete : function(data) {
                eventInit();
            }
        });
    }
    
    function mdseqSelEvent(){
    	
        var selbx = $(this).parent().parent().parent().children('select');
        var amountbx = $(this).parent().parent().parent().parent().parent().parent().parent().children('.amount');
        var th = selbx;
        var table_id = selbx.parents('table').attr('id');
        var mdseq = selbx.val();

        var idx = selbx.parents('tr.app_tr').index();
        var strdt = $("input[name='strdt']").val();
        var enddt = $("input[name='enddt']").val();
        var ymd = "${ymd}";
        $('.app_tr .alloc_equip_num').eq(idx).empty();
        $('.app_tr .alloc_equip').eq(idx).val('');
        
        /* var mdseq_key = $("select[name='mdseq[]']").index(selbx); */
        
        
        /* if( selbx && $('#'+table_id).find("select[name='mdseq[]'] option:selected[value="+mdseq+"]").length > 1 )
        {
            alert('이미 선택한 모델 입니다.');
            selbx.parent().siblings('.amount').children('select').remove();
            selbx.val('');
            return false;
        } */

        $.ajax({
            url : '/rentLoad.do',
            type : 'post',
            data : {'mode':'load_amount', 'mdseq':mdseq, 'strdt':strdt, 'enddt':enddt},
            success : function(data) {

                var html = '';
                if($("select[name='mdseq[]'] option:selected[value="+mdseq+"]").length > parseInt(data)){
                	alert("신청가능한 수량이 초과 되었습니다. \n가능신청수량 : 최대 " + data + "개");
                	selbx.children('option').eq(0).attr('selected', 'selected');
                    selbx.siblings('div').children('span').text('...');
                	amountbx.empty();
                	eventInit();
                	return false;
                }
                
                if(parseInt(data) > 0)
                {
                    /* html = '<div class="amountSel">';
                    html += '<p class="inputDesign">';
                    html += "<select name='amount[]' style='width: 60px;'><option value=''>...</option>";
                    for(var i = 1; i <= data; i++)
                    {
                        html += "<option value='"+i+"'>"+i+"</option>";
                    }
                    html += "</select>";
                    html += '</p>';
                    html += '</div>'; */
                    html = "<div class='btn-zone' style='float:none'>";
                    html += "<input type='hidden' name='amount[]' value='1'/>";
                    html += "<input type='hidden' class='appueno_arr' name='appueno_arr' value='${empno}'>";
                    html += "<input type='hidden' class='appuenm_arr' name='appuenm_arr' value='${userNm}'>";
                    html += "<input type='hidden' class='deptno_arr' name='deptno_arr' value='${dept_No}'>";
                    html += "<input type='hidden' class='dept_Nm1dept_arr' name='dept_Nm1dept_arr' value='${deptName}'>";
                    html += "<input type='text' class='schword' style='width: 60px;' value='${userNm}'> <input type='button' style='cursor: pointer; height:27px;' class='search_btn schbtn' onclick='searchMember(event, this)' value='검색'>";
                    html += "</div>";
                }
                th.parents('tr.app_tr').children('.amount').empty().append(html);
                $('.inputDesign').jqTransform();
                
                
            }, complete : function(data) {
                eventInit(); 
            }
        });
    }

    function amountSelEvent() {
        var selbx = $(this).parent().parent().parent().children('select');
        var idx = selbx.parents('tr.app_tr').index() - 1;
        $('.app_tr .alloc_equip_num').eq(idx).empty();
        $('.app_tr .alloc_equip').eq(idx).val('');
        eventInit();
    }

    function selectZindex() {
        var n = $('.jqTransformSelectWrapper').length;
        $(".jqTransformSelectWrapper").each(function(i) {
            $(this).css("z-index", n - i);
        });
    }

    function selectChanged() {
        $('.inputDesign').jqTransform();
        eventInit();
        //         $('select').jqTransSelect();
    }

    function userSetData(arr) {
        if ($('.schword').eq(arr.key).siblings().hasClass('appeno')) {
            $("input[name='deptno']").val(arr.deptno);
            $("input[name='appeno']").val(arr.empno);
            $("input[name='appenm']").val(arr.name);
            $("input[name='appss']").val(arr.dept_nm);
            $("input[name='apptel']").val(arr.telno);
            $("input[name='appmail']").val(arr.empno + '@kepco.co.kr');
        } else if ($('.schword').eq(arr.key).siblings().hasClass('appueno')) {
            $("input[name='appueno']").val(arr.empno);
            $("input[name='appuenm']").val(arr.name);
        } else if ($('.schword').eq(arr.key).siblings().hasClass('appueno_arr')) {
        	$('.schword').eq(arr.key).siblings("input[name='appueno_arr']").val(arr.empno);
        	$('.schword').eq(arr.key).siblings("input[name='appuenm_arr']").val(arr.name);
        	$('.schword').eq(arr.key).siblings("input[name='deptno_arr']").val(arr.deptno);
        	$('.schword').eq(arr.key).siblings("input[name='dept_Nm1dept_arr']").val(arr.dept_nm);
        } else if ($('.schword').eq(arr.key).siblings().hasClass('insuno')){
        	$('.schword').eq(arr.key).siblings("input[name='insuno']").val(arr.empno);
        	$('.schword').eq(arr.key).siblings("input[name='insunm']").val(arr.name);
        } else if ($('.schword').eq(arr.key).siblings().hasClass('banpno')){
        	$('.schword').eq(arr.key).siblings("input[name='banpno']").val(arr.empno);
        	$('.schword').eq(arr.key).siblings("input[name='banpnm']").val(arr.name);
        }

        $('.schword').eq(arr.key).val(arr.name);
        $('.deptno').eq(arr.key).val(arr.deptno);
        
        $('#mem_list_layer').slideUp('fast').remove();
    }

    //대여신청
    function check() {
        if (!$("#tbl_equip select[name='gbcd[]']").length) {
            alert('신청하신 데이터가 없습니다.');
            return false;
        }

        ch = false;
        $.each($("#tbl_equip select[name='gbcd[]']"), function(i) {

            if (!$(this).val() || !$("#tbl_equip select[name='mdseq[]']").eq(i).val() || !$("#tbl_equip input[name='amount[]']").eq(i).val()) {
                ch = true;
            }
        });
        if (ch) {
            alert('장비, 모델명, 신청수량을 빠짐없이 선택하세요.');
            return false;
        }
        
        var radioVal = $("input[name=rent_NB_Gubun]:checked").val();
        if($("#gbcdChk").val().indexOf("001") != '-1'){
	    	if(!radioVal){
	    		 alert('노트북 사용용도에 맞게 선택하세요.');
	             return false;
	    	}
        }

        if (!$.trim($("input[name='appss']").val())) {
            alert('신청부서를 입력하세요.');
            $("input[name='appss']").focus();
            return false;
        } else if (!$.trim($("input[name='appenm']").val())) {
            alert('신청자를 입력하세요.');
            $("input[name='appenm']").focus();
            return false;
        } else if (!$.trim($("input[name='apptel']").val())) {
            alert('연락처를 입력하세요.');
            $("input[name='apptel']").focus();
            return false;
        }
        var fileCheck = document.getElementById("file_attach").value;
        if($("#gbcdChk").val().indexOf("001") != '-1'){
	        if(!fileCheck){
	            alert("보안서약서를 첨부해주세요.");
	            return false;
	        }
        }
        
        if (confirm('신청하시겠습니까?')) {
            return true;
        } else {
            return false;
        }
    }
    
    $(".imgSty").on("click", function (){
 	   funGoPageDetailSetFrm("/contentsSecurityDown.do", "securityDownForm");
    })
    
	$("#file_attach").change(function(){
		if($(this).val() != ''){
			var ext = $(this).val().split(".").pop().toLowerCase();
			if($.inArray(ext, ["pdf","gif","png","jpg","jpeg"]) == -1 ){
				alert("pdf, gif, png, jpg, jpeg 파일만 업로드 가능합니다.");
				$(this).val('');
			}
		}
	})
   
	function changeNB_Gubun(){
	var add_arr = new Array;
	add_arr = [];
	var raioValue = '';
		$("select[name='gbcd[]']").each(function(){
			add_arr.push($(this).find('option:selected').val());
		});
		$("#gbcdChk").val(add_arr);
		$.each(add_arr, function (index, item){
			if(add_arr.indexOf("001") == '-1'){
				$("#changeStatus").hide();
				$("#changeStatus_1").hide();
				$("input[name=rent_NB_Gubun]").attr("disabled", true);
			}else{
				$("#changeStatus").show();
				$("#changeStatus_1").show();
				$("input[name=rent_NB_Gubun]").attr("disabled", false);
			}
		})
	}
    
</script>
<c:import url="/resource/common/include/bottom.jsp" />