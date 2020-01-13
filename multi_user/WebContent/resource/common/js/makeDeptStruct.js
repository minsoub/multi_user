
function makeDeptTree() {
    getDeptList();
}

function makeDeptTree01(list) {
    var dept1Code;
    var dept1Name;
    
    var ul = document.getElementById("deptTree");
    for (var i = 0; i < list.length; i++) {
        if (dept1Code == null) {
            dept1Code = list[i].dept1Code;
            dept1Name = list[i].dept1Name;
            var li = makeOneRow1(dept1Name, dept1Code);
            ul.appendChild(li);
        } else if(dept1Code != list[i].dept1Code) {
            dept1Code = list[i].dept1Code;
            dept1Name = list[i].dept1Name;
            var li = makeOneRow1(dept1Name, dept1Code);
            ul.appendChild(li);
        }
    }
}

function makeSearchDeptTree(list){
	
	var dept_name;
	var dept_code;
	var dept_nm_arr;
	
	var ul_root = document.getElementById("deptTree");
	
	while (ul_root.hasChildNodes()) {
		ul_root.removeChild(ul_root.lastChild);
	}
	
	for(var i = 0 ; i < list.length ; i++ ){
		dept_nm_arr = list[i].dept_name.split(" ");
		dept_code = list[i].dept_code;
		
		var ul;
		var li;
		for(var k = dept_nm_arr.length -2 ; k >= 0 ; k-- ){
			
			var ul_tmp = document.createElement("ul");
			var li_tmp = document.createElement("li");
			li_tmp.setAttribute("id", "dept_"+i+"_arr_"+k);
			
			var span = document.createElement("span");
			span.setAttribute("class", "folder");
			
			var text = document.createTextNode(dept_nm_arr[k]);
			
			if( k == dept_nm_arr.length -2){
				span.setAttribute("id", dept_code);
			}
			span.appendChild(text);
			li_tmp.appendChild(span);
			if( k < dept_nm_arr.length -2){
				li_tmp.appendChild(ul);
			}
		    ul_tmp.appendChild(li_tmp);
		    ul = ul_tmp.cloneNode(true);
		    li = li_tmp.cloneNode(true);
		}
		ul_root.appendChild(li);
		$("#deptTree").treeview({collapsed: false});
	}
	
}

function makeOneRow(deptName, deptCode) {
    var li = document.createElement("li");
    li.setAttribute("id", deptCode);
    li.setAttribute("class", "closed");

    var span = document.createElement("span");
    span.setAttribute("class", "folder");
    span.setAttribute("onclick", "javascript:getDeptUserlist('"+ deptCode +"');");

    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("value", deptCode);

    var text = document.createTextNode(deptName);

    span.appendChild(input);
    span.appendChild(text);
    li.appendChild(span);

    return li;
}

function makeDeptTree02(list) {
    var parentLi;
    var dept1Code;
    var dept2Code;
    var dept2Name;

    var ul = document.createElement("ul");
    ul.setAttribute("class", "deptTree02");
    for (var i = 0; i < list.length; i++) {
        if (dept1Code == null) {
            dept1Code = list[i].dept1Code;
            if (dept2Code == null) {
                dept2Code = list[i].dept2Code;
                dept2Name = list[i].dept2Name;
                var li = makeOneRow2(dept2Name, dept2Code);
                ul.appendChild(li);
            }
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept1Code);
                parentLi.appendChild(ul);
            }
        } else if(dept1Code == list[i].dept1Code) {
            dept2Code = list[i].dept2Code;
            dept2Name = list[i].dept2Name;
            var li = makeOneRow2(dept2Name, dept2Code);
            ul.appendChild(li);
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept1Code);
                parentLi.appendChild(ul);
            }
        } else {
            parentLi = document.getElementById(dept1Code);
            parentLi.appendChild(ul);
            dept1Code = list[i].dept1Code;
            ul = document.createElement("ul");
            ul.setAttribute("class", "deptTree02");
            dept2Code = list[i].dept2Code;
            dept2Name = list[i].dept2Name;
            var li = makeOneRow2(dept2Name, dept2Code);
            ul.appendChild(li);
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept1Code);
                parentLi.appendChild(ul);
            }
        }
    }
