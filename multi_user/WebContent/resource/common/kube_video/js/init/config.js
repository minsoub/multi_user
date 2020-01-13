//config

var pageInfo	= new Array();  // 페이지 정보
pageInfo[1] 	= {tPage:1, noVideo:"", interactive:"",quiz:"",slider:0};
pageInfo[3] 	= {tPage:1, noVideo:"", interactive:"1",quiz:"",slider:0};


// pageInfo[3][6] = { pop01 : {width:0, height:0, totalPage:0, time:"00:02:55~00:02:57", type:"down"}};

//내부망일 시 bolIntranet = true, 외부망일 시 bolPorted = true, 검수용은 전체 false
var bolIntranet = true; // 내부망 여부
var bolPorted = false; // 외부망여부
var bolTLock = false; //페이지 이동 제어
var bolPLock = false; //트래커 이동 제어
var menuType = "page"  // 메뉴타입 ("page : 페이지이동  time : 시간이동")
var scriptType = "search"  // 자막 검색 타입 ("jump : 화면이동  search : 자막검색")
var scriptVersion = "twoLine"  // 자막 버전 ("scroll : 스크롤 자막  twoLine : 두줄 자막")
var strClient = "kepco"
var strYear = "2019"
var strChapter = getURL(1); // 현재 차시(문자)
var strPage = getURL(0);    // 현재 페이지(문자);
var bolComplete				= false;
var nCurTime = 0;

var lmsTime = 0;
var lmsPassed = false;
var curProgress = 0;

var contentZoomScale = 1;

var osType = getOSType();                 // 사용 os
var browserType =  getBrowserType();      // 사용 browser
var mobileOS = (osType == "iPhone OS" || osType =="Android OS" || osType == "iPad");

var strInitial = "KF";                // 과정 이니셜
//var curPage = parseInt(getURL(0));    // 현재 페이지(정수)
//var curChapter = parseInt(getURL(1)); // 현재 차시(정수)

var curPage =1 
var curChapter =3
var totalPage = pageInfo[curChapter].tPage; //전체 페이지 수

var bolFScreen = false;   // 전체화면 여부 ( false : 창모드 true : 전체화면 )
var bolScript = false;    // vtt자막 활성화 여부 ( false : 활성화 true : 비활성화 )
var autoPassBol = false;  // 비디오 자동넘김 여부 ( false : 자동넘김x true : 자동넘김o )
var mediaSpd = 1;         // 비디오 초기 속도
var lastIndex = 200;      // 탭 시작 번호

var contentScale_x = 1;
var contentScale_y = 1;


var mainVideo = null;     //메인 비디오 객체
var controller = null;    //컨트롤바 객체
var fullBol = false;

var setJindo = "";

var quizPage = false;     // 현재 페이지가 퀴즈(상호작용)페이지인지 체크
var videoQuality = "high";

//쿠키
var strScrapCookie = strClient + "_" + strYear + "_" + strChapter + "_" + "scrap";
var scrapCookieList = "";

try{
  var popArr = pageInfo[curChapter].popup.split(","); // 내부팝업 페이지
  var popBol = false; //내부팝업 페이지 여부
  for(var j=0; j<= popArr.length; j++){
    var tmpPop = popArr[j] * 1;
    if(tmpPop == curPage) popBol = true;
  }  
}
catch(e){
}

try{
  var noVideoArr = pageInfo[curChapter].noVideo.split(","); // 내부팝업 페이지
  var noVideoBol = false; //영상 없는 페이지 여부 ( 없으면 true )
  for(var j=0; j<= noVideoArr.length; j++){
    var tmpPop = noVideoArr[j] * 1;
    if(noVideoArr == curPage) noVideoBol = true;
  }  
}
catch(e){
}

function getURL(_lastIndex)
{
  var url = document.location.href.split("/");
  return url[url.length - _lastIndex - 1].split(".")[0];
}


var itrArr = pageInfo[curChapter].interactive.split(","); // 상호작용 페이지
var itrBol = false; //상호작용 페이지 여부

for(var i=0; i<= itrArr.length; i++){
  var tmpItr = itrArr[i] * 1;
  if(tmpItr == curPage) itrBol = true;
}


$(document).ready(function() {
  if(bolIntranet)
  {
    lmsTime = gmPlayTime * 1;
    lmsPassed = gmEduComplete;
  }
});