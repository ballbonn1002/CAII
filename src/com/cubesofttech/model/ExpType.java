package com.cubesofttech.model;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "exp_type")
@NamedQueries({
    @NamedQuery(name = "ExpType.findAll", query = "SELECT t FROM ExpType t")
})
public class ExpType implements Serializable {

    /** Creates a new instance of ExpType */
    public ExpType() {
    }

    public ExpType(
            String expTypeId,
            String name,
            String description,
            String userCreate,
            String userUpdate,
            Timestamp timeCreate,
            Timestamp timeUpdate
    ) {
        this.expTypeId = expTypeId;
        this.name = name;
        this.description = description;
        this.userCreate = userCreate;
        this.userUpdate = userUpdate;
        this.timeCreate = timeCreate;
        this.timeUpdate = timeUpdate;
    }

    @Id
    @Column(name = "exp_type_id")
    private String expTypeId;   // varchar(1)

    @Column(name = "name")
    private String name;        // varchar(32)

    @Column(name = "description")
    private String description; // varchar(255)

    @Column(name = "user_create")
    private String userCreate;  // varchar(32)

    @Column(name = "user_update")
    private String userUpdate;  // varchar(32)

    @Column(name = "time_create")
    private Timestamp timeCreate;

    @Column(name = "time_update")
    private Timestamp timeUpdate;

    // ===== Getter / Setter =====

    public String getExpTypeId() {
        return expTypeId;
    }

    public void setExpTypeId(String expTypeId) {
        this.expTypeId = expTypeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    // ===== toString / equals =====

    @Override
    public String toString() {
        return super.toString()
            + "expTypeId=[" + expTypeId + "]\n"
            + "name=[" + name + "]\n"
            + "description=[" + description + "]\n"
            + "userCreate=[" + userCreate + "]\n"
            + "userUpdate=[" + userUpdate + "]\n"
            + "timeCreate=[" + timeCreate + "]\n"
            + "timeUpdate=[" + timeUpdate + "]\n";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!(obj instanceof ExpType)) return false;

        ExpType that = (ExpType) obj;

        if (!(that.getExpTypeId() == null ? this.getExpTypeId() == null
                : that.getExpTypeId().equals(this.getExpTypeId()))) return false;

        if (!(that.getName() == null ? this.getName() == null
                : that.getName().equals(this.getName()))) return false;

        if (!(that.getDescription() == null ? this.getDescription() == null
                : that.getDescription().equals(this.getDescription()))) return false;

        if (!(that.getUserCreate() == null ? this.getUserCreate() == null
                : that.getUserCreate().equals(this.getUserCreate()))) return false;

        if (!(that.getUserUpdate() == null ? this.getUserUpdate() == null
                : that.getUserUpdate().equals(this.getUserUpdate()))) return false;

        if (!(that.getTimeCreate() == null ? this.getTimeCreate() == null
                : that.getTimeCreate().equals(this.getTimeCreate()))) return false;

        if (!(that.getTimeUpdate() == null ? this.getTimeUpdate() == null
                : that.getTimeUpdate().equals(this.getTimeUpdate()))) return false;

        return true;
    }
}
