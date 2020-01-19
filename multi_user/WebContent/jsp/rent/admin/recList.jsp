<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<style>
    .tabList:hover{background-color: lightblue; cursor: pointer;}
</style>
<body>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="3" var="left_depth_1"/>

    <div id="contents" class="learn-frame-area">
        <div class="contents-framebox" id="contents_id">
            <!-- leftmenu -->
            <div class="contents-header-framebox">
                <div class="learn-tit-framebox">
                    <c:import url="/resource/common/include/leftMenu_01.jsp">
                        <c:param name="left_depth_1" value="3"></c:param>
                        <c:param name="left_depth_2" value="5"></c:param>
                        <c:param name="left_depth_3" value="2"></c:param>
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
                <div class="nav-title">접수현황</div>
            </div>
            
	        <div id="apDiv" style="display:none;">
	        	<div class="basic-list">
				<table id="ms_list">
					<colgroup>
						<col width="75px" />
						<col width="230px" />
						<col width="150px" />
						<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="no-td">구분</th>
							<th scope="col" class="like-td">발송메일/번호</th>
							<th scope="col" class="like-td">발송일시</th>
							<th scope="col" class="like-td">발송여부 (LOG)</th>
						</tr>
					</thead>
				</table>
				</div>
			</div>

            <form id="frm" name="frm" method="get" action="/admin/recList.do" onSubmit="return false;">
            <input type="hidden" id="gbcd" name="gbcd" value="${gbcd}"/>
            <input type="hidden" id="pageNo" name="pageNo" value="1"/>
            <input type="hidden" name="sch_return" id="sch_return" value="${sch_return}"/>
            <input type="hidden" id="appno" />
            <input type="hidden" id="rfid_empno" name="rfid_empno" value="${rfid_empno}" />
            <div class="searchArea_con" style="width:1000px;">
                    <fieldset>
                    <div class="search-box">
                        <div class="form-group">
                            <legend>검색영역</legend>
                            <div>
                                <p class="inputDesign">
                                <select name="sch_status">
                                    <option value="">전체</option>
                                    <c:forEach var="appstArr" items="${config.appstArr}" varStatus="x">
                                    <option value="${appstArr.key}" ${appstArr.key == sch_status ? "selected" : ""}>${appstArr.value}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div>
                                <p class="inputDesign">
                                <select name="sch_approval">
                                    <option value="">전체</option>
                                    <c:forEach var="approvalArr" items="${config.approvalArr}" varStatus="x">
                                    <option value="${approvalArr.key}" ${approvalArr.key == sch_approval ? "selected" : ""}>${approvalArr.value}</option>
                                    </c:forEach>
                                </select>
                            </div>


                            <input type="text" name="sch_strdt" id="sch_strdt" readonly value='${rentDto.sch_strdt}'
                            style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
                            ~
                            <input type="text" name="sch_enddt" id="sch_enddt" readonly value="${rentDto.sch_enddt}"
                            style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">


                            <img src="/resource/images/btn/qMark.png" style="margin-left: 8px;" title="신청자 OR 사용자 OR 인수자 OR 반납자 OR 사번 OR 설비별칭">
                            <input type="text" name="sch_text" value="${sch_text}" style="width: 158px;height:15px;font-size:12px;color:#666;" placeholder="검색어를 입력하세요." onkeydown="javascript:schKeyDown();">
                            <input type="text" name="sch_text2" value="${sch_text2}" style="width: 158px;height:15px;font-size:12px;color:#666;" placeholder="설비관리번호,신청번호, 자산번호" onkeydown="javascript:schKeyDown();">
                            <input type="button" style="cursor: pointer;" onclick="javascript:recList();" class="search_btn" value="검색">
                        </div>
                    </div>
                    </fieldset>
            </div>
            </form>

            <div class="basic-list2">
                <table id="listTable">
                    <caption>탭정보</caption>
                    <thead>
                        <tr>
                            <c:forEach var="codeList" items="${codeList}" varStatus="x">
                            <th scope="col" ${gbcd == (codeList.GBCD eq '000' ? 'all' : codeList.GBCD) ? 'style="background-color: lightblue; cursor: pointer;"' : 'class=tabList'} onclick="javascript:recList('${codeList.GBCD eq '000' ? 'all' : codeList.GBCD}')">${codeList.GBNM}<br/><span class="red-f">(${codeList.APPNO_CNT})</span></th>
                            </c:forEach>
                        </tr>
                    </thead>
                </table>
            </div>
            
            <div class="basic-list2" style="margin-top:5px;">
                <table id="listTable" summary="">
                    <caption>대여가능수</caption>
                    <colgroup>
                        <col style="width:10%">
                        <col style="width:18%">
                        <col style="">
                        <col style="width:18%">
                        <col style="">
                        <col style="">
                        <col style="">
                        <col style="width:10%">
                        <col style="width:12%">
                        <col style="width:10%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">신청번호</th>
                            <th scope="col">대여장비</th>
                            <th scope="col">설비수</th>
                            <th scope="col">대여기간</th>
                            <th scope="col">신청자</th>
                            <th scope="col">사용자</th>
                            <th scope="col">잔여기간</th>
                            <th scope="col">신청일</th>
                            <th scope="col">상태 </th>
                            <th scope="col">mail/sms</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="recList" items="${recList}" varStatus="x">
                        <tr onclick="javascript:funDetail('${recList.appno}');" style="cursor: pointer;">
                            <td title="${recList.preview}">${recList.appnum}</td>
                            <td title="${recList.preview}">${recList.gbnm}</td>
                            <td>${recList.amount}</td>
                            <td class="${recList.rec_class}">${fn:substring(recList.strdt,0,4)}.${fn:substring(recList.strdt,4,6)}.${fn:substring(recList.strdt,6,8)} ~ ${fn:substring(recList.enddt,0,4)}.${fn:substring(recList.enddt,4,6)}.${fn:substring(recList.enddt,6,8)}</td>
                            <td>${recList.appenm}</td>
                            <td>${recList.appuenm}</td>
                            <td><c:if test="${recList.remain ne ''}">${recList.remain}일</c:if></td>
                            <td>${fn:substring(recList.regdt,0,4)}.${fn:substring(recList.regdt,4,6)}.${fn:substring(recList.regdt,6,8)}</td>
                            <td>${recList.statusStr}
                            <c:if test="${recList.banpdt != null && recList.banpdt ne '' && recList.status == '6'}">
                            <br>
                    		<span class="blue-f">(${fn:substring(recList.banpdt,0,4)}.${fn:substring(recList.banpdt,4,6)}.${fn:substring(recList.banpdt,6,8)} ${fn:substring(recList.banpdt,8,10)}시)</span>
                    		</c:if>
                            </td>
                            <td onclick="event.cancelBubble=true;"><img class="cursor_pointer" src="/resource/images/btn/mailsms.png" onclick="javascript:msHistory('${recList.appno}')"></td>
                        </tr>
                        </c:forEach>
                        <c:if test="${fn:length(recList) == 0}">
                        <tr>
                            <td align="center" colspan="10">등록된 데이터가 없습니다.</td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            <div>
                <table width="100%" style="margin-top:10px;">
                        <tr>
                            <td>
                                <span class="bg_01" style="padding:5px;">승인전, 대여예정, 사용중, 반납예정, 반납건</span>
                                <span class="bg_02" style="padding:5px;">미반납건</span>
                                <span class="bg_03" style="padding:5px;">내일 대여예정</span>
                            </td>
                        </tr>
                    </table>
            </div>
            <div class="basic-list2">
                <c:import url="/resource/common/include/paging.jsp" />
	            <div>
	            	<span>사용자 화면 상태 : </span><span id="userscreen"></span>
	            </div>
                <div class="btn-zone">
                    <ul>
                        <li><input type="button" class="admin_btn" onclick="javascript:openUserRentalScreen('standby');" value="대기화면 팝업"></li>
                        <li><input type="button" class="admin_btn" onclick="javascript:openUserRentalScreen('tag');" value="사용자 신원 확인 팝업"></li>                       	
                        <li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:recList(null,'plan');" value="반납예정"></li>
                        <li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:recList(null,'no');" value="미반납"></li>
                        <li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:window.location='/admin/recList.do'" value="전체목록"></li>
                        <li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:window.location='/admin/recRegist.do'" value="등록"></li>
                    </ul>
                </div>
            </div>

        </div>
        <!--content end-->
        </div>
    </div>

