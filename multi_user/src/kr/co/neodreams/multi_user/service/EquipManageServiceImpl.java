package kr.co.neodreams.multi_user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Address;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.common.CommonUtil;
import kr.co.neodreams.multi_user.common.DataMap;
import kr.co.neodreams.multi_user.common.mail.SendMail;
import kr.co.neodreams.multi_user.common.onestop.OneStopLogVO;
import kr.co.neodreams.multi_user.dao.EquipManageDao;
import kr.co.neodreams.multi_user.dao.RentDao;
import kr.co.neodreams.multi_user.dto.EquipManageDto;
import kr.co.neodreams.multi_user.dto.RentDto;

@Service
public class EquipManageServiceImpl extends BaseService implements EquipManageService {

    @Autowired
    EquipManageDao equipManageDao;

    @Autowired
    RentDao rentDao;

    /** 코드(대) 취득 */
    @Override
    public List<EquipManageDto> getCodeList(EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getCodeList(equipManageDto);
        return resultList;
    }

    /** 모든 코드 취득 */
    @Override
    public List<EquipManageDto> getAllCodeList(EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getAllCodeList(equipManageDto);
        return resultList;
    }

    /** 확인증 출력 관련 APP테이블 정보 조회 */
    @Override
    public EquipManageDto getAppTblInfo(EquipManageDto equipManageDto) throws Exception {
        EquipManageDto result = new EquipManageDto ();
        result = equipManageDao.getAppTblinfo(equipManageDto);
        return result;
    }

    /** 표준모델 등록 하위코드 가져오기 */
    @Override
    public Map<String, Object> getSubTreeList(EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = equipManageDao.getSubTree(equipManageDto);

        Map<String, Object> resultMap = new LinkedHashMap<String, Object> ();
        Map<String, Object> gbcdMap = new LinkedHashMap<String, Object> ();
        Map<String, Object> subMap = new LinkedHashMap<String, Object> ();

        for (EquipManageDto result : resultList) {
            if(result.getGbcd().length() == 6)
            {
                gbcdMap = new LinkedHashMap<String, Object> ();

                gbcdMap.put("gbcd", result.getGbcd());
                gbcdMap.put("gbnm", result.getGbnm());

                resultMap.put(result.getGbcd().substring(0, 6), gbcdMap);
                subMap = new LinkedHashMap<String, Object> ();
            }
            else if(result.getGbcd().length() == 9)
            {

                Map<String, String> gbcdMinMap = new LinkedHashMap<String, String> ();
                gbcdMinMap.put("gbcd", result.getGbcd());
                gbcdMinMap.put("gbnm", result.getGbnm());

                subMap.put(result.getGbcd(), gbcdMinMap);
                gbcdMap.put("sub", subMap);

                resultMap.put(result.getGbcd().substring(0, 6), gbcdMap);
            }
        }

        return resultMap;
    }

    /** 결재 */
    @Override
    public boolean signUp (EquipManageDto dto) throws Exception {

        String appno = (String) dto.getAppno();
        String status = (String) dto.getStatus();
        String empno = (String) dto.getEmpno();
        String appnum = (String) dto.getAppnum();
        String name = (String) dto.getName();
        String deptName = (String) dto.getDeptName();
        String posName = (String) dto.getPosName();

        if( StringUtils.isEmpty(appno) ||  StringUtils.isEmpty(status) ||  StringUtils.isEmpty(empno) )
        {
            return false;
        }
        EquipManageDto insertDto = new EquipManageDto();

        int seqno = equipManageDao.getNextSignSeq();

        if (StringUtils.equals(status, "1")){
            insertDto.setRegSign("Y");
        } else {
            insertDto.setRegSign("N");
        }
        String title = "대여신청 번호[" + appnum + "]";

        insertDto.setSeqno(String.valueOf(seqno));
        insertDto.setAppno(appno);
        insertDto.setStatus(status);
        insertDto.setTitle(title);
        insertDto.setEmpno(empno);
        insertDto.setAppnum(appnum);
        insertDto.setName(name);
        insertDto.setDeptName(deptName);
        insertDto.setPosName(posName);

        equipManageDao.insertSignInfo(insertDto);

        return true;
    }

