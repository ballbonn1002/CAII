package com.cubesofttech.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "sso_token")
@NamedQueries({
    @NamedQuery(name = "SsoToken.findAll", query = "SELECT t FROM SsoToken t")
})
public class SsoToken implements Serializable {

    @Id
    @Column(name = "token_id")
    private String tokenId;  // token_id

    @Column(name = "user_id")
    private String userId;   // user_id

    @Column(name = "issued_at")
    private Date issuedAt;  // issued_at

    @Column(name = "expires_at")
    private Date expiresAt; // expires_at

    @Column(name = "last_seen_at")
    private Date lastSeenAt;  // last_seen_at

    @Column(name = "status")
    private String status;  // status ('ACTIVE', 'REVOKED', 'EXPIRED')

    @Column(name = "user_agent")
    private String userAgent;  // user_agent

    @Column(name = "ip_addr")
    private String ipAddr;  // ip_addr

    // Default constructor
    public SsoToken() {
    }

    // Constructor with all fields
    public SsoToken(String tokenId, String userId, Date issuedAt, Date expiresAt) {
        this.tokenId = tokenId;
        this.userId = userId;
        this.issuedAt = issuedAt;
        this.expiresAt = expiresAt;
        this.status = "ACTIVE";
    }

    public boolean isValid() {
        return "ACTIVE".equals(this.status) && new Date().before(this.expiresAt);
    }

    // Getters and Setters
    public String getTokenId() {
        return tokenId;
    }

    public void setTokenId(String tokenId) {
        this.tokenId = tokenId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Date getIssuedAt() {
        return issuedAt;
    }

    public void setIssuedAt(Date issuedAt) {
        this.issuedAt = issuedAt;
    }

    public Date getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(Date expiresAt) {
        this.expiresAt = expiresAt;
    }

    public Date getLastSeenAt() {
        return lastSeenAt;
    }

    public void setLastSeenAt(Date lastSeenAt) {
        this.lastSeenAt = lastSeenAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    public String getIpAddr() {
        return ipAddr;
    }

    public void setIpAddr(String ipAddr) {
        this.ipAddr = ipAddr;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        SsoToken ssoToken = (SsoToken) obj;
        return tokenId.equals(ssoToken.tokenId);
    }

    @Override
    public int hashCode() {
        return tokenId.hashCode();
    }

    @Override
    public String toString() {
        return "SsoToken{" +
                "tokenId='" + tokenId + '\'' +
                ", userId='" + userId + '\'' +
                ", issuedAt=" + issuedAt +
                ", expiresAt=" + expiresAt +
                ", lastSeenAt=" + lastSeenAt +
                ", status='" + status + '\'' +
                ", userAgent='" + userAgent + '\'' +
                ", ipAddr='" + ipAddr + '\'' +
                '}';
    }
}
