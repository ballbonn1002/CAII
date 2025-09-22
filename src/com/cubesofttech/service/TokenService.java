package com.cubesofttech.service;

import java.time.Duration;
import java.time.Instant;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cubesofttech.dao.SsoTokenDAO;
import com.cubesofttech.model.SsoToken;

@Service
public class TokenService {

    @Autowired
    private SsoTokenDAO ssoTokenDAO;

    public TokenService(SsoTokenDAO ssoTokenDAO) {
        this.ssoTokenDAO = ssoTokenDAO;
    }

    // creating new token and save to database
    public String createToken(String userId) {
        String tokenId = UUID.randomUUID().toString(); // Generate a new token ID

        Instant issuedAtInstant = Instant.now(); // Token time
        Instant expiresAtInstant = issuedAtInstant.plus(Duration.ofHours(15)); // Set expiration time

        Date issuedAt = Date.from(issuedAtInstant);
        Date expiresAt = Date.from(expiresAtInstant);

        SsoToken ssoToken = new SsoToken(tokenId, userId, issuedAt, expiresAt);

        ssoTokenDAO.save(ssoToken);

        return tokenId;
    }

    // retrieving a token and checking
    public SsoToken getToken(String tokenId) {
        SsoToken token = ssoTokenDAO.findByTokenId(tokenId);

        if (token != null) {
            // Check token not expired?
            if (token.isValid()) {
                return token;
            }
        }
        return null; // Token not found or expired
    }

    // Check token not expired
    public boolean isValid(SsoToken token) {
        if (token == null) {
            return false;
        }

        Date now = new Date();

        // Check if token is expired or revoked
        if (now.after(token.getExpiresAt()) || "REVOKED".equals(token.getStatus())) {
            return false;
        }

        return true;
    }

    // set status token
    public void invalidateToken(String tokenId) {
        SsoToken token = ssoTokenDAO.findByTokenId(tokenId);

        if (token != null) {
            token.setStatus("REVOKED"); // Set status to REVOKED
            ssoTokenDAO.update(token);  // Update token in database
        }
    }
}