</body>
<c:if test="${!empty msg}">alert("<spring:message code="${msg}" >");</spring:message></c:if>

<script type="text/javascript">

    var code1 = $('#selectCode').val();
    var modal_eq = '';

    $(document).ready(function() {
    	//$('#listTable tbody td').attr('title',"");
  
    	$(document).tooltip({
    	    content: function () {
    	        return $(this).prop('title');
    	    }
    	}); 
     	
        load_fnc('3', '0', '0'); //menu script

        $("#sch_strdt, #sch_enddt").datepicker();

        $('#apDiv').dialog({
            autoOpen : false,
            resizable : true,
            draggable : true,
            /* position : ['center', 'center'], */
            width : 620,
            height: 400,
            title : "반납 MAIL/SMS 발송내역 리스트",
            open : function() {
            	
            	var modal_appno = $("#appno").val();
            	
                if(!modal_appno)
                {
                    alert('error');
                    return false;
                }

                $.ajax({
                    url : '/admin/msHistory.do',
                    type : 'post',
                    dataType : 'json',
                    data : {'appno' : modal_appno},
                    success : function(data) {

                        var html = '';
                        var msList = data.msList;
                        
                        if(msList.length)
                        {
                            $.each(data.msList, function() {
                                html += "<tr class='newel'>";
                                html += "<td class='list01'>"+this.type+"</td>";
                                html += "<td align='center' class='list02'>"+this.sendms+"</td>";
                                html += "<td align='center' class='list02'>"+this.senddt+"</td>";
                                html += "<td align='center' class='list02'>"+this.etc+"</td>";
                                html += "</tr>";
                            });
                        }
                        else
                        {
                            html += "<tr class='newel'><td colspan='4' style='padding:5px; text-align:center; font-weight:bold;'>내역이 없습니다.</td></tr>";
                        }

                        $('#apDiv #ms_list tr.newel').remove();
                        $('#apDiv #ms_list tr:last').parent().append(html);

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

        
        $("#rfid_empno").on("input", function() {
        	console.log("rfid empno received");
        	
        	var _empno = $('#rfid_empno').val();
        	if (_empno.length == 8) {
        		console.log("{normal}empno input = " + _empno);
        	}	
        });
 });

    function schKeyDown() {
    	if (event.keyCode == 13)
    		recList();
    }

    function recList(code, mode){
        var frm = document.frm;

        var strdt = $("#sch_strdt").val();
        var enddt = $("#sch_enddt").val();

        if(code != undefined && code != null){
            $("#gbcd").val(code);
        }
        if(mode != undefined && mode != null && mode == 'no'){
            $("#sch_return").val("no");
        }
        if(mode != undefined && mode != null && mode == 'plan'){
            $("#sch_return").val("plan");
        }
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


        $("#pageNo").val("1");
        frm.submit();
    };
    
    function msHistory(appno){
    	$("#appno").val(appno);
    	$('#apDiv').dialog('open');
    }

	function funDetail(appno){       
		window.location="/admin/recView.do?appno=" + appno + "&rfid_empno=" + $('#rfid_empno').val();
	}


/*         var searchVal = '${searchVal}';
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

        var n = $('.jqTransformSelectWrapper').length;
        $(".jqTransformSelectWrapper").each(function(i) {
            $(this).css("z-index", n-i);
        });

    }); */
    
    var _showPopup;
    function openUserRentalScreen(val) {
    	var w = 1920;
    	var h = 1080;
    	var left = window.screenX + (screen.width / 2) - (w / 2);
    	var top = (screen.height / 2) - (h / 2);
    	  
   		_showPopup = window.open("/jsp/rent/admin/sign/userRentalScreen.jsp?" + val +"","_showPopup","width="+ w +", height="+ h +", top=" + top + " , left=" + left + "");
   		
   		_showPopup.blur();
   		
    }
</script>
<c:import url="/resource/common/include/bottom.jsp" />