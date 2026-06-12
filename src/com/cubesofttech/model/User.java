
package com.cubesofttech.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "user")
@NamedQueries({
    @NamedQuery(name = "User.findAll", query = "SELECT t FROM User t")})
public class User implements Serializable {
	/** Creates a new instance of User */
    public User() {
    }
    public User(
            String id	
            , String roleId	
            , String departmentId	
            , String managerId	
            , String positionId	
            , String employeeId	
            , String name	
            , String nickName	
            , String password	
            , String email	
            , String emailPassword	
            , String emailEnable	
            , java.sql.Date birthDate	
            , String address	
            , java.sql.Date startDate	
            , java.sql.Date endDate	
            , String workDayStart	
            , String workDayEnd	
            , String workTimeStart	
            , String workTimeEnd
            , String workType
            , String onsiteNum
            , BigDecimal latestSalary	
            , String eduInstitute1	
            , String eduInstitute2	
            , String eduInstitute3	
            , String eduInstitute4	
            , String eduDurStart1	
            , String eduDurStart2	
            , String eduDurStart3	
            , String eduDurStart4	
            , String eduDurEnd1	
            , String eduDurEnd2	
            , String eduDurEnd3	
            , String eduDurEnd4	
            , String eduDegree1	
            , String eduDegree2	
            , String eduDegree3	
            , String eduDegree4	
            , String enable	
            , BigDecimal leaveQuota1	
            , BigDecimal leaveQuota2	
            , BigDecimal leaveQuota3	
            , BigDecimal leaveQuota4	
            , java.sql.Timestamp timeCreate	
            , java.sql.Timestamp timeUpdate	
            , String emailHost	
            , java.sql.Timestamp passwordUpdate	
            , Integer loginFailed	
            , java.sql.Timestamp lastLoginFailedTime	
            , String path
            , String line_id
            , String facebookid
            , String flagSearch
            , String phonenum
            , String gender
            , Integer id_sitejob
            , String nameEN
            , String nickNameEN
            , String emergContact
            , String emergPhone
            , String employeeTypeId
            , String socialSecurity
            , BigDecimal withHold
            , String withHoldAuto
            , String taxDec
            , String transferType
            , String bank
            , String bankType
            , String bankNum
            , String bankBranch
            , String citizenId
            , String passportId
            , String paymentRemark
            , String pathSignature
            , String changepass_code
            
        ) {
        this.id = id;	
        this.roleId = roleId;	
        this.departmentId = departmentId;	
        this.managerId = managerId;	
        this.positionId = positionId;	
        this.employeeId = employeeId;	
        this.name = name;	
        this.nickName = nickName;	
        this.password = password;	
        this.email = email;	
        this.emailPassword = emailPassword;	
        this.emailEnable = emailEnable;	
        this.birthDate = birthDate;	
        this.address = address;	
        this.startDate = startDate;	
        this.endDate = endDate;	
        this.workDayStart = workDayStart;	
        this.workDayEnd = workDayEnd;	
        this.workTimeStart = workTimeStart;	
        this.workTimeEnd = workTimeEnd;
        this.workType = workType;
        this.onsiteNum = onsiteNum;
        this.latestSalary = latestSalary;	
        this.eduInstitute1 = eduInstitute1;	
        this.eduInstitute2 = eduInstitute2;	
        this.eduInstitute3 = eduInstitute3;	
        this.eduInstitute4 = eduInstitute4;	
        this.eduDurStart1 = eduDurStart1;	
        this.eduDurStart2 = eduDurStart2;	
        this.eduDurStart3 = eduDurStart3;	
        this.eduDurStart4 = eduDurStart4;	
        this.eduDurEnd1 = eduDurEnd1;	
        this.eduDurEnd2 = eduDurEnd2;	
        this.eduDurEnd3 = eduDurEnd3;	
        this.eduDurEnd4 = eduDurEnd4;	
        this.eduDegree1 = eduDegree1;	
        this.eduDegree2 = eduDegree2;	
        this.eduDegree3 = eduDegree3;	
        this.eduDegree4 = eduDegree4;	
        this.enable = enable;	
        this.leaveQuota1 = leaveQuota1;	
        this.leaveQuota2 = leaveQuota2;	
        this.leaveQuota3 = leaveQuota3;	
        this.leaveQuota4 = leaveQuota4;	
        this.timeCreate = timeCreate;	
        this.timeUpdate = timeUpdate;	
        this.emailHost = emailHost;	
        this.passwordUpdate = passwordUpdate;	
        this.loginFailed = loginFailed;	
        this.lastLoginFailedTime = lastLoginFailedTime;	
        this.path = path;
        this.line_id = line_id;
        this.facebookid = facebookid;
        this.flagSearch = flagSearch;
        this.phonenum = phonenum;
        this.gender = gender;
        this.id_sitejob = id_sitejob;
        this.nameEN = nameEN;
        this.nickNameEN = nickNameEN;
        this.emergContact = emergContact;
        this.emergPhone = emergPhone;
        this.employeeTypeId = employeeTypeId;
        this.socialSecurity = socialSecurity;
        this.withHold = withHold; 
        this.withHoldAuto = withHoldAuto;
        this.taxDec = taxDec;
        this.transferType = transferType;
        this.bank = bank;
        this.bankType = bankType;
        this.bankNum = bankNum;
        this.bankBranch = bankBranch;
        this.citizenId = citizenId;
        this.passportId = passportId;
        this.paymentRemark = paymentRemark;
        this.pathSignature = pathSignature;
        this.changepass_code = changepass_code;
    }
    
