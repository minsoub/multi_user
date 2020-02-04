<%
	' - Author(s):
	' - Date: 2017-10-13
	' - Copyright Notice: Copyright ⓒ 2009. neodreams.co.kr
	' - Description: 큐브 동영상 업로드
%>
<%
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
    uploadform.DefaultPath = "E:\project_upload_test\multi_user\kube\video_tmp\" & NowThisYear & "\" & NowThisMonth & NowThisDay

    '임시 폴더와 동일 폴더에 저장
	'strDirectory = "E:\VOD\KUBE\video_tmp\" & NowThisYear & "\" & NowThisMonth & NowThisDay & "\"
    strDirectory = "E:\project_upload_test\multi_user\kube\video_tmp\" & NowThisYear & "\" & NowThisMonth & NowThisDay & "\"
 
	'Response.Write(strDirectory) &"<BR>"
	'Response.End

	'---------------------------------------------------------------------------------------------------
	'# 업로드 확장자 제한  "cgi,pl,php,php3,php4,php5,ph,inc,phtm,phtml,js,exe,com,cmd,nt,jsp,bat,asp,c,cpp,h,stb,shtml,shtm,css,vbs,htm,html"
	'---------------------------------------------------------------------------------------------------

	Attach_File = uploadform("uploadFile").FileName

	'FileName = Mid(Attach_File, InstrRev(Attach_File, "\") + 1)
	'Response.write "FileNameFileName="& FileName &"<br>"
	
	strFile  = strDirectory & uploadform("tmpFileName") & "." & uploadform("tmpFileExt")
	
	FileSave = uploadform("uploadFile").SaveAs(strFile, False)

	'Size     = uploadform("tmpFileName").FileLen
	'FileName = Mid(FileSave, InstrRev(FileSave, "\") + 1)
	'Response.write "pdsFile="& uploadform("pdsFile").FileName &"<br>"
	'Response.write "FileName="& FileName &"<br>"

    '이미지 썸네일 추출
	Dim objExe  
	Dim sResult  
	Dim filename, sec, img_file_path
	
	bufferpath = "E:\imageBuffer\"
	
	filename = uploadform("tmpFileName") & "." & uploadform("tmpFileExt")

	outputpath = Replace(filename,Right(filename,"4"),"")
	'thumb_path = "E:\VOD\KUBE\video_thumb\" & NowThisYear & "\" & NowThisMonth & NowThisDay
	thumb_path = "E:\project_upload_test\multi_user\kube\video_thumb\" & NowThisYear & "\" & NowThisMonth & NowThisDay
	'response.write thumb_path & Replace(filename,Right(filename,"3"),"jpg")

    '썸네일 저장 폴더 생성
	Dim Fso
	Set Fso = Server.CreateObject("Scripting.FileSystemObject")

	If Not Fso.FolderExists(thumb_path) Then
	thumb_path = Fso.CreateFolder(thumb_path)          
	End If
	Set Fso = Nothing

	Set objExe = Server.CreateObject("ASPExec.Execute")  
	Set Executor = Server.CreateObject("ASPExec.Execute")
    videoFileName = bufferpath  & outputpath & "\" & Replace(filename,Right(filename,"4"),"")

	video_duration = uploadform("video_duration")
	'Response.write video_duration

    for i = 1 to 6 step 1
	    If video_duration = 0 Then
			If i = 1 Then 
			   sec = "1"  '어느 시점을 추출할지 정함. 초단위
			ElseIf i = 2 Then 
			   sec = "3"
			ElseIf i = 3 Then
			   sec = "5"
			ElseIf i = 4 Then
			   sec = "7"
			ElseIf i = 5 Then
			   sec = "10"
			ElseIf i = 6 Then
			   sec = "13"
			End If 
        Else 
			If i = 1 Then 
			   sec = 1  '어느 시점을 추출할지 정함. 초단위
			ElseIf i = 2 Then
			   sec = Cint(video_duration / 6 * 2)
			ElseIf i = 3 Then
			   sec = Cint(video_duration / 6 * 3)
			ElseIf i = 4 Then
			   sec = Cint(video_duration / 6 * 4)
			ElseIf i = 5 Then
			   sec = Cint(video_duration / 6 * 5)
			ElseIf i = 6 Then
			   sec = Cint(video_duration - 1)
			End If 
		End If 
          
		img_file_path = videoFileName & "_" & sec & ".jpg"       	   
		'Response.write img_file_path 


		'썸네일 추출 실행
		objExe.Application = "CmsSupport.exe"           
		objExe.Parameters = " T " & chr(34) & strDirectory & filename & chr(34) & " " & sec & " " & outputpath
		objExe.ShowWindow = False
		objExe.TimeOut = 10000
		intResult = objExe.ExecuteWinAppAndWait
		'Response.write " T " & chr(34) & strDirectory & filename & chr(34) & " " & sec & " " & outputpath
		'Response.Write "Result: " & intResult & "<p>"          
		
		if intResult = 0 then
			Executor.Application = "cmd /c move " & chr(34) & img_file_path & chr(34) & " " & chr(34) & thumb_path & "\" & Replace(filename,Right(filename,"4"),"") & "_" & i & ".jpg" & chr(34)
			strResult = Executor.ExecuteDosApp
			'Response.write Replace(Replace(filename,Right(filename,"4"),""), "_" & sec, "_1.jpg")
		else
		   Response.Write "THUMB_ERR"
		end if	
	Next
	


	' Error Handler
	If Err.Number <> 0 Then
	   Response.Write "PROC_ERR"
	else 
 	   Set RefBoard = dbCon.execute("select isnull(max(cid), 0) + 1 as cid from kube_tvm_contents")
		cid = RefBoard(0)
		'Response.Write RefBoard(0)

		'스트리밍 컨버팅 테이블
		'변경된 파일명으로 저장하고 컨버팅. 원본명은 게시글 작성시 kube_video_info 에 인서트
		streamSQL = "insert into kube_tvm_contents (cid, orgpath, orgname, convsts, extrsts, regdate, mediatype)"
		streamSQL = streamSQL & " values ('" & cid & "', '" & NowThisYear & "/" & NowThisMonth & NowThisDay & "', '" & uploadform("tmpFileName") & "." & uploadform("tmpFileExt") & "', 'EN70001', 'CP50001', GETDATE(), 'VIDEO')"
		'response.write("SQL : " & streamSQL & "<br>") 
		Set StreamRef = dbCon.Execute(streamSQL)

	   Response.Write cid
	End If

	On Error Goto 0 ' Reset error handling.


'자원 해제
Set uploadform = Nothing
dbCon.Close
Set dbCon = Nothing
Set Fso = Nothing
Set objExe = Nothing
Set Executor = Nothing
%>
