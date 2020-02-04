<%
	' - Author(s):
	' - Date: 2017-10-13
	' - Copyright Notice: Copyright ⓒ 2009. neodreams.co.kr
	' - Description: 큐브 동영상 업로드
%>

<%
	Set objStream = Server.CreateObject("ADODB.Stream")
%>
<!--  #include file = dbconn.inc  -->
<%
' Turn on error Handling
On Error Resume Next
'Code here that you want to catch errors from

	If Err.Number <> 0 Then
	   Response.Write "PROC_ERR"
	else 
		attatch_Seq = request("attatch_Seq") 
		Set RefBoard = dbCon.execute("select attatch_OrgName, attatch_PhyPath from multi_Attatch WHERE attatch_Seq = " & attatch_Seq)
		attatch_OrgName = RefBoard(0) 
		attatch_PhyPath = RefBoard(1) 

		Response.ContentType =  "application/unknown"
		Response.CacheControl = "public"
		Response.AddHeader "Content-Disposition", "attachment;filename=" & attatch_OrgName

		objStream.Open
		objStream.LoadFromFile attatch_PhyPath
		strFile = objStream.Read
		Response.BinaryWrite strFile
		Response.Flush
	End If

	On Error Goto 0 ' Reset error handling.


'자원 해제
Set objStream = Nothing
dbCon.Close
Set dbCon = Nothing
%>
