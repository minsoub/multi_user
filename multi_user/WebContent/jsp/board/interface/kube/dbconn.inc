<%

	'---------------------------------------------------------------------------------------------------
	' LOCALHOST DB Connection
	Dim dbCon
	Dim dbUserID, dbUserPwd, dbCatalog, dbSource

	dbUserID = "sa"
	dbUserPwd = "spdh901()!"
	dbCatalog = "NEWMEDIA"
	dbSource = "(local)"

	set dbCon = server.CreateObject("ADODB.CONNECTION")
	dbCon.Open "Provider=SQLOLEDB.1;Persist Security Info=True;User ID="& dbUserID &";password="& dbUserPwd &";Initial Catalog="& dbCatalog &";Data Source="& dbSource &";Locale Identifier=1042;Connect Timeout=15;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID="& dbSource &""
	'---------------------------------------------------------------------------------------------------

%>
