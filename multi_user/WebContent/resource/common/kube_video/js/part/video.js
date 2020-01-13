function setVideo(selector){
  this.$video = null;
  this.videoDOM = null;
  this.curTime = null;
  this.totTime = null;
  this.speed = 1;
  if(mobileOS) this.volume = 0.5;
  else if(document.cookie.length>0){
    if(getCookie("soundCookie")) this.volume = getCookie("soundCookie") * 1;
    else this.volume = 0.5;
  }
  else this.volume = 0.5;
  this.movieName = strInitial + strChapter + "_" +  strPage +".mp4"; //영상 이름

  // if(bolIntranet) this.moviePath = "http://100.1.48.20/KUBE/video/" + strChapter + "/" + this.movieName  // 사내망 영상 위치
  if(bolIntranet) this.moviePath = videopath;  // 사내망 영상 위치 테스트
  else this.moviePath = "../mov/"+ strChapter + "/" + this.movieName  // PC 영상 위치
  

  if(curPage == pageInfo[curChapter].quiz) 
  {
    $('.contents').append('<audio id="audio1" class="audio1" autoplay="" controls="none"></audio><div class="quiz_intro"><div>');
    this.moviePath = "../common/audio/quiz_nar.mp3";
    $('.video1').hide();
  }
  
  //한전 외부망 이어보기
  if(bolPorted)
  {
    this._lastPgr = 0;
    try {
      this._lastPgr = parent.fnGetQuerystring("lastPgr");
      if(this._lastPgr != "0" && this._lastPgr != 'undefined')  this._lastPgr = Number(this._lastPgr);
      else this._lastPgr = 1;
    } catch (e) {
      console.log(e)
    }  
  }


  
  if(pageInfo[curChapter].quiz != curPage) this.fnInitialization(selector);
  else this.fnInitializationSound($('.audio1'));

  

}

setVideo.prototype.fnInitialization = function(selector){
  var _this = this;
  this.$video = selector;
  this.videoDOM = this.$video.get(0);
  this.videoDOM.src = this.moviePath;
  if(bolIntranet) this.videoDOM.poster = thumbPath;
  //비디오 로딩완료 시점
  this.videoDOM.addEventListener('durationchange', function() {
    _this.totTime = _this.videoDOM.duration;
    parent.totalTime = Number(_this.totTime.toFixed(0));
    _this.videoDOM.volume = _this.volume;
    $('.soundLine').slider('value',_this.videoDOM.volume * 100);
    _this.videoDOM.playbackRate = _this.speed;
    $('.totTime').html(clock(_this.totTime));
    _this.fnVideoTrigger(_this.$video); //비디오트리거 호출
    if(bolPorted) this.currentTime = _this._lastPgr;
    else if(bolIntranet)  // 사내망 이어보기 
    {
      if((parent.lmsTime != 0 && parent.lmsTime != "undefined" && !parent.lmsPassed))
      {
    	  if(typeof parent.playerCtrl == 'function' && parent.channel == 'elearn')
    		  parent.playerCtrl(this);
      }
    }
  }, false);
}

setVideo.prototype.fnInitializationSound = function(selector){
  var _this = this;
  this.$video = selector;
  this.videoDOM = this.$video.get(0);
  this.videoDOM.src = this.moviePath;
  //비디오 로딩완료 시점
  this.videoDOM.addEventListener('canplay', function() {
    _this.totTime = _this.videoDOM.duration;
    _this.videoDOM.volume = _this.volume;
    $('.soundLine').slider('value',_this.videoDOM.volume * 100);
    _this.videoDOM.playbackRate = _this.speed;
    $('.totTime').html(clock(_this.totTime));
    _this.fnVideoTrigger(_this.$video); //비디오트리거 호출
    this.play();
  }, false);
}



