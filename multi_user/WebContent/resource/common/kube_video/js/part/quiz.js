function setQuiz(_xml)
{

    this.xml = _xml;
    this._try = 0;
    this._chance = 0;
    this._curPage = 1;
    this._totalPage = 0;
    this._correct = 0;
    this._answer = new Array();
    this._userAnswer = new Array();
    this._quizIndex = 50;
    this._colorOver = "#993300";
    this._nativeColor = "#ff9600"; //부정어 색깔
    this._color = "#000000";
    
    
    this._moduleBol = (curPage == "2")? true : false;
    //20190404 부정어 배열 +0425 먼 추가
    this._tmpNegativeString = ["틀린", "어려운", "아닌", "잘못된", "않는", "않은", "힘든", "잘못", "없는"," 먼 ","못한","불가능한"];
    this.$quiz = null;
    
    this.fnAjaxToEventXml();
}

setQuiz.prototype.quizRefresh = function(){
  this.$quiz.remove();
  this.fnAjaxToEventXml();
}

setQuiz.prototype.fnAjaxToEventXml = function(){
  var _this = this;
  $.ajax({
    url : "./xml/event.xml",
    type : "POST",
    success : function(xml){
      $(xml).find("quiz").each(function() {
        if($(this).attr("flag") == curPage) {
          quizPage = true;
          _this.initQuiz(xml);
        }
      });
    }
  });
}

