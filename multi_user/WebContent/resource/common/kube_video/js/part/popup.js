$(document).ready(function() {
	if(pageInfo[curChapter][curPage] != undefined){
        var templength = Object.keys(pageInfo[curChapter][curPage]).length;
        console.log(templength);
        for(var i=1; i<=templength; i++)
        {
            var tempPopupInfo = pageInfo[curChapter][curPage]['pop'+itostr(i)];
            console.log(tempPopupInfo);
            // var tempPopup = $('<button class="pop_btn" id = pop_btn_' + strChapter + '_' + strPage + '_' + itostr(i) + '></button>');
            
            if(templength == 1) var tempPopup = $('<button style=" background: url(./pop/img/' + strInitial + strChapter +"_" + strPage + '_pop.png) no-repeat; background-size: 100% 100%;" class="pop_btn" id = "' + strInitial + strChapter + '_' + strPage + '_pop" ></button>');
            else var tempPopup = $('<button style=" background: url(./pop/img/' + strInitial + strChapter +"_" + strPage + '_pop' + i + '.png) no-repeat; background-size: 100% 100%;"  class="pop_btn" id = ' + strInitial + strChapter + '_' + strPage + '_pop' + itostr(i) + '></button>');

            $('#contents').append(tempPopup);

            if(tempPopupInfo.type == "info")
            {
                tempPopup.on('click',function(){
                    var tmpNumber = $(this).attr('id');
                    tmpNumber = tmpNumber.substr(tmpNumber.length - 2);
                    if(tmpNumber == "op") tmpNumber = "01";
                    tempPopupInfo = pageInfo[curChapter][curPage]['pop'+tmpNumber];
                    window.open('./pop/popup.html?val='+tmpNumber,'popup','left=50,top=50,width='+tempPopupInfo.width+'px,height='+ tempPopupInfo.height +'px,scrollbars=no');
                });
            }
            else if(tempPopupInfo.type == "info_scroll")
            {
                tempPopup.on('click',function(){
                    var tmpNumber = $(this).attr('id');
                    tmpNumber = tmpNumber.substr(tmpNumber.length - 2);
                    if(tmpNumber == "op") tmpNumber = "01";
                    tempPopupInfo = pageInfo[curChapter][curPage]['pop'+tmpNumber];
                    window.open('./pop/popup_scroll.html?val='+tmpNumber,'popup','left=50,top=50,width='+tempPopupInfo.width+'px,height='+ tempPopupInfo.height +'px,scrollbars=no');
                });
            }
            else if(tempPopupInfo.type == "down")
            {
                tempPopup.on('click',function(){
                    var tmpNumber = $(this).attr('id');
                    tmpNumber = tmpNumber.substr(tmpNumber.length - 2);
                    if(tmpNumber == "op") tmpNumber = "01";
                    window.open('../common/down/'+ strInitial + strChapter + "_" + strPage + "_"  + tmpNumber +".zip" ,'_down');
                });
            }
            else if(tempPopupInfo.type == "link")
            {
                tempPopup.on('click',function(){
                    var tmpNumber = $(this).attr('id');
                    tmpNumber = tmpNumber.substr(tmpNumber.length - 2);
                    if(tmpNumber == "op") tmpNumber = "01";
                    var tempLink = pageInfo[curChapter][curPage]['pop'+tmpNumber].link;
                    window.open(tempLink ,'_link');
                });
            }
        }
    }
});