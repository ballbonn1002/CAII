package com.cubesofttech.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "expense")
@NamedQueries({
    @NamedQuery(name = "Expense.findAll", query = "SELECT t FROM Expense t")
})
public class Expense implements Serializable {

    /** Creates a new instance of Expense */
    public Expense() {
    }

    public Expense(
            Long expenseId,
            Long expenseGroupId,
            String expTypeId,
            Timestamp dtStart,
            Timestamp dtEnd,
            Long dtBy,
            String userId,
            String fromLocation,
            BigDecimal fromLat,
            BigDecimal fromLon,
            String toLocation,
            BigDecimal toLat,
            BigDecimal toLon,
            BigDecimal amount,
            String description,
            String userCreate,
            String userUpdate,
            Timestamp timeCreate,
            Timestamp timeUpdate
    ) {
        this.expenseId = expenseId;
        this.expenseGroupId = expenseGroupId;
        this.expTypeId = expTypeId;
        this.dtStart = dtStart;
        this.dtEnd = dtEnd;
        this.dtBy = dtBy;
        this.userId = userId;
        this.fromLocation = fromLocation;
        this.fromLat = fromLat;
        this.fromLon = fromLon;
        this.toLocation = toLocation;
        this.toLat = toLat;
        this.toLon = toLon;
        this.amount = amount;
        this.description = description;
        this.userCreate = userCreate;
        this.userUpdate = userUpdate;
        this.timeCreate = timeCreate;
        this.timeUpdate = timeUpdate;
    }

    @Id
    @Column(name = "expense_id")
    private Long expenseId;

    @Column(name = "expense_group_id")
    private Long expenseGroupId;

    @Column(name = "exp_type_id")
    private String expTypeId;

    @Column(name = "dt_start")
    private Timestamp dtStart;

    @Column(name = "dt_end")
    private Timestamp dtEnd;

    @Column(name = "dt_by")
    private Long dtBy;

    @Column(name = "user_id")
    private String userId;

    @Column(name = "from_location")
    private String fromLocation;

    @Column(name = "from_lat")
    private BigDecimal fromLat;

    @Column(name = "from_lon")
    private BigDecimal fromLon;

    @Column(name = "to_location")
    private String toLocation;

    @Column(name = "to_lat")
    private BigDecimal toLat;

    @Column(name = "to_lon")
    private BigDecimal toLon;

    @Column(name = "amount")
    private BigDecimal amount;

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

    // ===== Getter / Setter =====

    public Long getExpenseId() {
        return expenseId;
    }

    public void setExpenseId(Long expenseId) {
        this.expenseId = expenseId;
    }

    public Long getExpenseGroupId() {
        return expenseGroupId;
    }

    public void setExpenseGroupId(Long expenseGroupId) {
        this.expenseGroupId = expenseGroupId;
    }

    public String getExpTypeId() {
        return expTypeId;
    }

    public void setExpTypeId(String expTypeId) {
        this.expTypeId = expTypeId;
    }

    public Timestamp getDtStart() {
        return dtStart;
    }

    public void setDtStart(Timestamp dtStart) {
        this.dtStart = dtStart;
    }

    public Timestamp getDtEnd() {
        return dtEnd;
    }

    public void setDtEnd(Timestamp dtEnd) {
        this.dtEnd = dtEnd;
    }

    public Long getDtBy() {
        return dtBy;
    }

    public void setDtBy(Long dtBy) {
        this.dtBy = dtBy;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFromLocation() {
        return fromLocation;
    }

    public void setFromLocation(String fromLocation) {
        this.fromLocation = fromLocation;
    }

    public BigDecimal getFromLat() {
        return fromLat;
    }

    public void setFromLat(BigDecimal fromLat) {
        this.fromLat = fromLat;
    }

    public BigDecimal getFromLon() {
        return fromLon;
    }

    public void setFromLon(BigDecimal fromLon) {
        this.fromLon = fromLon;
    }

    public String getToLocation() {
        return toLocation;
    }

    public void setToLocation(String toLocation) {
        this.toLocation = toLocation;
    }

    public BigDecimal getToLat() {
        return toLat;
    }

    public void setToLat(BigDecimal toLat) {
        this.toLat = toLat;
    }

    public BigDecimal getToLon() {
        return toLon;
    }

    public void setToLon(BigDecimal toLon) {
        this.toLon = toLon;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
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

    // ===== toString / equals (โครงเดียวกับ Equipment) =====

    @Override
    public String toString() {
        return super.toString()
            + "expenseId=[" + expenseId + "]\n"
            + "expenseGroupId=[" + expenseGroupId + "]\n"
            + "expTypeId=[" + expTypeId + "]\n"
            + "dtStart=[" + dtStart + "]\n"
            + "dtEnd=[" + dtEnd + "]\n"
            + "dtBy=[" + dtBy + "]\n"
            + "userId=[" + userId + "]\n"
            + "fromLocation=[" + fromLocation + "]\n"
            + "fromLat=[" + fromLat + "]\n"
            + "fromLon=[" + fromLon + "]\n"
            + "toLocation=[" + toLocation + "]\n"
            + "toLat=[" + toLat + "]\n"
            + "toLon=[" + toLon + "]\n"
            + "amount=[" + amount + "]\n"
            + "description=[" + description + "]\n"
            + "userCreate=[" + userCreate + "]\n"
            + "userUpdate=[" + userUpdate + "]\n"
            + "timeCreate=[" + timeCreate + "]\n"
            + "timeUpdate=[" + timeUpdate + "]\n";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!(obj instanceof Expense)) return false;

        Expense that = (Expense) obj;

        if (!(that.getExpenseId() == null ? this.getExpenseId() == null
                : that.getExpenseId().equals(this.getExpenseId()))) return false;

        if (!(that.getExpenseGroupId() == null ? this.getExpenseGroupId() == null
                : that.getExpenseGroupId().equals(this.getExpenseGroupId()))) return false;

        if (!(that.getExpTypeId() == null ? this.getExpTypeId() == null
                : that.getExpTypeId().equals(this.getExpTypeId()))) return false;

        if (!(that.getDtStart() == null ? this.getDtStart() == null
                : that.getDtStart().equals(this.getDtStart()))) return false;

        if (!(that.getDtEnd() == null ? this.getDtEnd() == null
                : that.getDtEnd().equals(this.getDtEnd()))) return false;

        if (!(that.getDtBy() == null ? this.getDtBy() == null
                : that.getDtBy().equals(this.getDtBy()))) return false;

        if (!(that.getUserId() == null ? this.getUserId() == null
                : that.getUserId().equals(this.getUserId()))) return false;

        if (!(that.getFromLocation() == null ? this.getFromLocation() == null
                : that.getFromLocation().equals(this.getFromLocation()))) return false;

        if (!(that.getFromLat() == null ? this.getFromLat() == null
                : that.getFromLat().equals(this.getFromLat()))) return false;

        if (!(that.getFromLon() == null ? this.getFromLon() == null
                : that.getFromLon().equals(this.getFromLon()))) return false;

        if (!(that.getToLocation() == null ? this.getToLocation() == null
                : that.getToLocation().equals(this.getToLocation()))) return false;

        if (!(that.getToLat() == null ? this.getToLat() == null
                : that.getToLat().equals(this.getToLat()))) return false;

        if (!(that.getToLon() == null ? this.getToLon() == null
                : that.getToLon().equals(this.getToLon()))) return false;

        if (!(that.getAmount() == null ? this.getAmount() == null
                : that.getAmount().equals(this.getAmount()))) return false;

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