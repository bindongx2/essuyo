package com.webproject.essuyo.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webproject.essuyo.dao.CommentDao;
import com.webproject.essuyo.dao.CompanyDao;
import com.webproject.essuyo.dao.FacilityAdminDao;
import com.webproject.essuyo.domain.CompanyVO;
import com.webproject.essuyo.domain.SQLParamVO;
import com.webproject.essuyo.service.CompanyService;
import com.webproject.essuyo.service.ImageAdminService;

@Service
public class CompanyServiceImpl implements CompanyService {

	private Logger logger = LoggerFactory.getLogger(CompanyServiceImpl.class);

	@Autowired
	private CompanyDao companyDao;

	@Autowired
	private FacilityAdminDao facilityAdminDao;

	@Autowired
	private ImageAdminService imageAdminService;
	
	@Autowired
	private CommentDao commentDao;

	private final int MAX_RAKING_COUNT = 4;

	@Override
	public CompanyVO getCompanyVO(int companyId) {
		try {
			return companyDao.getCompany(companyId);
		} catch (Exception e) {
			logger.error("Company Table 조회 실패.. {}", e.toString());
			return null;
		}
	}

	private Map<String, Object> makeCompanyViewData(CompanyVO company) {

		if (company != null) {
			Map<String, Object> resultMap = new HashMap<>();

			resultMap.put("id", company.getId());
			resultMap.put("score", company.getScore());
			resultMap.put("name", company.getName());
			resultMap.put("type", company.getType());
			resultMap.put("address", company.getAddress());
			resultMap.put("number", company.getNumber());
			resultMap.put("state", company.getState());
			resultMap.put("time", company.getTime());
			resultMap.put("homepage", company.getHomepage());

			return resultMap;
		}

		return null;
	}
	
	private String makeRankTitle(String type, String subType) {

		String result = "";
		
		switch(type) {
		case "reservation" : 
				if( subType.equals("max")) {
					result = "가장 많은 예약";
				}else if( subType.equals("min")) {
					result = "가장 적은 예약";
				}
			break;
		case "comment" : 
			if( subType.equals("max")) {
				result = "가장 많은 댓글";
			}else if( subType.equals("min")) {
				result = "가장 적은 댓글";
			}
			break;
		case "score" : 
			if( subType.equals("max")) {
				result = "가장 높은 점수";
			}else if( subType.equals("min")) {
				result = "가장 낮은 점수";
			}
			break;
		case "price" : 
			if( subType.equals("max")) {
				result = "가장 높은 매출";
			}else if( subType.equals("min")) {
				result = "가장 낮은 매출";
			}
			break;
		
		}
		
		return result;
		
	}
	

	@Override
	public Map<String, Object> getSimpleCompanyInfo(int companyId) {
		try {
			CompanyVO company = this.getCompanyVO(companyId);

			if (company != null) {
				Map<String, Object> resultMap = this.makeCompanyViewData(company);

				resultMap.put("review", companyDao.cntReviews(companyId));
				resultMap.put("image", this.getImagePath(company.getId()).get(0));

				return resultMap;
			}

			return null;
		} catch (Exception e) {
			logger.error("Company 조회 실패.. {}", e.toString());
			return null;
		}
	}

	public Map<String, Object> getDetailCompanyInfo(int companyId) {
		try {

			CompanyVO company = this.getCompanyVO(companyId);

			if (company != null) {
				Map<String, Object> resultMap = this.makeCompanyViewData(company);

				resultMap.put("image", this.getImagePath(companyId));
				resultMap.put("facility", this.getCompanyFacility(companyId));
				resultMap.put("review", companyDao.cntReviews(companyId));

				return resultMap;
			}

			return null;
		} catch (Exception e) {
			logger.error("Company Table 조회 실패.. {}", e.toString());
			return null;
		}
	}

	@Override
	public List<Map<String, Object>> getRankCompanyInfoList() {

		List<String> type = new ArrayList<>();
		type.add("reservation");
		type.add("comment");
		type.add("score");
		type.add("price");
		String[] subType = { "max", "min" };

		Random random = new Random();

		try {
			
			List<Map<String, Object>> resultList = new ArrayList<>();

			for (int i = 0; i < MAX_RAKING_COUNT; i++) {
				
				int typeIndex = random.nextInt(type.size());
				int subTypeIndex = random.nextInt(2);

				Map<String, Object> param = new HashMap<>();
				param.put("type", type.get(typeIndex));
				param.put("subType", subType[subTypeIndex]);
				
				List<CompanyVO> companyList = companyDao.getRankCompanyList(param);
				
				if (companyList != null && companyList.size() != 0 ) {
					
					//< 동점일 경우 첫번째 Index를 선택한다.
					CompanyVO company = companyList.get(0);
					Map<String, Object> resultMap = this.makeCompanyViewData(company);
						
					
					resultMap.put("rankTitle", this.makeRankTitle(type.get(typeIndex), subType[subTypeIndex]));
					resultMap.put("review", companyDao.cntReviews(company.getId()));
					resultMap.put("image", this.getImagePath(company.getId()).get(0));

					resultList.add(resultMap);
				}

				type.remove(typeIndex);
			}
			
			return resultList;
		} catch (Exception e) {
			logger.error("company rank 실패.. {}", e.toString());
			return null;
		}
	}
	
