package com.cubesofttech.dao;

import com.cubesofttech.model.SsoToken;
import java.util.List;

public interface SsoTokenDAO {

    // Save SsoToken
    void save(SsoToken ssoToken);

    // Find SsoToken by TokenId
    SsoToken findByTokenId(String tokenId);

    // Update an existing SsoToken
    void update(SsoToken ssoToken);

    // Delete SsoToken by TokenId
    void delete(String tokenId);

    // Find all SsoTokens
    List<SsoToken> findAll();
}
