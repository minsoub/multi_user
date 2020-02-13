package kr.co.neodreams.multi_user.dto;

import java.util.List;

import kr.co.neodreams.multi_user.base.dto.ItBaseDto;

/**
 * 플로터 출력 요청 DTO Class
 * 
 * @author hist
 *
 */
public class PrintReqDto extends ItBaseDto {
	private int			seq;			// 순번
	private String		req_size;		// 요청 크기
	private String		size_etc;		// 요청 크기 - 기타내용
	private String		req_height;		// 요청 높이
	private String		height_etc;		// 요청 높이 - 기타내용
	private String		content;		// 기타 사항
	
	// 파일
	private String freqs;				// 파일번호 리스트
	private String freq;				// 파일번호
	private String filename;			// 파일명
	private String maskname;			// 마스크명
	private String filesize;			// 파일사이즈
	private String phy_path;			// 물리적인 경로
	
	private List<PrintReqDto> attachList;		
	
	public String getFreqs() {
		return freqs;
	}
	public void setFreqs(String freqs) {
		this.freqs = freqs;
	}
	public String getFreq() {
		return freq;
	}
	public void setFreq(String freq) {
		this.freq = freq;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getMaskname() {
		return maskname;
	}
	public void setMaskname(String maskname) {
		this.maskname = maskname;
	}
	public String getFilesize() {
		return filesize;
	}
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	public String getPhy_path() {
		return phy_path;
	}
	public void setPhy_path(String phy_path) {
		this.phy_path = phy_path;
	}
	public List<PrintReqDto> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<PrintReqDto> attachList) {
		this.attachList = attachList;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getReq_size() {
		return req_size;
	}
	public void setReq_size(String req_size) {
		this.req_size = req_size;
	}
	public String getSize_etc() {
		return size_etc;
	}
	public void setSize_etc(String size_etc) {
		this.size_etc = size_etc;
	}
	public String getReq_height() {
		return req_height;
	}
	public void setReq_height(String req_height) {
		this.req_height = req_height;
	}
	public String getHeight_etc() {
		return height_etc;
	}
	public void setHeight_etc(String height_etc) {
		this.height_etc = height_etc;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
