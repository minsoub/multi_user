<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>결재선지정</title>
<link href="/resource/common/css/jojikdo.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/resource/common/js/jquery-1.9.1.js"></script>
<script language="javascript" src="/resource/common/js/jojikdo.js"></script>
</head>
<body topmargin=12 leftmargin=10>


<table width="550" cellpadding=0 cellspacing=0 border=0 onLoad="document.pre_form.key.focus()">
<tr>
	<td nowrap width="240" valign=top>
	<table width="100%" cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td style="padding-left:5px"><img src="/resource/images/decideline_tt.gif"></td>
	</tr>
	<tr>
		<td height=4></td>
	</tr>
	<tr>
		<td height=2 bgcolor=E4E4E4></td>
	</tr>
	</table>
	</td>
	<td nowrap width=10></td>
	<td nowrap width=300>
	<table border=0 cellpadding=0 cellspacing=0>
	<tr>
		<!-- <td><input type="radio" name="jojikdo" <?=$arr_jojik["0"]?> onClick="chgJojik(0)"></td> -->
		<%-- <td><input type="radio" name="jojikdo" ${jojikdo == "0" ? "checked='checked'" : ""} onClick="chgJojik(0)"></td> --%>
		<td>조직도</td>
		<td width=10></td>
		<!-- <td><input type="radio" name="jojikdo" <?=$arr_jojik["1"]?> onClick="chgJojik(1)"></td> -->
		<%-- <td><input type="radio" name="jojikdo" ${jojikdo == "1" ? "checked='checked'" : ""} onClick="chgJojik(1)"></td>
		<td>전체조직도</td> --%>
	</tr>
	<tr>
		<td colspan="5" height=1></td>
	</tr>
	</table>
	</td>
</tr>
<tr>
	<td valign="top">
	<form name="sign_form">
	<input type="hidden" name="sign_flag" value="">
	<input type="hidden" name="sign0_empno" value="">
	<input type="hidden" name="sign0_sosok" value="">
	<input type="hidden" name="sign0_user_name" value="">
	<input type="hidden" name="sign0_pos_name" value="">
	<input type="hidden" name="sign1_empno" value="">
	<input type="hidden" name="sign1_sosok" value="">
	<input type="hidden" name="sign1_user_name" value="">
	<input type="hidden" name="sign1_pos_name" value="">
	<input type="hidden" name="sign2_empno" value="">
	<input type="hidden" name="sign2_sosok" value="">
	<input type="hidden" name="sign2_user_name" value="">
	<input type="hidden" name="sign2_pos_name" value="">
	<table width="100%" cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td height=8 colspan=3></td>
	</tr>
	<tr>
		<td width=10></td>
		<td valign=top width=9><img src="/resource/images/decideline_dot.gif"></td>
		<td><b>결재선 세부보기</b></td>
	</tr>
	</table>
	<table cellpadding=0 cellspacing=0 border=0 width=100%>	
	<tr>
		<td width=10></td>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF">
		<tr height="27">
			<th width="30%" class=ta3>구분</th>
			<th width="30%" class=ta3>직위</th>
			<th width="40%" class=ta3>성명</th>
		</tr>
		<tr height="27">
			<td id="Tr21" align="center" onClick="SignFlag(2, '${sign_degree}');" onDblClick="delEmp(2);" style="cursor:hand;" class=ta4>결정</td>
			<td id="Tr22" align="center" onClick="SignFlag(2, '${sign_degree}');" onDblClick="delEmp(2);" style="cursor:hand;" class=ta4><span id="sign_pos2"></span></td>
			<td id="Tr23" align="center" onClick="SignFlag(2, '${sign_degree}');" onDblClick="delEmp(2);" style="cursor:hand;" class=ta4><span id="sign_name2"></span></td>
		</tr>
		<tr height="27">
			<td id="Tr11" align="center" onClick="SignFlag(1, '${sign_degree}');" onDblClick="delEmp(1);" style="cursor:hand;" class=ta4>검토</td>
			<td id="Tr12" align="center" onClick="SignFlag(1, '${sign_degree}');" onDblClick="delEmp(1);" style="cursor:hand;" class=ta4><span id="sign_pos1"></span></td>
			<td id="Tr13" align="center" onClick="SignFlag(1, '${sign_degree}');" onDblClick="delEmp(1);" style="cursor:hand;" class=ta4><span id="sign_name1"></span></td>
		</tr>
		<tr height="27" bgcolor="#FFFFFF">
			<td align="center" class=ta4>입안</td>
			<td align="center" class=ta4>${pos_name}</td>
			<td align="center" class=ta4>${user_name}</td>
		</tr>
		</table>
		<table width="100%" cellpadding=0 cellspacing=0 border=0 align=center>
		<tr>
			<td height=8></td>
		</tr>		
		</table>
		</td>
	</tr>
	</table>
	</form>
	</td>
	<td width=10></td>
	<td>
	<!-- 조직도 -->		
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top">
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td>
			<table border="0" cellpadding="0" cellspacing="2" bgcolor="#E4E4E4" width="100%" height="100%">
			<tr>
				<td bgcolor="#FFFFFF" valign="top"><iframe name="jojikFrm" id="jojikFrm" src="/jojikdo.do?jojikdo=${jojikdo}" frameborder="0" width="100%" height="252"></iframe></td>
			</tr>
			</table>
			<table cellpadding=0 cellspacing=0 border=0>
			<form name="pre_form" method="post">
			<tr>
				<td width=10></td>
				<td colspan="5" valign=top><b>인명찾기</b></td>
				<td width=10></td>
				<td><input type="text" name="key" size="10" class=input OnKeyPress="keyPressChk();" style="IME-MODE:ACTIVE;"></td>
				<td width=3><input type="text" name="foo" value="" READONLY style="width:0px;height:0px;"></td>
				<td><img src="/resource/images/bt_search4.gif" onClick="getSearchUserList()" style="cursor:hand;"></td>
				<td width=2></td>
				<td><img src="/resource/images/bt_return.gif" onClick="init();" style="cursor:hand;"></td>
			</tr>
			</form>
			</table>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	<!-- 조직도 -->	
	</td>
</tr>
<tr>
	<td colspan="3">
	<table cellpadding=0 cellspacing=0 border=0 align=center>
	<tr>
		<td colspan="3" height=8></td>
	</tr>
	<tr>
		<td><img src="/resource/images/btn_save02.gif" onClick="Sign('');" style="cursor:hand;"></td>
		<td width=3></td>
		<td><img src="/resource/images/btn_cancel.gif" onClick="self.close();" style="cursor:hand;"></td>		
	</tr>
	</table>
	</td>
</tr>
</table>







</body>
</html>

