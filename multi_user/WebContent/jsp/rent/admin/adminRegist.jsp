<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="8" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
    <div class="contents-framebox" id="contents_id">
        <!-- leftmenu -->
        <div class="contents-header-framebox">
        <div class="learn-tit-framebox">
            <c:import url="/resource/common/include/leftMenu_01.jsp">
                <c:param name="left_depth_1" value="8"></c:param>
                <c:param name="left_depth_2" value="5"></c:param>
                <c:param name="left_depth_3" value="5"></c:param>
            </c:import>
        </div>
        </div>
        <!-- leftmenu end-->

        <!--content-->
        <div class="contents-con-framebox">
            <div class="nav-box">
                <div class="nav-img"><img src="/resource/images/sub/sub8_tit_img.png"></div>
                <div class="nav-list">
                    <img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리메뉴</b>
                </div>
                <div class="nav-title">설정관리</div>
            </div>

            <div class="sub-nav-title">관리자 등록</div>

            <div class="searchArea_con">
                    <fieldset>
                    <div class="search-box">
                        <div class="form-group">
                            <legend>검색영역</legend>
                            <input type="text" class="schword" name="keyword" style="width: 180px;height:15px;margin-left: 8px;font-size:12px;color:#666;">
                            <input type="button" style="cursor: pointer;" class="search_btn schbtn" value="검색">

                            <div class="basic-list" style="font-size: 12px;">
                            <div id="mem_list_layer" style="display:none; overflow: auto; position: absolute; background-color: white; z-index: 100" >
                                <table width="460" border="0" cellpadding="0" cellspacing="1">
                                    <colgroup>
                                        <col width="100" />
                                        <col width="100" />
                                        <col width="300" />
                                    </colgroup>
                                    <tr id="_title">
                                        <th style="border-left: 1px solid #ddd; border-right: 1px solid #ddd; padding: 5px 0;">사번</th>
                                        <th class="titbg" style="border-left: 1px solid #ddd; border-right: 1px solid #ddd; padding: 5px 0;">이름</th>
                                        <th class="titbg" style="border-left: 1px solid #ddd; border-right: 1px solid #ddd; padding: 5px 0;">소속</th>
                                    </tr>
                                </table>
                            </div>
                            </div>

                        </div>
                    </div>
                    </fieldset>
            </div>

            <div class="basic-list">
            <form name="frm" method="post" action="/admin/insertAdmin.do" onsubmit="return check();">
                <div class="insrtfrom-framebox">
                <div class="insert-step1-box">
                    <div class="form-step1">
                        <fieldset>
                        <legend>장비신청</legend>
                            <div class="row-group">
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>사번</label></dt>
                                    <dd style="width: 230px;"><input type="text" name="empno"></dd>
                                    <dt class="must-option"><label>성명</label></dt>
                                    <dd style="width: 230px;"><input type="text" name="empnm"></dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>메일수신여부</label></dt>
                                    <dd style="width: 230px;">
                                    <input type="radio" name="get_mail" value="Y" class="checks small">
                                    <label>사용</label>
                                    <input type="radio" name="get_mail" value="N" class="checks small" checked="checked">
                                    <label>미사용</label>
                                    </dd>
                                    <dt class="must-option"><label>소속</label></dt>
                                    <dd style="width: 230px;"><input type="text" name="deptnm"></dd>
                                </dl>
                            </div>
                            <div class="btn-zone">
                                <ul>
                                    <li><input type="submit" class="search_btn" style="border:0 none;color:#fff;display:inline-block;font-weight:bold;position:relative;background-color:#0b4894;" value="저장"></li>
                                    <li><input type="button" style="width:52px;height:27px;" onclick="javascript:window.location='/admin/adminList.do';" value="목록"></li>
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
<script type="text/javascript">
$(document).ready(function() {
    load_fnc('4', '0', '0'); //menu script
    
    $(".schword").keypress(function(e) {
        if(e.keyCode == 13)
        {
            var key = $('.schword').index($(this));
            $('.schbtn').eq(key).trigger('click');
            return false;
        }
    });

    //신청자 검색
    $(".search_btn").click(function() {

        var obj = $("input[name='keyword']");

        if( !$.trim(obj.val()) )
        {
            alert('이름/사번을 입력하여 주십시요.');
            obj.val('').focus();
            return false;
        }

        $.ajax({
            url : '/admin/searchMember.do',
            type : 'post',
            data : {'keyword':$.trim(obj.val())},
            success : function(data) {

                var parse_data = $.parseJSON(data);
                var data_len = parse_data.memberList.length;
                /* 92111431 */

                var memList = parse_data.memberList;
                var arr = {};

                if(!data_len)
                {
                    alert('검색된 데이터가 없습니다.');
                    $("input[name='empno'], input[name='empnm'], input[name='deptnm'], input[name='keyword']").val('');
                    return false;
                }
                else if(data_len == 1)
                {
                    $("input[name='empno']").val(memList[0].empno);
                    $("input[name='empnm']").val(memList[0].name);
                    $("input[name='deptnm']").val(memList[0].dept_nm);
                }
                else if(data_len > 1)
                {
                    var html = '';
                    $.each(memList, function() {

                        arr.empno = this.empno;
                        arr.name = this.name;
                        arr.dept_nm = this.dept_nm;

                        html += "<tr>";
                        html += "<td class='mem_list_td' style='border-left: 2px solid #ddd; border-right: 2px solid #ddd; min-height:0; padding: 5px 0;'><a href='#' onclick='admSetData("+JSON.stringify(arr)+");'>"+this.empno+"</a></td>";
                        html += "<td class='mem_list_td' style='border-left: 2px solid #ddd; border-right: 2px solid #ddd; min-height:0; padding: 5px 0;'><a href='#' onclick='admSetData("+JSON.stringify(arr)+");'>"+this.name+"</a></td>";
                        html += "<td class='mem_list_td' style='border-left: 2px solid #ddd; border-right: 2px solid #ddd; min-height:0; padding: 5px 0;'><a href='#' onclick='admSetData("+JSON.stringify(arr)+");'>"+this.dept_nm+"</a></td>";
                        html += "</tr>";
                    });

                    $('#mem_list_layer table tr').not('#_title').remove();
                    $('#mem_list_layer table tr:last').after(html);
                    $('#mem_list_layer').slideDown();
                }

            }

        }); //end of ajax

    });


});

function admSetData(arr)
{
    $('input[name=empno]').val(arr.empno);
    $('input[name=empnm]').val(arr.name);
    $('input[name=keyword]').val(arr.name);
    $('input[name=deptnm]').val(arr.dept_nm);
    $('#mem_list_layer').slideUp('fast');
}

function check()
{
    if( !$.trim($("input[name='empno']").val()) )
    {
        alert('사번을 입력하세요.');
        $("input[name='empno']").focus();
        return false;
    }
    else if( !$.trim($("input[name='empnm']").val()) )
    {
        alert('성명을 입력하세요.');
        $("input[name='empnm']").focus();
        return false;
    }

    if(confirm('등록하시겠습니까?'))
    {
        return true;
    }
    else
    {
        return false;
    }
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />