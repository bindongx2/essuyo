package com.webproject.essuyo.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.joda.time.LocalDate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.webproject.essuyo.dao.BusinessDao;
import com.webproject.essuyo.dao.UserDAO;
import com.webproject.essuyo.domain.BusinessVO;
import com.webproject.essuyo.domain.CompanyVO;
import com.webproject.essuyo.domain.ImageInfoVO;
import com.webproject.essuyo.domain.SQLParamVO;
import com.webproject.essuyo.domain.UserVO;
import com.webproject.essuyo.service.ImageAdminService;
import com.webproject.essuyo.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;

	@Autowired
	private BusinessDao businessDao;

	@Autowired
	private ImageAdminService imageAdminService;

	private Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	// 로그인 서비스
	@Override
	public UserVO login(UserVO vo) throws Exception {
		
		return dao.login(vo);
	}

	// 회원가입 서비스
	@Override
	public void regist(UserVO vo) throws Exception {

		dao.regist(vo);
	}
	
	// 증명서 발급  서비스
	@Override
	public UserVO print(UserVO vo) throws Exception {
		
		return dao.print(vo);
	}

	@Override
	public void keepLogin(String email, String seesionId, Date next) throws Exception {
		dao.keepLogin(email, seesionId, next);

	}

	@Override
	public UserVO checkLoginBefore(String value) {
		return dao.checkUserWithSessionkey(value);
	}

	// 이메일 중복 체크. 같은 이메일이 이미 DB에 존재하면 false, 아니면 true를 리턴

	@Override
	public UserVO getUserVO(String email) {

		return dao.selectByEmail(email);
	}
	@Override
	public UserVO getUserVO(int id) {
		return dao.selectById(new SQLParamVO("user",id));
	}
	
	@Override
	public Map<String, Object> getUserInfo(String email) {

		Map<String, Object> result = new HashMap<>();

		UserVO user = dao.selectByEmail(email);

		if (user != null) {
			result.put("id", user.getId());
			result.put("name", user.getName());
			result.put("email", user.getEmail());
			result.put("age", user.getAge());
			result.put("gender", user.getGender());
			result.put("lastLogin", new LocalDate(user.getLastDate()));
			result.put("url", imageAdminService.getImagePath(user.getImageInfoId()));

			if (user.getBusinessId() != 0) {
				result.put("business", this.getBusinessInfo(user.getBusinessId()));

			}

			return result;
		}

		return null;
	}

	@Override
	public boolean checkId(String email) {
		int emailCnt = dao.checkId(email);

		if (emailCnt > 0) {
			return false;
		} else {
			return true;
		}
	}

	@Override
	public void companyRegist(CompanyVO cvo) throws Exception {
		dao.companyRegist(cvo);

	}

	@Override
	public void businessRegist() throws Exception {
		dao.businessRegist();

	}

	@Override
	public void ownerRegist(UserVO vo) throws Exception {
		dao.ownerRegist(vo);

	}

	// 메시지에서 받는 email 찾기 위한 service
	@Override
	public UserVO selectMessageEmail(String id) throws Exception {
		return dao.selectMessageEmail(id);

	}

	@Override
	@Transactional
	public int setGoodCount(int businessId) {
		try {
				if( businessDao.updateGoodCountByBusinessId(businessId) != 0) {
					return businessDao.selectById(businessId).getGood();
				}else {
					return 0;
				}
		} catch (Exception e) {
			logger.error("비지니스 조회 오류.. {} ", e.toString());
			return 0;
		}

	}

	@Override
	public int setUserInfo(UserVO user) {
		try {
			return dao.update(user);
		} catch (Exception e) {
			logger.error("유저 업데이트 오류.. {} ", e.toString());
			return 0;
		}
	}

	@Override
	@Transactional
	public int setUserInfo(UserVO user, MultipartFile file) {
		try {
			// < 파일이 있는 경우만
			if (file.getSize() > 0) {
				int deleteImageInfoId = user.getImageInfoId();

				// < 1. 이미지 서버에 저장
				int imageInfoId = imageAdminService.uploadFile(file);
				user.setImageInfoId(imageInfoId);

				// < 2. User 테이블에 이미지 갱신되면 파일 삭제 및 DB 삭제
				if (deleteImageInfoId != 1) {
					ImageInfoVO image = imageAdminService.getImageInfo(deleteImageInfoId);
					imageAdminService.deleteFile(image.getName(), image.getId());
				}
			}

			// < 1. 저장 성공하면 DB 갱신
			dao.update(user);

			return 1;
		} catch (Exception e) {
			logger.error("유저 업데이트 오류.. {} ", e.toString());
			return 0;
		}
	}

	@Override
	@Transactional
	public int addBusiness(String email) {

		try {
				UserVO user = dao.selectByEmail(email);
				if( user.getBusinessId() == 0 ) {
					//< 비지니스 생성
					BusinessVO business = new BusinessVO();
					businessDao.insert(business);

					//< 유저 업데이트
					UserVO updateUser = new UserVO();
					updateUser.setBusinessId(business.getId());
					updateUser.setEmail(email);
					dao.update(user);
					
					return business.getId();
				}else
					return 0;
			
		} catch (Exception e) {
			logger.error("비지니스 & 유저 업데이트 오류.. {} ", e.toString());
			return 0;
		}
	}
	
	@Override
	public BusinessVO getBusinessInfo(String email) {

		UserVO user = dao.selectByEmail(email);

		try {
			return businessDao.selectById(user.getBusinessId());
		} catch (Exception e) {
			logger.error("유저 조회 오류.. {} ", e.toString());
			return null;
		}

	}

	@Override
	public BusinessVO getBusinessInfo(int BusinessId) {
		try {
			return businessDao.selectById(BusinessId);
		} catch (Exception e) {
			logger.error("유저 조회 오류.. {} ", e.toString());
			return null;
		}
	}

	@Override
	public Map<String, Object> getSaleUserInfo(int CompanyId) {

		Map<String, Object> resultMap = new HashMap<>();

		BusinessVO business = null;
		try {
			business = businessDao.selectByCompanyId(CompanyId);

			SQLParamVO params = new SQLParamVO("business", business.getId());

			UserVO user = dao.selectById(params);

			resultMap.put("id", user.getId());
			resultMap.put("name", user.getName());
			resultMap.put("image", imageAdminService.getImagePath(user.getImageInfoId()));
			resultMap.put("comment", business.getComment());
			resultMap.put("good", business.getGood());

		} catch (Exception e) {
			logger.error("유저 조회 오류.. {} ", e.toString());
		}

		return resultMap;
	}

	// 컴퍼니 테이블을 수정하는 서비스(미완성)
	@Override
	public void companyUpdate(CompanyVO cvo) throws Exception {
		dao.companyUpdate(cvo);

	}

	// 이메일로 유저 찾기
	@Override
	public UserVO selectByEmail(String email) {

		return dao.selectByEmail(email);
	}

	// 컴퍼니 테이블에 정보를 입력한 직후에 실해시켜서 비즈니스 테이블에 컴퍼니 아이디를 넣어주는 서비스
	@Override
	public void cIdIntoBusiness(UserVO vo) throws Exception {
		dao.cIdIntoBusiness(vo);
	}
	
	
	//유저 테이블이 비지니스 아이디를 업데이트 해주는 서비스
	@Override
	public void bIdtoUser(UserVO vo) throws Exception {
		dao.bIdtoUser(vo);
		
	}

	//컴퍼니 테이블을 update하는 기능
	@Override
	public void companyModify(CompanyVO cvo) throws Exception {
		dao.companyModify(cvo);
		
	}

	@Override
	public List<Integer> getImgIds(CompanyVO cvo) throws Exception {
		
		return dao.getImgIds(cvo);
	}

	@Override
	public void updateLastDate(UserVO vo) throws Exception {
		dao.updateLastDate(vo);
		
	}
	
	

	

	


}