    @Id
    @Column(name = "id")
    private String id;	
    @Column(name = "role_id")
    private String roleId;	
    @Column(name = "department_id")
    private String departmentId;	
    @Column(name = "manager_id")
    private String managerId;	
    @Column(name = "position_id")
    private String positionId;	
    @Column(name = "employee_id")
    private String employeeId;	
    @Column(name = "name")
    private String name;	
    @Column(name = "nick_name")
    private String nickName;	
    @Column(name = "password")
    private String password;	
    @Column(name = "email")
    private String email;	
    @Column(name = "email_password")
    private String emailPassword;	
    @Column(name = "email_enable")
    private String emailEnable;	
    @Column(name = "birth_date")
    private java.sql.Date birthDate;	
    @Column(name = "flag_search")
    private String flagSearch;
    @Column(name = "address")
    private String address;	
    @Column(name = "start_date")
    private java.sql.Date startDate;	
    @Column(name = "end_date")
    private java.sql.Date endDate;	
    @Column(name = "work_day_start")
    private String workDayStart;	
    @Column(name = "work_day_end")
    private String workDayEnd;	
    @Column(name = "work_time_start")
    private String workTimeStart;	
    @Column(name = "work_time_end")
    private String workTimeEnd;	
    @Column (name = "work_type")
    private String workType;
    @Column (name = "onsite_num")
    private String onsiteNum;
    @Column(name = "latest_salary")
    private BigDecimal latestSalary;	
    @Column(name = "edu_institute_1")
    private String eduInstitute1;	
    @Column(name = "edu_institute_2")
    private String eduInstitute2;	
    @Column(name = "edu_institute_3")
    private String eduInstitute3;	
    @Column(name = "edu_institute_4")
    private String eduInstitute4;	
    @Column(name = "edu_dur_start_1")
    private String eduDurStart1;	
    @Column(name = "edu_dur_start_2")
    private String eduDurStart2;	
    @Column(name = "edu_dur_start_3")
    private String eduDurStart3;	
    @Column(name = "edu_dur_start_4")
    private String eduDurStart4;	
    @Column(name = "edu_dur_end_1")
    private String eduDurEnd1;	
    @Column(name = "edu_dur_end_2")
    private String eduDurEnd2;	
    @Column(name = "edu_dur_end_3")
    private String eduDurEnd3;	
    @Column(name = "edu_dur_end_4")
    private String eduDurEnd4;	
    @Column(name = "edu_degree_1")
    private String eduDegree1;	
    @Column(name = "edu_degree_2")
    private String eduDegree2;	
    @Column(name = "edu_degree_3")
    private String eduDegree3;	
    @Column(name = "edu_degree_4")
    private String eduDegree4;	
    @Column(name = "enable")
    private String enable;	
    @Column(name = "leave_quota_1")
    private BigDecimal leaveQuota1;	
    @Column(name = "leave_quota_2")
    private BigDecimal leaveQuota2;	
    @Column(name = "leave_quota_3")
    private BigDecimal leaveQuota3;	
    @Column(name = "leave_quota_lastyear")
    private BigDecimal leaveQuota4; //this is last year	
    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;	
    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;	
    @Column(name = "email_host")
    private String emailHost;	
    @Column(name = "password_update")
    private java.sql.Timestamp passwordUpdate;	
    @Column(name = "login_failed")
    private Integer loginFailed;	
    @Column(name = "last_login_failed_time")
    private java.sql.Timestamp lastLoginFailedTime;	
    @Column(name = "path")
    private String path;
    @Column(name = "facebookid")
    private String facebookid;
    //line
    @Column(name = "line_id")
    private String line_id;
    @Column(name = "phone_num")
    private String phonenum;
    @Column(name = "gender")
    private String gender;
    @Column(name = "username")
    private String username;
    @Column(name = "id_sitejob")
    private Integer id_sitejob;
    @Column(name = "title_name_th")
    private String titleNameTH;
    @Column(name = "title_name_en")
    private String titleNameEN;
    @Column(name = "name_en")
    private String nameEN;
    @Column(name = "nick_name_en")
    private String nickNameEN;
    @Column(name = "emergency_contact")
    private String emergContact;
    @Column(name = "emergency_phone")
    private String emergPhone;
    @Column(name = "employee_type_id")
    private String employeeTypeId;
    @Column(name = "social_security")
    private String socialSecurity;
    @Column(name = "withholding")
    private BigDecimal withHold;
    @Column(name = "withholding_auto")
    private String withHoldAuto;
    @Column(name = "tax_deduction")
    private String taxDec;
	@Column(name = "transfer_type")
    private String transferType;
    @Column(name = "bank")
    private String bank;
    @Column(name = "bank_type")
    private String bankType;
    @Column(name = "bank_number")
    private String bankNum;
    @Column(name = "bank_branch")
    private String bankBranch;
    @Column(name = "citizen_id")
    private String citizenId;
    @Column(name = "passport_id")
    private String passportId;
    @Column(name = "inc_da")
    private String incDa;
    @Column(name = "inc_nb")
    private String incNb;
    @Column(name = "payment_remark")
    private String paymentRemark;
    @Column(name = "path_signature")
    private String pathSignature;
    @Column(name = "employee_status")
    private String employeeStatus;
    @Column(name = "changepass_code")
    private String changepass_code;


