package com.webproject.essuyo.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.webproject.essuyo.domain.ImageInfoVO;

public interface ImageAdminService {

	public List<String> getImagePathList(String findType, int id);
	public String getImagePath(int imageInfoid);
	
	public List<ImageInfoVO> getImageInfoList(String findType, int id);
	public ImageInfoVO getImageInfo(int imageInfoid);
	
	public int addImageInfo(ImageInfoVO imageInfo) throws Exception;
	public int deleteImageInfo(int id) throws Exception;
	
	public int uploadFile(MultipartFile file);
	public boolean deleteFile(String filePath, int imageInfoId) throws Exception;
	
	
	public void addImageAdminProduct(int productId, int imageInfoId) throws Exception;
	
}
