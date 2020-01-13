/********************************************************/
/* ������Ʈ ��ȯ �ڹٽ�ũ��Ʈ                           */
/* �ۼ��� : �ִ���                                      */
/* �ۼ��� : 2006/03/14                                  */
/* ���ǻ����� �ִ�������...                             */
/*
�� �÷���
  �� ����
     flashToJS(objectWidth,objectHeight,objSrc,objOption)
     objectWidth : with
     objectHeight : height
     objSrc : swf ���� ���
     objOption : param ������Ʈ( name|value|name|value ��������...) 

  �� ���� 
      <OBJECT CLASSID="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" CODEBASE="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" WIDTH="165" HEIGHT="40">
       <PARAM NAME="movie" VALUE="TOP-IMAGE/logo.swf">
       <PARAM NAME="quality" VALUE="high">
      </OBJECT>
  �� ����
     <SCRIPT src='http://kepco-ep.kepco.co.kr/INIT/JS/ObjectToJS.js'></SCRIPT> <!-- �ش��������� �ѹ��� -->
     <script>flashToJS('972','71','/IMAGE/POWERSMS/sms.swf','');</script>

�� OCX
  �� ����
     ocxToJS(objectID,classID,codeBase,objectWidth,objectHeight,objOption,objAlign)
     objectID : ID
     classID : CLASSID
     codeBase : CODEBASE
     objectWidth : with
     objectHeight : height
     objOption : param ������Ʈ( name|value|name|value ��������...) 
     objAlign : align ��( name|value ��������...) 
     objOption : param ������Ʈ( name|value|name|value ��������...) 

  �� ���� 
      <OBJECT ID="eventDate" WIDTH="85" HEIGHT="20" CODEBASE="http://ivory.hq/IMAGE/ETC1/PRESIDENT_WORD/DMDateX.cab#version=v2" CLASSID="CLSID:69DDF0C8-1828-43BF-AF52-BE96BEFACA62"></OBJECT>
  �� ����
     <SCRIPT src='http://kepco-ep.kepco.co.kr/INIT/JS/ObjectToJS.js'></SCRIPT> <!-- �ش��������� �ѹ��� -->
     <SCRIPT>ocxToJS('eventDate','CLSID:69DDF0C8-1828-43BF-AF52-BE96BEFACA62','http://ivory.hq/IMAGE/ETC1/PRESIDENT_WORD/DMDateX.cab#version=v2','85','20','','')</SCRIPT>
*/
/********************************************************/
function ocxToJS(objectID,classID,codeBase,objectWidth,objectHeight,objOption,objAlign)
{
    
	var docWrite = "";
	var docAlign = "";
	var tmpobjOption,objCount,objAlignCount,i;
	if(objOption)
	{
		tmpobjOption 	= objOption.split("|");
		objCount			=	(tmpobjOption.length - 1);
		for(i=0;i<objCount;i++)
		{
			psi = (i+1);
			docWrite	= docWrite + "<PARAM name=\""+tmpobjOption[i]+"\" value=\""+tmpobjOption[psi]+"\">\n";
			i +=1;
		}
	}
	if(objAlign)
	{
		tmpobjAlign		=	objAlign.split("|");
		objAlignCount	=	(tmpobjAlign.length - 1);
		for(i=0;i<objAlignCount;i++)
		{
			psi	=	(i+1);
			docAlign	=	docAlign + tmpobjAlign[i]+"=\""+tmpobjAlign[psi]+"\" ";
			i +=1;
		}
	}
	document.write("<OBJECT id=\""+objectID+"\" "+docAlign+" width=\""+objectWidth+"\" height=\""+objectHeight+"\" ");
	document.write("classid=\"clsid:"+classID+"\" codebase=\""+codeBase+"\">\n");
	document.write(docWrite);
	document.write("</OBJECT>\n");
}
function flashToJS(objectWidth,objectHeight,objSrc,objOption)
{
	var docWrite = "";
	var tmpobjOption,objCount,i;
	if(objOption)
	{
		tmpobjOption 	= objOption.split("|");
		objCount			=	(tmpobjOption.length - 1);
		for(i=0;i<objCount;i++)
		{
			psi = (i+1);
			docWrite	= docWrite + "<PARAM name=\""+tmpobjOption[i]+"\" value=\""+tmpobjOption[psi]+"\">\n";
			i +=1;
		}
	}	
	document.write("<OBJECT id=\"swfmovie\" classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" ");
	document.write("codebase=\"http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab#version=6,0,29,0\" ");
	document.write("width=\""+objectWidth+"\" height=\""+objectHeight+"\">\n");
	document.write("<PARAM name=\"quality\" value=\"high\">\n");
	document.write("<PARAM name=\"movie\" value=\""+objSrc+"\">\n");
	document.write("<PARAM name=\"wmode\" value=\"transparent\">\n");
	document.write("<PARAM name=\"allowScriptAccess\" value=\"always\">\n");
	document.write(docWrite);
//	document.write("<EMBED src=\""+objSrc+"\" quality=\"high\" ");
//	document.write("pluginspage=\"http://www.adobe.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash\" ");
//	document.write("type=\"application/x-shockwave-flash\" 	width=\""+objectWidth+"\" height=\""+objectHeight+"\">\n");
//	document.write("</EMBED>\n");
	document.write("</OBJECT>\n");
}
function flashToJS_ID(id,objectWidth,objectHeight,objSrc,objOption)
{
	var docWrite = "";
	var tmpobjOption,objCount,i;
	if(objOption)
	{
		tmpobjOption 	= objOption.split("|");
		objCount			=	(tmpobjOption.length - 1);
		for(i=0;i<objCount;i++) {
			psi = (i+1);
			docWrite	= docWrite + "<PARAM name=\""+tmpobjOption[i]+"\" value=\""+tmpobjOption[psi]+"\">\n";
			i +=1;
		}
	}	
	document.write("<OBJECT id='"+id+"' classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" ");
	document.write(" codebase=\"http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab#version=6,0,29,0\" ");
	document.write(" width=\""+objectWidth+"\" height=\""+objectHeight+"\">\n");
	document.write("<PARAM name=\"quality\" value=\"high\">\n");
	document.write("<PARAM name=\"movie\" value=\""+objSrc+"\">\n");
	document.write("<PARAM name=\"wmode\" value=\"transparent\">\n");
	document.write(docWrite);
//	document.write("<EMBED src=\""+objSrc+"\" quality=\"high\" ");
//	document.write("pluginspage=\"http://www.adobe.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash\" ");
//	document.write("type=\"application/x-shockwave-flash\" 	width=\""+objectWidth+"\" height=\""+objectHeight+"\">\n");
//	document.write("</EMBED>\n");
	document.write("</OBJECT>\n");
}
function findActiveObject (id)
{
	var isInstall = false;

	try {           
	    console.log('asdlk;111111111111');
		var Unitobj = new ActiveXObject(id);
console.log('adsalfkhasdlfkh' + Unitobj);
		if(Unitobj) isInstall = true;
		else isInstall = false;
	}
	catch(e) {
	    console.log(e);          
		isInstall = false;
	}

	return isInstall;
}