    /** 대여 가능 장비 리스트 취득 */
    @Override
    public List<EquipManageDto> getEquipManageList(EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getEquipManageList(equipManageDto);
        return resultList;
    }

    /** 설비갯수 */
    @Override
    public Map<String, Object> getEquipAmountInfo(EquipManageDto equipManageDto, String SESS_EMPNO) throws Exception {
        Map<String, Object> resultMap = new HashMap<String, Object> ();
        /*등록된설비 총갯수*/
        int equipCnt = equipManageDao.getEquipRentNum(equipManageDto);
        /*신청접수갯수*/
        int currAppCnt = equipManageDao.getCurrAppCnt(equipManageDto);
        /*장바구니갯수*/
        int basketCnt = equipManageDao.getBasketCnt(equipManageDto);
        /*나의 장바구니갯수*/
        equipManageDto.setRegeno(SESS_EMPNO);
        int myBasketCnt = equipManageDao.getMyBasketCnt(equipManageDto);

        resultMap.put("equipCnt", equipCnt);
        resultMap.put("currAppCnt", currAppCnt);
        resultMap.put("basketCnt", basketCnt);
        resultMap.put("myBasketCnt", myBasketCnt);

        int rentEnableCnt = equipCnt - currAppCnt - basketCnt;

        if(rentEnableCnt < 0) {
            resultMap.put("rentEnableCnt", 0);
        } else {
            resultMap.put("rentEnableCnt", rentEnableCnt);
        }
        return resultMap;
    }

    /** 베스트순 */
    @Override
    public int getRentNumByModel(EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = equipManageDao.getEquipRentNum(equipManageDto);
        return result;
    }

    /** 장비정보 */
    @Override
    public String getModelSub(EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getModelSub(equipManageDto);

        String itemNm = "";
        for(int i = 0; i < resultList.size(); i++){
            String result = resultList.get(i).getItemNm();
            if (StringUtils.isNotEmpty(result)) {
                itemNm += result;
                if (i < resultList.size()-1) {
                    itemNm += " | ";
                }
            }
        }
        return itemNm;
    }

    /** 이미지정보 */
    @Override
    public String getImageUrl(EquipManageDto equipManageDto) throws Exception {
        EquipManageDto result = new EquipManageDto();
        result = equipManageDao.getImageUrl(equipManageDto);
        if (result == null) {
            return "";
        } else {
            return result.getImageUrl();
        }
    }

    /** 장비정보 */
    @Override
    public EquipManageDto getCodeInfo(EquipManageDto equipManageDto) throws Exception {
        EquipManageDto result = new EquipManageDto ();
        result = equipManageDao.getCodeInfo(equipManageDto);
        return result;
    }

    /** 모델기본정보 */
    @Override
    public EquipManageDto getModelBasicInfo (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto ();
        result = equipManageDao.getModelBasicInfo(equipManageDto);
        return result;
    }

    /** 모델정보 */
    @Override
    public List<EquipManageDto> getModelInfo(EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getModelInfo(equipManageDto);
        return resultList;
    }

    /** 대여 가능 장비 리스트 취득 */
    @Override
    public List<EquipManageDto> getAttachFileInfo(EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getAttachFileInfo(equipManageDto);
        return resultList;
    }

    /** 대여 가능 장비 리스트 취득 */
    @Override
    public List<EquipManageDto> getBasketInfo(EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getBasketInfo(equipManageDto);
        return resultList;
    }
    
    @Override
	public String partBanp(HttpServletRequest request) throws Exception {
    	
    	String retVal = "false";
    	
    	DataMap dataMap = new DataMap(request, "non_encoding");
    	
   		equipManageDao.partBanp(dataMap);
   		
   		retVal = "true";
   		
		return retVal;
	}

	/** 모델 코드 정보 */
    @Override
    public Map<String, Object> getModelByCode (EquipManageDto equipManageDto) throws Exception{
        Map<String, Object> resultMap = new HashMap<String, Object> ();

        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();

        resultList = equipManageDao.getModelByCode(equipManageDto);

        Map<String, Object> modelByCodeMap = new HashMap<String, Object> ();

        for (EquipManageDto result : resultList) {
            modelByCodeMap.put(result.getMdseq(), result.getMdnm());
        }

        resultMap.put("resultList", resultList);
        resultMap.put("modelByCodeMap", modelByCodeMap);

        return resultMap;
    }

