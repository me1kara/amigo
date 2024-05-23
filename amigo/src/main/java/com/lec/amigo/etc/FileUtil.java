package com.lec.amigo.etc;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUtil {
	
	public static void uploadFile(String FILE_UPLOAD_PATH, String fileName, ByteBuffer byteBuffer){
		//파일생성로직
		File dir = new File(FILE_UPLOAD_PATH);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		File file = new File(FILE_UPLOAD_PATH, fileName);
		FileOutputStream out = null;
		FileChannel outChannel = null;
		try {
			byteBuffer.flip(); //byteBuffer를 읽기 위해 세팅
			out = new FileOutputStream(file, true); //생성을 위해 OutputStream을 연다.
			outChannel = out.getChannel(); //채널을 열고
			byteBuffer.compact(); //파일을 복사한다.
			outChannel.write(byteBuffer); //binary타입으로 받은 파일을 작성
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(out != null) {
					out.close();
				}
				if(outChannel != null) {
					outChannel.close();
				}
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
		byteBuffer.position(0); 
	}
	
	public static String uploadFiles(List<MultipartFile> uploadFile, String uploadFolder) throws FileUploadException {
		if (!uploadFile.isEmpty()) {

			List<Map<String, String>> uploadFileList = new ArrayList<>();

			for(int i = 0; i < uploadFile.size(); i++) {
			String fileRealName = uploadFile.get(i).getOriginalFilename(); // 파일 진짜 이름 가져오기
				if(fileRealName != "") {

			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length()); // 확장자명 구하기
			
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			String uniqueName = uuids[0] + fileExtension; // 랜덤 글자 생성
			
			Map<String, String> map = new HashMap<>();
			map.put("fileRealName", fileRealName);
			map.put("uniqueName", uniqueName);
			
			uploadFileList.add(map);
				}
			}			
				
			try {
				for(int i=0; i<uploadFileList.size(); i++) {
					File saveFile = new File(uploadFolder +"\\"+uploadFileList.get(i).get("uniqueName"));
					uploadFile.get(i).transferTo(saveFile);
				}
				
			} catch (Exception e) {
				log.error("다중 파일 업로드 실패 = {} ",e.getMessage());
				for(int i=0; i<uploadFile.size(); i++) {
					new File(uploadFolder+"\\"+uploadFileList.get(i).get("uniqueName")).delete();
				}
				throw new FileUploadException(e.getMessage());
			} 
			ArrayList<String> DBUpload = new ArrayList<>();
			for(int i=0; i<uploadFileList.size(); i++) {
				DBUpload.add(uploadFileList.get(i).get("uniqueName"));
			}
		
			return StringUtils.join(DBUpload, ",");  // 리스트 값들을 ,로 연결해주는 자바에 있는 메서드
		} 
		
		return "fail";
	}
}
