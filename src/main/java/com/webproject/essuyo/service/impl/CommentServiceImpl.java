package com.webproject.essuyo.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webproject.essuyo.dao.CommentDao;
import com.webproject.essuyo.dao.UserDAO;
import com.webproject.essuyo.domain.CommentVO;
import com.webproject.essuyo.domain.SQLParamVO;
import com.webproject.essuyo.domain.UserVO;
import com.webproject.essuyo.service.CommentService;
import com.webproject.essuyo.service.ImageAdminService;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao commentDao;

	@Autowired
	private UserDAO userDao;

	@Autowired
	private ImageAdminService imageAdminService;

	private final int SEARCH_LIMIT = 5;

	private Logger logger = LoggerFactory.getLogger(CommentServiceImpl.class);

	@Override
	public List<Map<String, Object>> getCommentList(String type, int id, int start) {

		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		try {
			SQLParamVO params = new SQLParamVO(type, id, (start - 1) * SEARCH_LIMIT, SEARCH_LIMIT);
			List<CommentVO> commentList = commentDao.selectById(params);

			// UserVO userInfo = userService.getUserInfo(id);

			// if (userInfo != null) {
			for (CommentVO data : commentList) {
				Map<String, Object> paramMap = new HashMap<>();

				paramMap.put("id", data.getId());
				paramMap.put("title", data.getTitle());
				paramMap.put("content", data.getContent());
				paramMap.put("regDate", data.getRegDate());
				paramMap.put("score", data.getScore());
				paramMap.put("helpful", data.getHelpful());
				paramMap.put("userId", data.getUserId());

				if (type.equals("user") == true) {
					List<String> companyImageList = imageAdminService.getImagePathList("company", data.getCompanyId());
					paramMap.put("imageUrl", companyImageList.get(0));
					paramMap.put("companyId", data.getCompanyId());
				} else if (type.equals("company") == true) {
					UserVO user = userDao.selectById(new SQLParamVO("user", data.getUserId()));
					paramMap.put("commentUserEmail", user.getEmail());
					paramMap.put("name", user.getName());
					paramMap.put("totalReply", userDao.reviewCnt(user.getId()));
					paramMap.put("imageUrl", imageAdminService.getImagePath(user.getImageInfoId()));
				}
				resultList.add(paramMap);
			}
			// }

		} catch (Exception e) {
			logger.error("댓글 조회 실패.. | {} ", e.toString());
		}

		return resultList;
	}

	// 댓글 입력
	@Override
	public void writerComment(CommentVO comment) throws Exception {
		commentDao.create(comment);

	}

	@Override
	public void modifyComment(CommentVO comment) throws Exception {
		
		commentDao.update(comment);
	}

	@Override
	public void removeComment(CommentVO comment) throws Exception {
		
		commentDao.delete(comment);
	}
	
	@Override
	public int getAllCommentCount(String type, int id) {
		
			try {
				int max = 0;
				if(type.equals("user") == true ) {
					max =  commentDao.selectAllUserCommentCount(id);
				}else {
					max =  commentDao.selectAllCompanyCommentCount(id);
				}
				
				int resultCount = max/SEARCH_LIMIT;
				
				if( max%SEARCH_LIMIT > 0)
					resultCount += 1;
				
				return resultCount;
				
			} catch (Exception e) {
				logger.error("댓글 카운트 조회 실패.. | {} ", e.toString());
				return 0 ;
			}
		
		
	}


	@Override
	public Integer helpful(Integer commentId) throws Exception {
		int result =  commentDao.helpful(commentId);
		if( result > 0 ) {
			List<CommentVO> commentList =  commentDao.selectById(new SQLParamVO("comment",commentId));
			return commentList.get(0).getHelpful();
		}
		return 0;
	}

}
