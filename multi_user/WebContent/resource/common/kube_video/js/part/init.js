$(document).ready(function() {
  var _this = this;
  _this.$contents = $('.contents');
  controller = new setController($('.controller'));
  mainVideo = new setVideo($('.video1'));
  script = new setScript();
  // menu = new setMenu();
  // quiz = new setQuiz();


  if( mobileOS )
  {
    $('.sound').hide();
    $('.soundLineWrap').hide();
    // $('.fullscreen').hide();
    $('.replay').hide();
  }

  if(osType =="Android OS" ) 
  {
    $('.mobile_down').show();
    $('.scriptTxt').css("font-size","18px");
  }

  $( window ).resize(function() {
    scaleChange($('.interactive'));
  });
  
  if(browserType.indexOf("IE") == -1){
    $('.mobile_play_btn').show();
  }
  if(osType == "iPhone OS"){
    window.onorientationchange = function() {
      scaleChange($('.interactive'));
    }
  }

  if(bolPorted || bolIntranet) $(document).bind("contextmenu",function(e){	return false;  });

  $(parent.document).on('MSFullscreenChange webkitfullscreenchange mozfullscreenchange fullscreenchange', function(e) { 
    fullBol = !fullBol; 
    contentZoomScale = (fullBol && getBrowserType().indexOf("IE")!= -1)? 0.01 : 1;
    if(fullBol){
      $('.fullscreen').closest("div").children(".tooltips").text("화면축소");
      $('.fullscreen').addClass("toggle");
    }
    else{
      $('.fullscreen').removeClass("toggle");
      $('.fullscreen').closest("div").children(".tooltips").text("전체화면");
    }
  });

  

  //쿠키 불러오기 (스크랩, 음량)
  var cookie = document.cookie;
  if(cookie.length>0){
    if(getCookie(strScrapCookie)){
      scrapCookieList = getCookie(strScrapCookie);
      for(var i=0; i<scrapCookieList.split("_").length; i++){
        $('.ScrapList').find('.box_'+scrapCookieList.split("_")[parseInt(i)]).show();
      }
    }
    //mainVideo.volume = getCookie("soundCookie") * 1;
  }
  else{
    scrapCookieList = "undifiend";
  }

  // 콘텐츠 종료 시 
  window.onbeforeunload=function(){
    

    if(bolIntranet)
    {
      var tempTime = Math.round(mainVideo.videoDOM.currentTime);
      parent.playTime(tempTime, 9)
    }
    
    var scrapCookie = scrapCookieList;
    var soundCookie = mainVideo.videoDOM.volume;

    setCookie(strScrapCookie,scrapCookie,10000);
    setCookie("soundCookie",soundCookie,10000);
  }




});


isShift = false;
isCtrl = false;
$(document).keyup(function(keyEvent) 
{
  getKey = keyEvent.keyCode;
  if(getKey == 16) isShift = false;
  if(getKey == 17) isCtrl = false;

});
$(document).keydown(function(keyEvent) 
{
      getKey = keyEvent.keyCode;
      if(getKey == 16) isShift = true;
      if(getKey == 17) isCtrl = true;
      if(isShift && getKey == 188) 
      {
        var goPage = parseInt(curPage) - 1;
        if(goPage <= 0 ) alert("처음 페이지 입니다.");
        else movePage(goPage, "prev");
      }
      if(isShift && getKey == 190) 
      {
        var goPage = parseInt(curPage) + 1;
        if(goPage > totalPage ) alert("마지막 페이지 입니다.");
        else movePage(goPage, "next");
      } 
      if(isShift && getKey == 191)
      {
        ($('.scriptWrap').css("display") == "none") ? $('.scriptWrap').show() : $('.scriptWrap').hide();
      }
      if(isCtrl && getKey == 190)
      {
        (mainVideo.videoDOM.volume != 0)? $('.soundLine').slider('value', 0) : $('.soundLine').slider('value', 50);
      }
      // if(isShift && getKey == 34) $( ".timeLine" ).slider( "enable" );
});

