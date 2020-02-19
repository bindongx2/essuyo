package com.webproject.essuyo.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.webproject.essuyo.domain.CommentVO;
import com.webproject.essuyo.domain.SQLParamVO;

@Repository
public class CommentDao {

	@Autowired
	private SqlSession sqlSession;
	
	private String NAME_SAPACE = "mappers.Comment";
	
	public List<CommentVO> selectById(SQLParamVO params) throws Exception{
		
		return sqlSession.selectList(NAME_SAPACE + ".selectById" , params);
	}

	// 댓글 입력
	public void create(CommentVO comment) throws Exception{
		
		sqlSession.insert(NAME_SAPACE + ".create", comment);
	}
	
	// 댓글  갯수
	public int selectAllCompanyCommentCount(int company_id) throws Exception{
		return sqlSession.selectOne(NAME_SAPACE+".selectCompanyCommentCount",company_id);
	}
	public int selectAllUserCommentCount(int userId) throws Exception{
		return sqlSession.selectOne(NAME_SAPACE+".selectUserCommentCount",userId);
	}
	
	
	
	// 댓글 수정
	public void update(CommentVO comment) throws Exception{
		sqlSession.update(NAME_SAPACE + ".update", comment);
	}
	
	// 댓글 삭제
	public void delete(CommentVO comment) throws Exception{
		sqlSession.update(NAME_SAPACE + ".delete", comment);
	}
	
	// helpful
	public Integer helpful(Integer commentId) throws Exception{
		
		return sqlSession.update(NAME_SAPACE + ".helpful", commentId);
	}

}