    /** 장비 신청 정보 */
    @Override
    public EquipManageDto getRecViewInfo (EquipManageDto equipManageDto) throws Exception{
        EquipManageDto result = new EquipManageDto ();
        result = equipManageDao.getRecViewInfo(equipManageDto);
        return result;
    }

    @Override
    public void updateStatus (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.updateStatus(equipManageDto);
    }

    @Override
    public void updateEqlst (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.updateEqlst(equipManageDto);
    }

    @Override
    public void updateIsSign (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.updateIsSign(equipManageDto);
    }

    @Override
    public void updateAmount (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.updateAmount(equipManageDto);
    }

    @Override
    public void updateInsu (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.updateInsu(equipManageDto);
    }

    @Override
    public void updateInUse (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.updateInUse(equipManageDto);
    }

    @Override
    public void updateBanp (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.updateBanp(equipManageDto);
    }

    @Override
    public void updateAppData (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.updateAppData(equipManageDto);
    }

    @Override
    /* 장비 신청 모델,수량 정보  */
    public List<EquipManageDto> getAmountForModel (EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getAmountForModel(equipManageDto);
        return resultList;
    }

    @Override
    public List<EquipManageDto> getAssignedEquipInfo (EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getAssignedEquipInfo(equipManageDto);
        return resultList;
    }

    @Override
    public List<EquipManageDto> getEqnm (EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getEqnm (equipManageDto);
        return resultList;
    }

    @Override
    public boolean isAssignEquip (EquipManageDto equipManageDto) throws Exception {
        boolean result = false;

        EquipManageDto resultDto = new EquipManageDto ();
        resultDto = equipManageDao.getAssignEquip1(equipManageDto);

        int appAmount = 0;
        if(StringUtils.isNotEmpty(resultDto.getAmount())) {
            appAmount = Integer.valueOf(resultDto.getAmount());
        }

        int assignAmount = 0;
        if(StringUtils.isNotEmpty(resultDto.getMdseq())) {
            equipManageDto.setMdseqArr(resultDto.getMdseq().split(","));
            assignAmount = equipManageDao.getAssignEquip2(equipManageDto);
        }

        if( (appAmount > 0 && assignAmount > 0) && (appAmount == assignAmount) )
        {
            result = true;
        }

        return result;
    }

    /** 장비 대여상태 조회 */
    @Override
    public EquipManageDto getStatusApproval (EquipManageDto equipManageDto) throws Exception {
        EquipManageDto result = new EquipManageDto ();
        result = equipManageDao.getStatusApproval(equipManageDto);
        return result;
    }

    @Override
    public EquipManageDto getAmount (EquipManageDto equipManageDto) throws Exception {
        EquipManageDto result = new EquipManageDto ();
        result = equipManageDao.getAmount(equipManageDto);
        return result;
    }

    /*배정된모델삭제*/
    @Override
    public int delRecModel (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = equipManageDao.delRecModel(equipManageDto);
        return result;
    }

    /*배정된설비삭제*/
    @Override
    public int delRecEquip (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = equipManageDao.delRecEquip(equipManageDto);
        return result;
    }

    /*장바구니삭제*/
    @Override
    public int delBskno (EquipManageDto equipManageDto) throws Exception {
        int result = 0;
        result = equipManageDao.delBskno(equipManageDto);
        return result;
    }

    @Override
    public List<Map<String, String>> getAdminUserMail () throws Exception {
        return (List<Map<String, String>>) equipManageDao.getAdminUserMail();
    }

    @Override
    public int getNextAppno () throws Exception {
        int result = 0;
        result = equipManageDao.getNextAppno();
        return result;
    }

    @Override
    public int getNextSignSeq () throws Exception {
        int result = 0;
        result = equipManageDao.getNextSignSeq();
        return result;
    }

    @Override
    public int getNextBskno () throws Exception {
        int result = 0;
        result = equipManageDao.getNextBskno();
        return result;
    }

