<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="com.lec.amigo.vo.UserVO"%>
<%@page import="com.lec.amigo.vo.ChatRoom"%>
<%@page import="org.springframework.web.servlet.tags.Param"%>
<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
UserVO user = (UserVO) session.getAttribute("user");
int index = Integer.parseInt(request.getParameter("index"));
int user_no = user.getUser_no();

boolean check = false;
check = (Boolean) request.getAttribute("checkRoom");

if (!check) {
%>
<script>alert('잘못된 접근입니다!'); location.href='/view/main.jsp';</script>
<%
}
List<ChatVO> chatList = (List<ChatVO>) request.getAttribute("chatList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	<script src="/resources/js/chat/chatRoom.js"></script>
	<link rel="stylesheet" href="/resources/css/chat/chatRoom.css">
</head>
<body>
	<c:set var="user" value="<%=user%>" />
	<%@include file="/includes/header.jsp"%>
	<div class="container">
		<section>
			<article
				style="width: 450px; margin: 0 auto; position: relative; left: 0;">

				<div style="display: flex;">
					<h1 class="page-header">채팅방</h1>
					<button class="btn btn-close" style="margin-left: auto;"
						onclick="history.back(-1)"></button>
				</div>

				<%
				SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd"); //지난날짜일때
				SimpleDateFormat formatter2 = new SimpleDateFormat("a hh:mm:ss");//시분초만, 오늘날짜일때
				%>
				<c:set var="formatter1" value="<%=formatter1%>">
				</c:set>
				<c:set var="formatter2" value="<%=formatter2%>">
				</c:set>

				<table class="table table-bordered"
					style="background: rgb(87, 160, 227);" id="chat-board">
					<tr class="table-borderless" style="border: none;">
						<td colspan="6">
							<ul id="list" style="list-style: none; height: 550px;"" >
								<!-- 해당 방의 채팅리스트를 출력 -->
								<c:forEach var="chat" items="<%=chatList%>">
									<c:choose>
										<c:when test="${chat.getUser_nick()!=user.getUser_nick() }">
											<c:choose>
												<c:when test="${chat.getFile()==null}">
													<li class="chat_left"
														style="margin-bottom: 3px; clear: both;"
														id="chat_no_${chat.getChat_no() }"><c:choose>
															<c:when test='${chat.getContent() eq "해당유저는 나갔습니다" }'>
																<div class="left">
																	<em>${chat.getUser_nick() } 이(가) 나갔습니다.</em>
																</div>
															</c:when>
															<c:otherwise>
																<div class="chat-bubble left">
																	<div class="align-self-center" style="max-height: 90%;">
																		<fmt:formatDate value="<%=new java.util.Date()%>"
																			pattern="yyyyMMdd" var="nowDate" />
																		<fmt:formatDate value="${chat.getDate()}"
																			pattern="yyyyMMdd" var="sDate" />

																		${chat.getUser_nick() }<span
																			style="font-size: 12px; color: #777;"> <c:choose>
																				<c:when test="${sDate<nowDate }">
																	${formatter1.format(chat.getDate()) }
																</c:when>
																				<c:otherwise>
																	${formatter2.format(chat.getDate()) }
																</c:otherwise>
																			</c:choose>
																		</span>
																	</div>
																	<div>${chat.getContent()}</div>
																</div>
															</c:otherwise>
														</c:choose></li>
												</c:when>
												<c:when test="${chat.getFile()!=null}">
													<span style="font-size: 11px; color: #777;">${chat.getDate() }</span>

													<li
														style="margin-bottom: 3px; overflow: hidden; clear: both;"
														id="chat_no_${chat.getChat_no() }"><span
														onclick="imgPop('/chatImg/${chat.getFile() }')"> <img
															src="/chatImg/${chat.getFile() }" width="200px"
															height="200px">
													</span></li>
												</c:when>
											</c:choose>
										</c:when>
										<c:when test="${chat.getUser_nick()==user.getUser_nick() }">
											<c:choose>
												<c:when test="${chat.getFile()==null}">
													<li class="chat_right"
														style="margin-bottom: 3px; float: right;"
														id="chat_no_${chat.getChat_no() }">
														<div class="chat-bubble right">
															<span class="chat_right"
																onmousedown="mouseDown(${chat.getChat_no()})"
																onmouseleave="mouseLeave()" onmouseup="mouseLeave()">${chat.getContent()}</span>
														</div>
													</li>
												</c:when>
												<c:when test="${chat.getFile()!=null}">
													<li style="margin-bottom: 3px; float: right;"
														id="chat_no_${chat.getChat_no() }"><span
														class="chat_right" style="overflow: hedden;"
														onmousedown="mouseDown(${chat.getChat_no()})"
														onmouseleave="mouseLeave()" onmouseup="mouseLeave()"
														onclick="imgPop('/chatImg/${chat.getFile() }')"> <img
															src="/chatImg/${chat.getFile() }" width="200px"
															height="200px"></span></li>
												</c:when>
											</c:choose>
											<li style="clear: both;"></li>
										</c:when>
									</c:choose>
								</c:forEach>
							</ul>
						</td>
					</tr>
					<tr class="table-borderless" id="submit_btn_wrap"
						style="border: none;">
						<td colspan="5" id="msgTd" scroll=auto
							style="width: 376.5px; height: 62px; overflow-x: hidden;"><textarea
								style="width: 100%;" type="text" name="msg" id="msg"
								placeholder="대화 내용을 입력하세요." class="form-control"></textarea> <label
							for="fileUpload"
							style="position: relative; bottom: 25px; left: 5px;"><i
								class="bi bi-card-image" id="photo"></i> </label></td>
						<td colspan=MESSAGE_ENTER style="text-align: rigth;"><button
								class="btn btn-light"
								style="width: 100px; height: 62px; color: rgb(87, 160, 227); font-weight: bold;"
								id="chat_submit_btn">보내기</button></td>
					</tr>
				</table>
				<input type="file" id="fileUpload" onchange="previewFile()"
					style="display: none;" accept=".gif, .jpg, .png">


			</article>
		</section>
	</div>

	<script>
	//채팅 서버 주소
  		var url = "ws://localhost:8088/chatHandler.do?<%=index%>";
  		var index = "<%=index%>";
		
  	//웹 소켓
  		var ws = new WebSocket(url);
  		ws.binaryType = "arraybuffer";
  	  		
  	   	// 소켓 이벤트 매핑
  	   	ws.onopen = function () {
  	   	 	let user_name = '<%=user.getUser_nick()%>';
  	   		//웹소켓 서버연결시
			let ent ={
		  			order : MESSAGE_ENTER,
		  			type: "message",
		  			userName : user_name,
		  			roomIndex : index
		  	}
  	   		//json형식으로 데이터 주고받음
  			ws.send(JSON.stringify(ent));
  			$('#msg').focus(); 
  			
  			//서버에서 메세지가 왔을시
  			ws.onmessage = function (evt) {
  	  			let msg = evt.data;
  	  			var jd = JSON.parse(msg); //json타입으로 주고받기에 파싱과정이 필요함
  	  			let jdl = Object.keys(jd);
  	  			
  	  			let order;
  	  			let user;
  	  			let txt;
  	  			let roomIndex;
  	  			let chat_no;
  	  			let type;
  	  			
  	  			//메세지종류 분기
  	  			switch(jd.order){
   	  				case MESSAGE_ENTER : 
	  	  				order = jd.order;
	  	  			    user = jd.userName;
	  	  			    roomIndex = jd.index;
	  	  			    break;  
	  	  			//메세지보냄
  	  				case MESSAGE_SEND : 
  	  	  				order = jd.order;
  	  	  				user = jd.userName;
  	  	  				roomIndex = jd.roomIndex;			
  	  	  				chat_no = jd.chatNo;
  	  	  				type= jd.type;
  	  					break;
  	  				//삭제
  	  				case MESSAGE_DELETE:
  	  	  				let delete_no = jd.chatNo;	
  	  	  				roomIndex = jd.roomIndex;			
  	  			
  	  	  				if(parseInt(roomIndex)==index){
  	  	  					$('#chat_no_'+delete_no).remove();
  		  				}
  	  	  				break;	
  	  			}
  	  			
  	  			if (order == MESSAGE_ENTER) {
  	  				if(parseInt(roomIndex)==index){
  	  					printEnter(user);
  	  				}
  	  			//다른 사람이 보낸 메세지일 경우
  	  			} else if (jd.type == 'message' && jd.order== MESSAGE_SEND) {
  	  				txt = jd.msg;
  	  				//서버에서 보낸 방번호와 현재 방번호가 일치하는지 확인하는 로직
  	  				if(parseInt(roomIndex)==index){
  	  					if(user=='<%=user.getUser_nick()%>'){
  	  						//서버에 메세지를 보낸 주체가 나라면, 오른쪽에 출력
  	  						printMe(txt, chat_no);
  	  					}else{
  	  						//서버에 메세지를 보낸 주체가 내가 아니라면 왼쪽에 출력
  	  						print(user, txt, chat_no);				
  	  					}
  	  					
  	  				}
  	  			//파일을 보내온 경우
  	  			}else if(jd.type=='file'){
  	  				let fileName = jd.fileName;
	  				if(user=='<%=user.getUser_nick()%>') {
	  					//파일명을 통해 서버의 특정경로에 있는 파일을 가져오는 형식 
  	  					printImageMe(fileName, chat_no);
  	  				}else{
  	  					printImage(user, fileName, chat_no);
  	  						
  	  				}
  	  			}
  	  			//채팅방 나감
   	  			else if (order == MESSAGE_ENTER) {
  	  				if(parseInt(roomIndex)==index){
  	  					printExit(user);
	  				}
  	  			} 
  	  			$('#list').scrollTop($('#list').prop('scrollHeight'));
  	  		};
  	  	   			
  	  		ws.onclose = function (evt) {
  	  			console.log('소켓이 닫힙니다.');  	  			
  	  		};

  	  		ws.onerror = function (evt) {
  	  			console.log('에러발생!');
  	  		};
  	  	
  	  		
  	  	  //상대방이 보내온 이미지 출력
    	  function printImage(user, fileName, chat_no) {
    	    	let temp = '';
    	    	
    	    	//파일이름과 경로를 통해 서버에서 이미지를 가져옴
    	    	let realFile ="/chatImg/"+fileName;
    	    	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
    	    	temp += '<li style="margin-bottom:3px; clear: both;" id="chat_no_'+chat_no+'">';

    	   	  	temp += '<img width="200px" height="200px" src='+realFile+' onclick="imgPop('+"'"+realFile+"'"+')">';
    	   	  	temp += '</li>';
    	   			  			
    	    	$('#list').append(temp);
    	    	$('#list').scrollTop($('#list').prop('scrollHeight'));
    	  }
  	  	  
  	  	  //내 화면단에 이미지 출력
  	  	  function printImageMe(fileName, chat_no){
	  		
  	  		//파일이름과 경로를 통해 출력
  	    	let realFile ="/chatImg/"+fileName;
  	  	  	let temp = '';
  	  	
  	  	  	temp += '<li style="margin-bottom:3px; float:right;" id="chat_no_'+chat_no+'">';
  	  		temp += '<span onmousedown="mouseDown('+chat_no+')" onmouseleave="mouseLeave()" onmouseup="mouseLeave()" onclick="imgPop('+"'"+realFile+"'"+')"><img width="200px" height="200px" src=' + realFile + '><span>';
  	  	  	temp += '</li>';
  	  	  	temp += '<li style="clear: both;"></li';
  	  	  
  	  	  			
  	  	  	$('#list').append(temp);
  	  	  	$('#list').scrollTop($('#list').prop('scrollHeight'));
  	  		}
 	  	  
  	  	  // 상대방이 보낸 메세지 화면에 출력
  	  	  function print(user, txt, chat_no) {
  	  	  	let temp = '';
			
  	  	  	temp += '<li class="chat_left" style="margin-bottom:3px; clear: both;" id="chat_no_'+chat_no+'">';
  	  	 
			temp += '<div class="chat-bubble left">';
			temp += '<div class="align-self-center">';
			temp += user + '<span style="font-size: 12px; color: #777;">'+new Date().toLocaleTimeString()+'</span>'
			temp += '</div>';
			temp += '<div>'+txt;
			temp += '</div></div>';	
  	  	  	temp += '</li>';		
  	  	  	$('#list').append(temp);
  	  	  	$('#list').scrollTop($('#list').prop('scrollHeight'));
  	  	  }
  	  	  //내가 보낸 메세지 출력
  	  	  function printMe(txt, chat_no) {
    	  	  	let temp = '';
    	  	  	temp += '<li class="chat_right" style="margin-bottom:3px; float:right;" id="chat_no_'+chat_no+'">';
    	  	  	temp += '<div class="chat-bubble right"><span onmousedown="mouseDown('+chat_no+')" onmouseleave="mouseLeave()" onmouseup="mouseLeave()">'+txt+'</span></div>';
    	  	  	temp += '</li>';
    	  	  	temp += '<li style="clear: both;"></li';
    	  	  			
    	  	  	$('#list').append(temp);
    	  	  	$('#list').scrollTop($('#list').prop('scrollHeight'));
    	  }
  	  	  		
  	  	  // 다른 client 접속		
  	  	  function printEnter(user) {
  	  	  	let temp = '';
  	  	  	temp += '<li style="margin-bottom:3px;">';
  	  	  	temp += "'" + user + "' 이(가) 입장했습니다." ;
  	  	  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
  	  	  	temp += '</li>';
  	  	  	$('#list').append(temp);
  	  	  }

  	  	  // client 접속 종료
  	  	  function printExit(user) {
  	  	  	let temp = '';
  	  	  	temp += '<li style="margin-bottom:3px;">';
  	  	  	temp += "'" + user + "' 이(가) 종료했습니다." ;
  	  	  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
  	  	  	temp += '</li>';
  	  	  			
  	  	  	$('#list').append(temp);
  	  	  }
  	  	  
  	  	  
  	  	  
  	  	  //보내기버튼 클릭시
  	  	  $('#chat_submit_btn').click(function(){
  	  		  	let message = $('#msg').val();
  	  			let fileVal = $('#fileUpload').val();
  	  			//파일인지 문자인지 분기
  	  			if(fileVal!=''){
  	  				sendFile();
  	  				preview_del();
  	  			}else if(message!=''){
  	  				send_text();

  	  			}  	  		
  				$('#msg').val('');
  	  	  		$('#msg').focus();
  	  	  	}
  	  	  	);
  	  	  
  	  	  //
  	  	  $('#msg').keydown(function(e) {
    	  	  	if (event.keyCode == 13) {
      	  		  	let message = $('#msg').val();
      	  			let fileVal = $('#fileUpload').val();  	  			
      	  			if(fileVal!=''){
      	  				sendFile();
      	  			}if(message!=''){
      	  				send_text();
      	  			}
      	  	  		//printMe($('#msg').val()); //본인 대화창에
      	  	    	$('#msg').val('');
      	  	  		e.preventDefault();
      	  	    	preview_del();	
      	  	    	$('#msg').focus();
    	  	  	}
    	  });
  	  	  
  	  	  
  	  	  //문자 보내기
  		  function send_text() {
	  		let option ={
	  			order : MESSAGE_SEND,
	  			type: "message",
	  			userName : user_name,
	  			msg :  $('#msg').val(),
	  			roomIndex : index
	  		}
	  		ws.send(JSON.stringify(option));
	  		
  		  }
  		  
  		 //파일 보내기로직
  		function sendFile(){
  			let file = document.querySelector("#fileUpload").files[0];
  			let fileReader = new FileReader();
  			fileReader.onload = function(e) {
  				let param = {
  					order : MESSAGE_SEND,
  					type: "fileUpload",
  					file: file.name,
  					roomIndex: index,
  					userName : user_name
  				}
  			    rawData = e.target.result;
  				ws.send(JSON.stringify(param)); // 보내기전 메시지를 보내서 파일을 보냄을 명시
  			  	ws.send(rawData); //실파일보내기(비나리타입), 서버에 저장용
  			};
  			//인풋파일을 어레이버퍼형식으로 읽기
  			fileReader.readAsArrayBuffer(file);
  			}   	
  		};

  
  </script>

</body>
</html>