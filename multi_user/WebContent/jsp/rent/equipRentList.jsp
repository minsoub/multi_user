<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<body>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="2" var="left_depth_1"/>

    <div id="contents" class="learn-frame-area">
        <div class="contents-framebox" id="contents_id">
            <!-- leftmenu -->
            <div class="contents-header-framebox">
                <div class="learn-tit-framebox">
                    <c:import url="/resource/common/include/leftMenu_01.jsp">
                        <c:param name="left_depth_1" value="8"></c:param>
                        <c:param name="left_depth_2" value="2"></c:param>
                    </c:import>
                </div>
            </div>
            <!-- leftmenu end-->

            <!--content-->
            <div class="contents-con-framebox">
                <div class="nav-box">
                    <div class="nav-img">
                        <img alt="" src="./resource/images/sub/sub8_tit_img.png">
                    </div>
                    <div class="nav-list">
                        <img alt=""
                            src="./resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b
                            style="color: #000000;">설비현황</b>
                    </div>
                    <div class="nav-title">설비현황</div>
                </div>

                <form id="frm" name="frm" method="post" action="/equipRentList.do"
                    onSubmit="return false;">
                    <input type="hidden" id="amount" name="amount" value="${amount}">
                    <input type="hidden" id="orderBy" name="orderBy" value="${orderBy}">
                    <input type="hidden" id="bestTxt" name="bestTxt" value="${bestTxt}">
                    <input type="hidden" id="lchTxt" name="lchTxt" value="${lchTxt}">
                    <input type="hidden" id="searchVal" name="searchVal" value="${searchVal}">
                    <input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">

                    <div class="searchArea_con">
                        <fieldset>
                            <div class="search-box">
                                <div class="form-group">
                                    <legend>검색영역</legend>
                                    <label style="font-size:22px; font-weight: bold; position:relative; top:4px;">설비명</label>&nbsp;
                                    <select id="selectCode" name="selectCode" style="width: 146px; text-align:center;">
		                                <c:forEach var="codeList" items="${codeList}" varStatus="x">
		                                <option value="${codeList.gbcd}" ${selectCode == codeList.gbcd ? "selected" : ""}>${codeList.gbnm}</option>
		                                </c:forEach>
		                            </select>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <label style="font-size:22px; font-weight: bold; position:relative; top:4px;">대여일</label>&nbsp;
                                    <input type="text" name="strdt" id="strdt" readonly value="${strdt}" style="width: 145px; height: 15px; font-size: 12px; color: #666; border-right-width: 0px; background-image: url('./resource/images/btn/down_01.png'); background-position: right; background-repeat: no-repeat;">&nbsp;&nbsp;&nbsp;&nbsp;
                                    <label style="font-size:22px; font-weight: bold; position:relative; top:4px;">반납일</label>&nbsp;
                                    <input type="text" name="enddt" id="enddt" readonly value="${enddt}" style="width: 145px; height: 15px; font-size: 12px; color: #666; border-right-width: 0px; background-image: url('./resource/images/btn/down_01.png'); background-position: right; background-repeat: no-repeat;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:btnSearFrm();" value="검색">
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </form>
<!--
                <div style="float: left">
                    <ul class="equip" style="width: 760px; display: block;">
                        <c:forEach items="${codeList}" var="codeList">
                            <c:if test="${selectCode eq codeList.gbcd}">
                                <li><a href="javascript:;" onclick="javascript:btnSearFrm('${codeList.gbcd}');" class="aHover">${codeList.gbnm}</a></li>
                            </c:if>
                            <c:if test="${selectCode ne codeList.gbcd}">
                                <li><a href="javascript:;" onclick="javascript:btnSearFrm('${codeList.gbcd}');">${codeList.gbnm}</a></li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
-->
<!--
                <div class="btn-zone" style="margin-top: -7px;">
                    <ul>
                        <li><input type="button"
                            name="srchDescription" class="search_btn"
                            onclick="javascript:btnSearFrm();" value="상세검색"
                            style="width: 80px;"></li>
                    </ul>
                </div>
 -->
                <div id="searchDetail" class="basic-list1">
                    <table id="listTable" summary="">
