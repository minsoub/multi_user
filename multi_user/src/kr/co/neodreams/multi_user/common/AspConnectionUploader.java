package kr.co.neodreams.multi_user.common;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.log4j.Logger;

public class AspConnectionUploader {
    Logger log = Logger.getLogger(this.getClass());

    static String CRLF = "\r\n";
    static String twoHyphens = "--";
    static String boundary = "*****mgd*****";

    private DataOutputStream dataStream = null;

    public String uploadVideo(String postUrl, File originalFile, String videoFileName, String videoFileExt, String video_duration) {
        String success = "false";

        try {
            if (originalFile.exists()){
                try {
                    FileInputStream fileInputStream = new FileInputStream(originalFile);
                    URL connectURL = new URL(postUrl);
                    HttpURLConnection conn = (HttpURLConnection) connectURL.openConnection();

                    conn.setDoInput(true);
                    conn.setDoOutput(true);
                    conn.setUseCaches(false);
                    conn.setRequestMethod("POST");

                    conn.setRequestProperty("User-Agent", "myGeodiary-V1");
                    conn.setRequestProperty("Connection", "Keep-Alive");
                    conn.setRequestProperty("Content-Type", "multipart/form-data;boundary=" + boundary);
                    conn.connect();
                    
                    dataStream = new DataOutputStream(conn.getOutputStream());

                    writeFormField("video_duration", video_duration);
                    writeFormField("tmpFileName", videoFileName);
                    writeFormField("tmpFileExt", videoFileExt);
                    writeFileField("uploadFile", originalFile.getName(), "video/mp4", fileInputStream);

                    // final closing boundary line
                    dataStream.writeBytes(twoHyphens + boundary + twoHyphens + CRLF);

                    fileInputStream.close();
                    dataStream.flush();
                    dataStream.close();
                    dataStream = null;
                    System.out.println("upload asp call");
                    String response = getResponse(conn);

                    success = response;

                    conn.disconnect();

                } catch (Exception e) {
                	e.printStackTrace();
                	log.error("getResponsegetResponsegetResponse" + e.toString());
                    success = "false";
                }
            }else {
                success = "false";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	try{
        		if( originalFile.exists()){
        			originalFile.delete();
        		}
        	}catch(Exception e){
        		e.printStackTrace();
        	}
        }
        return success;
    }

    /**
     * @param conn
     * @return
     */
    private String getResponse(HttpURLConnection conn) {
        try {
            DataInputStream dis = new DataInputStream(conn.getInputStream());
            byte[] data = new byte[1024];
            int len = dis.read(data, 0, 1024);

            dis.close();
            int responseCode = conn.getResponseCode();

            if (len > 0)
                return new String(data, 0, len);
            else
                return "";
        } catch (Exception e) {
        	e.printStackTrace();
            log.error("getResponsegetResponsegetResponse" + e.toString());
            return "";
        }
    }

    /**
     * this mode of reading response no good either
     */
    private String getResponseOrig(HttpURLConnection conn) {
        InputStream is = null;
        try {
            is = conn.getInputStream();
            // scoop up the reply from the server
            int ch;
            StringBuffer sb = new StringBuffer();
            while ((ch = is.read()) != -1) {
                sb.append((char) ch);
            }
            return sb.toString();   // TODO Auto-generated method stub
        } catch (Exception e) {
        	e.printStackTrace();
        	log.error("getResponsegetResponsegetResponse" + e.toString());
        } finally {
            try {
                if (is != null)
                    is.close();
            } catch (Exception e) {
            }
        }

        return "";
    }


    /**
     * write one form field to dataSream
     *
     * @param fieldName
     * @param fieldValue
     */
    private void writeFormField(String fieldName, String fieldValue) {
        try {
            dataStream.writeBytes(twoHyphens + boundary + CRLF);
            dataStream.writeBytes("Content-Disposition: form-data; name=\"" + fieldName + "\"" + CRLF);
            dataStream.writeBytes(CRLF);
            dataStream.writeBytes(fieldValue);
            dataStream.writeBytes(CRLF);
        } catch (Exception e) {
        	log.error("getResponsegetResponsegetResponse" + e.toString());
        }
    }

    /**
     * write one file field to dataSream
     *
     * @param fieldName  - name of file field
     * @param fieldValue - file name
     * @param type       - mime type
     */
    private void writeFileField(
            String fieldName,
            String fieldValue,
            String type,
            FileInputStream fis) {
        try {
            // opening boundary line
            dataStream.writeBytes(twoHyphens + boundary + CRLF);
            dataStream.writeBytes("Content-Disposition: form-data; name=\""
                    + fieldName
                    + "\";filename=\""
                    + fieldValue
                    + "\""
                    + CRLF);
            dataStream.writeBytes("Content-Type: " + type + CRLF);
            dataStream.writeBytes(CRLF);

            // create a buffer of maximum size
            int bytesAvailable = fis.available();
            int maxBufferSize = 1024;
            int bufferSize = Math.min(bytesAvailable, maxBufferSize);

            byte[] buffer = new byte[bufferSize];
            // read file and write it into form...
            int bytesRead = fis.read(buffer, 0, bufferSize);

            while (bytesRead > 0) {
                dataStream.write(buffer, 0, bufferSize);
                bytesAvailable = fis.available();
                bufferSize = Math.min(bytesAvailable, maxBufferSize);
                bytesRead = fis.read(buffer, 0, bufferSize);
            }

            // closing CRLF
            dataStream.writeBytes(CRLF);
        } catch (Exception e) {
        	e.printStackTrace();
        	log.error("getResponsegetResponsegetResponse" + e.toString());
        }
    }

}
