<%
	' - Author(s):
	' - Date: 2020-02-04
	' - Copyright Notice: Copyright ⓒ 2009. neodreams.co.kr
	' - Description: 공통 업로드 
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
    uploadform.DefaultPath = "E:\VOD\multi_user\multi_Contents\attatch_tmp\" & NowThisYear & "\" & NowThisMonth & NowThisDay

    '임시 폴더와 동일 폴더에 저장
	'strDirectory = "E:\VOD\KUBE\video_tmp\" & NowThisYear & "\" & NowThisMonth & NowThisDay & "\"
    strDirectory = "E:\VOD\multi_user\multi_Contents\attatch_tmp\" & NowThisYear & "\" & NowThisMonth & NowThisDay & "\"
	
	'Response.Write Err.Number
	'Response.Write(strDirectory) &"<BR>"
	'Response.End

	'---------------------------------------------------------------------------------------------------
	'# 업로드 확장자 제한  "cgi,pl,php,php3,php4,php5,ph,inc,phtm,phtml,js,exe,com,cmd,nt,jsp,bat,asp,c,cpp,h,stb,shtml,shtm,css,vbs,htm,html"
	'---------------------------------------------------------------------------------------------------
	'Dim bbsid, target_file_input

	bbsid = uploadform("bbsid")
	target_file_input = uploadform("uploadFile")

	On Error Goto 0 ' Reset error handling.

	Attach_File = uploadform(target_file_input).FileName
	'response.write "//Attach_File : " &Attach_File &"<br>"

	FileName = Mid(Attach_File, InstrRev(Attach_File, "\") + 1)
	'response.write "//FileName : " &FileName&"<br>"

	File_ext = uploadform(target_file_input).FileExtension
	'response.write "//File_ext : " &File_ext&"<br>"

	saveFileName = datediff("s","1970-01-01",now()) - (9*60*60)
	'response.write "//saveFileName : " &saveFileName&"<br>"

	strFile  = strDirectory & saveFileName & "." & File_ext
	'response.write "//strFile : " &strFile&"<br>"
	
	FileSave = uploadform(target_file_input).SaveAs(strFile, False)
	'response.write "//strFile : " &FileSave&"<br>"

	'완료파일, 사용자파일 구분
	

'Response.Write FileName &" || "& saveFileName &" || "& uploadform.FileExtension

	'Error Handler
	If Err.Number <> 0 Then
	   Response.Write "PROC_ERR"
	Else
		Set RefBoard = dbCon.execute("select ISNULL(MAX(FREQ), 0)+1 AS FREQ from SPLAZA_FILEINFO")
		FREQ = RefBoard(0)
		
		' 게시판 순번을 업데이트 해야 된다.
		streamSQL = "insert into SPLAZA_FILEINFO (FREQ, FILENAME, PHY_PATH, FILESIZE, DOWNLOAD, STS, EXIST)"
		streamSQL = streamSQL & "values ('" & FREQ & "', '"& Attach_File & "', '" & strFile &"',  '0', '0', '1', 'N')"
		'response.write("SQL : " & streamSQL & "<br>") 
		Set StreamRef = dbCon.Execute(streamSQL)

	   Response.Write SCF_SEQ
	End If

	On Error Goto 0 ' Reset error handling.

'자원 해제
Set uploadform = Nothing
dbCon.Close
Set dbCon = Nothing
%>