//    ul.appendChild(li);
//    console.log(li);
    treeviewLoad();
}

function makeDeptTree03(list) {
    var parentLi;
    var dept2Code;
    var dept3Code;
    var dept3Name;
    var ul = document.createElement("ul");
    ul.setAttribute("class", "deptTree03");
    for (var i = 0; i < list.length; i++) {
        if (dept2Code == null) {
            dept2Code = list[i].dept2Code;
            if (dept3Code == null) {
                dept3Code = list[i].dept3Code;
                dept3Name = list[i].dept3Name;
                var li = makeOneRow3(dept3Name, dept3Code);
                ul.appendChild(li);
            }
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept2Code);
                parentLi.appendChild(ul);
            }
        } else if(dept2Code == list[i].dept2Code) {
            dept3Code = list[i].dept3Code;
            dept3Name = list[i].dept3Name;
            var li = makeOneRow3(dept3Name, dept3Code);
            ul.appendChild(li);
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept2Code);
                parentLi.appendChild(ul);
            }
        } else {
            parentLi = document.getElementById(dept2Code);
            parentLi.appendChild(ul);
            dept2Code = list[i].dept2Code;
            ul = document.createElement("ul");
            ul.setAttribute("class", "deptTree03");
            dept3Code = list[i].dept3Code;
            dept3Name = list[i].dept3Name;
            var li = makeOneRow3(dept3Name, dept3Code);
            ul.appendChild(li);
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept2Code);
                parentLi.appendChild(ul);
            }
        }
    }
//    ul.appendChild(li);
//    treeviewLoad();
}

function makeDeptTree04(list) {
    var parentLi;
    var dept3Code;
    var dept4Code;
    var dept4Name;

    var ul = document.createElement("ul");
    ul.setAttribute("class", "deptTree04");
    for (var i = 0; i < list.length; i++) {
        if (dept3Code == null) {
            dept3Code = list[i].dept3Code;
            if (dept4Code == null) {
                dept4Code = list[i].dept4Code;
                dept4Name = list[i].dept4Name;
                var li = makeOneRow4(dept4Name, dept4Code);
                ul.appendChild(li);
            }
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept3Code);
                parentLi.appendChild(ul);
            }
        } else if(dept3Code == list[i].dept3Code) {
            dept4Code = list[i].dept4Code;
            dept4Name = list[i].dept4Name;
            var li = makeOneRow4(dept4Name, dept4Code);
            ul.appendChild(li);
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept3Code);
                parentLi.appendChild(ul);
            }
        } else {
            parentLi = document.getElementById(dept3Code);
            parentLi.appendChild(ul);
            dept3Code = list[i].dept3Code;
            ul = document.createElement("ul");
            ul.setAttribute("class", "deptTree04");
            dept4Code = list[i].dept4Code;
            dept4Name = list[i].dept4Name;
            var li = makeOneRow4(dept4Name, dept4Code);
            ul.appendChild(li);
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept3Code);
                parentLi.appendChild(ul);
            }
        }
    }
//    ul.appendChild(li);
//    treeviewLoad();
}
function makeDeptTree05(list) {
    var parentLi;
    var dept4Code;
    var dept5Code;
    var dept5Name;

    var ul = document.createElement("ul");
    ul.setAttribute("class", "deptTree05");
    for (var i = 0; i < list.length; i++) {
        if (dept4Code == null) {
            dept4Code = list[i].dept4Code;
            if (dept5Code == null) {
                dept5Code = list[i].dept5Code;
                dept5Name = list[i].dept5Name;
                var li = makeOneRow(dept5Name, dept5Code);
                ul.appendChild(li);
            }
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept4Code);
                parentLi.appendChild(ul);
            }
        } else if(dept4Code == list[i].dept4Code) {
            dept5Code = list[i].dept5Code;
            dept5Name = list[i].dept5Name;
            var li = makeOneRow(dept5Name, dept5Code);
            ul.appendChild(li);
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept4Code);
                parentLi.appendChild(ul);
            }
        } else {
            parentLi = document.getElementById(dept4Code);
            parentLi.appendChild(ul);
            dept4Code = list[i].dept4Code;
            ul = document.createElement("ul");
            ul.setAttribute("class", "deptTree05");
            dept5Code = list[i].dept5Code;
            dept5Name = list[i].dept5Name;
            var li = makeOneRow(dept5Name, dept5Code);
            ul.appendChild(li);
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept4Code);
                parentLi.appendChild(ul);
            }
        }
    }
