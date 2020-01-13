package kr.co.neodreams.multi_user.service;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.beanutils.converters.IntegerArrayConverter;
import org.apache.commons.lang.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.neodreams.multi_user.base.service.BaseService;
import kr.co.neodreams.multi_user.common.StringUtil;
import kr.co.neodreams.multi_user.dao.RentDao;
import kr.co.neodreams.multi_user.dto.RentDto;

@Service
public class RentServiceImpl extends BaseService implements RentService{

	@Autowired
	RentDao rentDao;
	
	@Override
	public List<RentDto> appList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.appList(rentDto);
	}
	
	@Override
	public int getAppListCnt(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getAppListCnt(rentDto);
	}

	@Override
	public List<RentDto> codeList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.codeList(rentDto);
	}

	@Override
	public List<RentDto> loadAppModel(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.loadAppModel(rentDto);
	}
	
	@Override
	public List<RentDto> loadSign(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.loadSign(rentDto);
	}
	
	@Override
	public RentDto getModelInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getModelInfo(rentDto);
	}
	
	@Override
	public List<RentDto> getModelInfoArr(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getModelInfoArr(rentDto);
	}
	
	@Override
	public List<RentDto> getModelInfoByAppno(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getModelInfoByAppno(rentDto);
	}

	@Override
	public RentDto getCodeInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getCodeInfo(rentDto);
	}

	@Override
	public List<RentDto> basketList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.basketList(rentDto);
	}
	
	@Override
	public void deleteBasket(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.deleteBasket(rentDto);
	}

	@Override
	public RentDto getAppStatusInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getAppStatusInfo(rentDto);
	}

	@Override
	public void updAppCancel(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updAppCancel(rentDto);
	}

	@Override
	public List<RentDto> getSignInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getSignInfo(rentDto);
	}

	@Override
	public void delAppEquip(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.delAppEquip(rentDto);
	}

	@Override
	public List<RentDto> code(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.code(rentDto);
	}

	@Override
	public int getCodeCnt(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getCodeCnt(rentDto);
	}

	@Override
	public String getMaxGbcd(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getMaxGbcd(rentDto);
	}

	@Override
	public void insCode(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.insCode(rentDto);
	}

	@Override
	public void updCode(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updCode(rentDto);
	}

	@Override
	public List<RentDto> getSubCode(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getSubCode(rentDto);
	}

	@Override
	public List<RentDto> adminList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.adminList(rentDto);
	}

	@Override
	public void deleteAdmin(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.deleteAdmin(rentDto);
	}

	@Override
	public void updateAdmin(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updateAdmin(rentDto);
	}

	@Override
	public int empidChk(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.empidChk(rentDto);
	}

	@Override
	public void insertAdmin(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.insertAdmin(rentDto);
	}

	@Override
	public List<RentDto> searchAdmin(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.searchAdmin(rentDto);
	}

	@Override
	public List<RentDto> stanModelList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.stanModelList(rentDto);
	}

	@Override
	public int getStanModelCnt(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getStanModelCnt(rentDto);
	}

	@Override
	public List<RentDto> getModelSub(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getModelSub(rentDto);
	}

	@Override
	public List<RentDto> equipList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.equipList(rentDto);
	}

	@Override
	public int getEquipCnt(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getEquipCnt(rentDto);
	}

	@Override
	public List<RentDto> discardList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.discardList(rentDto);
	}

	@Override
	public int getDiscardCnt(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getDiscardCnt(rentDto);
	}

	@Override
	public List<RentDto> companyList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.companyList(rentDto);
	}

	@Override
	public List<RentDto> getModelList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getModelList(rentDto);
	}

	@Override
	public RentDto equipInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.equipInfo(rentDto);
	}

	@Override
	public List<RentDto> getAdminChk(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getAdminChk(rentDto);
	}

	@Override
	public RentDto getEQLSTChk(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getEQLSTChk(rentDto);
	}

	@Override
	public void updEquip(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updEquip(rentDto);
	}

	@Override
	public String getNewEqnm(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getNewEqnm(rentDto);
	}

	@Override
	public int getMaxEqno(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getMaxEqno(rentDto);
	}

	@Override
	public void insEquip(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.insEquip(rentDto);
	}

	@Override
	public int getMaxFileNo() throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getMaxFileNo();
	}

	@Override
	public void insFile(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.insFile(rentDto);
	}

	@Override
	public List<RentDto> getFileList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getFileList(rentDto);
	}

	@Override
	public void delFile(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.delFile(rentDto);
	}

	@Override
	public List<RentDto> recList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.recList(rentDto);
	}

	@Override
	public int getRecListCnt(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getRecListCnt(rentDto);
	}

	@Override
	public void updModel(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updModel(rentDto);
	}

	@Override
	public void updModelSub(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updModelSub(rentDto);
	}

	@Override
	public List<RentDto> codeChkOfModelSub(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.codeChkOfModelSub(rentDto);
	}

	@Override
	public List<RentDto> codeChkOfCode(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.codeChkOfCode(rentDto);
	}

	@Override
	public void insModel(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.insModel(rentDto);
	}

	@Override
	public void insModelSub(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.insModelSub(rentDto);
	}

	@Override
	public void delModelSub(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.delModelSub(rentDto);
	}

	@Override
	public int maxMdseqModel() throws Exception {
		// TODO Auto-generated method stub
		return rentDao.maxMdseqModel();
	}

	@Override
	public int getUseEquipCnt(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getUseEquipCnt(rentDto);
	}

	@Override
	public List<RentDto> msHistory(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.msHistory(rentDto);
	}

	@Override
	public List<RentDto> searchMember(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.searchMember(rentDto);
	}

	@Override
	public List<RentDto> equipRentPop(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.equipRentPop(rentDto);
	}

	@Override
	public int getEquipRentPopCnt(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getEquipRentPopCnt(rentDto);
	}

	@Override
	public List<RentDto> equipRentStatusNo1(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.equipRentStatusNo1(rentDto);
	}

	@Override
	public List<RentDto> equipRentStatusNo2(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.equipRentStatusNo2(rentDto);
	}

	@Override
	public List<RentDto> monthlyRentStatusElement(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.monthlyRentStatusElement(rentDto);
	}

	@Override
	public List<RentDto> monthlyRentStatusData(RentDto rentDto)
			throws Exception {
		// TODO Auto-generated method stub
		return rentDao.monthlyRentStatusData(rentDto);
	}

	@Override
	public RentDto mailView(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.mailView(rentDto);
	}

	@Override
	public RentDto signInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.signInfo(rentDto);
	}

	@Override
	public RentDto getSignStatusInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getSignStatusInfo(rentDto);
	}

	@Override
	public void updSign(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updSign(rentDto);
	}

	@Override
	public void updStatus(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updStatus(rentDto);
	}

	@Override
	public List<RentDto> assignedApp(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.assignedApp(rentDto);
	}

	@Override
	public List<RentDto> allocList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.allocList(rentDto);
	}

	@Override
	public void insAppEquip(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.insAppEquip(rentDto);
	}

	@Override
	public int getEquipRentNum(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getEquipRentNum(rentDto);
	}

	@Override
	public int getCurrentAppSumAmount(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getCurrentAppSumAmount(rentDto);
	}

	@Override
	public int getBasketSumAmount(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getBasketSumAmount(rentDto);
	}

	@Override
	public void updAppModel(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updAppModel(rentDto);
	}

	@Override
	public RentDto getEqnoAppEquipInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getEqnoAppEquipInfo(rentDto);
	}

	@Override
	public List<RentDto> getReservedEquipInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getReservedEquipInfo(rentDto);
	}

	@Override
	public List<RentDto> getEquipInfoForExt(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getEquipInfoForExt(rentDto);
	}

	@Override
	public void updAppDate(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updAppDate(rentDto);
	}

	@Override
	public RentDto getAppInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getAppInfo(rentDto);
	}

	@Override
	public RentDto getAppModelInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getAppModelInfo(rentDto);
	}

	@Override
	public int getAppAmount(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getAppAmount(rentDto);
	}

	@Override
	public void updAppInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updAppInfo(rentDto);
	}

	@Override
	public List<RentDto> smsToUser(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.smsToUser(rentDto);
	}

	@Override
	public List<RentDto> getAppEquip(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getAppEquip(rentDto);
	}

	@Override
	public void updAppEquip(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.updAppEquip(rentDto);
	}
	
	@Override
	public List<RentDto> recListPreview(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.recListPreview(rentDto);
	}

	@Override
	public boolean isAssignEquip(String appno) throws Exception {
		// TODO Auto-generated method stub
        RentDto rentDto = new RentDto();
        boolean rt = false;
        
        if(StringUtil.isEmpty(appno)){
            return false;
            
        }else{
            
            int appAmount = 0;
            int assignAmount = 0;
            
            rentDto.setAPPNO(Integer.parseInt(appno));
            RentDto appModelInfo = rentDao.getAppModelInfo(rentDto);
            
            if(appModelInfo.getAMOUNT() > 0){
                appAmount = appModelInfo.getAMOUNT();
            }
            
            if(!StringUtil.isEmpty(appModelInfo.getMDSEQ_GRP())){
                String[] str = appModelInfo.getMDSEQ_GRP().split(",");
                Integer[] mdseq_arr = ArrayUtils.toObject((int[]) new IntegerArrayConverter().convert(null, str));
                rentDto.setMDSEQ_ARR(mdseq_arr);
                assignAmount = rentDao.getAppAmount(rentDto);
            }
            
            if((appAmount > 0 && assignAmount > 0) && (appAmount == assignAmount)){
                rt = true;
            }
            return rt;
        }
	}

	@Override
	public void delAppEquipUser(RentDto rentDto) throws Exception {
		rentDao.delAppEquipUser(rentDto);
	}

	@Override
	public void updAppEquipUser(RentDto rentDto) throws Exception {
		rentDao.updAppEquipUser(rentDto);
	}

	@Override
	public void insAppModel(RentDto rentDto) throws Exception {
		rentDao.insAppModel(rentDto);
	}

	@Override
	public void delAppModel(RentDto rentDto) throws Exception {
		rentDao.delAppModel(rentDto);
	}

	@Override
	public RentDto getEquipUserHistory(RentDto rentDto) throws Exception {
		return rentDao.getEquipUserHistory(rentDto);
	}

	@Override
	public void insEquipUserHistory(RentDto rentDto) throws Exception {
		rentDao.insEquipUserHistory(rentDto);
	}

	@Override
	public void updEquipUserHistory(RentDto rentDto) throws Exception {
		rentDao.updEquipUserHistory(rentDto);
	}

	@Override
	public void partBanp(RentDto rentDto) throws Exception {
    	rentDao.partBanp(rentDto);
	}
	
	@Override
	public String getMaxUhseq(RentDto rentDto) throws Exception {
		return rentDao.getMaxUhseq(rentDto);
	}

	@Override
	public RentDto getMailViewChgEu(RentDto rentDto) throws Exception {
		return rentDao.getMailViewChgEu(rentDto);
	}

	@Override
	public RentDto getMailViewChgEm(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getMailViewChgEm(rentDto);
	}

	@Override
	public List<RentDto> getAppListView(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getAppListView(rentDto);
	}

	@Override
	public RentDto getMailViewInfo(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getMailViewInfo(rentDto);
	}

	@Override
	public RentDto getEquipUser(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getEquipUser(rentDto);
	}

	@Override
	public List<RentDto> putJojikDep0List() throws Exception {
		// TODO Auto-generated method stub
		return rentDao.putJojikDep0List();
	}

	@Override
	public List<RentDto> getDept1List() throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getDept1List();
	}

	@Override
	public List<RentDto> getDept2List() throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getDept2List();
	}
	
	@Override
	public List<RentDto> getDept1UserListByCode() throws Exception {
	    // TODO Auto-generated method stub
	    return rentDao.getDept1UserListByCode();
	}
	
	@Override
	public List<RentDto> getDept2UserListByCode() throws Exception {
	    // TODO Auto-generated method stub
	    return rentDao.getDept2UserListByCode();
	}

	@Override
	public List<RentDto> getDept3List() throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getDept3List();
	}

	@Override
	public List<RentDto> getDept4List() throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getDept4List();
	}

	@Override
	public List<RentDto> getDept5List() throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getDept5List();
	}

	@Override
	public List<RentDto> getDept6List() throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getDept6List();
	}

    @Override
    public List<RentDto> getDept3ListByCode(RentDto rentDto) throws Exception {
        // TODO Auto-generated method stub
        return rentDao.getDept3ListByCode(rentDto);
    }

    @Override
    public List<RentDto> getDept4ListByCode(RentDto rentDto) throws Exception {
        // TODO Auto-generated method stub
        return rentDao.getDept4ListByCode(rentDto);
    }

    @Override
    public List<RentDto> getDept5ListByCode(RentDto rentDto) throws Exception {
        // TODO Auto-generated method stub
        return rentDao.getDept5ListByCode(rentDto);
    }

    @Override
    public List<RentDto> getDept6ListByCode(RentDto rentDto) throws Exception {
        // TODO Auto-generated method stub
        return rentDao.getDept6ListByCode(rentDto);
    }

    @Override
    public List<RentDto> getDept3UserListByCode(RentDto rentDto) throws Exception {
        // TODO Auto-generated method stub
        return rentDao.getDept3UserListByCode(rentDto);
    }

    @Override
    public List<RentDto> getDept4UserListByCode(RentDto rentDto) throws Exception {
        // TODO Auto-generated method stub
        return rentDao.getDept4UserListByCode(rentDto);
    }

    @Override
    public List<RentDto> getDept5UserListByCode(RentDto rentDto) throws Exception {
        // TODO Auto-generated method stub
        return rentDao.getDept5UserListByCode(rentDto);
    }

    @Override
    public List<RentDto> getDept6UserListByCode(RentDto rentDto) throws Exception {
        // TODO Auto-generated method stub
        return rentDao.getDept6UserListByCode(rentDto);
    }


	@Override
	public List<RentDto> getDeptEmpList(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getDeptEmpList(rentDto);
	}

    @Override
    public List<RentDto> getSearchUser(RentDto rentDto) throws Exception {
        // TODO Auto-generated method stub
        return rentDao.getSearchUser(rentDto);
    }

	@Override
	public void insertMikepSign(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		rentDao.insertMikepSign(rentDto);
	}
	
	@Override
    public HashMap<String, String> getMInsuBanpStat(HashMap<String, String> mInsuBanpStatParamMap) throws Exception {
        // TODO Auto-generated method stub
        return rentDao.getMInsuBanpStat(mInsuBanpStatParamMap);
    }

	@Override
	public List<HashMap<String, Object>> getRentListCnt(RentDto rentDto) throws Exception {
		// TODO Auto-generated method stub
		return rentDao.getRentListCnt(rentDto);
	}

	/*대여현황 사용자 정보*/
	@Override
	public List<RentDto> rentUserList(RentDto rentDto) {
		return rentDao.rentUserList(rentDto);
	}

	@Override
	public int rentUserListCnt(RentDto rentDto) throws Exception {
		return rentDao.rentUserListCnt(rentDto);
	}

	@Override
	public List<RentDto> rentCheck(String eqno) throws Exception {
		return rentDao.rentCheck(eqno);
	}

}
