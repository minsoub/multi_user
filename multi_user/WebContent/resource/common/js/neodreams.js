/*top_menu 관련 js*/
function load_fnc(depth_1,depth_2,depth_3){
	menu_load(depth_1,depth_2,depth_3);
	topmenu_load(depth_1,depth_2,depth_3);
}

function topmenu_load(depth_1,depth_2,depth_3){
		$("#topmenu-framebox").removeClass('mob-topmenu');
		$("#topmenu-framebox").addClass('web-topmenu');
		if($("#wrapper").find('#m-menubox').length){
			$("#topmenu-framebox").unwrap().unwrap();
		}
		                
		//kube top menu는 동적으로 호출
		//타 메뉴에서는 kube 메뉴 정보가 없으므로 마우스오버 시 DB 훑음
		//li 갯수가 0이 아닌 경우에는 이미 DB를 끌어오고 있으므로 걍 냅둠.
		//신규 팝업 창으로 변경 됨. 2017-12-01
		if(depth_1 == '8'){ 
			/*
			if($('#topmenu8 > ul').children().length == 0){
				$.ajax({
					url: "/getMenuList.do",
					type: "POST",
					dataType: "json",
					async: false,
					success: function(msg) {
						
						var optHtml = '<li class="menu-on"><a href="/kube.do">KUBE 홈</a></li>';
						
						if(msg != null && msg.length > 0){
							
							var kubeTopMenuChk = 'N';
							
							var forCnt = msg.length;
							
							for(var i = 0; i < forCnt; i++){
								
								if(msg[i].p_code_seq != 'LX4IaGcnTLA8InG' && kubeTopMenuChk == 'Y'){
									optHtml = optHtml + "<li><a href=\"/kube/channel/" + msg[i].link_url + "/" + msg[i].p_code_seq + "/" + msg[i].code_seq + "\">" + msg[i].code_desc + "</a></li>";
									kubeTopMenuChk = 'N';
								}else if(msg[i].p_code_seq == 'LX4IaGcnTLA8InG'){
									kubeTopMenuChk = 'Y';
								}
							}
							 
							$('#topmenu8 > ul').html(optHtml); 
							
							//web-topmenu
							$(".web-topmenu>ul>li").on({
								mouseenter:function(){
									var hover_menu = $(this).attr('id').replace('topmenu','');
									for(var t=1;t<=$(".web-topmenu>ul>li").length;t++){
										if(t == hover_menu){$("#topmenu"+hover_menu).addClass('menu-on');
										}else{$("#topmenu"+t).removeClass('menu-on');}
									}
								},mouseleave:function(){
								}
							});
							
							$(".topmenu-framebox").on('mouseleave',function(){menu_load(depth_1,depth_2,depth_3);});
						} 
					}
				});
			}else{
				//web-topmenu
				$(".web-topmenu>ul>li").on({
					mouseenter:function(){
						var hover_menu = $(this).attr('id').replace('topmenu','');
						for(var t=1;t<=$(".web-topmenu>ul>li").length;t++){
							if(t == hover_menu){$("#topmenu"+hover_menu).addClass('menu-on');
							}else{$("#topmenu"+t).removeClass('menu-on');}
						}
					},mouseleave:function(){
					}
				});
				
				$(".topmenu-framebox").on('mouseleave',function(){menu_load(depth_1,depth_2,depth_3);});
			}	
			*/
		}else{
			//web-topmenu
			$(".web-topmenu>ul>li").on({
				mouseenter:function(){
					var hover_menu = $(this).attr('id').replace('topmenu','');
					for(var t=1;t<=$(".web-topmenu>ul>li").length;t++){
						if(t == hover_menu){$("#topmenu"+hover_menu).addClass('menu-on');
						}else{$("#topmenu"+t).removeClass('menu-on');}
					}
				},mouseleave:function(){
				}
			});
			
			$(".topmenu-framebox").on('mouseleave',function(){menu_load(depth_1,depth_2,depth_3);});
		}
}

