package kr.co.neodreams.multi_user.dto;

import kr.co.neodreams.multi_user.base.dto.ItBaseDto;

/**
 * 사진촬영요청 DTO Class
 * 
 * @author hist
 *
 */
public class PhotoReqDto extends ItBaseDto {
	private int				seq;			// 요청 순번
	private String			req_type;		// 요청 타입
	private String			req_content;	// 요청 특이사항
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getReq_type() {
		return req_type;
	}
	public void setReq_type(String req_type) {
		this.req_type = req_type;
	}
	public String getReq_content() {
		return req_content;
	}
	public void setReq_content(String req_content) {
		this.req_content = req_content;
	}
	
	
}
