package com.lec.amigo.controller;



import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.lec.amigo.common.PagingVO;
import com.lec.amigo.service.TrailService;
import com.lec.amigo.vo.TrailVO;
import com.lec.amigo.vo.UserVO;

@Controller
public class TrailController {
	
	@Autowired
	TrailService trailService;
	
	int route_no;
	List<TrailVO> trailReviewList;
	
	@RequestMapping("view/trail/trail_detail.do")
	public String trailDetail(HttpServletRequest req,Model model,PagingVO pagingVO,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int rowSizePerPage) {
		
		try {
			route_no = Integer.parseInt(req.getParameter("route_no"));
		} catch (Exception e) {
			//새로운 route_no 파라미터값이 없으므로 기존 산책 루트 그대로 유지
		}
		
		pagingVO.setTotalRowCount(trailService.getTotalRowCount(route_no));
		pagingVO.setCurPage(curPage);
		pagingVO.setRowSizePerPage(rowSizePerPage);
		pagingVO.pageSetting();
		List<TrailVO> trailReviewList = trailService.getTrailReviewList(route_no,pagingVO);			
		
		model.addAttribute("route_no",route_no);
		model.addAttribute("pagingVO",pagingVO);		
		model.addAttribute("trailReviewList",trailReviewList);
		
		return "trail_datail.jsp";
	}
	
	@RequestMapping(value="view/trail/insertTrailReview.do", method=RequestMethod.GET)
	public String insertTrailReview(HttpServletRequest req,Model model) {
		int route_no = Integer.parseInt(req.getParameter("route_no"));
		model.addAttribute("route_no",route_no);
		return "trail_insert.jsp";
	}
	
	@RequestMapping(value="view/trail/insertTrailReview.do", method = RequestMethod.POST)
	public String insertTrailReview(HttpServletRequest req,HttpSession sess,TrailVO trail) {
		UserVO user = (UserVO)sess.getAttribute("user");
		trail.setUser_no(user.getUser_no());
		trail.setUser_nick(user.getUser_nick());
		trailService.insertTrailReview(trail);
		
		return "redirect:/view/trail/trail_detail.do";
	}
	
	@RequestMapping(value="/view/trail/deleteTrailReview.do", method = RequestMethod.GET)
	public String deleteDog(HttpServletRequest req) {
	int walk_review_no = Integer.parseInt(req.getParameter("walk_review_no"));
    trailService.deleteTrailReview(walk_review_no);

	return "redirect:/view/trail/trail_detail.do";
	}
	
	@RequestMapping(value="/view/trail/updateTrailReview.do", method = RequestMethod.GET)
	public String updateDog(HttpServletRequest req,Model model,TrailVO trail) {
		int walk_review_no = Integer.parseInt(req.getParameter("walk_review_no"));
		model.addAttribute("trail", trailService.getTrailReview(walk_review_no));
		return "trail_update.jsp";
	}
	
	@RequestMapping(value="/view/trail/updateTrailReview.do", method = RequestMethod.POST)
	public String updateDog(Model model,TrailVO trail) {
		trailService.updateTrailReview(trail);
		return "redirect:/view/trail/trail_detail.do";
	}
	
	
	
}
