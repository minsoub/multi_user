<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div id="contents" class="learn-frame-area">
    <div class="contents-framebox" id="contents_id">
        <!--content-->
        <div class="contents-con-framebox" style="padding: 13px;">
            <div class="sub-nav-title" style="margin-top: 20px;">결재선 관리</div>

            <div class="basic-list" style="width: 580px;">
	            <form id="frm" name="frm" method="post">
	            	<table style="width:580px;margin-top: 10px;margin-bottom:15px; border: solid 1px #ddd">
	            		<tr>
	            			<td style="border-right: solid 1px #ddd">점검자</td>
	            			<td style="border-right: solid 1px #ddd">파트장</td>
	            			<td>부서장</td>
	            		</tr>
	            		<tr style="height: 100px;">
	            			<td style="border-right: solid 1px #ddd">
	            				<input type="hidden" id="app_empno1" name="app_empno1" value="${appList.app_empno1 }" />
	            				<input type="text" id="app_emp_name1" name="app_emp_name1" value="${appList.app_emp_name1 }" onclick="$('#mem_list_layer').slideUp('fast').remove();" onkeypress="javascript:funEnter(this,event);" />
	            				<span class="btn-zone"><input type="button"  style="cursor: pointer; height: 30px; width: 48px; margin-right: 5px;" class="search_btn schbtn" value="검색"></span>
	            			</td>
	            			<td style="border-right: solid 1px #ddd">
	            				<input type="hidden" id="app_empno2" name="app_empno2" value="${appList.app_empno2 }" />
	            				<input type="text" id="app_emp_name2" name="app_emp_name2" value="${appList.app_emp_name2 }" onclick="$('#mem_list_layer').slideUp('fast').remove();" onkeypress="javascript:funEnter(this,event);" />
	            				<span class="btn-zone"><input type="button"  style="cursor: pointer; height: 30px; width: 48px; margin-right: 5px;" class="search_btn schbtn" value="검색"></span>
	            			</td>
	            			<td>
	            				<input type="hidden" id="app_empno3" name="app_empno3" value="${appList.app_empno3 }" />
	            				<input type="text" id="app_emp_name3" name="app_emp_name3" value="${appList.app_emp_name3 }" onclick="$('#mem_list_layer').slideUp('fast').remove();" onkeypress="javascript:funEnter(this,event);" />
	            				<span class="btn-zone"><input type="button"  style="cursor: pointer; height: 30px; width: 48px; margin-right: 5px;" class="search_btn schbtn" value="검색"></span>
	            			</td>
	            		</tr>
	            	</table>
	            	<div id="srh_member"></div>
          			<div class="btn-zone">
                        <ul>
                            <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funSave();" value="저장"></li>
                            <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:window.self.close();" value="닫기"></li>
                        </ul>
                    </div>
	            </form>
            </div>
        </div>
        <!--content end-->
    </div>
</div>
<script type="text/javascript">
//신청자, 사용자 검색
$(".schbtn").click(function(e) {
	
	$('#mem_list_layer').slideUp('fast').remove();
    e.preventDefault();
    var obj = $(this);
    
    var schword = $(this).parent().prev();
    
    if( !$.trim(schword.val()) )
    {
        alert('이름/사번을 입력하여 주십시요.');
        schword.focus();
        return false;
    }else{
    	//app_empno 초기화
    	$(schword).prev().val('');
    }

    $.ajax({
        url : '/admin/searchMember.do',
        type : 'post',
        data : { 'mode':'search_member', 'keyword':$.trim(schword.val()) },
        success : function(data) {

            var parse_data = $.parseJSON(data).memberList;
            var data_len = parse_data.length;
            var arr = {};

            if(data_len){ 
                var html = "<div id='mem_list_layer'><table width='580'>";
                html += "<colgroup><col width='100' /><col width='100' /><col width='380' /></colgroup>";
                html += "<tr id='_title'><th class='titbg'>사번</th>";
                html += "<th class='titbg'>이름</th>";
                html += "<th class='titbg'>소속</th></tr>";

                $.each(parse_data, function() {
                    arr.empno = this.empno;
                    arr.name = this.name;
                    arr.dept_nm = this.dept_nm_depth1;
                    arr.telno = this.telno;

                    html += "<tr>";
                    html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+","+ $('.schbtn').index(obj)+");'>"+this.empno+"</a></td>";
                    html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+","+ $('.schbtn').index(obj)+");'>"+this.name+"</a></td>";
                    html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+","+ $('.schbtn').index(obj)+");'>"+this.dept_nm+"</a></td>";
                    html += "</tr>";
                });

                html += "</table></div>";
                $('#srh_member').html(html);
                $('#mem_list_layer').slideDown();

            }else{
            	alert('검색된 데이터가 없습니다.');
                $('#app_empno' + arr.key).val('');
                $('#app_emp_name' + arr.key).val('');
                return false;
            }
        }
    }); //end of ajax
});

function userSetData(arr, idx){
	$('#app_empno' + (idx + 1)).val(arr.empno);
    $('#app_emp_name' + (idx + 1)).val(arr.name);
    $('#mem_list_layer').slideUp('fast').remove();
}

function funEnter(obj, e){
	if(e.keyCode == 13){
		$(obj).next().children().trigger('click');
	}
}

function funSave(){
	
	var chkTF = true;
	
	for(var i = 1; i < 4; i++){
		if($.trim($('#app_empno' + i).val()) == ''){
			alert('누락된 정보가 있습니다. 결재선을 확인하시기 바랍니다.');
			$('#app_empno' + i).focus();
			chkTF = false;
			break;
		}
	}

	if(chkTF){
		if(confirm('설정하신 결재선으로 저장하시겠습니까?')){
			
			dataString = $("#frm").serialize();
			
			$.ajax({
		        url : '/admin/insertCheckAppManage.do',
		        type: "POST",
		        data: dataString,
		        dataType: "html",
		        success: function(msg) {
		        	
		           var tmp_result = $.trim(msg);
		           
		    	   if(tmp_result != 'false'){
					   alert('저장 되었습니다.');
					   opener.location.replace(opener.location.href);
					   window.self.close();
		    		   return true;
					}else{
		    		   alert("오류가 발생 했습니다");
		    		   return false;
					}
		        }
			});
		}
	}
}
</script>