package com.cubesofttech.model;
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "equipment")
@NamedQueries({
    @NamedQuery(name = "Equipment.findAll", query = "SELECT t FROM Equipment t")})
public class Equipment implements Serializable {
    
    /** Creates a new instance of Equipment */
    public Equipment() {
    }
    public Equipment(
            Integer equipmentId	
            , String name	
            , Integer amount	
            , String detail	
            , String itemNo	
            , String image	
            , String status	
            , String location	
            , String note	
            , String ram	
            , String process	
            , String battery	
            , String hdd	
            , String windows	
            , String serialNo	
            , java.sql.Timestamp timeCreate	
            , String userCreate	
            , java.sql.Timestamp timeUpdate	
            , String userUpdate	
            , String type	
            , String wifiaddress
            , String lanaddress
            , String display
            , String statusLog
        ) {
        this.equipmentId = equipmentId;	
        this.name = name;	
        this.amount = amount;	
        this.detail = detail;	
        this.itemNo = itemNo;	
        this.image = image;	
        this.status = status;	
        this.location = location;	
        this.note = note;	
        this.ram = ram;	
        this.process = process;	
        this.battery = battery;	
        this.hdd = hdd;	
        this.windows = windows;	
        this.serialNo = serialNo;	
        this.timeCreate = timeCreate;	
        this.userCreate = userCreate;	
        this.timeUpdate = timeUpdate;	
        this.userUpdate = userUpdate;	
        this.type = type;	
        this.wifiaddress = wifiaddress;	
        this.lanaddress = lanaddress;
        this.display = display;
        this.statusLog = statusLog;
    }
    
    @Id
    @Column(name = "equipment_id")
    private Integer equipmentId;	
    @Column(name = "name")
    private String name;	
    @Column(name = "amount")
    private Integer amount;	
    @Column(name = "detail")
    private String detail;	
    @Column(name = "item_no")
    private String itemNo;	
    @Column(name = "image")
    private String image;	
    @Column(name = "status")
    private String status;	
    @Column(name = "location")
    private String location;	
    @Column(name = "note")
    private String note;	
    @Column(name = "ram")
    private String ram;	
    @Column(name = "process")
    private String process;	
    @Column(name = "battery")
    private String battery;	
    @Column(name = "hdd")
    private String hdd;	
    @Column(name = "windows")
    private String windows;	
    @Column(name = "serial_no")
    private String serialNo;	
    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;	
    @Column(name = "user_create")
    private String userCreate;	
    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;	
    @Column(name = "user_update")
    private String userUpdate;	
    @Column(name = "type")
    private String type;	
    @Column(name = "wifiaddress")
    private String wifiaddress;	
    @Column(name = "lanaddress")
    private String lanaddress;	
    @Column(name = "display")
    private String display;
    @Column(name = "status_log")
    private String statusLog;
    /**
     * catalog item ที่เครื่องนี้สังกัด - FK ไป product.product_id (N equipment : 1 product)
     * เป็น String เพราะคอลัมน์ใน DB เป็น varchar(32) ตามแบบเดียวกับ
     * unit_of_measure.product_id / stock.product_id ที่มีอยู่เดิม
     */
    @Column(name = "product_id")
    private String productId;
    /**
     * warehouse ระดับบนสุด (warehouse.parent = 0) ที่เครื่องนี้อยู่ - ระบุได้เฉพาะตอน status = Available
     * FK ไป warehouse.warehouse_id (BIGINT) / null = ยังไม่ระบุ
     */
    @Column(name = "warehouse_id")
    private Long warehouseId;

