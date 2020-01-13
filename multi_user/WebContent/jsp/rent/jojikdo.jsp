<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>조직도</title>
<style type="text/css">
A:link, A:visited,A:active		{ color:#767676 ;text-decoration:none;}
A:hover		{ color:#0014A4 ;text-decoration:underline}
BODY { scrollbar-3dlight-color:#595959;scrollbar-arrow-color:#7F7F7F;scrollbar-base-color:#CFCFCF;scrollbar-darkshadow-color:#FFFFFF;scrollbar-face-color:#DFDFDF;scrollbar-highlight-color:#FFFFFF;scrollbar-shadow-color:#595959;background-color:#FFFFFF;}
body, table, tr, td, select, textarea, input { FONT-SIZE: 12px; COLOR: #555555; LINE-HEIGHT: 130%; FONT-FAMILY: 굴림,Arial;}
IMG { border:0}
.cut-td {text-overflow:ellipsis;overflow:hidden;}
</style> 
<link rel="stylesheet" href="/resource/common/css/jquery.treeview.css" />

<script type="text/javascript" src="/resource/common/js/jquery-1.9.1.js"></script>
<script src="/resource/common/js/jquery.treeview.js" type="text/javascript"></script>
<script src="/resource/common/js/makeDeptStruct.js" type="text/javascript"></script>
</head>
<body leftmargin="7" topmargin="7" bgcolor="#FFFFFF">





<form name="jojik_form" method="get" action="/jojikdo.do">
<input type="hidden" name="mode" value="">
<input type="hidden" name="dcode" value="">
<input type="hidden" name="key" value="">
<input type="hidden" name="jojikdo" value="${jojikdo}">
<input type="hidden" name="deptno" value="${deptno}">


<div id="main">
	<div id="deptTreeDiv">
	    <ul id="deptTree" class="filetree treeview">
	    </ul>
    </div>
</div>

<!-- <input type="button" onclick="document.getElementById('0000').click();" value="test"/> -->



<%-- <table border="0" cellspacing="0" cellpadding="0">



<tr> 
	<td>
	<table border="1" cellspacing="0" cellpadding="0">
		<tr>
			<td width="15">${treeimg}</td>
			<td width="15"><img src="/resource/images/treeimg02.gif" border="0"></td>
			<td class="cut-td"><a href="JavaScript:parent.init();" onFocus="this.blur()"> ${dept_name}</a></td>
		</tr>
	</table>
	</td>
</tr>










<tr> 
	<td>
	<table border="1" cellspacing="0" cellpadding="0">
		<tr>
		<td width="10"></td>
		<td width="15"><a><img src="/resource/images/treeimg03.gif" border="0"></a></td>
		<td width="15"><a></a><img src="/resource/images/treeimg02.gif" border="0"></td>
		<td class="cut-td"><?=$deptname?></td>
		</tr>
	</table>
	</td>
</tr>






<tr>
	<td>
		<table border="1" cellspacing="0" cellpadding="0">
		<tr><td>부서정보가 없습니다.</td></tr>
		</table>
	</td>
</tr>




</table> --%>
</form>
<script type="text/javascript">
	
	deptLoad();	
	
	function deptLoad() {
	    makeDeptTree();
	}
	function treeviewLoad() {
	    $("#deptTree").treeview();
	}
	function getDeptList() {
		
	    $.ajax({
	        type : "post",
	        url : "/getDeptAllList.do",
	        data : "",
	        datatype : "json",
	        success : function(data) {

	            var list01 = data.deptList01;
	            var list02 = data.deptList02;
	            var userList01 = data.deptUserList01;
	            var userList02 = data.deptUserList02;
// 	            var list03 = data.deptList03;
// 	            var list04 = data.deptList04;
// 	            var list05 = data.deptList05;
// 	            var list06 = data.deptList06;
	            if (list01 != null){
	                if (list01.length > 0) {
	                    makeDeptTree01(list01);
	                }
	            }
	            if (userList01 != null){
	                if (userList01.length > 0) {
	                    makeEmpTree(userList01);
	                }
	            }
	            if (list02 != null){
	                if (list02.length > 0) {
	                    makeDeptTree02(list02);
	                }
	            }
	            if (userList02 != null){
	                if (userList02.length > 0) {
	                    makeEmpTree(userList02);
	                }
	            }
// 	            if (list03 != null){
// 	                if (list03.length > 0) {
// 	                    makeDeptTree03(list03);
// 	                }
// 	            }
// 	            if (list04 != null){
// 	                if (list04.length > 0) {
// 	                    makeDeptTree04(list04);
// 	                }
// 	            }
// 	            if (list05 != null){
// 	                if (list05.length > 0) {
// 	                    makeDeptTree05(list05);
// 	                }
// 	            }
// 	            if (list06 != null){
// 	                if (list06.length > 0) {
// 	                    makeDeptTree06(list06);
// 	                }
// 	            }
	            //makeDeptListFinish();
	            treeviewLoad();
	        }
	    });
	}
	
	function getDept3List(deptCd, thisObj) {
	    if(! thisObj.hasClass('inquired')) {
    	    $.ajax({
    	        type : "post",
    	        url : "/getDept3ListByCode.do",
    	        data : { deptCode: deptCd },
    	        datatype : "json",
    	        success : function(data) {
    	            var list03 = data.deptList03;
    	            if (list03 != null){
    	                if (list03.length > 0) {
    	                    makeDeptTree03(list03);
    	                }
    	            }
    	            var userList03 = data.deptUserList03;
    	            if (userList03 != null){
    	                if (userList03.length > 0) {
    	                    makeEmpTree(userList03);
    	                }
    	            }
                    thisObj.siblings(".deptTree02").treeview();
                    thisObj.addClass('inquired');
    	        }
    	    });
	    }
	}

	function getDept4List(deptCd, thisObj) {
	    if(! thisObj.hasClass('inquired')) {
    	    $.ajax({
    	        type : "post",
    	        url : "/getDept4ListByCode.do",
    	        data : { deptCode: deptCd },
    	        datatype : "json",
    	        success : function(data) {
    	            var list04 = data.deptList04;
    	            if (list04 != null){
    	                if (list04.length > 0) {
    	                    makeDeptTree04(list04);
    	                }
    	            }
    	            var userList04 = data.deptUserList04;
    	            if (userList04 != null){
    	                if (userList04.length > 0) {
    	                    makeEmpTree(userList04);
    	                }
    	            }
                    thisObj.siblings(".deptTree03").treeview();
                    thisObj.addClass('inquired');
    	        }
    	    });
	    }
	}

	function getDept5List(deptCd, thisObj) {
	    if(! thisObj.hasClass('inquired')) {
    	    $.ajax({
    	        type : "post",
    	        url : "/getDept5ListByCode.do",
    	        data : { deptCode: deptCd },
    	        datatype : "json",
    	        success : function(data) {
    	            var list05 = data.deptList05;
    	            if (list05 != null){
    	                if (list05.length > 0) {
    	                    makeDeptTree05(list05);
    	                }
    	            }
    	            var userList05 = data.deptUserList05;
    	            if (userList05 != null){
    	                if (userList05.length > 0) {
    	                    makeEmpTree(userList05);
    	                }
    	            }
                    thisObj.siblings(".deptTree04").treeview();
                    thisObj.addClass('inquired');
    	        }
    	    });
	    }
	}

	function getDept6List(deptCd, thisObj) {
	    if(! thisObj.hasClass('inquired')) {
    	    $.ajax({
    	        type : "post",
    	        url : "/getDept6ListByCode.do",
    	        data : { deptCode: deptCd },
    	        datatype : "json",
    	        success : function(data) {
    	            var list06 = data.deptList06;
    	            if (list06 != null){
    	                if (list06.length > 0) {
    	                    makeDeptTree06(list06);
    	                }
    	            }
    	            var userList06 = data.deptUserList06;
    	            if (userList06 != null){
    	                if (userList06.length > 0) {
    	                    makeEmpTree(userList06);
    	                }
    	            }
                    thisObj.siblings(".deptTree06").treeview();
                    thisObj.addClass('inquired');
    	        }
    	    });
	    }
	}

	function makeDeptListFinish () {
	    $("#spinner").fadeOut();
	    $("#deptTree").fadeIn();
	}

	function getDeptUserlist(deptCd) {
// 	    ajaxcall("<c:url value='/getDeptUserlist.do' />", "POST", "", { deptCode: deptCd }, receiveDeptUserList, "");
	}

	function receiveSearchUserList(data) {
	    if (data != null) {
	        var list = JSON.parse(data).searchUserList;
	        if (list.length > 0) {
	            if (list != null) {
	                var ol = document.createElement("ol");
	                ol.setAttribute("id", "userSelectAble");
	                ol.setAttribute("class", "userSelectAble selectable");
	                var li;
	                for (var i = 0; i < list.length; i++) {
	                    li = document.createElement("li");
	                    li.setAttribute("class", "dept" + idx);

	                    var input = document.createElement("input");
	                    input.setAttribute("type", "hidden");
	                    input.setAttribute("name", "empNo");
	                    input.setAttribute("value", list[i].empNo);

	                    var text = document.createTextNode(list[i].deptName +" "+ list[i].levelNm +" / "+ list[i].name);

	                    li.appendChild(input);
	                    li.appendChild(text);
	                    ol.appendChild(li);
	                }
	                $(".userSelect").empty();
	                $(".userSelect").append(ol);
	                selectableLoad(idx);
	            }
	        } else {
	            $(".userSelect").empty();
	        }
	    }
	}

	function receiveDeptUserList(data) {
	    if (data != null) {
// 	    	alert("testset");
	        var list = JSON.parse(data).deptUserList;
	        var code = JSON.parse(data).deptCode;
	        if (list.length > 0) {
	            if (list != null) {
	               /*  var ol = document.createElement("ol");
	                ol.setAttribute("id", "userSelectAble");
	                ol.setAttribute("class", "userSelectAble selectable");
	                var li;
	                for (var i = 0; i < list.length; i++) {
	                    li = document.createElement("li");
	                    li.setAttribute("class", "dept" + list[i].deptCode);

	                    var input = document.createElement("input");
	                    input.setAttribute("type", "hidden");
	                    input.setAttribute("name", "empNo");
	                    input.setAttribute("value", list[i].empNo);

	                    var text = document.createTextNode(list[i].deptName +" "+ list[i].levelNm +" / "+ list[i].name);

	                    li.appendChild(input);
	                    li.appendChild(text);
	                    ol.appendChild(li);
	                }
	                $(".userSelect").empty();
	                $(".userSelect").append(ol);
	                selectableLoad(code); */
	            }
	        } else {
	            $(".userSelect").empty();
	        }
	    }
	}

	function selectableLoad(code) {
	    var deptCd = code;
	    $(".userSelectAble").selectable({filter: "li"});
	    $(".memberSelectAble").selectable({filter: "li"});
	    $(".stepSelectAble").selectable({filter: "li"});
	}

	function userSelectUp() {
	    $("#memberSelectAble li.ui-selected").remove();
	}

	function userSelectDown() {
	    var availableConut = 20;
	    var item1List = $("#userSelectAble li.ui-selected");
	    if (item1List.length > 0) {
	        var item2List = $("#memberSelectAble li");
	        var item3List = $("#stepSelectAble li");
	        if (item2List.length < availableConut) {
	            for (var i = 0; i < item1List.length; i++) {
	                if ($("#memberSelectAble li").length < availableConut){
	                    var checkVal = true;
	                    var item1 = item1List[i].children;
	                    for (var j = 0; j < item2List.length; j++) {
	                        var item2 = item2List[j].children;
	                        //같은값이 있는지 체크
	                        if (item1[0].value == item2[0].value) {
	                            checkVal = false;
	                        }
	                    }
	                    for (var j = 0; j < item3List.length; j++) {
	                        var item3 = item3List[j].children;
	                        //같은값이 있는지 체크
	                        if (item1[0].value == item3[0].value) {
	                            checkVal = false;
	                        }
	                    }
	                    if (checkVal == true) {
	                        var cln = item1List[i].cloneNode(true);
	                        document.getElementById("memberSelectAble").appendChild(cln);
	                    }
	                }
	            }
	            $("#memberSelectAble li").removeClass("ui-selected");
	            $("#memberSelectAble li input").attr("name","memberEmpNo");
	        }
	    }
	}

	function memberSelectUp() {
	    var availableConut = 5;
	    var item1List = $("#stepSelectAble li.ui-selected");
	    if (item1List.length > 0) {
	        for (var i = 0; i < item1List.length; i++) {
	            if ($("#memberSelectAble li").length < availableConut){
	                document.getElementById("memberSelectAble").appendChild(item1List[i]);
	            }
	        }
	    }
	    $("#memberSelectAble li input").attr("name","memberEmpNo");
	}

	function memberSelectDown() {
	    var availableConut = 5;
	    var item1List = $("#memberSelectAble li.ui-selected");
	    if (item1List.length > 0) {
	        for (var i = 0; i < item1List.length; i++) {
	            if ($("#stepSelectAble li").length < availableConut){
	                document.getElementById("stepSelectAble").appendChild(item1List[i]);
	            }
	        }
	    }
	    $("#stepSelectAble li input").attr("name","stepEmpNo");
	}

	function frmSubmit() {
	    $("#membersInviteFrm").attr("action", '<c:url value="/saveShareMember.do" />');
	    $("#membersInviteFrm").attr("method", "post");
	    $("#membersInviteFrm").submit();
	    $("#membersInviteFrm").attr('onsubmit', 'return false;');
	    setTimeout("frmSubmitTrue()", 2000);
	}
	function frmSubmitTrue() {
	    $("#membersInviteFrm").attr('onsubmit', '');
	}
	
	function ajaxcall( url, method, datatype, paramdata, callback, error ){
	    if(error==null || error==""){
	        error=ajaxCallDefaultError;
	    }

	    //ajax 기본설정
	    $.ajax({
	        url: url,
	        type: method,
	        dataType: datatype,
	        data: paramdata,
	        success: callback,
	        error: error
	    });
	}

	function ajaxCallDefaultError(qXHR, status, thrownError){
	    openPopup("ajaxCallError - "+qXHR.status, getExceptionMessage(qXHR), "html");
	    //openPopup("ajaxCallError- "+qXHR.status, qXHR.responseText, "html");
	 }
	
</script>
</body>
</html>