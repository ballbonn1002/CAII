
package com.cubesofttech.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "news")
@NamedQueries({
    @NamedQuery(name = "News.findAll", query = "SELECT t FROM News t")})
public class News implements Serializable {
    
    /** Creates a new instance of News */
    public News() {
    }
    public News(
            Integer newsId	
            , Integer fileId	
            , String newsHead	
            , String newsDescription	
            , String userCreate	
            , String userUpdate	
            , java.sql.Timestamp timeCreate	
            , java.sql.Timestamp timeUpdate	
        ) {
        this.newsId = newsId;	
        this.fileId = fileId;	
        this.newsHead = newsHead;	
        this.newsDescription = newsDescription;	
        this.userCreate = userCreate;	
        this.userUpdate = userUpdate;	
        this.timeCreate = timeCreate;	
        this.timeUpdate = timeUpdate;	
    }
    
    @Id
    @Column(name = "news_id")
    private Integer newsId;	
    @Column(name = "file_id")
    private Integer fileId;	
    @Column(name = "news_head")
    private String newsHead;	
    @Column(name = "news_description")
    private String newsDescription;	
    @Column(name = "user_create")
    private String userCreate;	
    @Column(name = "user_update")
    private String userUpdate;	
    @Column(name = "time_create")
    private java.sql.Timestamp timeCreate;	
    @Column(name = "time_update")
    private java.sql.Timestamp timeUpdate;	



    public Integer getNewsId() {
        return this.newsId;
    }		
    public void setNewsId(Integer newsId) {
        this.newsId = newsId;
    }
    public Integer getFileId() {
        return this.fileId;
    }		
    public void setFileId(Integer fileId) {
        this.fileId = fileId;
    }
    public String getNewsHead() {
        return this.newsHead;
    }		
    public void setNewsHead(String newsHead) {
        this.newsHead = newsHead;
    }
    public String getNewsDescription() {
        return this.newsDescription;
    }		
    public void setNewsDescription(String newsDescription) {
        this.newsDescription = newsDescription;
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
        return super.toString() + "newsId=[" + newsId + "]\n" + "fileId=[" + fileId + "]\n" + "newsHead=[" + newsHead + "]\n" + "newsDescription=[" + newsDescription + "]\n" + "userCreate=[" + userCreate + "]\n" + "userUpdate=[" + userUpdate + "]\n" + "timeCreate=[" + timeCreate + "]\n" + "timeUpdate=[" + timeUpdate + "]\n";
    }

    public boolean equals(Object obj) {
        if (this == obj) {
                return true;
        }
        if (!(obj instanceof News)) {
                return false;
        }
        News that = (News) obj;
        if (!(that.getNewsId() == null ? this.getNewsId() == null
                        : that.getNewsId().equals(this.getNewsId()))) {
                return false;
        }
        if (!(that.getFileId() == null ? this.getFileId() == null
                        : that.getFileId().equals(this.getFileId()))) {
                return false;
        }
        if (!(that.getNewsHead() == null ? this.getNewsHead() == null
                        : that.getNewsHead().equals(this.getNewsHead()))) {
                return false;
        }
        if (!(that.getNewsDescription() == null ? this.getNewsDescription() == null
                        : that.getNewsDescription().equals(this.getNewsDescription()))) {
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
