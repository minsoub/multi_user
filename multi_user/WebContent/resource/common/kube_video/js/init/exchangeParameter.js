
// 1. 콘텐츠 iframe을 감싸는 https://edu.kepco.co.kr/classroom/videoPlayerAu 프레임에 있어야 하는 함수 입니다.
// start

var eudstmUrl = 'http://edustrm.kepco.co.kr/';  //postMessage 사용시 허용할 url


// //postMessage receive event 등록 
if (window.addEventListener) {
    window.addEventListener('message', postMessageController, true);    
} else if (window.attachEvent) {
    window.attachEvent('onmessage', postMessageController);
}

function postMessageController(_thisEvent) {
    
    if (eudstmUrl.indexOf(_thisEvent.origin) == -1) // 허용된 url이 아닐 경우 
    {   
        console.dir('origin : ' + _thisEvent.origin);
    } 
    else 
    {
        var param = _thisEvent.data;
        // console.log(param)
        if(param.parameterType == "colse")  // 콘텐츠 닫을 때 진도 값 전달 시 
        {
            delete param['parameterType'];  // 파라메터 보낼 시 저장 타입은 삭제
            top.opener.savePopVideoPgr(param);
        }
        else if(param.parameterType == "interval")   // 지정된 시간 마다 진도값 전달 시 
        {
            delete param['parameterType'];  // 파라메터 보낼 시 저장 타입은 삭제
            // /api/contents/savePgr
            // /classroom/html5Save
            $.getPostJSON('/api/contents/savePgr', param)   ///classroom/html5Save에는 전송이 안되서 기존 방식으로 사용했습니다.
            .done(function (result) {  
                console.log('done');
                console.log(result);
            }).fail(function (fail) {  
                console.log(fail)
            });
        }
        
    }
}

//end


//2. iframe 사용 시 전체화면 허용 옵션 추가 구문입니다.
//allowfullscreen="true" 추가 부탁드립니다.
<iframe src = "#" allowfullscreen="true" ></iframe>

//3. 콘텐츠 이어보기는 lastPgr로 지정했습니다.
    