// 이미지로 제어
setQuiz.prototype.initQuiz = function(_xml){


  var _this = this;
  _this.xml = _xml;
  _this.$quiz = "";

  
  //모듈평가에 사용 (문제 많을 시)



  $(_xml).find("quiz").each(function() {
    if($(this).attr("flag") == curPage)
    {
      
      var totalPage = $(this).find("page").length;
      var quizType = $(this).attr("type");
      _this.$quiz = $('<div class="quiz '+ quizType +'"><img src="../common/img/title/leftTitle_'+strChapter+'.png" style="left: 0px; top: 0px; position: absolute;" class="leftTitle_'+strChapter+'"/><div class="wrong_answer"></div><div class="none_check"></div></div>');

      if(_this._moduleBol) _this.$quiz.append('<div class="module totalQuizpage">'+ $(_xml).find("quiz > page").length  +'</div>')
      $(this).find("page").each(function(){
        var pageNum = $(this).attr("num");
        var pageType = $(this).attr("type");

        //20190404 부정어 처리 
        var quizAlternative = "";
        var nativeOn = false;
        for(var i=0; i<=_this._tmpNegativeString.length; i++)
        {
          if($(this).find('question > text').text().indexOf(_this._tmpNegativeString[i]) != -1) 
          {
            quizAlternative = $(this).find('question > text').text().replace(_this._tmpNegativeString[i], '<span style="color:'+_this._nativeColor+'; font-size:30px; text-decoration: underline;">'+_this._tmpNegativeString[i]+'</span>');
            nativeOn = true;
            break;
          }
        }
        if(!nativeOn){
          quizAlternative = $(this).find('question > text').text();
          nativeOn = false;
        }

        _this._answer[pageNum] = $(this).attr("answer");
        var quest = $(
         '<div class="page flag_' + pageNum + '">\
           <div class="question ' + quizType + '">\
           <div class="symbol '+quizType+'"><div class="symbol '+quizType+' symbol_'+pageNum+'"></div>\
           <div class="o_symbol ' + quizType + '"></div>\
           <div class="x_symbol ' + quizType + '"></div>\
           </div>\
           <div class="text '+ quizType +'">' + quizAlternative + '</div>\
           </div>\
           <div class="direction"><div class=text></div></div>\
           <div class="example '+ quizType + '"><div class="bg"></div></div>\
           <button class="confirm '+ quizType +'"></button>\
           <div class="feedback '+ quizType + '"></div>\
         </div>'
        );

        //모듈평가에 사용 (문제 많을 시)
        if(_this._moduleBol)
        {
          _this.$quiz.addClass("module");
          quest.addClass("module");
          quest.find('.symbol > .symbol').addClass("module").removeClass("symbol_" + pageNum).html('<span style="color:#8AC13A;">Q</span>' + '<span>'+pageNum+'</span>' ); 
          
        }

        var questionTitle = "";
        var tempTitleArr = ["","일","이","삼","사","오","육","칠","팔","구","십"];
        var tempTens = (pageNum > 10)?  (pageNum / 10).toFixed(0) : 0;
        var tempUnits  = pageNum % 10
        if(pageNum >= 20) questionTitle = "문제 " + tempTitleArr[tempTens] + "십" + tempTitleArr[tempUnits] + "번 "
        else if(pageNum >= 10 && pageNum < 20) questionTitle = "문제 " + "십" + tempTitleArr[tempUnits] + "번 "
        else questionTitle = "문제 " + tempTitleArr[tempUnits] + "번 "

        fnsetSubTitle(quest.find(".question"),questionTitle + $(this).find("question > text").text(),_this._quizIndex++);

        if($(this).find('direction> text').text()!="")
        {
          quest.find(".direction > .text").html($(this).find('direction > text').text());
          fnsetSubTitle(quest.find(".direction"),"지문 : " + $(this).find("direction > text").text(),_this._quizIndex++);
          quest.find(".direction").show();
          quest.find(".example").addClass("half");
        }

        $(this).find("example").each(function(){
          var examNum = $(this).attr("num");
          var exam = $('');
          if(pageType=="half") //보기가 2개인 경우
          {
            exam = $('<button class="'+pageType +' '+ pageType + '_' + examNum  + " " + quizType + ' ">\
                            <div class="symbol '+quizType+'"></div><span class="text"></span></button>');
          }
          else if(pageType=="multiple") // 보기가 여러개일 경우
          {
            exam = $('<li class="'+pageType +' '+ pageType + '_' + examNum + '"><div class="btn'+$(this).attr("num")+'"></div>\
                            <span class="text">' + $(this).find("text").text() + '</span></li>');
          }
          quest.find(".example").append(exam);
          var examTitle = "";
          switch(examNum){
            case "1":
            examTitle = "보기 일번 "
            break;
            case "2":
            examTitle = "보기 이번 "
            break;
            case "3":
            examTitle = "보기 삼번 "
            break;
            case "4":
            examTitle = "보기 사번 "
            break;
            case "5":
            examTitle = "보기 오번 "
            break;
          }
          fnsetSubTitle(exam,examTitle + $(this).find("text").text(),_this._quizIndex++);
          exam.on('click keydown', function(e) {
            if(e.type=="keydown" && e.key!="Enter") return;
            _this._userAnswer[pageNum] = examNum;
            $(this).find("div").addClass("toggle");
            $(this).closest(".example").find('div').not($(this).find("div")).removeClass("toggle");
            $(this).closest(".example").find('.'+pageType).not($(this)).css("color",_this._color);
            $(this).css("color",_this._colorOver);
          });
          exam.on('mouseover', function() {
              $(this).css("color",_this._colorOver);
          });
          exam.on('mouseleave', function() {
              $(this).css("color",_this._color);
          });
        });
        
        quest.find(".feedback").append($('<div class="answer '+ quizType +'">\
                                            <span class=" '+ quizType + ' text text_'+  _this._answer[pageNum] +'"></div></div>\
                                          <div class="explain '+ quizType + '"><span class="text '+ quizType + '">' + $(this).find("feedback > text").text() + '</span></div>'));
        quest.find(".feedback").css("display","none");
        if(pageNum == totalPage) {
          if(quizType != "pretest" && quizType != "sudden" ) quest.find(".feedback").append($('<button class="result_btn '+ quizType +'"></button>'));
        }
        else quest.find(".feedback").append($('<button class="next_btn '+ quizType + '"></button>'));

        if(pageNum != 1)quest.find(".feedback").append($('<button class="prev_btn '+ quizType + '"></button>'));


        var peedbackTitle = "";
        switch(_this._answer[pageNum]){
          case "1":
            peedbackTitle = "정답은 일번입니다. "
          break;
          case "2":
            peedbackTitle = "정답은 이번입니다."
          break;
          case "3":
            peedbackTitle = "정답은 삼번입니다."
          break;
          case "4":
            peedbackTitle = "정답은 사번입니다."
          break;
          case "5":
            peedbackTitle = "정답은 오번입니다."
          break;
        }

        fnsetSubTitle(quest.find(".feedback"),peedbackTitle +$(this).find("feedback > text").text(),_this._quizIndex++);


        _this.$quiz.append(quest);

        //확인하기 버튼 처리
        fnSetSubButton(quest.find(".confirm"),'정답 확인',_this._quizIndex++, function() {
          

          if(_this._userAnswer[pageNum]=="" || _this._userAnswer[pageNum]==undefined) //체크 안했을떄
          {
            _this.$quiz.find(".none_check").fadeIn(300).delay(500).fadeOut(300);
            return;
          }
          _this._chance = (pageType=="half" || _this._moduleBol)? 1 : 2;
          _this._try++;
          if(_this._userAnswer[pageNum]==_this._answer[pageNum]) // 정답일떄
          {
            setAudio('o_sound');
            _this._correct++;
            quest.find(".confirm").hide(10);
            quest.find(".feedback").show(100);
            if(pageType=="half"){
              _this.$quiz.find(".flag_"+ pageNum +" > .example > .half").off();
              _this.$quiz.find(".flag_"+ pageNum +" > .example > .half_"+_this._answer[pageNum] ).addClass("toggle");
              _this.$quiz.find(".flag_"+ pageNum +" > .question > .symbol > .o_symbol").css("display","block");
              if(pageNum == totalPage) endVideo();
            }
            if(pageType=="multiple")
            {
              _this.$quiz.find(".flag_"+ pageNum +" > .question > .symbol > .o_symbol").css("display","block");
              _this.$quiz.find(".flag_"+ pageNum +" > .example > .multiple").off();
              _this.$quiz.find(".flag_"+ pageNum +" > .example > .multiple_"+_this._answer[pageNum]).css("color",_this._colorOver);
            }
          }
          else if(_this._try < _this._chance)
          {
            setAudio('x_sound');
            _this.$quiz.find(".wrong_answer").fadeIn(300).delay(500).fadeOut(300); //오답이지만 기회 남았을떄
            _this._userAnswer[pageNum]="";
            _this.$quiz.find(".flag_"+ pageNum +" > .example > .multiple  > .toggle").removeClass("toggle");
          }
          else //최종 오답
          {
            setAudio('x_sound');
            quest.find(".confirm").hide(10);
            quest.find(".feedback").show(100);
            _this.$quiz.find(".flag_"+ pageNum +" > .question > .symbol > .x_symbol").css("display","block");
            if(pageType=="half"){
              _this.$quiz.find(".flag_"+ pageNum +" > .example > .half").off();
              _this.$quiz.find(".flag_"+ pageNum +" > .example > .half_"+_this._answer[pageNum] ).addClass("toggle");    
              if(pageNum == totalPage) endVideo();      
            }
            else if(pageType=="multiple"){
              _this.$quiz.find(".flag_"+ pageNum +" > .example > .multiple  > .btn"+_this._answer[pageNum]).addClass("correct");
              _this.$quiz.find(".flag_"+ pageNum +" > .example > .multiple_"+_this._answer[pageNum]).css("color",_this._colorOver);
              _this.$quiz.find(".flag_"+ pageNum +" > .example > .multiple").off();
            }
        
          }
        });
        //다음 문제 버튼
        fnSetSubButton(quest.find(".feedback > .next_btn"),'다음 문제',_this._quizIndex++, function() {
          var nextPageNum = pageNum * 1 + 1;
          _this.$quiz.find(".flag_"+pageNum).hide(10);
          _this.$quiz.find(".flag_"+nextPageNum).show(10);
          _this._try = 0;
        });
        //이전 문제 버튼
        fnSetSubButton(quest.find(".feedback > .prev_btn"),'이전 문제',_this._quizIndex++, function() {
          var nextPageNum = pageNum * 1 - 1;
          _this.$quiz.find(".flag_"+pageNum).hide(10);
          _this.$quiz.find(".flag_"+nextPageNum).show(10);
          _this._try = 0;
        });
        //결과 보기 버튼
        fnSetSubButton(quest.find(".feedback > .result_btn"),'결과 보기',_this._quizIndex++, function() {
          _this.$quiz.find(".flag_"+pageNum).hide(10);
          _this.showBoard(totalPage);
        });
        if(pageNum != 1) quest.css("display","none");
      });
    }
    
    $('.contents').append(_this.$quiz);
    // if(noVideoArr) _this.$quiz.show();
  });


}



