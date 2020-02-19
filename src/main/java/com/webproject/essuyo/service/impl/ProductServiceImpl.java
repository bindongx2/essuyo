package com.webproject.essuyo.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.joda.time.Days;
import org.joda.time.LocalDate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.webproject.essuyo.dao.ProductDao;
import com.webproject.essuyo.domain.ProductManagerVO;
import com.webproject.essuyo.domain.ProductVO;
import com.webproject.essuyo.service.ImageAdminService;
import com.webproject.essuyo.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao productDao;

	@Autowired
	private ImageAdminService imageAdminService;

	private Logger logger = LoggerFactory.getLogger(ProductServiceImpl.class);

	private Map<String, Object> makeProductViewData(ProductVO product) {
		
		if( product != null ) {
			Map<String, Object> resultMap = new HashMap<>();
			
			resultMap.put("name", product.getName());
			resultMap.put("id", product.getId());
			resultMap.put("saleStartDate", product.getSaleStartDate());
			resultMap.put("saleEndDate", product.getSaleEndDate());
			LocalDate endDate = new LocalDate(product.getSaleEndDate());
			resultMap.put("state", LocalDate.now().isAfter(endDate) == false ? "예약가능" : "판매종료");
			resultMap.put("discription", product.getDiscription());
			resultMap.put("price", product.getPrice());
			resultMap.put("url", this.getImagePath(product.getId()));
			
			return resultMap;
		}
		
		return null;
	}
	
	@Override
	public Map<String, Object> getProduct(int productId) {
		try {
			// < 상품 정보
			 ProductVO product = productDao.selectByProductId(productId);

			if (product != null) {
				return makeProductViewData(product);
			}

		} catch (Exception e) {
			logger.error("상품 조회 실패.. | {} ", e.toString());
			return null;
		}
		return null;
	}

	@Override
	public List<Map<String,Object>> getProductList(int companyId) {
		
		// < 상품 정보
		try {
				List<Map<String,Object>> resultList = new ArrayList<>();
				List<ProductVO> productList = productDao.selectByCompanyId(companyId);
				
				for(ProductVO product : productList) {
					resultList.add(makeProductViewData(product));
				}
				
				return resultList;
				
		} catch (Exception e) {
			logger.error("상품 조회 실패.. | {} ", e.toString());
			return null;
		}
		
	}

	
	
	@Override
	public List<String> getImagePath(int productId) {
		return imageAdminService.getImagePathList("product", productId);
	}

	@Override
	public List<String> getDisableDate(int productId) {
		try {
			return productDao.selectManagerDisableDateList(productId);
		} catch (Exception e) {
			logger.error("상품 조회 실패.. | {} ", e.toString());
			return null;
		}
	}

	@Override
	@Transactional
	public int addProduct(ProductVO product, int productCount, int companyId ,List<MultipartFile> imageList) {
	
		try {
				//< 1. 상품 디비 생성
				productDao.insert(product);
				
				//< 2. 상품 제고 디비 생성
				LocalDate startDate = new LocalDate(product.getSaleStartDate());
				LocalDate endDate = new LocalDate(product.getSaleEndDate());
				
				int productManagerCount = Days.daysBetween(startDate, endDate).getDays() + 1;
				
				for(int i=0; i<productManagerCount; i ++) {
					ProductManagerVO productManager = new ProductManagerVO();
					productManager.setCount(productCount);
					productManager.setProductId(product.getId());
					LocalDate saleDate = startDate.plusDays(i);
					productManager.setSaleDate(saleDate.toString());
					
					productDao.insertManager(productManager);
				}
				
				//< 3. 상품 관리 디비 추가
				Map<String,Integer> params = new HashMap<>();
				params.put("productId", product.getId());
				params.put("companyId", companyId);
				productDao.insertAdmin(params);
			
				//< 4. 파일 업로드
			for( MultipartFile file : imageList ) {
				imageAdminService.addImageAdminProduct(product.getId(), imageAdminService.uploadFile(file));
			}
			
			
			return 1;
				
		} catch (Exception e) {
			logger.error("상품 조회 실패.. | {} ", e.toString());
			return 0;
		}

	}

	@Override
	public int updateProduct(ProductVO product, List<MultipartFile> imageList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean deleteProduct(int productId) {
		try {
				productDao.delete(productId);
				return true;
		} catch (Exception e) {
			logger.error("상품  삭제 실패.. | {} ", e.toString());
			return false;
		}	
	}



}
