function setController(_selector){

  this.tabIndex = 200; 
  this.$controller = _selector; // 컨트롤 선택자
  this.fnConrollerInit(); // 컨트롤러 초기화 함수 호출
}

setController.prototype.fnConrollerInit = function(){
  var _this = this;
  //타임바 및 사운드바는 jquery-ui 슬라이더 사용
  $('.timeLine').slider({
    range: "min",
    max: 1000,
    create: function( event, ui ) {
    },    
    start: function( event, ui ) { 
      mainVideo.videoDOM.pause(); 
      if(itrBol){
        mainVideo.$video.show();
        
        if(typeof pracInit == 'function'){
        	pracInit();
        }
      }
    },
    slide: function( event, ui ) {
      if(ui.value >= curProgress){
        $('.timeLine').slider('value',curProgress)
        return false;
      }
    },
    stop: function( event, ui )
    {
      var persent = $('.timeLine').slider('value');
      var totTime = mainVideo.videoDOM.duration;
      mainVideo.videoDOM.currentTime = totTime * persent / 1000;
      mainVideo.fnTimeUpdate();
      (mainVideo.videoDOM.currentTime != totTime) ? mainVideo.videoDOM.play() : mainVideo.videoDOM.pause();
    }
  });

  $('.timeLineWrap').on("mouseenter",function(){
	  $('.timeLine > .ui-slider-handle').fadeIn(100);
	  
	  if(bolIntranet) $('.titmeLineThumbnailWrap').fadeIn(100);
  });
  
  if(bolIntranet) 
  {
	  $('.titmeLineThumbnail').css("background",'url("'+ snakeImgPath +'")');  // 이미지 변경
    //$('.titmeLineThumbnail').css("background",'url("'+ "http://100.1.48.20/KUBE/video/2019/1022/19102208390885_05102049.jpg" +'")');  // 이미지 변경
    // $('.titmeLineThumbnail').css("background",'url("'+ 이미지경로변수 +'")');
    $('.timeLineWrap').on("mousemove",function(event){
      var tempLeft = event.pageX - (($('.titmeLineThumbnailWrap').width() * contentZoomScale) / 2); // 마우스 위치 대비 썸네일 위치 지정
      var tempMax = ($('.timeLineWrap').width() * contentZoomScale) - ($('.titmeLineThumbnailWrap').width() * contentZoomScale);    // 썸네일 최대 위치 
      var tempTimePercent = Math.floor(mainVideo.videoDOM.duration * (event.pageX / ($('.timeLineWrap').width() * contentZoomScale))); // 동영상 전체 시간 * (마우스 위치 / 전체 타임라인 바 넓이)
      tempLeft = (tempLeft <= 0)? 0 : tempLeft; 
      tempLeft = (tempLeft >= tempMax)? tempMax : tempLeft; 
      $('.titmeLineThumbnailWrap').css("left",tempLeft);

      const thumbnailWidth = 120; //썸네일 한 개 넓이 
      const thumbnailHeight = 80; //썸네일 한 개 높이 
      var thumbnailMaxX = thumbnailWidth * 20;   // 썸네일 한개 넓이 * 가로 갯 수 = 총 넓이
      var curThumbnailX = tempTimePercent * thumbnailWidth; // 영상 시간(초) * 썸네일 한개 넓이 = 현재 x좌표
      var curThumbnailY =  Math.floor(curThumbnailX / thumbnailMaxX) * thumbnailHeight; // x좌표 / 총 넓이 * 썸네일 높이 = 현재 y좌표

      curThumbnailY = (Math.floor(curThumbnailX / thumbnailMaxX) * thumbnailHeight) * -1;
      curThumbnailX = (curThumbnailX - (thumbnailMaxX * Math.floor(curThumbnailX / thumbnailMaxX))) * -1

      $('.titmeLineThumbnail').css("background-position-x",curThumbnailX)
      $('.titmeLineThumbnail').css("background-position-y",curThumbnailY)

      $('.ThumbnailTime').html(clock(tempTimePercent)); // 썸네일 시간 
    });
  }
  
  
  $('.timeLineWrap').on("mouseleave focusout",function(){
	  $('.timeLine > .ui-slider-handle').fadeOut(100);
	  if(bolIntranet) $('.titmeLineThumbnailWrap').hide(1);
  });

  $('.soundLine').slider({
    range: "min",
    max: 100,
    value: 50,
    change: function()
    {
      var persent = $('.soundLine').slider('value');
      mainVideo.videoDOM.volume = persent / 100;
      mainVideo.volume = persent / 100;
    }
  });



  //버튼 객체 생성
  help = new setButton($('.help'), "학습도우미", _this.tabIndex++, false);
  map = new setButton($('.map'), "러닝맵", _this.tabIndex++, false);
  down = new setButton($('.down'), "다운로드", _this.tabIndex++, false);
  ebook = new setButton($('.ebook'), "e-book", _this.tabIndex++, true);
  spd1 = new setButton($('.speed1'), "0.8배속", _this.tabIndex++, false);
  spd2 = new setButton($('.speed2'), "1.0배속", _this.tabIndex++, false);
  spd3 = new setButton($('.speed3'), "1.2배속", _this.tabIndex++, false);
  spd4 = new setButton($('.speed4'), "1.5배속", _this.tabIndex++, false);
  spd5 = new setButton($('.speed5'), "2.0배속", _this.tabIndex++, false);
  qualityLow = new setButton($('.qualityLow'),"저화질", _this.tabIndex++, false);
  qualityHigh = new setButton($('.qualityHigh'),"고화질", _this.tabIndex++, false);
  menu = new setButton($('.menu'), "목차", _this.tabIndex++, true);
  additional = new setButton($('.additional'), "부가메뉴", _this.tabIndex++, true);
  //스크랩 객체는 따로 함수에서 정의
  this.fnSetScrap();
  // this.fnSetBookMark();
  search = new setButton($('.searchBtn'), "인터넷검색", _this.tabIndex++, true);
  note = new setButton($('.note'), "마이노트", _this.tabIndex++, false);
  playPause = new setButton($('.playPause'), "재생/일시정지", _this.tabIndex++, false);
  replay = new setButton($('.replay'), "다시보기", _this.tabIndex++, false);
  sound = new setButton($('.sound'), "소리", _this.tabIndex++, true);
  mobile_down = new setButton($('.mobile_down'), "영상다운", _this.tabIndex++, true);
  quality = new setButton($('.quality'), "화질선택", _this.tabIndex++, true);
  script = new setButton($('.script'), "자막", _this.tabIndex++, true);
  scriptSearch = new setButton($('.scriptSearch'), "자막검색", _this.tabIndex++, true);
  setUp = new setButton($('.setUp'), "배속", _this.tabIndex++, true);
  fullscreen = new setButton($('.fullscreen'), "전체화면", _this.tabIndex++, true);
  prevPage = new setButton($('.prevPage'), "이전페이지", _this.tabIndex++, true);
  nextPage = new setButton($('.nextPage'), "다음페이지", _this.tabIndex++, true);

  $('.curPage').html(strPage);
  $('.totPage').html(itostr(totalPage));

	//////////////////////////////////
  this.fnSetComponent();
}

