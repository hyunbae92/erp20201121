package erp.beans;

import java.util.ArrayList;
import java.util.List;

import erp.vo.DepartInfoVO;

public class DepartInfoBean {
	
	private DepartInfoVO di;
	
	public List<DepartInfoVO> getList(){
		List<DepartInfoVO> diList = new ArrayList<>();
		DepartInfoVO di = new DepartInfoVO();
		di.setDiNum(1);
		di.setDiName("개발팀");
		di.setDiEtc("야근합니까?");
		di.setDiCode("00");
		diList.add(di);
		return diList;
	}
	
	public int setDepartInfo(DepartInfoVO di) {
		this.di=di;
		return 1;
	}
	public DepartInfoVO getDepartInfoVO() {
		return this.di;
	}
}