    @Override
    public List<EquipManageDto> getEquipInfo (EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getEquipInfo(equipManageDto);
        return resultList;
    }

    /** 장비 대여상태 조회 */
    @Override
    public EquipManageDto getEquipStatus (EquipManageDto equipManageDto) throws Exception {
        EquipManageDto result = new EquipManageDto ();
        result = equipManageDao.getStatusApproval(equipManageDto);
        return result;
    }

    /** 장비 대여상태 조회 */
    @Override
    public EquipManageDto getEquipAmount (EquipManageDto equipManageDto) throws Exception {
        EquipManageDto result = new EquipManageDto ();
        result = equipManageDao.getEquipAmount(equipManageDto);
        return result;
    }

    @Override
    public Map<String, Object> getEquipModelInfo (EquipManageDto equipManageDto) throws Exception {


        Map<String, Object> listMap = new LinkedHashMap<String, Object> ();
        Map<String, Object> gbcdMap = new LinkedHashMap<String, Object> ();
        Map<String, Object> mdseqSubMap = new LinkedHashMap<String, Object> ();
        Map<String, Object> mdseqMap = new LinkedHashMap<String, Object> ();
        Map<String, Object> eqnoSubMap = new LinkedHashMap<String, Object> ();
        Map<String, Object> eqnoMap = new LinkedHashMap<String, Object> ();


        List<EquipManageDto> resultList1 = new ArrayList<EquipManageDto> ();
        List<EquipManageDto> resultList2 = new ArrayList<EquipManageDto> ();        
        resultList1 = equipManageDao.getEquipModelInfo(equipManageDto); // MDSEQ 기준 해당 모델의 총 장비 목록
        resultList2 = equipManageDao.getEquipNo(equipManageDto); // 현재 접수된 목록에서 반려를 제외한 배정된 장비목록
        List<String> eqnoList = new ArrayList<String> ();
        for (EquipManageDto result : resultList2) {
        	// 배정된 장비목록
            eqnoList.add(result.getEqno());
        }

        String preGbcd = "";
        String preMdseq = "";
        String preEqno = "";

        for (EquipManageDto res : resultList1) {
        	// 총 장비 목록 중 배정된 장비목록과 같을 때
            if (eqnoList.contains(res.getEqno())){
                continue;
            }

            
            if (!preGbcd.equals(res.getGbcd())){
                /*값이 틀리면 새로입력*/
                preGbcd = res.getGbcd();
                /*객체초기화*/
                gbcdMap = new LinkedHashMap<String, Object> ();
                mdseqSubMap = new LinkedHashMap<String, Object> ();
                mdseqMap = new LinkedHashMap<String, Object> ();
                eqnoSubMap = new LinkedHashMap<String, Object> ();
                eqnoMap = new LinkedHashMap<String, Object> ();

                gbcdMap.put("name", res.getGbnm());
                gbcdMap.put("code", res.getGbcd());

                if(StringUtils.isNotEmpty(res.getMdseq())) {
                    if (!preMdseq.equals(res.getMdseq())){
                        /*값이 틀리면 새로입력*/
                        preMdseq = res.getMdseq();

                        mdseqMap = new LinkedHashMap<String, Object> ();
                        eqnoMap = new LinkedHashMap<String, Object> ();
                        eqnoSubMap = new LinkedHashMap<String, Object> ();

                        mdseqMap.put("name", res.getMdnm());
                        mdseqMap.put("code", res.getMdseq());

                        if(StringUtils.isNotEmpty(res.getEqno())) {
                            if (!preEqno.equals(res.getEqno())){
                                /*값이 틀리면 새로입력*/
                                preEqno = res.getEqno();

                                eqnoMap = new LinkedHashMap<String, Object> ();
                                eqnoMap.put("name", res.getEqnm());
                                eqnoMap.put("code", res.getEqno());
                                eqnoMap.put("rst", res.getEqrst());
                                eqnoMap.put("mst", res.getEqmst());
                                eqnoMap.put("lst", res.getEqlst());
                                eqnoMap.put("eqalias", res.getEqalias());

                                eqnoSubMap.put(res.getEqno(), eqnoMap);
                                mdseqMap.put("sub", eqnoSubMap);
                            }
                        }
                        mdseqSubMap.put(res.getMdseq(), mdseqMap);
                        gbcdMap.put("sub", mdseqSubMap);
                    } else {
                        if(StringUtils.isNotEmpty(res.getEqno())) {
                            if (!preEqno.equals(res.getEqno())){
                                /*값이 틀리면 새로입력*/
                                preEqno = res.getEqno();

                                eqnoMap = new LinkedHashMap<String, Object> ();
                                eqnoMap.put("name", res.getEqnm());
                                eqnoMap.put("code", res.getEqno());
                                eqnoMap.put("rst", res.getEqrst());
                                eqnoMap.put("mst", res.getEqmst());
                                eqnoMap.put("lst", res.getEqlst());
                                eqnoMap.put("eqalias", res.getEqalias());

                                eqnoSubMap.put(res.getEqno(), eqnoMap);
                                mdseqMap.put("sub", eqnoSubMap);
                            }
                        }
                    }
                }
            } else {
                if(StringUtils.isNotEmpty(res.getMdseq())) {
                    if (!preMdseq.equals(res.getMdseq())){
                        /*값이 틀리면 새로입력*/
                        preMdseq = res.getMdseq();

                        mdseqMap = new LinkedHashMap<String, Object> ();
                        eqnoMap = new LinkedHashMap<String, Object> ();
                        eqnoSubMap = new LinkedHashMap<String, Object> ();

                        mdseqMap.put("name", res.getMdnm());
                        mdseqMap.put("code", res.getMdseq());

                        if(StringUtils.isNotEmpty(res.getEqno())) {
                            if (!preEqno.equals(res.getEqno())){
                                /*값이 틀리면 새로입력*/
                                preEqno = res.getEqno();

                                eqnoMap = new LinkedHashMap<String, Object> ();
                                eqnoMap.put("name", res.getEqnm());
                                eqnoMap.put("code", res.getEqno());
                                eqnoMap.put("rst", res.getEqrst());
                                eqnoMap.put("mst", res.getEqmst());
                                eqnoMap.put("lst", res.getEqlst());
                                eqnoMap.put("eqalias", res.getEqalias());

                                eqnoSubMap.put(res.getEqno(), eqnoMap);
                                mdseqMap.put("sub", eqnoSubMap);
                            }
                        }
                        mdseqSubMap.put(res.getMdseq(), mdseqMap);
                        gbcdMap.put("sub", mdseqSubMap);
                    } else {
                        if(StringUtils.isNotEmpty(res.getEqno())) {
                            if (!preEqno.equals(res.getEqno())){
                                /*값이 틀리면 새로입력*/
                                preEqno = res.getEqno();

                                eqnoMap = new LinkedHashMap<String, Object> ();
                                eqnoMap.put("name", res.getEqnm());
                                eqnoMap.put("code", res.getEqno());
                                eqnoMap.put("rst", res.getEqrst());
                                eqnoMap.put("mst", res.getEqmst());
                                eqnoMap.put("lst", res.getEqlst());
                                eqnoMap.put("eqalias", res.getEqalias());

                                eqnoSubMap.put(res.getEqno(), eqnoMap);
                                mdseqMap.put("sub", eqnoSubMap);
                            }
                        }
                    }
                }
            }

            listMap.put(res.getGbcd(), gbcdMap);
        }

        return listMap;
    }