//버튼객체의 기능 정의
setController.prototype.fnSetComponent = function(){

  var _this = this;
  // 메뉴 펼치기
  menu.fnButtonOnClick(function(){
    _this.fnToggleOff($('.indexMenu'));
    var menuWidth = $('.indexMenu').css('width').split("px")[0] *1;
    if($('.indexMenu').css("display") == "none"){
      $('.indexMenu').fadeIn(100)
      $('.indexMenu').css("left","0px");
    }
    else {
      $('.indexMenu').fadeOut(100);
      $('.indexMenu').css("left", -menuWidth );
    }
  });
  // 학습도우미
  help.fnButtonOnClick(function(){
    if(pageInfo[curChapter].quiz != curPage) mainVideo.videoDOM.pause();
    tempPopup = window.open( "../common/pop/help/help.html", "help",'width=865, height=597');
    if(pageInfo[curChapter].quiz != curPage){
    tempPopup.onbeforeunload = function()
    {
      tempPopup.opener.focus();
      if($('.curTime').text() != $('.totTime').text()) mainVideo.videoDOM.play();
    }
  }
  });
  
  // 러닝맵
  map.fnButtonOnClick(function(){
    if(pageInfo[curChapter].quiz != curPage) mainVideo.videoDOM.pause();
    tempPopup = window.open( "../common/map/map.html", "help",'width=600, height=700');
    if(pageInfo[curChapter].quiz != curPage){
    tempPopup.onbeforeunload = function()
    {
      tempPopup.opener.focus();
      if($('.curTime').text() != $('.totTime').text()) mainVideo.videoDOM.play();
    }
    }
  });
  // 모바일 영상 다운로드
  mobile_down.fnButtonOnClick(function(){

    var message = confirm("오프라인에서 시청 할 수 있는 영상 다운로드 입니다.\r3G/4G/5G망으로 접속시 데이터 요금이 부과 될 수 있습니다.\r또한 저장된 영상은 진도와 무관한 학습용 영상입니다. \r다운로드 하시겠습니까?");
    if (message) {
      window.open(mainVideo.moviePath, "_down");
    } else {
      return false;
    }
    
  });
  // e-book
  ebook.fnButtonOnClick(function(){
    var wid = eval(screen.availWidth); // 모니터 가로
    var hig = eval(screen.availHeight); // 모니터 세로
    
		// window.open("../common/ebook/ebook.html", "innerebook","width=1275,height=715");
    window.open("../common/ebook/web/viewer.html?file=../01.pdf", "_ebook", '"resizable=yes,top=0,left=0,width='+ wid +',height='+ hig +'"');
  });
  // 부가메뉴 펼치기
  additional.fnButtonOnClick(function(){
    _this.fnToggleOff('supportWrap');
    ($('.supportWrap').css("display") == "none") ? $('.supportWrap').show() : $('.supportWrap').hide();
  });
  // 포털 검색
  search.fnButtonOnClick(function(){
    // alert("준비 중 입니다.")
    _this.fnToggleOff('searchWrap');
    ($('.searchWrap').css("display") == "none") ? $('.searchWrap').show() : $('.searchWrap').hide();
  });
  // 자막 펼치기
  script.fnButtonOnClick(function(){
    ($('.scriptWrap').css("display") == "none") ? $('.scriptWrap').show() : $('.scriptWrap').hide();
  });
  // 속도 설정
  setUp.fnButtonOnClick(function(){
    _this.fnToggleOff('speedWrap');
    ($('.speedWrap').css("display") == "none") ? $('.speedWrap').show() : $('.speedWrap').hide();
  });
  // 소리 설정
  sound.fnButtonOnClick(function(){
    (mainVideo.videoDOM.volume != 0)? $('.soundLine').slider('value', 0) : $('.soundLine').slider('value', 50);
  });


  quality.fnButtonOnClick(function(){
    _this.fnToggleOff('qualityWrap');
    ($('.qualityWrap').css("display") == "none") ? $('.qualityWrap').show() : $('.qualityWrap').hide();
  });
  qualityLow.fnButtonOnClick(function(){
    if(videoQuality == "low") return false;
    fnVideoQuality("low");
  });
  qualityHigh.fnButtonOnClick(function(){
    if(videoQuality == "high") return false;
    fnVideoQuality("high");
  });

  function fnVideoQuality(){
      videoQuality = (videoQuality == "high")? "low" : "high";
      $('.playPause').parent().find(".tooltips").text("재생");
      $('.playPause').attr("title", "재생");
      var getVideoPath = videopath;
      if(videoQuality == "high")
      {
        $('.qualityLow').removeClass("toggle");
        $('.qualityHigh').addClass("toggle");
        if(bolIntranet) var tempPath = videopath;
      }
      else
      {
        $('.qualityHigh').removeClass("toggle");
        $('.qualityLow').addClass("toggle");
        if(bolIntranet) var tempPath = getVideoPath.replace('.mp4','_0.mp4');
      }
      if(!bolIntranet) //로컬 확인 용
      {
        var tempName = (videoQuality == "low")? strInitial + strChapter + "_" +  strPage +  "_low.mp4" : strInitial + strChapter + "_" +  strPage + ".mp4"; 
        var tempPath = "../mov/"+ strChapter + "/" + tempName  // PC 영상 위치
      }
      
      var tempTime = mainVideo.videoDOM.currentTime;
      mainVideo.videoDOM.src = tempPath;
      mainVideo.videoDOM.addEventListener('durationchange', function() {
        mainVideo.videoDOM.currentTime = tempTime;
      });
      mainVideo.videoDOM.play();
   
  }


  // 전체화면
  fullscreen.fnButtonOnClick(function(){
    var target = $('body').get(0);
    // if(mobileOS) target = $('.video1').get(0);
    // if( osType == "iPhone OS" ) target.webkitEnterFullscreen();
    if (!fullBol)
    {
        if (target.requestFullscreen) target.requestFullscreen();
        else if (target.msRequestFullscreen) target.msRequestFullscreen();
        else if (target.mozRequestFullScreen) target.mozRequestFullScreen();
        else if (target.webkitRequestFullscreen) target.webkitRequestFullscreen();
    }
    else
    {
        if (parent.document.exitFullscreen) parent.document.exitFullscreen();
        else if(parent.document.msExitFullscreen) parent.document.msExitFullscreen();
        else if (parent.document.mozCancelFullScreen) parent.document.mozCancelFullScreen();
        else if (parent.document.webkitCancelFullScreen) parent.document.webkitCancelFullScreen();
    }
  });

  //속도 설정
  spd1.fnButtonOnClick(function(){ _this.fnSetPlayBackRate(0.8, spd1.$target) });
  spd2.fnButtonOnClick(function(){ _this.fnSetPlayBackRate(1.0, spd2.$target) });
  spd3.fnButtonOnClick(function(){ _this.fnSetPlayBackRate(1.2, spd3.$target) });
  spd4.fnButtonOnClick(function(){ _this.fnSetPlayBackRate(1.5, spd4.$target) });
  spd5.fnButtonOnClick(function(){ _this.fnSetPlayBackRate(2.0, spd5.$target) });

  // 재생,일시정지
  playPause.fnButtonOnClick(function(){
    // (mainVideo.videoDOM.paused) ? setJindo = setInterval(function(){ parent.playTime++; }, 1000 / mainVideo.speed) : clearInterval(setJindo);
    (mainVideo.videoDOM.paused) ? mainVideo.videoDOM.play() : mainVideo.videoDOM.pause();
    
  });
  // 다시보기
  replay.fnButtonOnClick(function(){
    mainVideo.videoDOM.currentTime = 0;
    mainVideo.videoDOM.play();
    if(pageInfo[curChapter].quiz == curPage)
    {
      $('.quiz_intro').fadeIn(1);
      quiz.againQuiz();
      quiz.$quiz.hide();
    }
    else if(itrBol){
      mainVideo.$video.fadeIn(1);
      
      if(typeof pracInit == 'function'){
    	  pracInit();
      }
    }
  });

  // 다음페이지
  nextPage.fnButtonOnClick(function(){
    nextMovePage();
  });
  // 이전페이지
  prevPage.fnButtonOnClick(function(){
    prevMovePage();
  });

  fnSetSubButton($('.mobile_play_btn'),'재생',_this.tabIndex++, function() {
    mainVideo.videoDOM.play();
    $('.mobile_play_btn').hide();
    $('.playPause').addClass('pause');
    $('.playPause').removeClass('play');
  });

}


