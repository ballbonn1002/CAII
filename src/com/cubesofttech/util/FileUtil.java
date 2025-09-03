package com.cubesofttech.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class FileUtil {
	
	private FileUtil(){
	}
	public static void upload(File file, String filePath, String fileName) throws Exception {

		FileInputStream inps = null;
		FileOutputStream outs = null;
		try {
			File path = new File(filePath);
			if (!path.exists()) {
				path.mkdirs();
			}

			inps = new FileInputStream(file);
			outs = new FileOutputStream(filePath + fileName);

			int read = 0;
			byte[] bytes = new byte[1024];
			while ((read = inps.read(bytes)) != -1) {
				outs.write(bytes, 0, read);
			}
		} catch (IOException e) {
			throw e;
		} finally {
			if (inps != null && outs != null) {
				inps.close();
				outs.close();
			}
		}
	}
	
	public static String getFileSize(double size) {
		String result = null;
		String[] ending = {"B","KB","MB","GB"};
		int i = 0;
		
		for(i=0;size>1024;i++) {
			size=size/1024;
		}
		
		result = String.format("%.2f ", size) + ending[i];
		
		return result;
	}
}
