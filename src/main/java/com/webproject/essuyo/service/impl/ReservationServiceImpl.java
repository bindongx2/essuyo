package com.webproject.essuyo.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.joda.time.LocalDate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.webproject.essuyo.dao.CompanyDao;
import com.webproject.essuyo.dao.ProductDao;
import com.webproject.essuyo.dao.ReservationDao;
import com.webproject.essuyo.dao.UserDAO;
import com.webproject.essuyo.domain.CompanyVO;
import com.webproject.essuyo.domain.ProductManagerVO;
import com.webproject.essuyo.domain.ReservationVO;
import com.webproject.essuyo.domain.SQLParamVO;
import com.webproject.essuyo.domain.UserVO;
import com.webproject.essuyo.service.ReservationService;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private ReservationDao reservationDao;

	@Autowired
	private ProductDao productDao;

	@Autowired
	private UserDAO userDao;
	
	@Autowired
	private CompanyDao companyDao;

	private final int SEARCH_LIMIT = 5;
	private final int MAX_GENDER_COUNT = 2;
	private final int MAX_CATEGORY_COUNT = 4;

	private Logger logger = LoggerFactory.getLogger(ProductServiceImpl.class);

	@Override
	@Transactional
	public int regReservationInfo(String email, ReservationVO reservationInfo) {
		try {
			int maxCount = reservationInfo.getProductCount();
					
			for(int i=0; i < maxCount; i++) {
		
				ProductManagerVO productManager = new ProductManagerVO();
				
				productManager.setCount(1);
				productManager.setProductId(reservationInfo.getProductId());
				LocalDate saleDate = new LocalDate(reservationInfo.getResDate());
				productManager.setSaleDate(saleDate.plusDays(i).toString());
				productDao.updateManager(productManager);
				
			}
		
			int userId = userDao.selectByEmail(email).getId();
			reservationInfo.setState("성공");
			reservationInfo.setProductType(companyDao.getCompany(reservationInfo.getCompanyId()).getType());
			reservationInfo.setUserId(userId);
					
			reservationDao.insert(reservationInfo);
			return reservationInfo.getId();

		} catch (Exception e) {
			logger.error("예약 등록 실패.. | {} ", e.toString());
			return 0;
		}

	}

	@Override
	public List<Map<String, Object>> getReservationList(String findType, int id, int start) {

		if (findType == null || findType.equals("") || id == 0 || start == 0) {
			return null;
		}

		SQLParamVO params = new SQLParamVO(findType, id, (start - 1) * SEARCH_LIMIT, SEARCH_LIMIT);

		try {

			List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
			List<ReservationVO> reservationList = reservationDao.select(params);

			if (reservationList != null && reservationList.size() != 0) {
				for (ReservationVO data : reservationList) {
					Map<String, Object> resultMap = new HashMap<>();

					if (findType.equals("user") == true) {
						CompanyVO company = companyDao.getCompany(data.getCompanyId());
						resultMap.put("typeId", company.getId() );
						resultMap.put("typeName", company.getName() );
					}
					else if (findType.equals("company") == true) {
						UserVO user = userDao.selectById(new SQLParamVO("user",data.getUserId()));
						resultMap.put("typeId", user.getId() );
						resultMap.put("typeName", user.getName());
					}
					
					resultMap.put("id", data.getId() );
					resultMap.put("companyId", data.getCompanyId() );
					resultMap.put("productId", data.getProductId() );
					resultMap.put("productName", productDao.selectByProductId(data.getProductId()).getName());
					resultMap.put("resDate", data.getRegDate());
					resultMap.put("state", data.getState());
					resultMap.put("totalPrice", data.getTotalPrice());

					resultList.add(resultMap);
					
				}

				return resultList;
			}
			return null;
		} catch (Exception e) {
			logger.error("예약 조회 실패.. | {} ", e.toString());
			return null;
		}

	}

	@Override
	public List<ReservationVO> getReservationListAll(String findType, int id) {

		if (findType == null || findType.equals("") || id == 0) {
			return null;
		}

		SQLParamVO params = new SQLParamVO(findType, id);

		try {
			return reservationDao.select(params);
		} catch (Exception e) {
			logger.error("예약 조회 실패.. | {} ", e.toString());
			return null;
		}

	}

	@Override
	public int getReservationTotalPrice(String findType, int id) {

		if (findType == null || findType.equals("") || id == 0) {
			return 0;
		}

		SQLParamVO params = new SQLParamVO(findType, id);

		try {
			return reservationDao.selectTotalPrice(params);
		} catch (Exception e) {
			logger.error("예약 조회 실패.. | {} ", e.toString());
			return 0;
		}

	}

	@Override
	public List<ReservationVO> getReservationListNotState(String findType, int id) {

		if (findType == null || findType.equals("") || id == 0) {
			return null;
		}

		SQLParamVO params = new SQLParamVO(findType, id);

		try {
			return reservationDao.selectNotState(params);
		} catch (Exception e) {
			logger.error("예약 조회 실패.. | {} ", e.toString());
			return null;
		}

	}

	@Override
	public List<Integer> getMonthlyPrice(String type, int id) {

		List<Integer> monthlyPrice = new ArrayList<Integer>(); // < 월별 지불/수입 리스트

		for (int i = 0; i < 12; i++) {
			monthlyPrice.add(0);
		}

		List<Map<String, Integer>> resultMap;
		try {
			resultMap = reservationDao.selectMonthlyPrice(new SQLParamVO(type, id));

			for (Map<String, Integer> data : resultMap) {
				int month = 0;
				int monthlyTotalPrice = 0;
				for (String key : data.keySet()) {
					if (key.equals("month") == true) {
						month = data.get(key).intValue() - 1;
					} else if (key.equals("monthlyTotalPrice") == true) {
						String totalPrice = String.valueOf(data.get(key));
						monthlyTotalPrice = Integer.parseInt(totalPrice);
					}
				}
				monthlyPrice.set(month, monthlyTotalPrice);

			}

			return monthlyPrice;
		} catch (Exception e) {
			logger.error("상품 월별 합계 조회 실패.. | {} ", e.toString());
			return null;
		}

	}

	@Override
	public List<List<Integer>> getMonthlyReservationCount(String type, int id) {

		try {
				List<Integer> monthly = new ArrayList<Integer>(); // < 월별 지불/수입 리스트

				for (int i = 0; i < 12; i++) {
					monthly.add(0);
				}
		
				 List<Map<String, Integer>> resultMap = reservationDao.selectMonthlyReservationCount(new SQLParamVO(type, id));

				for (Map<String, Integer> data : resultMap) {
					int month = 0;
					int Totalcount = 0;
					
					for (String key : data.keySet()) {
						if (key.equals("month") == true) {
							String categoryName = String.valueOf(data.get(key));
							month = Integer.parseInt(categoryName);

						} else if (key.equals("count") == true) {
							String count = String.valueOf(data.get(key));
							Totalcount = Integer.parseInt(count);
						}
					}
					
					monthly.set(month-1, Totalcount);
				}
				List<List<Integer>> result = new ArrayList<List<Integer>>();
				result.add(monthly);
				
				return result;
		} catch (Exception e) {
			logger.error("상품 월별 합계 조회 실패.. | {} ", e.toString());
			return null;
		}
	}

	public int getCategoryIndex(String category) {
		switch (category) {
		case "숙박":
			return 0;
		case "차량대여":
			return 1;
		case "문화":
			return 2;
		case "식당":
			return 3;
		}

		return -1;
	}

	@Override
	public List<Integer> getCategoryReservationCount(String type, int id) {
		List<Integer> category = new ArrayList<Integer>(); // < 월별 지불/수입 리스트

		for (int i = 0; i < MAX_CATEGORY_COUNT; i++) {
			category.add(0);
		}

		List<Map<String, Object>> resultMap;

		try {
			resultMap = reservationDao.selectCategoryCount(new SQLParamVO(type, id));

			for (Map<String, Object> data : resultMap) {
				int categoryIndex = 0;
				int categroyCount = 0;

				for (String key : data.keySet()) {
					if (key.equals("productType") == true) {
						String categoryName = String.valueOf(data.get(key));
						categoryIndex = this.getCategoryIndex(categoryName);

					} else if (key.equals("count") == true) {
						String count = String.valueOf(data.get(key));
						categroyCount = Integer.parseInt(count);
					}
				}
				category.set(categoryIndex, categroyCount);

			}

			return category;
		} catch (Exception e) {
			logger.error("상품 월별 합계 조회 실패.. | {} ", e.toString());
			return null;
		}

	}

	@Override
	public List<List<Integer>> getComprehensiveReservation(String type, int id) {

		List<List<Integer>> comprehensive = new ArrayList<>();

		int MaxMonth = 12;
		
		//monthlyList리스트에 0,0,0,0~ 12개 만들기
		for (int i = 0; i < MAX_CATEGORY_COUNT; i++) {
			List<Integer> monthlyList = new ArrayList<>();
			for (int m = 0; m < MaxMonth; m++) {
				monthlyList.add(0);
			}
			comprehensive.add(monthlyList);
		}

		try {
			//월마다 예약 총 횟수 Count
			List<Map<String, Object>> resultMap = reservationDao
					.selectComprehensiveReservation(new SQLParamVO(type, id));

			for (Map<String, Object> data : resultMap) {
				int month = 0;
				int categoryIndex = 0;
				int count = 0;

				for (String key : data.keySet()) {
					if (key.equals("productType") == true) {
						String categoryName = String.valueOf(data.get(key));
						categoryIndex = this.getCategoryIndex(categoryName);

					} else if (key.equals("count") == true) {
						String categoryCount = String.valueOf(data.get(key));
						count = Integer.parseInt(categoryCount);

					} else if (key.equals("month") == true) {
						String categroyMonth = String.valueOf(data.get(key));
						month = Integer.parseInt(categroyMonth) - 1;
					}
				}
				comprehensive.get(categoryIndex).set(month, count);
			}

			return comprehensive;
		} catch (Exception e) {
			logger.error("상품 월별 합계 조회 실패.. | {} ", e.toString());
			return null;
		}

	}

	@Override
	public List<Integer> getGenderReservationCount(int id) {

		List<Integer> genderList = new ArrayList<Integer>(); // < 월별 지불/수입 리스트

		for (int i = 0; i < MAX_GENDER_COUNT; i++) {
			genderList.add(0);
		}
		

		try {
			List<Map<String, Object>> resultMap = reservationDao.selectGenderReservationCount(id);
			
			for (Map<String, Object> data : resultMap) {
				int genderIndex = 0;
				int count = 0;

				for (String key : data.keySet()) {
					if (key.equals("gender") == true) {
						String gender = String.valueOf(data.get(key));
						if( gender.equals("남") == true ) {
							genderIndex = 0;
						}else {
							genderIndex = 1 ;
						}
	
					} else if (key.equals("count") == true) {
						String countStr = String.valueOf(data.get(key));
						count = Integer.parseInt(countStr);
					} 

					genderList.set(genderIndex,count);

				}

			}

			return genderList;
			
		} catch (Exception e) {
			logger.error("상품 월별 합계 조회 실패.. | {} ", e.toString());
			return null;
		}
	}

	@Override
	public int setCancelReservation(int reservationId) {
		try {
			ReservationVO rv = new ReservationVO();
			rv.setId(reservationId);
			rv.setState("취소");
			return reservationDao.update(rv);
		} catch (Exception e) {
			logger.error("상품 월별 합계 조회 실패.. | {} ", e.toString());
			return 0;
		}
	}

	@Override
	public int getAllReservationCount(String type, int id) {
		
		try {
				int max = reservationDao.selectCount(new SQLParamVO(type,id));
				int resultCount = max/SEARCH_LIMIT;
				
				if( max%SEARCH_LIMIT > 0)
					resultCount += 1;
					
				return resultCount;
		} catch (Exception e) {
			logger.error("예약 총 개수 조회 실패.. | {} ", e.toString());
			return 0;
		}
	}


}