//버튼 클릭시 나머지 버튼 사라짐
setController.prototype.fnToggleOff = function(_target){
  if(_target != 'speedWrap') {
    $('.speedWrap').hide();
    $('.speedWrap').removeClass('toggle');
  }
  if(_target != 'qualityWrap') {
    $('.qualityWrap').hide();
    $('.qualityWrap').removeClass('toggle');
  }
}


//배속기능
setController.prototype.fnSetPlayBackRate = function(_spd,_target){
  mainVideo.videoDOM.playbackRate = _spd;
  for(var i=1; i<=5; i++){
    var togleClear = $('.speed'+i);
    togleClear.removeClass("toggle");
  }
  _target.addClass("toggle");
  mainVideo.speed = _spd;
  
  // clearInterval(setJindo)
  // setJindo = setInterval(function(){ parent.playTime++; }, 1000 / _spd);
}

//스크랩기능
setController.prototype.fnSetScrap = function(){
  var _this = this;
  scrap = new setButton($('.bookMark'), "스크랩", _this.tabIndex++, false);

  scrap.fnButtonOnClick(function(){
    _this.fnToggleOff('scrapWrap');
    ($('.scrapWrap').css("display") == "none") ? $('.scrapWrap').show() : $('.scrapWrap').hide();
  });

  for(i=1; i<=totalPage; i++)
  {
    if( i % 10 == 0 ) var $scrapBox = $('<span class="scrapBox box_'+ i +'">'+ itostr(i) +'</span><br><br>')
    else var $scrapBox = $('<span class="scrapBox box_'+ i +'">'+ itostr(i) +'</span>')
    var scrap =  new setButton($scrapBox, i+"페이지 이동", _this.tabIndex++, false);
    scrap.fnScrapOnClick();
    $('.ScrapList').append($scrapBox);
  }
  var scrapAdd = new setButton($('.scrapAdd'),"스크랩 추가", _this.tabIndex++, false);
  scrapAdd.fnButtonOnClick(function(){
    if(scrapCookieList.indexOf(curPage) != -1) return;
    else{
      if(scrapCookieList != "" && scrapCookieList != "undifiend") scrapCookieList = scrapCookieList +"_"+curPage;
      else scrapCookieList = curPage;
      $('.ScrapList').find('.box_'+curPage).show();
    }
  });

  var scrapEdit = new setButton($('.scrapEdit'),"스크랩 편집/삭제", _this.tabIndex++, false);
  scrapEdit.fnButtonOnClick(function(){
    if(!_this.scriptToggle){
      $('.scrapEdit').addClass('toggle');
      $('.scrapInfo').html('페이지 버튼을<br>클릭하면 삭제됩니다');
    }
    else{
      $('.scrapEdit').removeClass('toggle');
      $('.scrapInfo').html('"스크랩 추가"를 한<br>페이지가 표시됩니다');
    }
    _this.scriptToggle = !_this.scriptToggle;
  });

}