<!--                         등록된 상세 데이터가 없습니다. -->
                        <caption>상세검색</caption>
                        <c:set var="subTreeMapSize" value="${fn:length(subTreeMap)}" />
                        <c:if test="${subTreeMapSize == 0}">
                            <colgroup>
                                <col style="">
                            </colgroup>
                            <tr>
                                <th scope="col">등록된 상세 데이터가 없습니다.</th>
                            </tr>
                        </c:if>
                        <c:if test="${subTreeMapSize != 0}">
                            <colgroup>
                                <col style="width: 15%">
                                <col style="width: 15%">
                                <col style="">
                            </colgroup>

                            <c:set var="detailCount" value="0" />
                            <c:set var="firstValSize" value="2" />
                            <c:forEach items="${subTreeMap}" var="list">
                                <c:set var="firstKey" value="${list.key}" />
                                <c:set var="firstVal" value="${list.value}" />
                                <c:set var="firstSize" value="${fn:length(firstVal)}" />

                                <c:if test="${firstSize == 3}">
                                    <c:forEach items="${firstVal}" var="first" varStatus="firstRoop">
                                        <c:if test="${firstSize == 3}">
                                            <c:set var="firstValSize" value="${firstValSize + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${detailCount == 0}">
                                        <c:set var="detailCount" value="1" />
                                        <tr>
                                            <th scope="col" rowspan="<c:out value="${firstValSize}"/>" class="first">상세검색</th>
                                        </tr>
                                    </c:if>
                                    <tr>
                                        <th scope="col"><c:out value="${firstVal['gbnm']}"/></th>
                                        <td scope="col">
                                            <c:forEach items="${firstVal['sub']}" var="sub" varStatus="subRoop">
                                                <c:set var="subVal" value="${sub.value}" />

                                                <c:if test="${subRoop.first eq true}">
                                                    <span style="display: block; float: left; padding-left: 10px;">
                                                        <label style="vertical-align: middle;">
                                                            <input type="radio" class="checks small detail_search"
                                                               name="sch_<c:out value="${firstVal['gbcd']}"/>"
                                                               value="<c:out value="${firstVal['gbcd']}"/>"
                                                               checked="checked">
                                                        전체
                                                        </label>
                                                    </span>
                                                </c:if>
                                                <span style="display: block; float: left; padding-left: 10px;">
                                                    <label style="vertical-align: middle;">
                                                        <input type="radio" class="checks small detail_search"
                                                               name="sch_<c:out value="${firstVal['gbcd']}"/>"
                                                               value="<c:out value="${subVal['gbcd']}"/>">
                                                        <c:out value="${subVal['gbnm']}"/>
                                                    </label>
                                                </span>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </table>
                </div>
                <div style="padding: 10px 0;">
                    <span id="bestOrderBy" class="cursor_pointer">${bestTxt}</span>&nbsp;|&nbsp;
                    <span id="lchOrderBy" class="cursor_pointer">${lchTxt}</span>&nbsp;|&nbsp;
					<a href="javascript:;" onclick="javascript:showSearchDeatil();"><span id="controlSearchDetail">상세검색 열기</span></a>
                </div>

                <div class="basic-list">
                    <table id="listTable" summary="">
                        <caption>게시판 테이블</caption>
                        <colgroup>
                            <col style="width: 7%">
                            <col style="width: 15%">
                            <col style="">
                            <col style="width: 20%">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col" class="no-td">
                                    <div class="checks small">
                                        <input type="checkbox" id="model_all" name="model_all">
                                        <label for="model_all"></label>
                                    </div>
                                </th>
                                <th scope="col" class="like-td">장비</th>
                                <th scope="col" class="like-td">장비정보</th>
                                <th scope="col" class="like-td">수량</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:choose>
				        	<c:when test="${empty equipManageList}">
				        		<tr>
				        			<td colspan=4>대여가능한 설비 혹은 등록된 설비가 없습니다.</td>
				        		</tr>
				        	</c:when>
			        		<c:otherwise>
	                            <c:forEach items="${equipManageList}" var="equipList">
	                                <tr>
	                                    <td class="no-td">
	                                        <div class="checks small">
	                                            <input type="checkbox" id="model_num${equipList.mdseq}"
	                                                   class="model_num" name="model_num"
	                                                   value="${equipList.mdseq}">
	                                            <label for="model_num${equipList.mdseq}"></label>
	                                        </div>
	                                    </td>
	                                    <td class="like-td">
	                                        <c:if test="${equipList.imageUrl eq ''}">
	                                            <img alt="No Image" src="/resource/images/sub/noimg.png">
	                                        </c:if>
	                                        <c:if test="${equipList.imageUrl ne ''}">
	                                        	<img alt="model Image" src="<%= Constants.ASP_DOMAIN %>multi_user_jsp/rent/${fn:replace(equipList.imageUrl,'/OCFSFILES/data01/www/DATA/APPS/apply/rent/','')}" >
	                                        </c:if>
	                                        <img alt="상세보기" class="more_bt cursor_pointer" src="resource/images/btn/view.png"
	                                             mdseq="${equipList.mdseq}" mdNm="${equipList.mdnm}" style="padding-top: 5px;">
	                                    </td>
	                                    <td class="subject1">${equipList.item}</td>
	                                    <td class="like-td">
	                                        <form id="" name="" method="" onSubmit="" onkeypress="">
	                                            <div style="float: right">
	                                                <p class="inputDesign">
	                                                    <select name="sel_${equipList.mdseq}" id="sel_${equipList.mdseq}" style="z-index:500;">
	                                                        <c:forEach var="i" begin="1" end="${equipList.eqEnable}">
	                                                            <option value="${i}">${i}</option>
	                                                        </c:forEach>
	                                                    </select>
	                                                </p>
	                                            </div>
	                                        </form>
	                                    </td>
	                                </tr>
	                            </c:forEach>
                            </c:otherwise>
			        	</c:choose>
                        </tbody>
                    </table>
                </div>

                <div class="btn-zone">
                    <ul>
                        <li><input type="button" id="simul_reg"
                            name="srchDescription" class="search_btn"
                            value="신청하기" style="width: 80px;"></li>
                        <li><input type="button" id="simul_basket"
                            name="srchDescription2" class="search_btn"
                            onclick="javascript:void(0);" value="장바구니"
                            style="width: 80px;"></li>
                    </ul>
                </div>

            </div>
            <!--content end-->
            <div id="loading" style="display:none; position:absolute; left:150px; top:50%; text-align:center; width:100%; z-index:9999"><img src="/resource/images/pre-loader.gif" /></div>
        </div>
    </div>

    <div class="popup_view_box view1" id="apDiv" style="display:none;">
    </div>
