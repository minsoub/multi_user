function isEmpty(input)
{
    if (input.value == null || input.value.replace(/ /gi,"") == "") {
        return true;
    }
    return false;
}


function keyPressChk()
{
	if (event.keyCode == 13) 
		getSearchUserList();
}

function getSearchUserList()
{
	
	var key = $("input[name='key']").val();
	$.ajax({
        type : "post",
        url : "/getSearchUserList.do",
        data : { mode: "search", key: key },
        datatype : "json",
        success : function(data) {
        	var searchList = data.searchUserList;
        	if (searchList != null){
                if (searchList.length > 0) {
                	jojikFrm.makeSearchDeptTree(searchList);
                	jojikFrm.makeEmpTree(searchList);
                	jojikFrm.treeviewLoad();
                }
            }
        }
	});
}


function SignFlag(flag, sign_degree)
{
	var obj = document.sign_form;
	obj.sign_flag.value = flag;

	// [BEGIN] ���� 3�� �� 4�� 2014-03-04 ���� 4:59:04
	if (flag == 0) {
		if (sign_degree == '4') {
			/*Tr01.style.backgroundColor='#E0E0E0';
			Tr02.style.backgroundColor='#E0E0E0';
			Tr03.style.backgroundColor='#E0E0E0';*/
		}
		Tr11.style.backgroundColor='#F2F2F2';
		Tr12.style.backgroundColor='#F2F2F2';
		Tr13.style.backgroundColor='#F2F2F2';
		Tr21.style.backgroundColor='#F2F2F2';
		Tr22.style.backgroundColor='#F2F2F2';
		Tr23.style.backgroundColor='#F2F2F2';
	}
	else if (flag == 1) {
		if (sign_degree == '4') {
			/*Tr01.style.backgroundColor='#F2F2F2';
			Tr02.style.backgroundColor='#F2F2F2';
			Tr03.style.backgroundColor='#F2F2F2';*/
		}
		Tr11.style.backgroundColor='#E0E0E0';
		Tr12.style.backgroundColor='#E0E0E0';
		Tr13.style.backgroundColor='#E0E0E0';
		Tr21.style.backgroundColor='#F2F2F2';
		Tr22.style.backgroundColor='#F2F2F2';
		Tr23.style.backgroundColor='#F2F2F2';
	}
	else {
		if (sign_degree == '4') {
			/*Tr01.style.backgroundColor='#F2F2F2';
			Tr02.style.backgroundColor='#F2F2F2';
			Tr03.style.backgroundColor='#F2F2F2';*/
		}
		Tr11.style.backgroundColor='#F2F2F2';
		Tr12.style.backgroundColor='#F2F2F2';
		Tr13.style.backgroundColor='#F2F2F2';
		Tr21.style.backgroundColor='#E0E0E0';
		Tr22.style.backgroundColor='#E0E0E0';
		Tr23.style.backgroundColor='#E0E0E0';
	}
	// [END] ���� 3�� �� 4�� 2014-03-04 ���� 4:59:04
}


function addEmp(empno,user_name,pos_name,sosok)
{
	var obj = document.sign_form;

	// [BEGIN] ���� 3�� �� 4�� 2014-03-04 ���� 4:59:04
	if (obj.sign_flag.value == 2) {
		obj.sign2_empno.value = empno;
		obj.sign2_user_name.value = user_name;
		obj.sign2_pos_name.value = pos_name;
		obj.sign2_sosok.value = sosok;

		sign_pos2.innerHTML = pos_name;
		sign_name2.innerHTML = user_name;
	}
	else if (obj.sign_flag.value == 1) {
		obj.sign1_empno.value = empno;
		obj.sign1_user_name.value = user_name;
		obj.sign1_pos_name.value = pos_name;
		obj.sign1_sosok.value = sosok;

		sign_pos1.innerHTML = pos_name;
		sign_name1.innerHTML = user_name;
	}
	else if (obj.sign_flag.value == 0) {
		obj.sign0_empno.value = empno;
		obj.sign0_user_name.value = user_name;
		obj.sign0_pos_name.value = pos_name;
		obj.sign0_sosok.value = sosok;

		sign_pos0.innerHTML = pos_name;
		sign_name0.innerHTML = user_name;
	}
	else {
		alert('���籸���� �������ּ���');
	}
	// [END] ���� 3�� �� 4�� 2014-03-04 ���� 4:59:04
}


function delEmp (flag)
{
	var obj = document.sign_form;

	// [BEGIN] ���� 3�� �� 4�� 2014-03-04 ���� 4:59:04
	if (flag == 0) {
		obj.sign0_empno.value = '';
		obj.sign0_user_name.value = '';
		obj.sign0_pos_name.value = '';
		obj.sign0_sosok.value = '';

		sign_pos0.innerHTML = '';
		sign_name0.innerHTML = '';
	}
	else if (flag == 1) {
		obj.sign1_empno.value = '';
		obj.sign1_user_name.value = '';
		obj.sign1_pos_name.value = '';
		obj.sign1_sosok.value = '';

		sign_pos1.innerHTML = '';
		sign_name1.innerHTML = '';
	}
	else if (flag == 2) {
		obj.sign2_empno.value = '';
		obj.sign2_user_name.value = '';
		obj.sign2_pos_name.value = '';
		obj.sign2_sosok.value = '';

		sign_pos2.innerHTML = '';
		sign_name2.innerHTML = '';
	}
}


function Sign(no_status)
{
	var obj = document.sign_form;
	//var open_obj = window.dialogArguments;

	if( obj.sign2_empno.value=='' ) { // ���缱������ ���������
		alert("결재자를 지정해주세요.");
		return;
	}

	else if (confirm('신청하시겠습니까?')) {
			opener.reg_form.sign1Empno.value = obj.sign1_empno.value;
			opener.reg_form.sign1UserName.value = obj.sign1_user_name.value;
			opener.reg_form.sign1PosName.value = obj.sign1_pos_name.value;
			opener.reg_form.sign1Sosok.value = obj.sign1_sosok.value;
		
			opener.reg_form.sign2Empno.value = obj.sign2_empno.value;
			opener.reg_form.sign2UserName.value = obj.sign2_user_name.value;
			opener.reg_form.sign2PosName.value = obj.sign2_pos_name.value;
			opener.reg_form.sign2Sosok.value = obj.sign2_sosok.value;

		opener.reg_form.submit();

		window.close();
	}
}


function userSearch()
{
	if(isEmpty(pre_form.key)) {
		alert('�̸�/����� �Է����ּ���');
		return;
	}
	jojikFrm.jojik_form.key.value = pre_form.key.value;
	with(jojikFrm.jojik_form) {
		mode.value = 'search';
		dcode.value = '';
		submit();
	}
}


function openSub(code)
{
	with(jojikFrm.jojik_form) {
		mode.value = '';
		dcode.value = code;
		submit();
	}
}


function init()
{
	pre_form.key.value = '';
	with(jojikFrm.jojik_form) {
		mode.value = '';
		dcode.value = '';
		key.value = '';
		submit();
	}
}


function chgJojik(v)
{
	with(jojikFrm.jojik_form) {
		mode.value = '';
		dcode.value = '';
		key.value = '';
		jojikdo.value = v;
		submit();
	}
}