    @Override
    public List<EquipManageDto> getEquipNo (EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getEquipNo(equipManageDto);
        return resultList;
    }

    @Override
    public List<EquipManageDto> getNotInEquipNo (EquipManageDto equipManageDto) throws Exception {
        List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getNotInEquipNo(equipManageDto);
        return resultList;
    }

    /*사용자취소 - admin true(접수현황에서 취소), false(사용자취소)*/
    @Override
    public Boolean appCancel (String appno, Boolean admin, String sessionEmpno, String sendInfoChk) throws Exception {
        if (StringUtils.isEmpty(appno)) {
            return false;
        }
        EquipManageDto searchDto = new EquipManageDto ();
        searchDto.setAppno(appno);
        EquipManageDto resultDto = new EquipManageDto ();

        resultDto = equipManageDao.getStatusApproval(searchDto);

        Boolean isCancel = false;
        isCancel = CommonUtil.isCancel(resultDto.getStatus(), resultDto.getApproval());
        if(!isCancel) {
            return false;
        }

        RentDto updateDto = new RentDto ();
        updateDto.setUSER_EMPNO(sessionEmpno);
        updateDto.setAPPNO(Integer.valueOf(appno));
        /*결재접수이면서 최종승인 전 조건일 시 상태값만 변경*/
        rentDao.updAppCancel(updateDto);

        RentDto rentDto = new RentDto ();
        rentDto.setAPPNO(Integer.valueOf(appno));
        List<RentDto> list = rentDao.getSignInfo(rentDto);

        if (!list.isEmpty()) {

            Boolean isFinalSign = false;
            for (RentDto dto : list) {
                if(dto.getSTATUS() == "3" && dto.getREG_SIGN() == "Y") {
                    isFinalSign = true;
                }
            }

            if(!isFinalSign) {
                return true;
            }
        }

        rentDao.delAppEquip(rentDto);

        try {
            if(admin) {/*접수현황에서 취소*/

                log.debug("=================================SENDMAILUSER START==============================");
                if(sendInfoChk.equals("Y")){
	                Address[] toAddrs = new Address[1];
	                toAddrs[0] =  new InternetAddress(resultDto.getAppeno() + "@kepco.co.kr");
	                SendMail mail = SendMail.getInstance();
	                String mailSubject = "[멀티미디어 대여 취소 알림] 신청하신 접수번호[" + resultDto.getAppnum() + "]가 취소되었습니다.";
	                mail.sendMail(toAddrs, appno, "touser", "" , mailSubject);
                }else{
                	log.debug("[!] 관리자 요청 하에 메일 및 SMS가 미전송처리 되었습니다.");
                }

                log.debug("=================================SENDMAILUSER FINISH==============================");

            } else {//신청목록에서 취소(사용자)
                log.debug("=================================SENDMAILADMIN START==============================");

                Address[] toAddrs = null;
                List<Map<String, String>> result = equipManageDao.getAdminUserMail();
                if (result != null)
                    toAddrs = new Address[result.size()];

                int cnt = 0;
                for (Map<String, String> adminInfo : result) {
                    String empno = adminInfo.get("empno");
                    InternetAddress address = new InternetAddress(empno + "@kepco.co.kr");
                    toAddrs[cnt] = address;
                    cnt++;
                }
                SendMail mail = SendMail.getInstance();
                String mailSubject = "[멀티미디어 대여 취소 알림]" + resultDto.getAppenm() + "님께서 신청하신 내역이 취소되었습니다.";
                mail.sendMail(toAddrs, appno, "toadmin", "" , mailSubject);
                log.debug("=================================SENDMAILADMIN FINISH==============================");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return true;
    }

    /*대여등록*/
    @Override
    public void insertAppData (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.insertAppData(equipManageDto);
    }

    /*모델 배정*/
    @Override
    public void insertAppModel (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.insertAppModel(equipManageDto);
    }

    /*장비 배정*/
    @Override
    public void insertAppEquip (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.insertAppEquip(equipManageDto);
    }

    @Override
    public void insertSignInfo (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.insertSignInfo(equipManageDto);
    }

    @Override
    public void insertBasketInfo (EquipManageDto equipManageDto) throws Exception {
        equipManageDao.insertBasketInfo(equipManageDto);
    }

    @Override
    public void updateMailPath (HashMap<String, String> mailInfo) throws Exception {
        equipManageDao.updateMailPath(mailInfo);
    }
    /*사용자 배정*/
	@Override
	public void insertEquipUser(EquipManageDto equipManageDto) throws Exception {
		equipManageDao.insertEquipUser(equipManageDto);
	}

	@Override
	public List<EquipManageDto> getEquipUserList(EquipManageDto equipManageDto) throws Exception {
		List<EquipManageDto> resultList = new ArrayList<EquipManageDto> ();
        resultList = equipManageDao.getEquipUserList(equipManageDto);
        return resultList;
	}

	@Override
	public int updateAppEquipUser(EquipManageDto equipManageDto) throws Exception {
		return equipManageDao.updateAppEquipUser(equipManageDto);
	}

	@Override
	public List<EquipManageDto> getRecInfo(EquipManageDto equipManageDto) throws Exception {
		return equipManageDao.getRecInfo(equipManageDto);
	}

	@Override
	public void insertEQtoEU() throws Exception {
		equipManageDao.insertEQtoEU();
	}

	@Override
	public List<EquipManageDto> selectAMexpEQ() throws Exception {
		return equipManageDao.selectAMexpEQ();
	}

	@Override
	public String getMaxEuseq(EquipManageDto equipManageDto) throws Exception {
		return equipManageDao.getMaxEuseq(equipManageDto);
	}

	@Override
	public int deleteEquipUser(EquipManageDto equipManageDto) throws Exception {
		return equipManageDao.deleteEquipUser(equipManageDto);
	}
	
	@Override
	public void insertMonthAppData (HashMap<String, String> dataMap) throws Exception {
		equipManageDao.insertMonthAppData(dataMap);
	}
	
	@Override
	public HashMap<String, String> getCheckAppList () throws Exception {
		return equipManageDao.getCheckAppList();
	}
	
	@Override
	public List<HashMap<String, String>> getCheckAppMonthList (EquipManageDto equipManageDto) throws Exception {
        return equipManageDao.getCheckAppMonthList(equipManageDto);
	}
	
	@Override
	public HashMap<String, String> getCheckAppMonthInfo (String app_month) throws Exception {
        return equipManageDao.getCheckAppMonthInfo(app_month);
	}
	
	@Override
	public List<HashMap<String, String>> getCheckAppMonthListXls (EquipManageDto equipManageDto) throws Exception {
		return equipManageDao.getCheckAppMonthListXls(equipManageDto);
	}
	
	@Override
	public List<HashMap<String, String>> getCheckAppMonthDeviceList (HashMap<String, String> dataMap) throws Exception {
		return equipManageDao.getCheckAppMonthDeviceList(dataMap);
	}

	@Override
	public int getCheckAppMonthListCnt(EquipManageDto equipManageDto) throws Exception {
		return equipManageDao.getCheckAppMonthListCnt(equipManageDto);
	}
	
	@Override
	public void insertCheckAppManage (HashMap<String, String> dataMap) throws Exception {
		equipManageDao.insertCheckAppManage(dataMap);
	}
	
	@Override
	public HashMap<String, String> getMonthApproval_Info (String app_month) throws Exception {
		return equipManageDao.getMonthApproval_Info(app_month);
	}
	
	@Override
	public void updateMonthApproval_Info (String app_month, String level) throws Exception {
		equipManageDao.updateMonthApproval_Info(app_month, level);
	}

	@Override
	public void insertOneStopLog(List<OneStopLogVO> oneStopLogList) throws Exception {
		equipManageDao.insertOneStopLog(oneStopLogList);
	}
	
	@Override
	public int getOneStopLogCnt() throws Exception {
		return equipManageDao.getOneStopLogCnt();
	}

	@Override
	public List<HashMap<String, String>> oneStopLogList (OneStopLogVO oneStopLog) throws Exception {
		return equipManageDao.oneStopLogList(oneStopLog);
	}

	@Override
	public int oneStopLogListCnt(OneStopLogVO oneStopLog) throws Exception {
		return equipManageDao.oneStopLogListCnt(oneStopLog);
	}

	@Override
	public HashMap<String, String> oneStopLogDetail(OneStopLogVO oneStopLog) throws Exception {
		return equipManageDao.oneStopLogDetail(oneStopLog);
	}

	@Override
	public void insertFile(EquipManageDto equipFileDto) throws Exception {
		equipManageDao.insertFile(equipFileDto);
	}

	@Override
	public EquipManageDto selectRentFile(String appno) throws Exception {
		return equipManageDao.selectRentFile(appno);
	}

	@Override
	public int  AjaxRentFileremove(int rENT_SECURITY_SEQ) throws Exception {
		return equipManageDao.AjaxRentFileremove(rENT_SECURITY_SEQ);
	}
}