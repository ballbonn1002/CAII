package com.cubesofttech.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "company_contact")
public class CompanyContact {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "company_contact_id")
    private Long companyContactId;

    @Column(name = "company_id")
    private String companyId;

    @Column(name = "file_id")
    private String fileId;

    @Column(name = "social_id")
    private String socialId;

    @Column(name = "company_address_id")
    private String companyAddressId;

    @Column(name = "title_name_en")
    private String titleNameEn;

    @Column(name = "contact_name")
    private String contactName;

    @Column(name = "nickname")
    private String nickname;

    @Column(name = "title_name_th")
    private String titleNameTh;

    @Column(name = "contact_name_th")
    private String contactNameTh;

    @Column(name = "nickname_th")
    private String nicknameTh;

    @Column(name = "position")
    private String position;

    @Column(name = "company_en")
    private String companyEn;

    @Column(name = "phone")
    private String phone;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "admin")
    private String admin;

    @Column(name = "address_location")
    private String addressLocation;

    @Column(name = "is_active")
    private String isActive;

    @Column(name = "description")
    private String description;

    @Column(name = "user_create")
    private String userCreate;

    @Column(name = "user_update")
    private String userUpdate;

    @Column(name = "time_create")
    private Timestamp timeCreate;

    @Column(name = "time_update")
    private Timestamp timeUpdate;

    public Long getCompanyContactId() {
        return companyContactId;
    }

    public void setCompanyContactId(Long companyContactId) {
        this.companyContactId = companyContactId;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId;
    }

    public String getSocialId() {
        return socialId;
    }

    public void setSocialId(String socialId) {
        this.socialId = socialId;
    }

    public String getCompanyAddressId() {
        return companyAddressId;
    }

    public void setCompanyAddressId(String companyAddressId) {
        this.companyAddressId = companyAddressId;
    }

    public String getTitleNameEn() {
        return titleNameEn;
    }

    public void setTitleNameEn(String titleNameEn) {
        this.titleNameEn = titleNameEn;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getTitleNameTh() {
        return titleNameTh;
    }

    public void setTitleNameTh(String titleNameTh) {
        this.titleNameTh = titleNameTh;
    }

    public String getContactNameTh() {
        return contactNameTh;
    }

    public void setContactNameTh(String contactNameTh) {
        this.contactNameTh = contactNameTh;
    }

    public String getNicknameTh() {
        return nicknameTh;
    }

    public void setNicknameTh(String nicknameTh) {
        this.nicknameTh = nicknameTh;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getCompanyEn() {
        return companyEn;
    }

    public void setCompanyEn(String companyEn) {
        this.companyEn = companyEn;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public String getAddressLocation() {
        return addressLocation;
    }

    public void setAddressLocation(String addressLocation) {
        this.addressLocation = addressLocation;
    }

    public String getIsActive() {
        return isActive;
    }

    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUserCreate() {
        return userCreate;
    }

    public void setUserCreate(String userCreate) {
        this.userCreate = userCreate;
    }

    public String getUserUpdate() {
        return userUpdate;
    }

    public void setUserUpdate(String userUpdate) {
        this.userUpdate = userUpdate;
    }

    public Timestamp getTimeCreate() {
        return timeCreate;
    }

    public void setTimeCreate(Timestamp timeCreate) {
        this.timeCreate = timeCreate;
    }

    public Timestamp getTimeUpdate() {
        return timeUpdate;
    }

    public void setTimeUpdate(Timestamp timeUpdate) {
        this.timeUpdate = timeUpdate;
    }
}