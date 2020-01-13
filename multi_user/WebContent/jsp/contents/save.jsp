<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/resource/common/js/jquery-1.9.1.js"></script>
</head>
<body>
<form id="FormDetail" name="FormDetail" action="" method="post">
	<input type="hidden" id="SHSEQNUM" 	name="SHSEQNUM" value="${SM_SEQ ne null ? cha:seqEncode(SM_SEQ) : ''}">
	<input type="hidden" id="mode"		name="mode" 	value="${mode}"/>
	<input type="hidden" id="mode2" 	name="mode2" 	value=""/>
</form>
<c:choose>
<c:when test="${Complete eq false}">
<script>
alert("오류로 인하여 저장에 실패 하였습니다.");
location.replace("/contentsRequest.do");
</script>
</c:when>
<c:otherwise>
	<c:choose>
		<c:when test="${mode eq '1'}">
			<script>
					alert("수정이 완료 되었습니다.");
					$("#FormDetail").attr("action","/contentsDetail.do");
					$("#FormDetail").submit();
			</script>
		</c:when>
		<c:when test="${mode eq '2'}">
			<script>
					alert("신청이 취소 되었습니다.");
					$("#FormDetail").attr("action","/mypageContentsList.do");
					$("#FormDetail").submit();
			</script>
		</c:when>
		<c:otherwise>
			<c:redirect url="/contentsProgress.do" />
		</c:otherwise>
	</c:choose>
</c:otherwise>
</c:choose>
</body>
</html>