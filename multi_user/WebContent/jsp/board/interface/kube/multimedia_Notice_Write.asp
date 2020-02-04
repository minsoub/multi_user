<%
	' - Author(s):
	' - Date: 2017-10-13
	' - Copyright Notice: Copyright ⓒ 2009. neodreams.co.kr
	' - Description: 큐브 동영상 업로드
%>
<%
	Session.CodePage = "65001"
	Set uploadform = Server.CreateObject("DEXT.FileUpload")
	uploadform.AutoMakeFolder = True
%>
<!--  #include file = dbconn.inc  -->
<%
' Turn on error Handling
On Error Resume Next
'Code here that you want to catch errors from

	Dim datToday
	datToday=Date()  '오늘 날짜

	Dim NowThisYear, NowThisMonth, NowThisDay
	NowThisYear=Year(datToDay) ' 현재연도값
	NowThisMonth=Month(datToday) '현재 월값
	NowThisDay=Day(datToday) '오늘 날짜 값
	
	'폴더명 4자리 맞추기 위함. 10이하 월, 일 2자리로 맞춤
	If Len(NowThisMonth) = 1 Then
		NowThisMonth = "0" & NowThisMonth
	End If 

	If Len(NowThisDay) = 1 Then
		NowThisDay = "0" & NowThisDay
	End If 

	'업로드 임시 저장 폴더
	'uploadform.DefaultPath = "E:\VOD\KUBE\video_tmp\" & NowThisYear & "\" & NowThisMonth & NowThisDay
    uploadform.DefaultPath = "E:\project_upload_test\multi_user\multiNotice\attatch_tmp\" & NowThisYear & "\" & NowThisMonth & NowThisDay

    '임시 폴더와 동일 폴더에 저장
	'strDirectory = "E:\VOD\KUBE\video_tmp\" & NowThisYear & "\" & NowThisMonth & NowThisDay & "\"
    strDirectory = "E:\project_upload_test\multi_user\multiNotice\attatch_tmp\" & NowThisYear & "\" & NowThisMonth & NowThisDay & "\"
	
'	Response.Write Err.Number
'	Response.Write(strDirectory) &"<BR>"
	'Response.End

	'---------------------------------------------------------------------------------------------------
	'# 업로드 확장자 제한  "cgi,pl,php,php3,php4,php5,ph,inc,phtm,phtml,js,exe,com,cmd,nt,jsp,bat,asp,c,cpp,h,stb,shtml,shtm,css,vbs,htm,html"
	'---------------------------------------------------------------------------------------------------

	Attach_File = uploadform("uploadFile").FileName

'	FileName = Mid(Attach_File, InstrRev(Attach_File, "\") + 1)
'	Response.write "FileNameFileName="& FileName &"<br>"
	
	saveFileName = datediff("s","1970-01-01",now()) - (9*60*60)

	strFile  = strDirectory & saveFileName & "." & uploadform.FileExtension
	
	FileSave = uploadform("uploadFile").SaveAs(strFile, False)

'Response.Write FileName &" || "& saveFileName &" || "& uploadform.FileExtension

	' Error Handler
	If Err.Number <> 0 Then
	   Response.Write "PROC_ERR"
	else 
		Set RefBoard = dbCon.execute("select isnull(max(attatch_Seq), 0) + 1 as attatch_Seq from multi_Attatch")
		attatch_Seq = RefBoard(0)

		streamSQL = "insert into multi_Attatch(attatch_Seq, attatch_OrgName, attatch_PhyPath, attatch_LogPath)"
		streamSQL = streamSQL & " values ('" & attatch_Seq & "', '" & Attach_File & "', '" & strFile & "', '" & "\" & NowThisYear & "\" & NowThisMonth & NowThisDay & "\" & saveFileName & "." & uploadform.FileExtension &"')"
		'response.write("SQL : " & streamSQL & "<br>") 
		Set StreamRef = dbCon.Execute(streamSQL)

	   Response.Write attatch_Seq
	End If

	On Error Goto 0 ' Reset error handling.


'자원 해제
Set uploadform = Nothing
dbCon.Close
Set dbCon = Nothing
%>
