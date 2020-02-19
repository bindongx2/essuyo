package com.webproject.essuyo.service;

import java.util.List;
import java.util.Map;

import com.webproject.essuyo.domain.CommentVO;

public interface CommentService {

	//< 덧글 리스트를 반환한다.
	public List<Map<String,Object>> getCommentList(String type, int id, int start);
	
	//public String getImagePath(String findType, int id);
	
	// 댓글 입력
	public void writerComment(CommentVO comment) throws Exception;
	// 댓글 수정
	public void modifyComment(CommentVO comment) throws Exception;
	// 댓글 삭제
	public void removeComment(CommentVO comment) throws Exception;
	
	// helpful 버튼 
	public Integer helpful(Integer commentId) throws Exception;

	//< 댓글 개수 구하기
	public int getAllCommentCount(String type, int id) ;


}
