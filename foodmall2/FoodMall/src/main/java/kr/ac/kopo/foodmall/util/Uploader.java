package kr.ac.kopo.foodmall.util;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;

public class Uploader {
	final private static String uploadPath = "d://foodmall/product_images/";
	
	public static boolean upload(MultipartFile file) {
		if(file != null && !file.isEmpty()) {
			String filename = file.getOriginalFilename();
			
			try {
				file.transferTo(new File(uploadPath + filename) );
				
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
		
		return false;
	}

}