	@Override
	public Map<String, Object> getList(int start, String value, String type, String name) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		List<CompanyVO> list = null;
		List<String> imageInfoList = null;
		List<Object> salesList = new ArrayList<>();
		

		String[] values = value.split(","); 					

		
		Map<String, Object> sales = new HashMap<>();


		for(int i= 0; i<values.length;i++) {
			sales.put("value" + values[i], values[i]);			
		}

		try {			
				if(value.equals("") == true && name.equals("null") && !type.equals("전체")) {
					sales.put("type", type);
					sales.put("name", name);
					sales.put("count", values.length);
					int salesCount = companyDao.SalesListCount(sales);
					resultMap.put("salesCount", salesCount);
					
					SQLParamVO param = new SQLParamVO();		
					param.setStart(start*4);
					param.setLimit(4);
					param.setType(type);
					
					list = companyDao.listType(param);				
					
				} else if(type.equals("전체")) {
					sales.put("type", type);
					sales.put("name", name);
					sales.put("count", values.length);
					SQLParamVO param = new SQLParamVO();
					param.setStart(start*4);
					param.setLimit(4);
					
					list = companyDao.listAll(param);
					
				}
				
				else {
					sales.put("type", type);
					sales.put("name", name);
					sales.put("count", values.length);
					int salesCount = companyDao.SalesListCount(sales);
					resultMap.put("salesCount", salesCount);
					
					Map<String, Object> filterParam = new HashMap<>();	

					for(int i= 0; i<values.length;i++) {
					filterParam.put("value" + values[i], values[i]);			
					}
					
					filterParam.put("count", values.length);					
					filterParam.put("start",start*4 );
					filterParam.put("limit",4 );
					filterParam.put("type", type);
					filterParam.put("name",name);
						
					list = companyDao.filter(filterParam);
					
				}
				
				
		} catch (Exception e) {
			logger.error("리스트 조회 실패.. | {} ", e.toString());
		}
		
		
		for(CompanyVO data : list) {
			Map<String, Object> salesMap = new HashMap<>();
						
			salesMap.put("id", data.getId());
			salesMap.put("name",data.getName());
			salesMap.put("type", data.getType());
			salesMap.put("discription",data.getDiscription());
			salesMap.put("score", data.getScore());
			salesMap.put("address", data.getAddress());
			salesMap.put("number", data.getNumber());
			salesMap.put("homepage", data.getHomepage());
			salesMap.put("state", data.getState());
			salesMap.put("time", data.getTime());
			salesMap.put("areaListId", data.getAreaListId());
			
			salesMap.put("commentCount", commentDao.selectAllCompanyCommentCount(data.getId()) );
			
	
	
			try {
				imageInfoList = this.getImagePath(data.getId());
			} catch (Exception e) {				
				logger.error("이미지 조회 실패");
			}		
			
			salesMap.put("image",imageInfoList.get(0));	
			salesList.add(salesMap);
		}
		
		resultMap.put("sales", salesList);

		return resultMap;
		
	}
	

	@Override
	public List<String> getCompanyFacility(int companyId) throws Exception {
		return facilityAdminDao.selectById(companyId);
	}

	@Override
	public List<String> getImagePath(int companyId) throws Exception {
		return imageAdminService.getImagePathList("company", companyId);
	}

	@Override
	public void companyImgInsert(int cId) throws Exception {
		companyDao.companyImgInsert(cId);
		
	}

	@Override
	public int selectId() throws Exception {
		
		return companyDao.selectId();
	}

	
	@Override
	public Map<String, Object> getAllCompanyCount() {

		try {
			List<Map<String, Object>> allCompanyCountList = companyDao.selectAllCompanyCount();
			Map<String, Object> resultMap = new HashMap<>();

			if (allCompanyCountList != null && allCompanyCountList.size() != 0) {

				for (Map<String, Object> data : allCompanyCountList) {
					String type = "";
					int count = 0;
					for (String key : data.keySet()) {
						if (key.equals("type") == true) {

							switch (String.valueOf(data.get(key))) {
							case "숙박":
								type = "hotel";
								break;
							case "차량대여":
								type = "car";
								break;
							case "식당":
								type = "food";
								break;
							case "문화":
								type = "museum";
								break;
							}

						} else if (key.equals("count") == true) {
							String strCount = String.valueOf(data.get(key));
							count = Integer.parseInt(strCount);
						}

					}
					resultMap.put(type, count);
				}
				return resultMap;
			}
			return null;

		} catch (Exception e) {
			logger.error("회사 카테고리별 카운트 조회 실패.. | {} ", e.toString());
			return null;
		}
	

	}

	@Override
	public int updateScore(int companyId){
		try {
			return companyDao.updateCompanyScore(companyId);
		} catch (Exception e) {
			logger.error("회사 평점 실패.. | {} ", e.toString());
			return 0;
		}
	}

}
