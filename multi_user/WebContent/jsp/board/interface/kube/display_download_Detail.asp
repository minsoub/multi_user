<%
	Response.Buffer = True
    Response.Clear

	Dim DBConn
	Set DBConn = Server.CreateObject("ADODB.Connection")

	DBConn.Provider = "SQLOLEDB.1;Persist Security Info=False;User ID=sa;pwd=spdh901()!;Initial Catalog=NEWMEDIA;Data Source=(local)"
	DBConn.Open

	SDP_SEQ = Request("SDP_SEQ")
	
	Dim SQL,RefBoard, SDP_orgFileName, SDP_phycalPath
	SQL="select SDP_orgFileName, SDP_phycalPath from tbSVC_DISPLAY_FILE WHERE SDP_SEQ = " & SDP_SEQ
	Set RefBoard = DBConn.Execute(SQL)
		 SDP_orgFileName=RefBoard(0)
 		 SDP_phycalPath=RefBoard(1)
		 RefBoard.Close
	Set RefBoard=Nothing

	Dim s
    Set s = Server.CreateObject("ADODB.Stream")
    s.Open
    s.Type = 1
	Dim fso
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    Dim f
	Set f = fso.GetFile(SDP_phycalPath)
	Dim intFilelength
    intFilelength = f.size
    s.LoadFromFile(SDP_phycalPath)

    Response.ContentType = "application/octect-stream name=" & SDP_orgFileName
    Response.AddHeader "Content-Disposition", "attachment; filename=" & SDP_orgFileName
    Response.AddHeader "Content-Length", intFilelength
    Response.CharSet = "EUC-KR"
    Response.ContentType = "application/octet-stream"
    Response.BinaryWrite s.Read
    Response.Flush
    s.Close
    Set s = Nothing
	Set fso = Nothing

	'자원 해제
	Set objStream = Nothing
	DBConn.Close
	Set DBConn = Nothing
%>