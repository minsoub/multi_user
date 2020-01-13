<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<body style="color: white; background-color: white;">
<script type="text/javascript">
var message = '${msg}';
var url = '${url}';
alert(message);
if (url == null || url == '') {
    window.history.back();
} else if (url == 'close') {
    window.close();
} else if (url == 'opener') {
    opener.location.reload();
    window.close();
} else {
    window.location.href = url;
}
</script></body>
</html>