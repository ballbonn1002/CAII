package com.cubesofttech.service;

import org.springframework.stereotype.Service;

@Service
public class BorrowService {

	public String manageStringItemId(int itemId) {
		String afterItemId = null;
		String beforeItemId = Integer.toString(itemId);
		if (beforeItemId.length() <= 1) {
			afterItemId = "000" + beforeItemId.trim();
		} else if (beforeItemId.length() <= 2) {
			afterItemId = "00" + beforeItemId.trim();
		} else if (beforeItemId.length() <= 3) {
			afterItemId = "0" + beforeItemId.trim();
		}
		return afterItemId;
	}
}