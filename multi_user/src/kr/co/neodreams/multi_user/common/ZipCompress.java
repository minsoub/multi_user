package kr.co.neodreams.multi_user.common;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.io.FilenameUtils;

import com.j256.simplemagic.ContentInfo;
import com.j256.simplemagic.ContentInfoUtil;

import kr.co.neodreams.multi_user.base.dao.BaseDao;
import net.sf.jazzlib.ZipEntry;
import net.sf.jazzlib.ZipInputStream;

public class ZipCompress extends BaseDao {
	/**
	* 압축풀기 메소드
	* @param zipFileName 압축파일
	* @param directory 압축 풀 폴더
	*/
	public static void decompress(String zipFileName, String directory) throws Throwable {
		File zipFile = new File(zipFileName);
		String baseFileName = FilenameUtils.getBaseName(zipFileName);
		FileInputStream fis = null;
		ZipInputStream zis = null;
		ZipEntry zipentry = null;
		
		
		ContentInfoUtil fileUtil = new ContentInfoUtil();
		try {
			ContentInfo info = fileUtil.findMatch(zipFile);
			
			String[] extensions = info.getFileExtensions();
			
			if(extensions != null && extensions.length > 0) {
				for(int i =0; i < extensions.length; i++) {
					System.out.println("File Extension : " + extensions[i]);
				}
			}

			//파일 스트림
			fis = new FileInputStream(zipFile);
			//Zip 파일 스트림
			zis = new ZipInputStream(fis);
			
			//퀴즈, 자막에 사용하는 기본 폴더들.
			List<String> folders = Arrays.asList("each", "jumpup", "pop", "print", "vtt", "xml");
			
			//entry가 없을때까지 뽑기
			while ((zipentry = zis.getNextEntry()) != null) {
				String filename = zipentry.getName();
				
				String fstFileName = filename.split("/")[0];
				
				if(!folders.contains(fstFileName)) {
					filename = filename.replaceAll(fstFileName, "");
				}
				
				File file = new File(directory, filename);
				//entiry가 폴더면 폴더 생성
				if (zipentry.isDirectory()) {
					file.mkdirs();
				} else {
					//파일이면 파일 만들기
					String ext = FilenameUtils.getExtension(zipentry.getName());

					if("vtt".equals(ext)) {
						file = new File(directory, "\\vtt\\"+ baseFileName+ '.' + ext);
					}
					createFile(file, zis);
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
			throw e;
		} finally {
			if (zis != null) zis.close();
			if (fis != null) fis.close();
			
			File file = new File(zipFileName);
			if(file.exists())
				file.delete();
		}
	}
	
	/**
	* 파일 만들기 메소드
	* @param file 파일
	* @param zis Zip스트림
	*/
	private static void createFile(File file, ZipInputStream zis) throws Throwable {
		//디렉토리 확인
		File parentDir = new File(file.getParent());
		//디렉토리가 없으면 생성하자
		if (!parentDir.exists()) {
			parentDir.mkdirs();
		}
		
		//파일 스트림 선언
		try (FileOutputStream fos = new FileOutputStream(file)) {
			byte[] buffer = new byte[256];
			int size = 0;
			//Zip스트림으로부터 byte뽑아내기
			while ((size = zis.read(buffer)) > 0) {
				//byte로 파일 만들기
				fos.write(buffer, 0, size);
			}
		} catch (Throwable e) {
			throw e;
		}
	}
	
	
	public static void main(String[] args){
	try{
		ZipCompress.decompress("D:\\neoDoc\\한전\\멀티미디어\\kube_sample\\contents1119\\03\\test\\test.zip", "D:\\neoDoc\\한전\\멀티미디어\\kube_sample\\contents1119\\03\\test");
	}catch(Throwable e){
		e.printStackTrace();
	}
	}
}
