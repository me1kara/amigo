package com.lec.amigo.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.lec.amigo.service.DogService;
import com.lec.amigo.vo.DogVO;
import com.lec.amigo.vo.UserVO;

@Controller
@PropertySource("classpath:config/uploadpath.properties")
public class DogController {

	@Autowired
	DogService dogService;
	
	@Autowired
	Environment environment;
	
	private String uploadFolder = "";
	
	@PostConstruct
	public void getUploadPathPropeties() {
		uploadFolder = environment.getProperty("uploadFolderdog");
	}
	
	@RequestMapping("view/mypage/getDogList.do")
	public String getDogList(HttpSession sess, Model model,DogVO dog) {
	UserVO user = (UserVO)sess.getAttribute("user");
	int user_no = user.getUser_no();
	List<DogVO> dogList = dogService.getDogList(user_no);
	model.addAttribute("dogList", dogList);
	return "amigo_profile.jsp";
	}
		
	@RequestMapping(value="/view/mypage/insertDog.do", method = RequestMethod.POST)
	public String insertDog(Model model,DogVO dog) throws IOException {	
		MultipartFile uploadFile = dog.getUploadFile();
		if (!uploadFile.isEmpty()) {
			String fileName = uploadFile.getOriginalFilename();  // 파일 진짜 이름 가져오기
			if(fileName != "") {
				String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length()); // 확장자명 구하기
				UUID uuid = UUID.randomUUID();
				String[] uuids = uuid.toString().split("-");
				fileName = uuids[0] + fileExtension; // 랜덤 글자 생성
			}
			uploadFile.transferTo(new File(uploadFolder+fileName));
			dog.setDog_image_file(fileName);
		}
	dogService.insertDog(dog);
	return "redirect:/view/mypage/getDogList.do ";
	}
	
	@RequestMapping(value="/view/mypage/updateDog.do", method = RequestMethod.GET)
	public String updateDog(HttpServletRequest req,Model model,DogVO dog) {
		int dog_no = Integer.parseInt(req.getParameter("dog_no"));
		model.addAttribute("dog", dogService.getDog(dog_no));
		return "amigo_profile_update.jsp";
	}
	
	@RequestMapping(value="/view/mypage/updateDog.do", method = RequestMethod.POST)
	public String updateDog(Model model,DogVO dog) throws IOException {
		MultipartFile uploadFile = dog.getUploadFile();
		if (!uploadFile.isEmpty()) {
			new File(uploadFolder+dog.getDog_image_file()).delete(); // 기존 파일 삭제하기
			String fileName = uploadFile.getOriginalFilename();  // 파일 진짜 이름 가져오기
			if(fileName != "") {
				String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length()); // 확장자명 구하기
				UUID uuid = UUID.randomUUID();
				String[] uuids = uuid.toString().split("-");
				fileName = uuids[0] + fileExtension; // 랜덤 글자 생성
			}
			uploadFile.transferTo(new File(uploadFolder+fileName));
			dog.setDog_image_file(fileName);
		}
	dogService.updateDog(dog);
	return "redirect:/view/mypage/getDogList.do ";
	}
	
	@RequestMapping(value="/view/mypage/deleteDog.do", method = RequestMethod.GET)
	public String deleteDog(HttpServletRequest req) {
	int dog_no = Integer.parseInt(req.getParameter("dog_no"));
	String fileName = req.getParameter("dog_image_file");
	new File(uploadFolder+fileName).delete();
	dogService.deleteDog(dog_no);
	return "redirect:/view/mypage/getDogList.do ";
	}
}