    public Integer getId_sitejob() {
		return id_sitejob;
	}
	public void setId_sitejob(Integer id_sitejob) {
		this.id_sitejob = id_sitejob;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getFlagSearch() {
		return flagSearch;
	}
	public void setFlagSearch(String flagSearch) {
		this.flagSearch = flagSearch;
	}
	public BigDecimal getLeaveQuota4() {
		return leaveQuota4;
	}
	public void setLeaveQuota4(BigDecimal leaveQuota4) {
		this.leaveQuota4 = leaveQuota4;
	}
	public String getId() {
        return this.id;
    }		
    public void setId(String id) {
        this.id = id;
    }
    public String getRoleId() {
        return this.roleId;
    }		
    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }
    public String getDepartmentId() {
        return this.departmentId;
    }		
    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }
    public String getManagerId() {
        return this.managerId;
    }		
    public void setManagerId(String managerId) {
        this.managerId = managerId;
    }
    public String getPositionId() {
        return this.positionId;
    }		
    public void setPositionId(String positionId) {
        this.positionId = positionId;
    }
    public String getEmployeeId() {
        return this.employeeId;
    }		
    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }
    public String getName() {
        return this.name;
    }		
    public void setName(String name) {
        this.name = name;
    }
    public String getNickName() {
        return this.nickName;
    }		
    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
    public String getPassword() {
        return this.password;
    }		
    public void setPassword(String password) {
        this.password = password;
    }
    public String getEmail() {
        return this.email;
    }		
    public void setEmail(String email) {
        this.email = email;
    }
    public String getEmailPassword() {
        return this.emailPassword;
    }		
    public void setEmailPassword(String emailPassword) {
        this.emailPassword = emailPassword;
    }
    public String getEmailEnable() {
        return this.emailEnable;
    }		
    public void setEmailEnable(String emailEnable) {
        this.emailEnable = emailEnable;
    }
    public java.sql.Date getBirthDate() {
        return this.birthDate;
    }		
    public void setBirthDate(java.sql.Date birthDate) {
        this.birthDate = birthDate;
    }
    public String getAddress() {
        return this.address;
    }		
    public void setAddress(String address) {
        this.address = address;
    }
    public java.sql.Date getStartDate() {
        return this.startDate;
    }		
    public void setStartDate(java.sql.Date startDate) {
        this.startDate = startDate;
    }
    public java.sql.Date getEndDate() {
        return this.endDate;
    }		
    public void setEndDate(java.sql.Date endDate) {
        this.endDate = endDate;
    }
    public String getWorkDayStart() {
        return this.workDayStart;
    }		
    public void setWorkDayStart(String workDayStart) {
        this.workDayStart = workDayStart;
    }
    public String getWorkDayEnd() {
        return this.workDayEnd;
    }		
    public void setWorkDayEnd(String workDayEnd) {
        this.workDayEnd = workDayEnd;
    }
    public String getWorkTimeStart() {
        return this.workTimeStart;
    }		
    public void setWorkTimeStart(String workTimeStart) {
        this.workTimeStart = workTimeStart;
    }
    public String getWorkTimeEnd() {
        return this.workTimeEnd;
    }		
    public void setWorkTimeEnd(String workTimeEnd) {
        this.workTimeEnd = workTimeEnd;
    }
    //addnew colum
    public String getWorkType() {
        return this.workType;
    }		
    public void setWorkType(String workType) {
        this.workType = workType;
    }
    
    public String getOnsiteNum() {
        return this.onsiteNum;
    }		
    public void setOnsiteNum(String onsiteNum) {
        this.onsiteNum = onsiteNum;
    }
    
    public BigDecimal getLatestSalary() {
        return this.latestSalary;
    }		
    public void setLatestSalary(BigDecimal latestSalary) {
        this.latestSalary = latestSalary;
    }
    public String getEduInstitute1() {
        return this.eduInstitute1;
    }		
    public void setEduInstitute1(String eduInstitute1) {
        this.eduInstitute1 = eduInstitute1;
    }
    public String getEduInstitute2() {
        return this.eduInstitute2;
    }		
    public void setEduInstitute2(String eduInstitute2) {
        this.eduInstitute2 = eduInstitute2;
    }
    public String getEduInstitute3() {
        return this.eduInstitute3;
    }		
    public void setEduInstitute3(String eduInstitute3) {
        this.eduInstitute3 = eduInstitute3;
    }
    public String getEduInstitute4() {
        return this.eduInstitute4;
    }		
    public void setEduInstitute4(String eduInstitute4) {
        this.eduInstitute4 = eduInstitute4;
    }
    public String getEduDurStart1() {
        return this.eduDurStart1;
    }		
    public void setEduDurStart1(String eduDurStart1) {
        this.eduDurStart1 = eduDurStart1;
    }
    public String getEduDurStart2() {
        return this.eduDurStart2;
    }		
    public void setEduDurStart2(String eduDurStart2) {
        this.eduDurStart2 = eduDurStart2;
    }
    public String getEduDurStart3() {
        return this.eduDurStart3;
    }		
    public void setEduDurStart3(String eduDurStart3) {
        this.eduDurStart3 = eduDurStart3;
    }
    public String getEduDurStart4() {
        return this.eduDurStart4;
    }		
    public void setEduDurStart4(String eduDurStart4) {
        this.eduDurStart4 = eduDurStart4;
    }
    public String getEduDurEnd1() {
        return this.eduDurEnd1;
    }		
    public void setEduDurEnd1(String eduDurEnd1) {
        this.eduDurEnd1 = eduDurEnd1;
    }
    public String getEduDurEnd2() {
        return this.eduDurEnd2;
    }		
    public void setEduDurEnd2(String eduDurEnd2) {
        this.eduDurEnd2 = eduDurEnd2;
    }
    public String getEduDurEnd3() {
        return this.eduDurEnd3;
    }		
    public void setEduDurEnd3(String eduDurEnd3) {
        this.eduDurEnd3 = eduDurEnd3;
    }
    public String getEduDurEnd4() {
        return this.eduDurEnd4;
    }		
    public void setEduDurEnd4(String eduDurEnd4) {
        this.eduDurEnd4 = eduDurEnd4;
    }
    public String getEduDegree1() {
        return this.eduDegree1;
    }		
    public void setEduDegree1(String eduDegree1) {
        this.eduDegree1 = eduDegree1;
    }
    public String getEduDegree2() {
        return this.eduDegree2;
    }		
    public void setEduDegree2(String eduDegree2) {
        this.eduDegree2 = eduDegree2;
    }
    public String getEduDegree3() {
        return this.eduDegree3;
    }		
    public void setEduDegree3(String eduDegree3) {
        this.eduDegree3 = eduDegree3;
    }
    public String getEduDegree4() {
        return this.eduDegree4;
    }		
    public void setEduDegree4(String eduDegree4) {
        this.eduDegree4 = eduDegree4;
    }
    public String getEnable() {
        return this.enable;
    }		
    public void setEnable(String enable) {
        this.enable = enable;
    }
    public BigDecimal getLeaveQuota1() {
        return this.leaveQuota1;
    }		
    public void setLeaveQuota1(BigDecimal leaveQuota1) {
        this.leaveQuota1 = leaveQuota1;
    }
    public BigDecimal getLeaveQuota2() {
        return this.leaveQuota2;
    }		
    public void setLeaveQuota2(BigDecimal leaveQuota2) {
        this.leaveQuota2 = leaveQuota2;
    }
    public BigDecimal getLeaveQuota3() {
        return this.leaveQuota3;
    }		
    public void setLeaveQuota3(BigDecimal leaveQuota3) {
        this.leaveQuota3 = leaveQuota3;
    }
    public java.sql.Timestamp getTimeCreate() {
        return this.timeCreate;
    }		
    public void setTimeCreate(java.sql.Timestamp timeCreate) {
        this.timeCreate = timeCreate;
    }
    public java.sql.Timestamp getTimeUpdate() {
        return this.timeUpdate;
    }		
    public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
        this.timeUpdate = timeUpdate;
    }
    public String getEmailHost() {
        return this.emailHost;
    }		
    public void setEmailHost(String emailHost) {
        this.emailHost = emailHost;
    }
    public java.sql.Timestamp getPasswordUpdate() {
        return this.passwordUpdate;
    }		
    public void setPasswordUpdate(java.sql.Timestamp passwordUpdate) {
        this.passwordUpdate = passwordUpdate;
    }
    public Integer getLoginFailed() {
        return this.loginFailed;
    }		
    public void setLoginFailed(Integer loginFailed) {
        this.loginFailed = loginFailed;
    }
    public java.sql.Timestamp getLastLoginFailedTime() {
        return this.lastLoginFailedTime;
    }		
    public void setLastLoginFailedTime(java.sql.Timestamp lastLoginFailedTime) {
        this.lastLoginFailedTime = lastLoginFailedTime;
    }
    public String getPath() {
        return this.path;
    }		
    public void setPath(String path) {
        this.path = path;
    }
    public String getFacebookid() {
        return this.facebookid;
    }		
    public void setFacebookid(String facebookid) {
        this.facebookid = facebookid;
    }
    