</body>

<script type="text/javascript">
	$('#searchDetail').hide();
    var code1 = $("#selectCode option:selected").val();
    var modal_eq = '';
    $(document).ready(function() {
        load_fnc('4', '0', '0'); //menu script
        $("#strdt").datepicker();
        $("#enddt").datepicker();
        var searchVal = '${searchVal}';
        var searchValArr = searchVal.split(',');
        for(var i=0; i<searchValArr.length; i++ ){
            var codeVal = 'sch_' + searchValArr[i].substring(0, 6);
            var codeValReal = searchValArr[i];
            $('input:radio[name="'+codeVal+'"][value="'+codeValReal+'"]').prop('checked', true);
        }
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

//        var n = $('.jqTransformSelectWrapper').length;
//        $(".jqTransformSelectWrapper").each(function(i) {
//            $(this).css("z-index", n-i);
//        });

        $("#model_all").change(function () {
            $(".model_num").prop('checked', $(this).prop("checked"));
        });

        $("#bestOrderBy").on('click',function(){
            var txt = $("#bestOrderBy").text();
            if(txt == '베스트순▼') {
                $("#bestTxt").val('베스트순▲');
                $("#orderBy").val('bestDesc');
            } else {
                $("#bestTxt").val('베스트순▼');
                $("#orderBy").val('bestAsc');
            }
            btnSearFrm();
        });
        $("#lchOrderBy").on('click',function(){
            var txt = $("#lchOrderBy").text();
            if(txt == '출시년월순▼') {
                $("#lchTxt").val('출시년월순▲');
                $("#orderBy").val('lchDesc');
            } else {
                $("#lchTxt").val('출시년월순▼');
                $("#orderBy").val('lchAsc');
            }
            btnSearFrm();
        });

        $('#apDiv').dialog({
            autoOpen : false,
            resizable : true,
            draggable : true,
            width : 650,
            height: 470,
            open : function() {

                var mdseq = $('.more_bt').eq(modal_eq).attr('mdSeq');
                var mdnm = $('.more_bt').eq(modal_eq).attr('mdNm');
                if(!mdseq)
                {
                    alert('error');
                    return false;
                }
                $("span.ui-dialog-title").html("<span style='color:#fff;'>장비정보 - "+mdnm+"</span>");
                $('#apDiv').load('appPopView.do?gbcd='+code1+'&mdseq='+mdseq);

            },
            close : function() {
                $('#apDiv').empty();
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

        //데이터 상세보기
        $('.more_bt').click(function() {
            modal_eq = $('.more_bt').index($(this));
            $('#apDiv').dialog('open');
        });

        //다중선택신청, 담기
        $('#simul_reg, #simul_basket').click(function() {

            var strdt = document.frm.strdt.value;
            var enddt = document.frm.enddt.value;

            var val = $('.model_num:checked').map(function() {
                return $(this).val() + '::' + $('#sel_'+$(this).val()).val();
            }).get();


            if(!val.length)
            {
                alert('최소 한개이상 선택하세요.');
                return false;
            }
            else if(!strdt || !enddt)
            {
                alert('대여,반납기간을 검색후 선택하세요.');
                $("input[name='strdt']").focus();
                return false;
            }

            var mdseq = [],
            amount = [],
            split = [];
            var url = "equipRentRegist.do?";
            $.each(val, function(i) {
                split = this.split('::');
                mdseq.push(split[0]);
                amount.push(split[1]);
            });

            if($(this).attr('id') == 'simul_reg')
            {
                var url = "equipRentRegist.do?mdseq="+mdseq+"&amount="+amount;
                url += "&strdt="+strdt+"&enddt="+enddt;
                window.location.href = url;
            }
            else
            {

                if(confirm('선택한 모델을 장바구니에 저장하겠습니까?'))
                {

                    $.ajax({
                        url : '/basketUpdate.do',
                        type : 'post',
                        dataType : 'text',
                        data : {'mode' : 'update', 'mdseq' : mdseq.join(','), 'strdt' : strdt, 'enddt' : enddt, 'amount' : amount.join(',')},
                        success : function(data) {
                            if(data == 'success')
                            {
                                alert('장바구니 등록에 성공하였습니다.');
//                                 window.location.reload();
                                window.location.href = '/equipRentList.do';
                                return false;
                            }
                            else
                            {
                                alert('장바구니 등록에 실패하였습니다.');
                            }
                        }
                    });

                }

            }

        });
    });

    // 검색
    function btnSearFrm(selectCode) {
    	// 설비명
    	if ($("#selectCode option:selected").val() == '-1') {
            alert("검색할 설비명을 선택하여 주십시요.");
            return false;
        }
    	
    	$('#loading').fadeIn();
    	
        // 날짜 형식
        var today = new Date()
        thismonth = today.getMonth() + 1;
        thisyear = today.getFullYear();
        thisday = today.getDate();

        thismonth = "" + thismonth;
        if (thismonth.length == 1) {
            thismonth = "0" + thismonth;
        }
        thisday = "" + thisday;
        if (thisday.length == 1) {
            thisday = "0" + thisday;
        }
        // 오늘일시(200802141102)
        var strToday = thisyear + "-" + thismonth + "-"
                + thisday;
        var strdt = document.frm.strdt.value;
        var enddt = document.frm.enddt.value;

        if(!strdt || !enddt)
        {
            $('#loading').hide();
            alert('대여, 반납날짜를 빠짐없이 입력하세요.');
            $("input[name='strdt']").focus();
            return false;
        }
        else if(strdt < strToday || enddt < strToday)
        {
            $('#loading').hide();
            alert('검색일자를 오늘이후로 선택하세요.');
            return false;
        }
        else if(enddt < strdt)
        {
            $('#loading').hide();
            alert('날짜를 다시 선택해주세요.');
            $("input[name='strdt']").focus();
            return false;
        }
        else if(getDateTerm(strdt, enddt, 'day') >= 365)
        {
            $('#loading').hide();
            alert('1년이상 대여할수 없습니다.\n\n관리자에게 문의하세요.');
            $("input[name='enddt']").val(new Date().format('yyyyMMdd'));
            return false;
        }
        var search_val = $('.detail_search:checked').map(function() {
            return $(this).val();
        }).get();
        if(search_val.length)
        {
            $("#searchVal").val(search_val);
        }
        if (strdt !== "") {
            // 시작일자
            if (CheckStr(strdt, " ", "") == 0
                    || document.frm.strdt.value.length < 10
                    || document.frm.strdt.value.indexOf("-") == -1) {
                $('#loading').hide();
                alert("대여일자를 날짜 형식으로 입력 하십시오.\n\n( 예 : "
                        + strToday + " )");
                document.frm.strdt.focus();
                return false;
            }
        }
        // 게시종료일시
        if (CheckStr(enddt, " ", "") == 0
                || document.frm.enddt.value.length < 10
                || document.frm.enddt.value.indexOf("-") == -1) {
            $('#loading').hide();
            alert("반납일자를 날짜 형식으로 입력 하십시오.\n\n( 예 : " + strToday
                    + " )");
            document.frm.enddt.focus();
            return false;
        }
        if (document.frm.enddt.value < document.frm.strdt.value) {
            $('#loading').hide();
            alert("조건의 대여일이 반납일보다 전일 수 없습니다.");
            document.frm.enddt.focus();
            return false;
        }

        funFrmPagingSubmit();
        return true;
    }
    
    function showSearchDeatil() {
    	if($("#searchDetail").css("display") == "none"){
    		$('#controlSearchDetail').html("상세검색 닫기");
            $('#searchDetail').show();  
        } else {
        	$('#controlSearchDetail').html("상세검색 열기");
            $('#searchDetail').hide();  
        } 
    }
</script>
<c:import url="/resource/common/include/bottom.jsp" />