	public Long getWarehouseId() {
		return warehouseId;
	}
	public void setWarehouseId(Long warehouseId) {
		this.warehouseId = warehouseId;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getStatusLog() {
		return statusLog;
	}
	public void setStatusLog(String statusLog) {
		this.statusLog = statusLog;
	}
	public String getDisplay() {
		return display;
	}
	public void setDisplay(String display) {
		this.display = display;
	}
	public String getWifiaddress() {
		return wifiaddress;
	}
	public void setWifiaddress(String wifiaddress) {
		this.wifiaddress = wifiaddress;
	}
	public String getLanaddress() {
		return lanaddress;
	}
	public void setLanaddress(String lanaddress) {
		this.lanaddress = lanaddress;
	}
	public Integer getEquipmentId() {
        return this.equipmentId;
    }		
    public void setEquipmentId(Integer equipmentId) {
        this.equipmentId = equipmentId;
    }
    public String getName() {
        return this.name;
    }		
    public void setName(String name) {
        this.name = name;
    }
    public Integer getAmount() {
        return this.amount;
    }		
    public void setAmount(Integer amount) {
        this.amount = amount;
    }
    public String getDetail() {
        return this.detail;
    }		
    public void setDetail(String detail) {
        this.detail = detail;
    }
    public String getItemNo() {
        return this.itemNo;
    }		
    public void setItemNo(String itemNo) {
        this.itemNo = itemNo;
    }
    public String getImage() {
        return this.image;
    }		
    public void setImage(String image) {
        this.image = image;
    }
    public String getStatus() {
        return this.status;
    }		
    public void setStatus(String status) {
        this.status = status;
    }
    public String getLocation() {
        return this.location;
    }		
    public void setLocation(String location) {
        this.location = location;
    }
    public String getNote() {
        return this.note;
    }		
    public void setNote(String note) {
        this.note = note;
    }
    public String getRam() {
        return this.ram;
    }		
    public void setRam(String ram) {
        this.ram = ram;
    }
    public String getProcess() {
        return this.process;
    }		
    public void setProcess(String process) {
        this.process = process;
    }
    public String getBattery() {
        return this.battery;
    }		
    public void setBattery(String battery) {
        this.battery = battery;
    }
    public String getHdd() {
        return this.hdd;
    }		
    public void setHdd(String hdd) {
        this.hdd = hdd;
    }
    public String getWindows() {
        return this.windows;
    }		
    public void setWindows(String windows) {
        this.windows = windows;
    }
    public String getSerialNo() {
        return this.serialNo;
    }		
    public void setSerialNo(String serialNo) {
        this.serialNo = serialNo;
    }
    public java.sql.Timestamp getTimeCreate() {
        return this.timeCreate;
    }		
    public void setTimeCreate(java.sql.Timestamp timeCreate) {
        this.timeCreate = timeCreate;
    }
    public String getUserCreate() {
        return this.userCreate;
    }		
    public void setUserCreate(String userCreate) {
        this.userCreate = userCreate;
    }
    public java.sql.Timestamp getTimeUpdate() {
        return this.timeUpdate;
    }		
    public void setTimeUpdate(java.sql.Timestamp timeUpdate) {
        this.timeUpdate = timeUpdate;
    }
    public String getUserUpdate() {
        return this.userUpdate;
    }		
    public void setUserUpdate(String userUpdate) {
        this.userUpdate = userUpdate;
    }
    public String getType() {
        return this.type;
    }		
    public void setType(String type) {
        this.type = type;
    }


    
    public String toString() {
        return super.toString() + "equipmentId=[" + equipmentId + "]\n" + "name=[" + name + "]\n" + "amount=[" + amount + "]\n" + "detail=[" + detail + "]\n" + "itemNo=[" + itemNo + "]\n" + "image=[" + image + "]\n" + "status=[" + status + "]\n" + "location=[" + location + "]\n" + "note=[" + note + "]\n" + "ram=[" + ram + "]\n" + "process=[" + process + "]\n" + "battery=[" + battery + "]\n" + "hdd=[" + hdd + "]\n" + "windows=[" + windows + "]\n" + "serialNo=[" + serialNo + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "userCreate=[" + userCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n" + "userUpdate=[" + userUpdate + "]\n" + "type=[" + type + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof Equipment)) {
                return false;
        }
        Equipment that = (Equipment) obj;
        if (!(that.getEquipmentId() == null ? this.getEquipmentId() == null
                        : that.getEquipmentId().equals(this.getEquipmentId()))) {
                return false;
        }
        if (!(that.getName() == null ? this.getName() == null
                        : that.getName().equals(this.getName()))) {
                return false;
        }
        if (!(that.getAmount() == null ? this.getAmount() == null
                        : that.getAmount().equals(this.getAmount()))) {
                return false;
        }
        if (!(that.getDetail() == null ? this.getDetail() == null
                        : that.getDetail().equals(this.getDetail()))) {
                return false;
        }
        if (!(that.getItemNo() == null ? this.getItemNo() == null
                        : that.getItemNo().equals(this.getItemNo()))) {
                return false;
        }
        if (!(that.getImage() == null ? this.getImage() == null
                        : that.getImage().equals(this.getImage()))) {
                return false;
        }
        if (!(that.getStatus() == null ? this.getStatus() == null
                        : that.getStatus().equals(this.getStatus()))) {
                return false;
        }
        if (!(that.getLocation() == null ? this.getLocation() == null
                        : that.getLocation().equals(this.getLocation()))) {
                return false;
        }
        if (!(that.getNote() == null ? this.getNote() == null
                        : that.getNote().equals(this.getNote()))) {
                return false;
        }
        if (!(that.getRam() == null ? this.getRam() == null
                        : that.getRam().equals(this.getRam()))) {
                return false;
        }
        if (!(that.getProcess() == null ? this.getProcess() == null
                        : that.getProcess().equals(this.getProcess()))) {
                return false;
        }
        if (!(that.getBattery() == null ? this.getBattery() == null
                        : that.getBattery().equals(this.getBattery()))) {
                return false;
        }
        if (!(that.getHdd() == null ? this.getHdd() == null
                        : that.getHdd().equals(this.getHdd()))) {
                return false;
        }
        if (!(that.getWindows() == null ? this.getWindows() == null
                        : that.getWindows().equals(this.getWindows()))) {
                return false;
        }
        if (!(that.getSerialNo() == null ? this.getSerialNo() == null
                        : that.getSerialNo().equals(this.getSerialNo()))) {
                return false;
        }
        if (!(that.getTimeCreate() == null ? this.getTimeCreate() == null
                        : that.getTimeCreate().equals(this.getTimeCreate()))) {
                return false;
        }
        if (!(that.getUserCreate() == null ? this.getUserCreate() == null
                        : that.getUserCreate().equals(this.getUserCreate()))) {
                return false;
        }
        if (!(that.getTimeUpdate() == null ? this.getTimeUpdate() == null
                        : that.getTimeUpdate().equals(this.getTimeUpdate()))) {
                return false;
        }
        if (!(that.getUserUpdate() == null ? this.getUserUpdate() == null
                        : that.getUserUpdate().equals(this.getUserUpdate()))) {
                return false;
        }
        if (!(that.getType() == null ? this.getType() == null
                        : that.getType().equals(this.getType()))) {
                return false;
        }
    return true;
    }

}