//    line
	public String getLine_id() {
		return line_id;
	}
	public void setLine_id(String line_id) {
		this.line_id = line_id;
	}
	public String getPhonenum() {
        return phonenum;
    }		
    public void setPhonenum(String phone_num) {
        this.phonenum = phone_num;
    }
	public String getGender() {
        return this.gender;
    }		
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getTitleNameTH() {
		return titleNameTH;
	}
	public void setTitleNameTH(String titleNameTH) {
		this.titleNameTH = titleNameTH;
	}
	public String getTitleNameEN() {
		return titleNameEN;
	}
	public void setTitleNameEN(String titleNameEN) {
		this.titleNameEN = titleNameEN;
	}
	public String getNameEN() {
		return nameEN;
	}
	public void setNameEN(String nameEN) {
		this.nameEN = nameEN;
	}
	public String getNickNameEN() {
		return nickNameEN;
	}
	public void setNickNameEN(String nickNameEN) {
		this.nickNameEN = nickNameEN;
	}

	/*
	 * public String getPhone_num() { return phone_num; } public void
	 * setPhone_num(String phone_num) { this.phone_num = phone_num; }
	 */
	public String getEmergContact() {
		return emergContact;
	}
	public void setEmergContact(String emergContact) {
		this.emergContact = emergContact;
	}
	public String getEmergPhone() {
		return emergPhone;
	}
	public void setEmergPhone(String emergPhone) {
		this.emergPhone = emergPhone;
	}
	public String getEmployeeTypeId() {
		return employeeTypeId;
	}
	public void setEmployeeTypeId(String employeeTypeId) {
		this.employeeTypeId = employeeTypeId;
	}
	public String getSocialSecurity() {
		return socialSecurity;
	}
	public void setSocialSecurity(String socialSecurity) {
		this.socialSecurity = socialSecurity;
	}
	public BigDecimal getWithHold() {
		return withHold;
	}
	public void setWithHold(BigDecimal withHold) {
		this.withHold = withHold;
	}
	public String getWithHoldAuto() {
		return withHoldAuto;
	}
	public void setWithHoldAuto(String withHoldAuto) {
		this.withHoldAuto = withHoldAuto;
	}
	public String getTaxDec() {
		return taxDec;
	}
	public void setTaxDec(String taxDec) {
		this.taxDec = taxDec;
	}
	public String getTransferType() {
		return transferType;
	}
	public void setTransferType(String transferType) {
		this.transferType = transferType;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getBankType() {
		return bankType;
	}
	public void setBankType(String bankType) {
		this.bankType = bankType;
	}
	public String getBankNum() {
		return bankNum;
	}
	public void setBankNum(String bankNum) {
		this.bankNum = bankNum;
	}
	public String getBankBranch() {
		return bankBranch;
	}
	public void setBankBranch(String bankBranch) {
		this.bankBranch = bankBranch;
	}
	public String getCitizenId() {
		return citizenId;
	}
	public void setCitizenId(String citizenId) {
		this.citizenId = citizenId;
	}
	public String getPassportId() {
		return passportId;
	}
	public void setPassportId(String passportId) {
		this.passportId = passportId;
	}
	
	public String getIncDa() {
		return incDa;
	}
	public void setIncDa(String incDa) {
		this.incDa = incDa;
	}
	public String getIncNb() {
		return incNb;
	}
	public void setIncNb(String incNb) {
		this.incNb = incNb;
	}
	public String getPaymentRemark() {
		return paymentRemark;
	}
	public void setPaymentRemark(String paymentRemark) {
		this.paymentRemark = paymentRemark;
	}
	
	public String getPathSignature() {
		return pathSignature;
	}
	public void setPathSignature(String pathSignature) {
		this.pathSignature = pathSignature;
	}
	
	public String getEmployeeStatus() {
		return employeeStatus;
	}
	public void setEmployeeStatus(String employeeStatus) {
		this.employeeStatus = employeeStatus;
	}
	
	public String getChangepass_code() {
		return changepass_code;
	}
	public void setChangepass_code(String changepass_code) {
		this.changepass_code = changepass_code;
	}
	
	@Override
	public String toString() {
		return "User [id=" + id + ", roleId=" + roleId + ", departmentId=" + departmentId + ", managerId=" + managerId
				+ ", positionId=" + positionId + ", employeeId=" + employeeId + ", name=" + name + ", nickName="
				+ nickName + ", password=" + password + ", email=" + email + ", emailPassword=" + emailPassword
				+ ", emailEnable=" + emailEnable + ", birthDate=" + birthDate + ", flagSearch=" + flagSearch
				+ ", address=" + address + ", startDate=" + startDate + ", endDate=" + endDate + ", workDayStart="
				+ workDayStart + ", workDayEnd=" + workDayEnd + ", workTimeStart=" + workTimeStart + ", workTimeEnd="
				+ workTimeEnd + ", workType=" + workType + ", onsiteNum=" + onsiteNum + ", latestSalary=" + latestSalary
				+ ", eduInstitute1=" + eduInstitute1 + ", eduInstitute2=" + eduInstitute2 + ", eduInstitute3="
				+ eduInstitute3 + ", eduInstitute4=" + eduInstitute4 + ", eduDurStart1=" + eduDurStart1
				+ ", eduDurStart2=" + eduDurStart2 + ", eduDurStart3=" + eduDurStart3 + ", eduDurStart4=" + eduDurStart4
				+ ", eduDurEnd1=" + eduDurEnd1 + ", eduDurEnd2=" + eduDurEnd2 + ", eduDurEnd3=" + eduDurEnd3
				+ ", eduDurEnd4=" + eduDurEnd4 + ", eduDegree1=" + eduDegree1 + ", eduDegree2=" + eduDegree2
				+ ", eduDegree3=" + eduDegree3 + ", eduDegree4=" + eduDegree4 + ", enable=" + enable + ", leaveQuota1="
				+ leaveQuota1 + ", leaveQuota2=" + leaveQuota2 + ", leaveQuota3=" + leaveQuota3 + ", leaveQuota4="
				+ leaveQuota4 + ", timeCreate=" + timeCreate + ", timeUpdate=" + timeUpdate + ", emailHost=" + emailHost
				+ ", passwordUpdate=" + passwordUpdate + ", loginFailed=" + loginFailed + ", lastLoginFailedTime="
				+ lastLoginFailedTime + ", path=" + path + ", facebookid=" + facebookid + ", line_id=" + line_id
				+ ", phonenum=" + phonenum + ", gender=" + gender + ", username=" + username + ", id_sitejob="
				+ id_sitejob + ", titleNameTH=" + titleNameTH + ", titleNameEN=" + titleNameEN + ", nameEN=" + nameEN
				+ ", nickNameEN=" + nickNameEN + ", emergContact=" + emergContact + ", emergPhone=" + emergPhone
				+ ", employeeTypeId=" + employeeTypeId + ", socialSecurity=" + socialSecurity + ", withHold=" + withHold
				+ ", withHoldAuto=" + withHoldAuto + ", taxDec=" + taxDec + ", transferType=" + transferType + ", bank="
				+ bank + ", bankType=" + bankType + ", bankNum=" + bankNum + ", bankBranch=" + bankBranch
				+ ", citizenId=" + citizenId + ", passportId=" + passportId + ", incDa=" + incDa + ", incNb=" + incNb
				+ ", paymentRemark=" + paymentRemark + ", pathSignature=" + pathSignature + ", employeeStatus=" + employeeStatus + "]";
	}
	

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof User)) {
                return false;
        }
        User that = (User) obj;
        if (!(that.getId() == null ? this.getId() == null
                        : that.getId().equals(this.getId()))) {
                return false;
        }
        if (!(that.getRoleId() == null ? this.getRoleId() == null
                        : that.getRoleId().equals(this.getRoleId()))) {
                return false;
        }
        if (!(that.getDepartmentId() == null ? this.getDepartmentId() == null
                        : that.getDepartmentId().equals(this.getDepartmentId()))) {
                return false;
        }
        if (!(that.getManagerId() == null ? this.getManagerId() == null
                        : that.getManagerId().equals(this.getManagerId()))) {
                return false;
        }
        if (!(that.getPositionId() == null ? this.getPositionId() == null
                        : that.getPositionId().equals(this.getPositionId()))) {
                return false;
        }
        if (!(that.getEmployeeId() == null ? this.getEmployeeId() == null
                        : that.getEmployeeId().equals(this.getEmployeeId()))) {
                return false;
        }
        if (!(that.getName() == null ? this.getName() == null
                        : that.getName().equals(this.getName()))) {
                return false;
        }
        if (!(that.getNickName() == null ? this.getNickName() == null
                        : that.getNickName().equals(this.getNickName()))) {
                return false;
        }
        if (!(that.getPassword() == null ? this.getPassword() == null
                        : that.getPassword().equals(this.getPassword()))) {
                return false;
        }
        if (!(that.getEmail() == null ? this.getEmail() == null
                        : that.getEmail().equals(this.getEmail()))) {
                return false;
        }
        if (!(that.getEmailPassword() == null ? this.getEmailPassword() == null
                        : that.getEmailPassword().equals(this.getEmailPassword()))) {
                return false;
        }
        if (!(that.getEmailEnable() == null ? this.getEmailEnable() == null
                        : that.getEmailEnable().equals(this.getEmailEnable()))) {
                return false;
        }
        if (!(that.getBirthDate() == null ? this.getBirthDate() == null
                        : that.getBirthDate().equals(this.getBirthDate()))) {
                return false;
        }
        if (!(that.getAddress() == null ? this.getAddress() == null
                        : that.getAddress().equals(this.getAddress()))) {
                return false;
        }
        if (!(that.getStartDate() == null ? this.getStartDate() == null
                        : that.getStartDate().equals(this.getStartDate()))) {
                return false;
        }
        if (!(that.getEndDate() == null ? this.getEndDate() == null
                        : that.getEndDate().equals(this.getEndDate()))) {
                return false;
        }
        if (!(that.getWorkDayStart() == null ? this.getWorkDayStart() == null
                        : that.getWorkDayStart().equals(this.getWorkDayStart()))) {
                return false;
        }
        if (!(that.getWorkDayEnd() == null ? this.getWorkDayEnd() == null
                        : that.getWorkDayEnd().equals(this.getWorkDayEnd()))) {
                return false;
        }
        if (!(that.getWorkTimeStart() == null ? this.getWorkTimeStart() == null
                        : that.getWorkTimeStart().equals(this.getWorkTimeStart()))) {
                return false;
        }
        if (!(that.getWorkTimeEnd() == null ? this.getWorkTimeEnd() == null
                        : that.getWorkTimeEnd().equals(this.getWorkTimeEnd()))) {
                return false;
        }
        if (!(that.getLatestSalary() == null ? this.getLatestSalary() == null
                        : that.getLatestSalary().equals(this.getLatestSalary()))) {
                return false;
        }
        if (!(that.getEduInstitute1() == null ? this.getEduInstitute1() == null
                        : that.getEduInstitute1().equals(this.getEduInstitute1()))) {
                return false;
        }
        if (!(that.getEduInstitute2() == null ? this.getEduInstitute2() == null
                        : that.getEduInstitute2().equals(this.getEduInstitute2()))) {
                return false;
        }
        if (!(that.getEduInstitute3() == null ? this.getEduInstitute3() == null
                        : that.getEduInstitute3().equals(this.getEduInstitute3()))) {
                return false;
        }
        if (!(that.getEduInstitute4() == null ? this.getEduInstitute4() == null
                        : that.getEduInstitute4().equals(this.getEduInstitute4()))) {
                return false;
        }
        if (!(that.getEduDurStart1() == null ? this.getEduDurStart1() == null
                        : that.getEduDurStart1().equals(this.getEduDurStart1()))) {
                return false;
        }
        if (!(that.getEduDurStart2() == null ? this.getEduDurStart2() == null
                        : that.getEduDurStart2().equals(this.getEduDurStart2()))) {
                return false;
        }
        if (!(that.getEduDurStart3() == null ? this.getEduDurStart3() == null
                        : that.getEduDurStart3().equals(this.getEduDurStart3()))) {
                return false;
        }
        if (!(that.getEduDurStart4() == null ? this.getEduDurStart4() == null
                        : that.getEduDurStart4().equals(this.getEduDurStart4()))) {
                return false;
        }
        if (!(that.getEduDurEnd1() == null ? this.getEduDurEnd1() == null
                        : that.getEduDurEnd1().equals(this.getEduDurEnd1()))) {
                return false;
        }
        if (!(that.getEduDurEnd2() == null ? this.getEduDurEnd2() == null
                        : that.getEduDurEnd2().equals(this.getEduDurEnd2()))) {
                return false;
        }
        if (!(that.getEduDurEnd3() == null ? this.getEduDurEnd3() == null
                        : that.getEduDurEnd3().equals(this.getEduDurEnd3()))) {
                return false;
        }
        if (!(that.getEduDurEnd4() == null ? this.getEduDurEnd4() == null
                        : that.getEduDurEnd4().equals(this.getEduDurEnd4()))) {
                return false;
        }
        if (!(that.getEduDegree1() == null ? this.getEduDegree1() == null
                        : that.getEduDegree1().equals(this.getEduDegree1()))) {
                return false;
        }
        if (!(that.getEduDegree2() == null ? this.getEduDegree2() == null
                        : that.getEduDegree2().equals(this.getEduDegree2()))) {
                return false;
        }
        if (!(that.getEduDegree3() == null ? this.getEduDegree3() == null
                        : that.getEduDegree3().equals(this.getEduDegree3()))) {
                return false;
        }
        if (!(that.getEduDegree4() == null ? this.getEduDegree4() == null
                        : that.getEduDegree4().equals(this.getEduDegree4()))) {
                return false;
        }
        if (!(that.getEnable() == null ? this.getEnable() == null
                        : that.getEnable().equals(this.getEnable()))) {
                return false;
        }
        if (!(that.getLeaveQuota1() == null ? this.getLeaveQuota1() == null
                        : that.getLeaveQuota1().equals(this.getLeaveQuota1()))) {
                return false;
        }
        if (!(that.getLeaveQuota2() == null ? this.getLeaveQuota2() == null
                        : that.getLeaveQuota2().equals(this.getLeaveQuota2()))) {
                return false;
        }
        if (!(that.getLeaveQuota3() == null ? this.getLeaveQuota3() == null
                        : that.getLeaveQuota3().equals(this.getLeaveQuota3()))) {
                return false;
        }
        if (!(that.getTimeCreate() == null ? this.getTimeCreate() == null
                        : that.getTimeCreate().equals(this.getTimeCreate()))) {
                return false;
        }
        if (!(that.getTimeUpdate() == null ? this.getTimeUpdate() == null
                        : that.getTimeUpdate().equals(this.getTimeUpdate()))) {
                return false;
        }
        if (!(that.getEmailHost() == null ? this.getEmailHost() == null
                        : that.getEmailHost().equals(this.getEmailHost()))) {
                return false;
        }
        if (!(that.getPasswordUpdate() == null ? this.getPasswordUpdate() == null
                        : that.getPasswordUpdate().equals(this.getPasswordUpdate()))) {
                return false;
        }
        if (!(that.getLoginFailed() == null ? this.getLoginFailed() == null
                        : that.getLoginFailed().equals(this.getLoginFailed()))) {
                return false;
        }
        if (!(that.getLastLoginFailedTime() == null ? this.getLastLoginFailedTime() == null
                        : that.getLastLoginFailedTime().equals(this.getLastLoginFailedTime()))) {
                return false;
        }
        if (!(that.getPath() == null ? this.getPath() == null
                        : that.getPath().equals(this.getPath()))) {
                return false;
        }
        if (!(that.getFacebookid() == null ? this.getFacebookid() == null
                : that.getFacebookid().equals(this.getFacebookid()))) {
        return false;
        }
        if (!(that.getPhonenum() == null ? this.getPhonenum() == null
                : that.getPhonenum().equals(this.getPhonenum()))) {
        	return false;
        }
        if (!(that.getGender() == null ? this.getGender() == null
                : that.getGender().equals(this.getGender()))) {
        	return false;
        }
        if (!(that.getTitleNameTH() == null ? this.getTitleNameTH() == null
        		: that.getTitleNameTH().equals(this.getTitleNameTH()))) {
        	return false;	
        }
        if (!(that.getTitleNameEN() == null ? this.getTitleNameEN() == null
        		: that.getTitleNameEN().equals(this.getTitleNameEN()))) {
        	return false;	
        }
        if (!(that.getNameEN() == null ? this.getNameEN() == null
        		: that.getNameEN().equals(this.getNameEN()))) {
        	return false;	
        }
        if (!(that.getNickNameEN() == null ? this.getNickNameEN() == null
        		: that.getNickNameEN().equals(this.getNickNameEN()))) {
        	return false;	
        }
        if(!(that.getEmergContact() == null ? this.getEmergContact() == null
        		: that.getEmergContact().equals(this.getEmergContact()))) {
        	return false;	
        }
        if(!(that.getEmergPhone() == null ? this.getEmergPhone() == null
        		: that.getEmergPhone().equals(this.getEmergPhone()))) {
        	return false;	
        }
        if(!(that.getEmployeeTypeId() == null ? this.getEmployeeTypeId() == null
        		: that.getEmployeeTypeId().equals(this.getEmployeeTypeId()))) {
        	return false;	
        }
        if(!(that.getSocialSecurity() == null ? this.getSocialSecurity() == null
        		: that.getSocialSecurity().equals(this.getSocialSecurity()))) {
        	return false;	
        }
        if(!(that.getWithHold() == null ? this.getWithHold() == null
        		: that.getWithHold().equals(this.getWithHold()))) {
        	return false;	
        }
        if(!(that.getWithHoldAuto() == null ? this.getWithHoldAuto() == null
        		: that.getWithHoldAuto().equals(this.getWithHoldAuto()))) {
        	return false;	
        }
        if(!(that.getTaxDec() == null ? this.getTaxDec() == null
        		: that.getTaxDec().equals(this.getTaxDec()))) {
        	return false;	
        }
        if(!(that.getTransferType() == null ? this.getTransferType() == null
        		: that.getTransferType().equals(this.getTransferType()))) {
        	return false;	
        }
        if(!(that.getBank() == null ? this.getBank() == null
        		: that.getBank().equals(this.getBank()))) {
        	return false;	
        }
        if(!(that.getBankType() == null ? this.getBankType() == null
        		: that.getBankType().equals(this.getBankType()))) {
        	return false;	
        }
        if(!(that.getBankNum() == null ? this.getBankNum() == null
        		: that.getBankNum().equals(this.getBankNum()))) {
        	return false;	
        }
        if(!(that.getBankBranch() == null ? this.getBankBranch() == null
        		: that.getBankBranch().equals(this.getBankBranch()))) {
        	return false;	
        }
        if(!(that.getCitizenId() == null ? this.getCitizenId() == null
        		: that.getCitizenId().equals(this.getCitizenId()))) {
        	return false;	
        }
        if(!(that.getPassportId() == null ? this.getPassportId() == null
        		: that.getPassportId().equals(this.getPassportId()))) {
        	return false;	
        }
        if(!(that.getPaymentRemark() == null ? this.getPaymentRemark() == null
        		: that.getPaymentRemark().equals(this.getPaymentRemark()))) {
        	return false;	
        }
        if(!(that.getPathSignature() == null ? this.getPathSignature() == null
        		: that.getPathSignature().equals(this.getPathSignature()))) {
        	return false;	
        }
        if(!(that.getEmployeeStatus() == null ? this.getEmployeeStatus() == null
        		: that.getEmployeeStatus().equals(this.getEmployeeStatus()))) {
        	return false;	
        }
        if(!(that.getChangepass_code() == null ? this.getChangepass_code() == null
        		: that.getChangepass_code().equals(this.getChangepass_code()))) {
        	return false;	
        }
        	
    return true;
    }

}
