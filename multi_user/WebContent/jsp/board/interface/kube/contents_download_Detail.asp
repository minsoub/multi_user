<%
	Response.Buffer = True
    Response.Clear

	Dim DBConn
	Set DBConn = Server.CreateObject("ADODB.Connection")

	DBConn.Provider = "SQLOLEDB.1;Persist Security Info=False;User ID=sa;pwd=spdh901()!;Initial Catalog=NEWMEDIA;Data Source=(local)"
	DBConn.Open

	SCF_SEQ = Request("SCF_SEQ")
	
	Dim SQL,RefBoard, SCF_orgFileName, SCF_phycalPath
	SQL="select SCF_orgFileName, SCF_phycalPath from tbSVC_CONTENTS_FILE WHERE SCF_SEQ = " & SCF_SEQ
	Set RefBoard = DBConn.Execute(SQL)
		 SCF_orgFileName=RefBoard(0)
 		 SCF_phycalPath=RefBoard(1)
		 RefBoard.Close
	Set RefBoard=Nothing

	Dim s
    Set s = Server.CreateObject("ADODB.Stream")
    s.Open
    s.Type = 1
	Dim fso
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    Dim f
	Set f = fso.GetFile(SCF_phycalPath)
	Dim intFilelength
    intFilelength = f.size
    s.LoadFromFile(SCF_phycalPath)

    Response.ContentType = "application/octect-stream name=" & SCF_orgFileName
    Response.AddHeader "Content-Disposition", "attachment; filename=" & SCF_orgFileName
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