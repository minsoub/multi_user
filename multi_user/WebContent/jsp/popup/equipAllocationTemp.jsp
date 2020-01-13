<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<body>

        <input type="hidden" name="appno" value="${appno}" />
        <input type="hidden" name="mdseq" value="${mdseq}" />
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
                                <th scope="col" class="like-td">대여장비 </th>
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
                                                           class="eqno ${allocEquip eq subMap2Val['code'] ? 'exp' : 'chkAble'}" />
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
                                    <td colspan='3' class='nodata'>대여 가능 장비가 없습니다.</td>
                                </tr>
                            </c:if>
                        <tbody>
                    </table>
                    <br />

                    <div class="btn-zone" style="padding: 10px;">
                        <input type="button" class="search_btn" id="go_alloc" value="저장" style="width: 50px;">
                    </div>


                </div>
            </div>
            <!--content end-->
        </div>

    <br />
</body>


<script type="text/javascript">
    $(document).ready(function() {
        $('.eqno').click(function() {
        	click_chk();
        });
        set_checked();
    });
    
    function click_chk(){
    	var chkCount = $('.eqno:checked').not(':disabled').length;
    	if(chkCount == 0){
    		$('input:checkbox[name="eqno[]"]').not(':checked').prop('disabled', false);
    	}else{
    		$('input:checkbox[name="eqno[]"]').not(':checked').prop('disabled', true);
    	}
    }
    function set_checked() {
    	var Listgubun = $('.exp').length;
        var amount = "${amount}";
        var allocEquip = "${allocEquip}";
        var disableEqArr = ${disableEqArr};
        var chkCount = $('.eqno:checked').not(':disabled').length;
        $('input[name="eqno[]"]').each(function(i){
        	var searchEqno = parseInt($('input[name="eqno[]"]').eq(i).val());
	        if(allocEquip == searchEqno ){
		        	$('input[name="eqno[]"]').eq(i).prop('checked', true);
	        }else if($.inArray(searchEqno, disableEqArr) != -1){
	        	$('input[name="eqno[]"]').eq(i).prop('checked', true);
	        	$('input[name="eqno[]"]').eq(i).prop('disabled', true);
	        }else{
	        	if(Listgubun == 0){
	        		$('input[name="eqno[]"]').eq(i).prop('disabled', false);
	        	}else{
	        		$('input[name="eqno[]"]').eq(i).prop('disabled', true);
	        	}
	        }
        });
    }
    
    $('#go_alloc').on('click', function() {

        var amount = "${amount}";
        var opener_idx = "${openerIdx}";

        //수량체크
        var checked = $('.eqno:checked').not(':disabled').map(function() {
            return $(this).val();
        }).get();

        if(!checked.length)
        {
            alert('신청 수량을 다시 확인해주세요.');
            return false;
        }

        $(opener.document).find('.alloc_equip_num:eq('+opener_idx+')').text(checked.length);
        $(opener.document).find('.alloc_equip:eq('+opener_idx+')').val(checked);
        self.close();

    });
    
</script>