//    ul.appendChild(li);
//    treeviewLoad();
}
function makeDeptTree06(list) {
    var parentLi;
    var dept5Code;
    var dept6Code;
    var dept6Name;

    var ul = document.createElement("ul");
    ul.setAttribute("class", "deptTree06");
    for (var i = 0; i < list.length; i++) {
        if (dept5Code == null) {
            dept5Code = list[i].dept5Code;
            if (dept6Code == null) {
                dept6Code = list[i].dept6Code;
                dept6Name = list[i].dept6Name;
                var li = makeOneRow(dept6Name, dept6Code);
                ul.appendChild(li);
            }
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept5Code);
                parentLi.appendChild(ul);
            }
        } else if(dept5Code == list[i].dept5Code) {
            dept6Code = list[i].dept6Code;
            dept6Name = list[i].dept6Name;
            var li = makeOneRow(dept6Name, dept6Code);
            ul.appendChild(li);
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept5Code);
                parentLi.appendChild(ul);
            }
        } else {
            parentLi = document.getElementById(dept5Code);
            parentLi.appendChild(ul);
            dept5Code = list[i].dept5Code;
            ul = document.createElement("ul");
            ul.setAttribute("class", "deptTree06");
            dept6Code = list[i].dept6Code;
            dept6Name = list[i].dept6Name;
            var li = makeOneRow(dept6Name, dept6Code);
            ul.appendChild(li);
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept5Code);
                parentLi.appendChild(ul);
            }
        }
    }
//    ul.appendChild(li);
//    treeviewLoad();
}

function makeEmpTree(list) {
    var parentLi;
    var dept_code;
    var EMPNO;
    var user_name;
    var pos_name;
    var sex;
    var levelno;
    var dept_name;

    var ul = document.createElement("ul");
    for (var i = 0; i < list.length; i++) {
        if (dept_code == null) {
            dept_code = list[i].dept_code;
            if (EMPNO == null) {
                EMPNO = list[i].EMPNO;
                if (EMPNO != '') {
                    user_name = list[i].user_name;
                    pos_name = list[i].pos_name;
                    sex = list[i].sex;
                    levelno = list[i].levelno;
                    dept_name = list[i].dept_name;
                    var li = makeOneRowUser(user_name, EMPNO, pos_name, sex, levelno, dept_name);
                    ul.appendChild(li);
                }
                if (i == (list.length-1)) {
                    parentLi = document.getElementById(dept_code);
                    parentLi.appendChild(ul);
                }
            }
        } else if(dept_code == list[i].dept_code) {
            EMPNO = list[i].EMPNO;
            if (EMPNO != '') {
                user_name = list[i].user_name;
                pos_name = list[i].pos_name;
                sex = list[i].sex;
                levelno = list[i].levelno;
                dept_name = list[i].dept_name;
                var li = makeOneRowUser(user_name, EMPNO, pos_name, sex, levelno, dept_name);
                ul.appendChild(li);
            }
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept_code);
                parentLi.appendChild(ul);
            }
        } else {
            parentLi = document.getElementById(dept_code);
            parentLi.appendChild(ul);
            dept_code = list[i].dept_code;
            ul = document.createElement("ul");
            EMPNO = list[i].EMPNO;
            if (EMPNO != '') {
                user_name = list[i].user_name;
                pos_name = list[i].pos_name;
                sex = list[i].sex;
                levelno = list[i].levelno;
                dept_name = list[i].dept_name;
                var li = makeOneRowUser(user_name, EMPNO, pos_name, sex, levelno, dept_name);
                ul.appendChild(li);
            }
            if (i == (list.length-1)) {
                parentLi = document.getElementById(dept_code);
                parentLi.appendChild(ul);
            }
        }
    }