setVideo.prototype.fnVideoTrigger = function(selector){
  var _this = this;
  this.$video.on('timeupdate', function() {
    _this.fnTimeUpdate();
    _this.fnPopUpButtonUpdate();
    

  });

  //영상 완료 시
  this.$video.on('ended',function(){
    _this.videoDOM.pause();
    if(bolPorted) parent.fnSetParameter();
    else if(bolIntranet) parent.playComplete();  // 사내망 영상 완료 시
    // clearInterval(setJindo)
    if(itrBol){
      setAudio('page'+ curChapter +'_nar');
      $('.video1').fadeOut(500);
      $('.interactive').fadeIn(1);
      return;
    }
    else if(pageInfo[curChapter].quiz == curPage){
    }
    else if(curPage != totalPage)
    {
      endVideo();
    }

  });
  // 볼륨 변환 시
  this.$video.on('volumechange', function() {
    $('.soundLine').slider('value',_this.volume * 100);
    if(_this.videoDOM.volume == 0) {
      $('.sound').addClass('toggle');
      $('.sound').parent().find(".tooltips").text("소리 켬");
      $('.sound').attr("title", "소리 켬");
    }
    else{
      $('.sound').removeClass('toggle');
      $('.sound').parent().find(".tooltips").text("소리 끔");
      $('.sound').attr("title", "소리 끔");
    }
  });
      // 일시정지일 떄
  this.$video.on('pause', function() {
    
    if(bolIntranet) parent.playTime(this.currentTime, 2);  // 사내망 일시정지 시 
    $('.playPause').addClass('play');
    $('.playPause').removeClass('pause');
    if(_this.videoDOM.currentTime != _this.videoDOM.duration && mobileOS) $('.mobile_play_btn').show();
    else{
      $('.playPause').parent().find(".tooltips").text("재생");
      $('.playPause').attr("title", "재생");
    }
  });
  // 재생 중일 때
  this.$video.on('play', function() {
    $('.sliderContents').css("display", "none");
    $('.playPause').addClass('pause');
    $('.playPause').removeClass('play');
    _this.videoDOM.playbackRate = _this.speed;
    if(mobileOS) $('.mobile_play_btn').hide();
    else{
      $('.playPause').parent().find(".tooltips").text("일시정지");
      $('.playPause').attr("title", "일시정지");
      $('.mobile_play_btn').hide();
      
      if(itrBol){
    	  if($('.video1').css('display') == 'none'){
    		  $('.interactive').fadeOut(500);
    		  $('.video1').fadeIn(1);
    	  }
        }
    }
    // playVideo();
  });

}

setVideo.prototype.fnTimeUpdate = function(){
  this.curTime = (this.videoDOM.currentTime >= this.videoDOM.duration)? this.videoDOM.duration : this.videoDOM.currentTime;
  if(nCurTime <= this.curTime) nCurTime = this.curTime;
  $('.curTime').html(clock(this.curTime));
  var percent = this.curTime / this.totTime * 100;
  if(bolIntranet && !lmsPassed) curProgress = (curProgress >= percent * 10)? curProgress : percent * 10; //curProgress range : 0 ~ 1000
  else curProgress = 1000;
  if(percent >= 100) percent = 100;
  percent = percent.toFixed(1) + "%"
  $('.timeLine >.ui-slider-handle').css('left',percent);
  $('.timeLine >.ui-slider-range').width(percent);
}




setVideo.prototype.fnPopUpButtonUpdate = function(){
  var _this = this;
  if(pageInfo[curChapter][curPage] != undefined)
  { 
    for(var i=1; i<=Object.keys(pageInfo[curChapter][curPage]).length; i++){
      var itostrI = itostr(i);
      if(pageInfo[curChapter][curPage]["pop"+itostrI].time != undefined)
      {
        var popupStartTime = secClock(pageInfo[curChapter][curPage]["pop"+itostrI].time.split("~")[0]);
        var popupEndTime = secClock(pageInfo[curChapter][curPage]["pop"+itostrI].time.split("~")[1]);
        if(Object.keys(pageInfo[curChapter][curPage]).length > 1){
          if(_this.videoDOM.currentTime >= popupStartTime  &&  _this.videoDOM.currentTime <= popupEndTime) $('#'+strInitial + strChapter + '_' + strPage + '_pop' + itostr(i)).fadeIn(300);
          else $('#'+strInitial + strChapter + '_' + strPage + '_pop' + itostr(i)).hide(1);
        }
        else{
          if(_this.videoDOM.currentTime >= popupStartTime  &&  _this.videoDOM.currentTime <= popupEndTime) $('#'+strInitial + strChapter + '_' + strPage + '_pop').fadeIn(300);
          else $('#'+strInitial + strChapter + '_' + strPage + '_pop').hide(1);
        }
      }
      else{
        if(Object.keys(pageInfo[curChapter][curPage]).length > 1){
          if(_this.videoDOM.currentTime >= _this.videoDOM.duration - 10) $('#'+strInitial + strChapter + '_' + strPage + '_pop' + itostr(i)).fadeIn(300);
          else $('#'+strInitial + strChapter + '_' + strPage + '_pop' + itostr(i)).hide(1);
        }
        else{
          if(_this.videoDOM.currentTime >= _this.videoDOM.duration - 10) $('#'+strInitial + strChapter + '_' + strPage + '_pop').fadeIn(300);
          else $('#'+strInitial + strChapter + '_' + strPage + '_pop').hide(1);
        }
      }
    }
  }
}