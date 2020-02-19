package com.webproject.essuyo.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.webproject.essuyo.dao.ImageAdminDao;
import com.webproject.essuyo.domain.ImageInfoVO;
import com.webproject.essuyo.domain.SQLParamVO;
import com.webproject.essuyo.service.ImageAdminService;

@Service
public class ImageAdminServieImpl implements ImageAdminService {

	@Autowired
	private ImageAdminDao imageAdminDao;
	

	private Logger logger = LoggerFactory.getLogger(ImageAdminServieImpl.class);
	private String UPLOAD_PATH  = "C:\\Users\\kyu\\git\\essuyo\\essuyo\\src\\main\\webapp\\resources\\images\\upload";
	//private String UPLOAD_PATH = "/usr/local/apache-tomcat-8.0.52/webapps/essuyo/resources/images/upload";

	@Override
	public ImageInfoVO getImageInfo(int imageInfoid) {
		if (imageInfoid == 0) {
			return null;
		}

		try {
			return imageAdminDao.selectImageById(imageInfoid);
		} catch (Exception e) {
			logger.error("이미지 조회 실패.. | {} ", e.toString());
			return null;
		}

	}

	@Override
	public String getImagePath(int imageInfoid) {
		ImageInfoVO image = this.getImageInfo(imageInfoid);

		if (image != null) {
			return image.getSavePath();
		}

		return null;
	}

	@Override
	public List<String> getImagePathList(String findType, int id) {

		List<String> resultList = new ArrayList<>();

		List<ImageInfoVO> imageList = this.getImageInfoList(findType, id);

		if (imageList != null) {
			for (ImageInfoVO image : imageList) {
				resultList.add(image.getSavePath());
			}
			return resultList;
		}
		return null;
	}

	@Override
	public List<ImageInfoVO> getImageInfoList(String findType, int id) {

		if (findType == null || findType.equals("") || id == 0) {
			return null;
		}

		SQLParamVO params = new SQLParamVO(findType, id);

		try {

			return imageAdminDao.selectImageById(params);
		} catch (Exception e) {
			logger.error("이미지 조회 실패.. | {} ", e.toString());
			return null;
		}
	}

	@Override
	public int addImageInfo(ImageInfoVO imageInfo) throws Exception {
		imageAdminDao.insert(imageInfo);
		return imageInfo.getId();
	}
	
	@Override
	public void addImageAdminProduct(int productId, int imageInfoId) throws Exception {
		
		Map<String,Object> param = new HashMap<>();
		param.put("productId", productId);
		param.put("imageInfoId", imageInfoId);
		
		imageAdminDao.insertAdminProduct(param);

	}


	@Override
	public int deleteImageInfo(int id) {

		try {
			return imageAdminDao.delete(id);
		} catch (Exception e) {
			logger.error("이미지 등록 실패.. | {} ", e.toString());
			return 0;
		}

	}

	@Override
	@Transactional
	public int uploadFile(MultipartFile file) {
		// 파일의 원본이름 저장

		logger.info("파일이름 :" + file.getOriginalFilename());
		logger.info("파일크기 : " + file.getSize());
		logger.info("컨텐트 타입 : " + file.getContentType());

		// 랜덤생성+파일이름 저장
		// 파일명 랜덤생성 메서드호출
		String extendName = file.getContentType().split("/")[1];
		UUID uuid = UUID.randomUUID();
		String savePath = uuid.toString() + "." + extendName;

		File targetFile = new File(UPLOAD_PATH, savePath);

		try {
			FileCopyUtils.copy(file.getBytes(), targetFile);

			ImageInfoVO imageInfo = new ImageInfoVO();
			imageInfo.setSavePath("/resources/images/upload/" + savePath);
			imageInfo.setName(savePath);
			imageInfo.setType(file.getContentType());

			return this.addImageInfo(imageInfo);

		} catch (IOException e) {
			logger.error("이미지 업로드 에러..", e.toString());
			return 0;
		} catch (Exception e) {
			logger.error("이미지 업로드 에러..", e.toString());
			return 0;
		}

	}

	@Override
	@Transactional
	public  boolean deleteFile(String filePath, int imageInfoId) throws Exception {

		File file = new File(UPLOAD_PATH + "//" + filePath);
		
		this.deleteImageInfo(imageInfoId);

		if (file.exists()) { // 파일존재여부확인
			if (file.delete()) {
				logger.info("파일 삭제 성공 | {} ", filePath);
				return true;
			} else {
				logger.info("파일 삭제 실패 | {} ", filePath);
				return false;
			}

		} else {
			logger.info("파일이 존재하지 않습니다. | {} ", filePath);
			return false;
		}

	}

}