function menu_load(depth_1,depth_2,depth_3){
	/*
	for(var t=1;t<=$("#topmenu-framebox>ul>li").length;t++){
		if(depth_1){
			if(depth_1 == t){
				$("#topmenu-framebox>ul>li:eq("+ (depth_1-1) +")").addClass('menu-on');
				if(depth_2){$("#topmenu-framebox>ul>li:eq("+ (depth_1-1) +")>ul>li:eq("+ (depth_2-1) +")").addClass('menu-on');}
				if(depth_3){$("#topmenu-framebox>ul>li:eq("+ (depth_1-1) +")>ul>li:eq("+ (depth_2-1) +")>ul>li:eq("+ (depth_3-1) +")").addClass('menu-on');}
			}else{
				$("#topmenu-framebox>ul>li:eq("+ (t-1) +")").removeClass('menu-on');
			}
		}		
	}
	*/
	
	if(depth_1){
		$("li[id^=topmenu]").removeClass('menu-on');

		$("#topmenu"+ depth_1).addClass('menu-on');
		if(depth_2){$("#topmenu"+ depth_1).children().eq(0).children().eq(depth_2 - 1).addClass('menu-on');}
		if(depth_3){$("#topmenu"+ depth_1).children().eq(0).children().eq(depth_2 - 1).children().eq(0).children().eq(depth_3 - 1).addClass('menu-on');}
	}		
}
/*top_menu 관련 js 끝*/

/*paging 관련 js*/
function goUrl(url){
	location.href = url;
}

function goPage(val01){

	var f = document.frm;
	f.target = "_self";
	f.pageNo.value = val01;
	f.action = location.href;	
	f.submit();
}

function goPage2(val01){
	$('#pageNo').val(val01);
	$('#frm').attr('action',location.href).attr('method', 'post').attr('target', '_self').submit();
}           

function funFrmPagingSubmit(){
	var f = document.frm;
	f.target = "_self";
	f.pageNo.value = "1";
	f.action = location.href;	
	f.submit();
}

function funFrmPagingSubmit2(url){
	$('#pageNo').val('1');
	$('#frm').attr('action', url).attr('method', 'post').attr('target', '_self').submit();
}

function funGoPageDetail(url){
	var f = document.frm;
	f.target = "_self";
	f.action = url;	
	f.submit();
}

function funSubmit(url){
	var f = document.frm;
	f.target = "_self";
	f.method = "post";
	f.action = url;	
	f.submit();
}

function funIfrmSubmit(url) {
	var f = document.frm;
	f.target = "ifrm";
	f.method = "post";
	f.action = url;
	f.submit();
}

function funGoPageDetailSetFrm(url, frmName) {
	$('#'  + frmName).attr('action', url).attr('method', 'post').attr('target', '_self').submit();
}
/*paging 관련 js 끝*/

