<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<body>
    <form action="/admin/equipAllocationUpdate.do" method="post" onsubmit="return alloc_check();">

        <input type="hidden" name="appno" value="${appno}" />
        <input type="hidden" name="mdseq" value="${mdseq}" />
        <input type="hidden" name="euseq" value="${euseq}" />
        <input type="hidden" name="amount" value="${amount}" />

        <div class="contents-framebox" id="contents_id">

            <!--content-->
            <div id="popup" style="width: 760px; padding: 20px;">
                <div class="sub-nav-title" style="margin-top: 5px;">대여진행상태</div>
                <div class="basic-list">
                    <table class="alloc_tbl">
                        <colgroup>
                            <col width="20%" />
                            <col width="20%" />
                            <col width="*" />
                        </colgroup>

                        <thead>
                            <tr>
                                <th scope="col" class="no-td">신청번호</th>
                                <th scope="col" class="like-td">대여장비</th>
                                <th scope="col" class="like-td">대여장비</th>
                            </tr>
                        </thead>
                        <tbody>
							
                            <c:forEach var="listMap" items="${list}">
                                <c:set var="listMapVal" value="${listMap.value}" />
                                <tr>
                                    <td class="alloc_code tac">${listMapVal['name'] }</td>
                                    <c:if test="${not empty(listMapVal['sub'])}">
                                        <c:forEach var="subMap1" items="${listMapVal['sub']}" varStatus="idx1">
                                            <c:set var="subMap1Val" value="${subMap1.value}" />
                                            <td class="alloc_model tac">${subMap1Val['name'] }</td>
                                            <td class="alloc_equip" style="text-align: left;">
                                                <c:forEach var="subMap2" items="${subMap1Val['sub']}" varStatus="idx2">
                                                    <c:set var="subMap2Val" value="${subMap2.value}" />
                                                    <div style="width: 145px; display: inline-block;">
														<input type="checkbox" name="eqno[]" value="${subMap2Val['code']}"
														class="eqno ${ euseq ne usrMap[subMap2Val['code']] ? (usrMap[subMap2Val['code']] == null ? 'listEq' : 'searchEq') : 'selectEq'}" />
														${subMap2Val['name']}(${subMap2Val['eqalias']})
                                                    </div>
                                                    <c:if test="${idx2.count % 3 == 0}">
                                                        <br>
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                        </c:forEach>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            <c:if test="${fn:length(list) == 0}">
                                <tr>
                                    <td colspan='3' class='nodata'>등록된 데이터가 없습니다.</td>
                                </tr>
                            </c:if>
                        <tbody>
                    </table>
                    <br />

                    <div class="btn-zone" style="padding: 10px;">
                        <input type="submit" class="search_btn" value="저장" style="width: 50px;">
                    </div>


                </div>
            </div>
            <!--content end-->
        </div>
    </form>

    <br />
</body>


<script type="text/javascript">
    $(window).load(function() {
        $('.eqno').click(function() {
        	click_Chk();
        });
        list_Chk();
    });

    function list_Chk(){
    	var elist = ${elist};
    	var selectorEq = $('.selectEq').length;
    	$('input[name="eqno[]"]').each(function(i){
    		var searchEqno = parseInt($('input[name="eqno[]"]').eq(i).val());
    		if(selectorEq == 0){
        		$('.listEq').prop('disabled', false);
    		}else{
	    		$('.listEq').prop('disabled', true);
    		}
    		$('.searchEq').prop('disabled', true);
    		$('.searchEq').prop('checked', true);
    		if($.inArray(searchEqno, elist) != -1){
	    		$('.selectEq').prop('checked', true);
    		}
	   	});
    }
    
    function click_Chk(){
    	var clickChk = $('input:checkbox[name="eqno[]"]:checked').not('.searchEq').val();
    	var chkCount = $('input:checkbox[name="eqno[]"]:checked').not('.searchEq').length;
    	if(chkCount == 0){
    		$('input:checkbox[name="eqno[]"]').not(':checked').prop('disabled', false);
    	}else{
    		$('input:checkbox[name="eqno[]"]').not(':checked').prop('disabled', true);
    	}
    }
    
    
    /* function set_checked() {
        
    	var amount = "${amount}";
        
        //수량체크
        var checked = $('.chkAble:checked').map(function() {
            return $(this).val();
        }).get();

      	if (checked.length >= amount) {
            $('.eqno').not($('.eqno:checked')).attr('disabled', true);
            $('.exp').attr('disabled', true);
        } else {
            $('.eqno').attr('disabled', false);
            $('.exp').attr('disabled', true);
        } 
    } */

    function alloc_check() {

        var eqAmount = "${eqAmount}";
        var status = "${status}";
        
        //수량체크
        var checked = $('.eqno:checked').not(':disabled').map(function() {
            return $(this).val();
        }).get();        
        
        if (!checked.length) {
            alert('최소 한개이상 선택하세요.');
            return false;
        } else if (status == '4' && checked.length != eqAmount) {
            alert('신청 수량을 다시 확인해주세요.');
            return false;
        }

        if (confirm('저장하시겠습니까?')) {
            return true;
        } else {
            return false;
        }

    }
</script>