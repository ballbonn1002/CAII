package com.cubesofttech.util;

import java.security.SecureRandom;
import java.util.Base64;

public final class Token {
	
	private Token() { };
	
	private static final SecureRandom RANDOM = new SecureRandom();
	
    public static String getToken() {
        byte[] bytes = new byte[32];
        RANDOM.nextBytes(bytes);
        String token = Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
        return token;
    }

}