/*재생 팝업*/
function VOD_Link(Re_form, Re_Step, subject, num){
	
	//기존 asp 에서는 01, 02, 03 나눠놨으나, 의미 없어서 한쪽으로 통합
	//리뉴얼하면서, 08, mpps 미사용
	if(Re_form == "1"){
		na_open_window('win', "media_02.do?num=" + num + "&Rs_title=" + subject + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
	}else if(Re_form == "2"){
		na_open_window('win', "media_02.do?num=" + num + "&Rs_title=" + subject + "&DirName", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
	}else if(Re_form == "3"){
		if($.trim(Re_Step) == "9"){
			//na_open_window('win', "media_01.do?f_num=" + num + "&Rs_title=" + subject + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);		
			na_open_window('win', "media_02.do?num=" + num + "&Rs_title=" + subject + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);		
		}else{
			//na_open_window('win1', "media_03.do?num=" + num + "&Rs_title=" + subject + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
			na_open_window('win', "media_02.do?num=" + num + "&Rs_title=" + subject + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
		}
	}else if(Re_form == "4"){
		na_open_window('win1', "mpps.do?num=" + num + "&DirName=news-news", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
	}else if(Re_form == "5"){
		VOD_Link = "#"
	}
}

function playPopup(Re_form, num){
	
	//기존 asp 에서는 01, 02, 03 나눠놨으나, 의미 없어서 한쪽으로 통합
	//리뉴얼하면서, 08, mpps 미사용 
	if(Re_form == "1"){
		na_open_window('win', "media_02.do?num=" + num + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
	}else if(Re_form == "2"){
		if(num == "12484"){
			na_open_window('win', "media_08.do?num=" +  num  + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
		}else{
			na_open_window('win', "media_02.do?num=" + num + "&DirName", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
		}
	}else if(Re_form == "3"){
		//if($.trim(Re_Step) == "9"){
			//na_open_window('win', "media_01.do?f_num=" + num + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
			na_open_window('win', "media_02.do?num=" + num + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
		//}else{
			//na_open_window('win1', "media_03.do?num=" + num + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);		
			//na_open_window('win1', "media_02.do?num=" + num + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);		
		//}
	}else if(Re_form == "4"){
		na_open_window('win1', "mpps.do?num=" + num + "&DirName=", 0, 0, 1164, 963, 0, 0, 0, 0, 0);
	}else if(Re_form == "5"){
		VOD_Link = "#"
	}
}
/*재생 팝업 끝*/


/*달력 기본설정*/
$.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd',
    prevText: '이전 달',
    nextText: '다음 달',
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    showMonthAfterYear: true,
    yearSuffix: '년'
});

/*ASP 에서 복사*/
function CheckStr(strOriginal, strFind, strChange){
    var position, strOri_Length;
    position = strOriginal.indexOf(strFind);
    while (position != -1){
        strOriginal = strOriginal.replace(strFind, strChange);
        position = strOriginal.indexOf(strFind);
    }
    strOri_Length = strOriginal.length;
    return strOri_Length;
}

function checkSpace (toCheck) {
    for (i = 0; i < (toCheck.length); i++) {
        if (toCheck.substring(i,i+1) == " ")  {
            return true;
            break;
        }
    }
    return false;
}
/*ASP 에서 복사*/

$(function(){
    $('.inputDesign').jqTransform();
});


function popupRental(url){
	$.ajax({
	    url : "/insertRentalPageLog.do", 
	    type: "POST",
        data: {"url" : url},
	    dataType : "html",  
	    success : function(result){ 
	    	
       }
	});
	
	window.open(url,"_equip","width=1100,height=800,scrollbars=yes,fullscreen=yes,resizable=yes");
}

//길이체크
function getByteLength(s, b, i, c)
{
    for(b=i=0; c=s.charCodeAt(i++); b+=c>>11?2:c>>7?1:1);
    return b;
}

function getDateTerm(strdt, enddt, type)
{
    if(!strdt || !enddt || !type)
    {
        alert('잘못된 접근입니다.');
        return false;
    }

    var sdt = new Date(strdt.substring(0,4), strdt.substring(4,6), strdt.substring(6,8)).getTime();
    var edt = new Date(enddt.substring(0,4), enddt.substring(4,6), enddt.substring(6,8)).getTime();

    var term = '',
        tp = '';

    switch(type)
    {
        case 'second' :
            tp = 1000;
        break;
        case 'minute' :
            tp = 1000 * 60;
        break;
        case 'hour' :
            tp = 1000 * 60 * 60;
        break;
        case 'day' :
            tp = 1000 * 60 * 60 * 24;
        break;
        case 'month' :
            tp = 1000 * 60 * 60* 24 * 365.25/12;
        break;
        case 'year' :
            tp = 1000 * 60 * 60* 24 * 365.25/12 * 12;
        break;
    }

    with(Math)
    {
        term = ((sdt - edt) / tp);
    }

    return Math.abs(Math.floor(term));
}

function funGoKubeVideoList(obj){                   
	location.href= $(obj).next().find('a').attr('href');
}

//레이어 팝업 중앙 정렬
jQuery.fn.layerCenter = function () {
    this.css("position","absolute");
    this.css("top", (Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) - 300) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
    return this;
}

//레이어 팝업 중앙 정렬
jQuery.fn.layerCenter2 = function () {
	this.css("position","absolute");
	this.css("top", (Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop())) + "px");
	this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth()) / 2) + $(window).scrollLeft()) + "px");
	return this;
}
 
layerPopupCenter = function(obj) {
	$(obj).show();
	$(obj).layerCenter();
}

layerPopupCenter2 = function(obj) {
	$(obj).show();
	$(obj).layerCenter2();
}

/**
 * 체크박스 컨트롤
 * 1. 체크박스 전체 선택으로 동일 네임 체크박스 상태 컨트롤 
 * 2. 동일 네임 체크박스의 상태로 체크박스 전체 선택 상태 컨트롤 
 */
function funAllChkCtrl(){
	
	var chkBoxStatus = false;
	var chkBoxCnt = 0;
	var allChkCnt = 0;
	
	$('input[type=checkbox]').change(function(){
		
		chkBoxStatus = $(this).is(':checked');
		
		if($(this).val() == 'all'){ 
			$('input[name=' + $(this).attr('name') + ']').prop('checked', chkBoxStatus);
		}else{
			
			chkBoxCnt = 0;
			allChkCnt = 0;
			
			$('input[name=' + $(this).attr('name') + ']').each(function(){
				if($(this).val() != 'all'){
					chkBoxCnt = chkBoxCnt + 1;  
				}
				
				if($(this).val() != 'all'
					&& $(this).is(':checked')){
					allChkCnt = allChkCnt + 1;
				}
			});          
			
			if(chkBoxCnt == allChkCnt){
				$($('input[name=' + $(this).attr('name') + ']')[0]).prop('checked', true);
			}else{ 
				$($('input[name=' + $(this).attr('name') + ']')[0]).prop('checked', false);
			}
		}
	});
}

function getTimeStamp() {
	  var d = new Date();

	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
}

function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}
