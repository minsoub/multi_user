$(document).ready(function() {
    $('.searchWrap').hide();
    searchClear();
    $('.controller').append($('\
        <div class="searchWrap">\
            <div class="searchKeyword">\
                <input type="text" id="keywordInput"/>\
            </div>\
            <div class="searchBtn">\
                <div class="naverBtn"></div>\
                <div class="googleBtn"></div>\
            </div>\
            <div class="searchClose"></div>\
        </div>\
    '));
    addSearch();
});

function addSearch() {
    // var keyword = $('#keywordInput').val();
    // var strNaverURL = "http://search.naver.com/search.naver?where=nexearch&query=" + keyword;
    // var strGoogleURL = "https://www.google.co.kr/search?source=hp&ei=RPK2W47pF4iY8QX654LABA&q=" + keyword;
    
    $('.naverBtn').on("click", function() {
        var keyword = $('#keywordInput').val();
        var strNaverURL = "http://search.naver.com/search.naver?where=nexearch&query=" + keyword;
        window.open(strNaverURL, "_search", "");
    })

    $('.googleBtn').on("click", function() {
        var keyword = $('#keywordInput').val();
        var strGoogleURL = "https://www.google.co.kr/search?source=hp&ei=RPK2W47pF4iY8QX654LABA&q=" + keyword;
        window.open(strGoogleURL, "_search", "");
    })

    $('.searchClose').on("click", function() {
        $('.searchWrap').hide();
        searchClear();
    })
}

function searchClear() {
    $('#keywordInput').val('');
}