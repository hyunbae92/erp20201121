package erp.vo;

public class DepartInfoVO {

	private Integer diNum;
	private String diName;
	private String diCode;
	private String diEtc;
	
	//getter ,setter
	public Integer getDiNum() {
		return diNum;
	}
	public void setDiNum(Integer diNum) {
		this.diNum = diNum;
	}
	public String getDiName() {
		return diName;
	}
	public void setDiName(String diName) {
		this.diName = diName;
	}
	public String getDiCode() {
		return diCode;
	}
	public void setDiCode(String diCode) {
		this.diCode = diCode;
	}
	public String getDiEtc() {
		return diEtc;
	}
	public void setDiEtc(String diEtc) {
		this.diEtc = diEtc;
	}
	
	//toString
	@Override
	public String toString() {
		return "DepartInfoVO [diNum=" + diNum + ", diName=" + diName + ", diCode=" + diCode + ", diEtc=" + diEtc + "]";
	}
	
}