setQuiz.prototype.showBoard = function(_totPage){
  _this = this;
  

  if(_this._moduleBol)
  {
    _this.$quiz.css("background","url(../common/img/module/result_bg.png)");
    var resultBoard=$('<div class="board module"><div class="score_middle">score : '+ _this._correct +'</div>\
                          <div clss="score_bottom"><span style="font-size: 40px; vertical-align: middle;">'+ $(_this.xml).find("quiz > page").length +'</span>\
                           문제중 <span style="font-size: 40px; vertical-align: middle; color: #ff9600;">'+ _this._correct + '</span>문제 맞았습니다.</div>\
                           <button class="explanation"></button><button class="retry"></button>\
                       </div>');
  }
  else
  {
    _this.$quiz.css("background","url(../common/img/quiz/result_bg.png)");
    var resultBoard=$('<div class="board"><div class="top"><div class="symbol"></div><div class="totPage">'+_totPage+'</div>\
        <div class="explain">'+_this._correct+'</div></div>\
        <div class="middle"></div><button class="retry"></button></div><div class="quizTitle"></div>');
    resultBoard.find('.top > .explain').addClass("explain_" + _this._correct);
    fnsetSubTitle(resultBoard.find('.top > .explain'),"총 " + _totPage +"문제 중 " +_this._correct+" 문제를 맞히셨습니다.",_this._quizIndex++);
    for(var i=1; i<=_totPage; i++)
    {
      var temp = $('<div class="result result_'+ i +'"><div class="symbol"></div><div class="checkSymbol"></div></div>');
      if(_this._userAnswer[i]==_this._answer[i]) temp.find('.checkSymbol').addClass("o_symbol");
      else temp.find('.checkSymbol').addClass("x_symbol");

      resultBoard.find('.middle').append(temp);
    }
  }
  
  fnSetSubButton(resultBoard.find('.retry'),'다시 풀기',_this._quizIndex++, function() {
    _this.againQuiz();
    _this._userAnswer = [];
  });

  fnSetSubButton(resultBoard.find('.explanation'),'해설 보기',_this._quizIndex++, function() {
    _this.$quiz.css("background","url(../common/img/module/background.png)");
    resultBoard.fadeOut(1);
    $('.prev_btn').fadeIn(1);
    $('.flag_1').fadeIn(100);
  });
  _this.$quiz.append(resultBoard);
  endVideo();







}


setQuiz.prototype.againQuiz = function(){
  this._try = 0;
  this._chance = 0;
  this._curPage = 1;
  this._totalPage = 0;
  this._correct = 0;
  this._userAnswer = [];
  this.$quiz.remove();
  this.initQuiz(this.xml);
  this.$quiz.show(1);
  $('.prev_btn').hide(1);
}
