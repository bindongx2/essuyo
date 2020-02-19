package com.webproject.essuyo.service;


import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.webproject.essuyo.domain.ProductVO;


public interface ProductService {
	
	//< 예약페이지 : 상품 ID를 통해 상품 검색
	public Map<String,Object> getProduct(int productId);
	
	public List<Map<String,Object>> getProductList(int companyId);
	
	public int addProduct(ProductVO product, int productCount, int companyId, List<MultipartFile> imageList);
	
	public int updateProduct(ProductVO product, List<MultipartFile> imageList);

	public boolean deleteProduct(int productId);
	
	public List<String> getImagePath(int productId);
	
	public List<String> getDisableDate(int productId);
	
}
