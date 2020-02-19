package com.webproject.essuyo.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.CompanyVO;
import com.webproject.essuyo.domain.SQLParamVO;
import com.webproject.essuyo.domain.UserVO;
import com.webproject.essuyo.utility.Encryption;

@Repository
public class UserDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "com.webproject.essuyo.dao";

	// 연습중(사이드바 유저명단)
	public UserVO userList(UserVO vo) throws Exception {
		Map<String, Object> dto = new HashMap<>();
		return session.selectOne(namespace + ".login", dto);
	}
	// 로그인 기능을 해 준다. vo 객체에서 이메일과 비번을 받아서 dto 맵에 넣어줌.
	public UserVO login(UserVO vo) throws Exception {
		Map<String, Object> dto = new HashMap<>();
		dto.put("email", vo.getEmail());		
		dto.put("password", Encryption.SHA512(vo.getPassword()));
		
		return session.selectOne(namespace + ".login", dto);
	}

	// 회원가입 기능.
	public void regist(UserVO vo) throws Exception {
		// dto 맵에 이름, 이메일, 비번, 나이, 성별, 주소, 핸드폰번호를 넣었다.
		Map<String, Object> dto = new HashMap<>();
		dto.put("name", vo.getName());
		dto.put("email", vo.getEmail());
		dto.put("password", Encryption.SHA512(vo.getPassword()));
		dto.put("age", vo.getAge());
		dto.put("gender", vo.getGender());
		dto.put("juso", vo.getJuso());
		dto.put("phoneNo", vo.getPhoneNo());
		
		session.insert(namespace + ".regist", dto);
	}
	
	// 증명서 발급 기능
	public UserVO print(UserVO vo) throws Exception {
		// dto id만 넣었다.
		Map<String, Object> dto = new HashMap<>();
		dto.put("id", vo.getId());	
		
		
		return session.selectOne(namespace + ".print", dto);
	}

	// 사업체 회원가입 기능.
	public void companyRegist(CompanyVO cvo) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("name", cvo.getName());
		map.put("type", cvo.getType());
		map.put("discription", cvo.getName());
		map.put("address", cvo.getAddress());
		map.put("number", cvo.getNumber());
		map.put("url", cvo.getHomepage());
		map.put("state", cvo.getState());
		map.put("time", cvo.getTime());

		session.insert(namespace + ".companyRegist", map);

	}

	// 비즈니스 테이블에 컴퍼니 아이디를 등록하는 기능
	// 컴퍼니 아이디는 LAST_INSERT_ID()로 들어가서 파라미터는 불필요
	public void businessRegist() throws Exception {
		session.insert(namespace + ".businessRegist");
	}

	// 사업자(오너)의 회원가입 부분.
	// map에 넣는 건 같지만, 마찬가지로 business_id를 LAST_INSERT_ID()로 입력한다.
	public void ownerRegist(UserVO vo) throws Exception {
		Map<String, Object> dto = new HashMap<>();
		dto.put("name", vo.getName());
		dto.put("email", vo.getEmail());
		dto.put("password", vo.getPassword());
		dto.put("age", vo.getAge());
		dto.put("gender", vo.getGender());

		session.insert(namespace + ".ownerRegist", dto);

	}

	// 컴퍼니 테이블을 수정하는 기능. 일단 cvo를 받아서 HashMap으로 넣어준다.
	public void companyUpdate(CompanyVO cvo) throws Exception {
		Map<String, Object> map = new HashMap<>();

		map.put("name", cvo.getName());
		map.put("type", cvo.getType());
		map.put("discription", cvo.getDiscription());
		map.put("address", cvo.getAddress());
		map.put("number", cvo.getNumber());
		map.put("homepage", cvo.getHomepage());
		map.put("state", cvo.getState());
		map.put("time", cvo.getTime());
		map.put("areaListId", cvo.getAreaListId());

		session.insert(namespace + ".companyUpdate", map);
	}

	// companyUpdate (컴퍼니 insert) 다음에 바로 실행시켜서, 비즈니스 테이블에 컴퍼니 아이디를 넣어준다
	public void cIdIntoBusiness(UserVO vo) throws Exception {
		Integer bId = vo.getBusinessId();
		session.update(namespace + ".cIdIntoBusiness", bId);

	}

	// 로그인 유지 기능. 여유가 생기면 마저 손보고, 작동 안 하는데 시간이 없을 경우엔 삭제
	public void keepLogin(String email, String seesionId, Date next) {
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("email", email);
		paraMap.put("sessionId", seesionId);
		paraMap.put("next", next);

		session.update(namespace + ".keepLogin", paraMap);

	}

	// 세션키 체크 기능, 위의 로그인 유지 기능과 마찬가지
	public UserVO checkUserWithSessionkey(String value) {

		return session.selectOne(namespace + ".checkUserWithSessionkey", value);
	}

	// 회원 가입 시 이메일 중복체크 기능
	public int checkId(String email) {

		return session.selectOne(namespace + ".checkId", email);
	}

	public UserVO selectById(SQLParamVO params) {
		return session.selectOne(namespace + ".selectById", params);
	}

	public UserVO selectByEmail(String email) {
		return session.selectOne(namespace + ".selectByEmail", email);
	}

	// 메시지에서 받는 email 찾기 위한 service
	public UserVO selectMessageEmail(String id) throws Exception {
		return session.selectOne(namespace + ".recevieID", id);
	}

	public int update(UserVO user) throws Exception {
		return session.update(namespace + ".update", user);
	}


	// 개인별 총 리뷰수
	public Integer reviewCnt(int userId) throws Exception {
		return session.selectOne(namespace + ".reviewCnt", userId);
	}

	//유저 테이블에 비지니스 아이디를 업데이트 해준다
	public void bIdtoUser(UserVO vo) throws Exception{
		
		session.update(namespace+".bIdtoUser", vo.getEmail());
		
	}
	
	//컴퍼니 테이블을 업데이트하는 기능
	public void companyModify(CompanyVO cvo) throws Exception{		
		
		session.update(namespace+".companyModify", cvo);
	}
	
	//컴퍼니 이미지 테이블의 이미지 아이디들을 얻는 DAO
	public List<Integer> getImgIds(CompanyVO cvo)throws Exception{
		int id = cvo.getId();
		
		return session.selectList(namespace+".getImgIds", id);

	}
	
	//로그인시 최종 접속일 항목을 갱신해 주는 DAO
	public void updateLastDate(UserVO vo) throws Exception{
		int id = vo.getId();
		
		session.update(namespace+".updateLastDate", id);
		
	}
	
}
