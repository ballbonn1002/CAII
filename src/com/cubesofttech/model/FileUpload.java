
package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "file")
@NamedQueries({
    @NamedQuery(name = "FileUpload.findAll", query = "SELECT t FROM FileUpload t")})
public class FileUpload implements Serializable {
    
    /** Creates a new instance of FileUpload */
    public FileUpload() {
    }
    public FileUpload(
            Integer fileId	
            , String page
            , String pageId
            , String userId	
            , String name	
            , String type	
            , String size	
            , String path	
            , String altName
            , String userCreate	
            , String userUpdate	
            , java.sql.Timestamp timeCreate	
            , java.sql.Timestamp timeUpdate	
        ) {
        this.fileId = fileId;	
        this.page = page;
        this.pageId = pageId;
        this.userId = userId;	
        this.name = name;	
        this.type = type;	
        this.size = size;	
        this.path = path;
        this.altName = altName;
        this.userCreate = userCreate;	
        this.userUpdate = userUpdate;	
        this.timeCreate = timeCreate;	
        this.timeUpdate = timeUpdate;	
    }
    
    @Id
    @Column(name = "file_id")
    private Integer fileId;	
    @Column(name = "page")
    private String page;	
    @Column(name = "page_id")
    private String pageId;	
    @Column(name = "user_id")
    private String userId;	
    @Column(name = "name")
    private String name;	
    @Column(name = "type")
    private String type;	
    @Column(name = "size")
    private String size;	
    @Column(name = "path")
    private String path;	
    @Column(name = "alt_name")
    private String altName;
    @Column(name = "user_create")
    private String userCreate;	
    @Column(name = "user_update")
    private String userUpdate;	
    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;	
    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;	



    public Integer getFileId() {
        return this.fileId;
    }		
    public void setFileId(Integer fileId) {
        this.fileId = fileId;
    }
    public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getPageId() {
		return pageId;
	}
	public void setPageId(String pageId) {
		this.pageId = pageId;
	}
	public String getUserId() {
        return this.userId;
    }		
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getName() {
        return this.name;
    }		
    public void setName(String name) {
        this.name = name;
    }
    public String getType() {
        return this.type;
    }		
    public void setType(String type) {
        this.type = type;
    }
    public String getSize() {
        return this.size;
    }		
    public void setSize(String size) {
        this.size = size;
    }
    public String getPath() {
        return this.path;
    }		
    public void setPath(String path) {
        this.path = path;
    }
    public String getAltName() {
		return altName;
	}
	public void setAltName(String altName) {
		this.altName = altName;
	}
	public String getUserCreate() {
        return this.userCreate;
    }		
    public void setUserCreate(String userCreate) {
        this.userCreate = userCreate;
    }
    public String getUserUpdate() {
        return this.userUpdate;
    }		
    public void setUserUpdate(String userUpdate) {
        this.userUpdate = userUpdate;
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


    
    public String toString() {
        return super.toString() + "fileId=[" + fileId + "]\n" + "page=[" + page + "]\n" + "pageId=[" + pageId + "]\n" + "userId=[" + userId + "]\n" + "typeId=["  + "name=[" + name + "]\n" + "type=[" + type + "]\n" + "size=[" + size + "]\n" + "path=[" + path + "]\n" + "altName=[" + altName + "]\n" + "userCreate=[" + userCreate + "]\n" + "userUpdate=[" + userUpdate + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof FileUpload)) {
                return false;
        }
        FileUpload that = (FileUpload) obj;
        if (!(that.getFileId() == null ? this.getFileId() == null
                        : that.getFileId().equals(this.getFileId()))) {
                return false;
        }
        if (!(that.getPage() == null ? this.getPage() == null
                : that.getPage().equals(this.getPage()))) {
        return false;
        }
        if (!(that.getPageId() == null ? this.getPageId() == null
                : that.getPageId().equals(this.getPageId()))) {
        return false;
        }
        if (!(that.getUserId() == null ? this.getUserId() == null
                        : that.getUserId().equals(this.getUserId()))) {
                return false;
        }
        if (!(that.getName() == null ? this.getName() == null
                        : that.getName().equals(this.getName()))) {
                return false;
        }
        if (!(that.getType() == null ? this.getType() == null
                        : that.getType().equals(this.getType()))) {
                return false;
        }
        if (!(that.getSize() == null ? this.getSize() == null
                        : that.getSize().equals(this.getSize()))) {
                return false;
        }
        if (!(that.getPath() == null ? this.getPath() == null
                        : that.getPath().equals(this.getPath()))) {
                return false;
        }
        if(!(that.getAltName() == null ? this.getAltName() == null
        				: that.getAltName().equals(this.getAltName()))) {
        		return false;
        }
        if (!(that.getUserCreate() == null ? this.getUserCreate() == null
                        : that.getUserCreate().equals(this.getUserCreate()))) {
                return false;
        }
        if (!(that.getUserUpdate() == null ? this.getUserUpdate() == null
                        : that.getUserUpdate().equals(this.getUserUpdate()))) {
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
    return true;
    }

}