//    ul.appendChild(li);
//    treeviewLoad();
}

function makeOneRowUser(user_name, empno, pos_name, sex, levelno, dept_name) {
    var li = document.createElement("li");
    li.setAttribute("id", empno);
    li.setAttribute("class", "closed");

    
    var span = document.createElement("span");
    
    if( sex%2 == 0 )
        span.setAttribute("class", "woman");
    else
        span.setAttribute("class", "man");
    
    span.setAttribute("onclick", "javascript:getDeptUserlist('"+ empno +"'); parent.addEmp('" + empno + "','" + user_name + "','" + pos_name + "','" + dept_name + "')");
    span.setAttribute("style", "cursor:pointer;")

    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("value", empno);

    var text = document.createTextNode(user_name + '(' + empno +')' );

    span.appendChild(input);
    span.appendChild(text);
    li.appendChild(span);
    return li;
}

function makeOneRow(deptName, deptCode) {
    var li = document.createElement("li");
    li.setAttribute("id", deptCode);
    li.setAttribute("class", "closed");

    var span = document.createElement("span");
    span.setAttribute("class", "folder");
    span.setAttribute("onclick", "javascript:getDeptUserlist('"+ deptCode +"');");

    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("value", deptCode);

    var text = document.createTextNode(deptName);

    span.appendChild(input);
    span.appendChild(text);
    li.appendChild(span);

    return li;
}

function makeOneRow1(deptName, deptCode) {
    var li = document.createElement("li");
    li.setAttribute("id", deptCode);
    li.setAttribute("class", "closed");

    var span = document.createElement("span");
    span.setAttribute("class", "folder");
    span.setAttribute("onclick", "javascript:getDept3List('"+ deptCode +"', $(this));getDeptUserlist('"+ deptCode +"');");

    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("value", deptCode);

    var text = document.createTextNode(deptName);

//    span.appendChild(img);
    span.appendChild(input);
    span.appendChild(text);
    li.appendChild(span);

    return li;
}

function makeOneRow2(deptName, deptCode) {
    var li = document.createElement("li");
    li.setAttribute("id", deptCode);
    li.setAttribute("class", "closed");

    var span = document.createElement("span");
    span.setAttribute("class", "folder");
    span.setAttribute("onclick", "javascript:getDept4List('"+ deptCode +"', $(this));getDeptUserlist('"+ deptCode +"');");

    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("value", deptCode);

    var text = document.createTextNode(deptName);

//    span.appendChild(img);
    span.appendChild(input);
    span.appendChild(text);
    li.appendChild(span);

    return li;
}

function makeOneRow3(deptName, deptCode) {
    var li = document.createElement("li");
    li.setAttribute("id", deptCode);
    li.setAttribute("class", "closed");

    var span = document.createElement("span");
    span.setAttribute("class", "folder");
    span.setAttribute("onclick", "javascript:getDept5List('"+ deptCode +"', $(this));getDeptUserlist('"+ deptCode +"');");

    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("value", deptCode);

    var text = document.createTextNode(deptName);

//    span.appendChild(img);
    span.appendChild(input);
    span.appendChild(text);
    li.appendChild(span);

    return li;
}

function makeOneRow4(deptName, deptCode) {
    var li = document.createElement("li");
    li.setAttribute("id", deptCode);
    li.setAttribute("class", "closed");

    var span = document.createElement("span");
    span.setAttribute("class", "folder");
    span.setAttribute("onclick", "javascript:getDept6List('"+ deptCode +"', $(this));getDeptUserlist('"+ deptCode +"');");

    var input = document.createElement("input");
    input.setAttribute("type", "hidden");
    input.setAttribute("value", deptCode);

    var text = document.createTextNode(deptName);

//    span.appendChild(img);
    span.appendChild(input);
    span.appendChild(text);
    li.appendChild(span);

    return li;
}

/**
 * Spinner표시
 * @param gifPath Gif파일패스
 */
/** Spinnerを表示する<DIV>のid */
var spinnerId = "spinner";

function showSpinner () {
    $("#deptTreeDiv").append("<div id='" + spinnerId + "'></div>");
//    $("#" + spinnerId).css("background-image", gifPath);
};
