<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="com.lec.amigo.vo.UserVO"%>
<%@page import="com.lec.amigo.vo.ChatRoom"%>
<%@page import="org.springframework.web.servlet.tags.Param"%>
<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="java.util.List"%>
<%@page import="com.lec.amigo.dao.ChatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<%
UserVO user = (UserVO) session.getAttribute("user");
int index = Integer.parseInt(request.getParameter("index"));
int user_no = user.getUser_no();

boolean check = false;

/*
	if((int)request.getAttribute("idCheck")>0){
		index = (int)request.getAttribute("idCheck");
	     System.out.println(index+"로그인성공!");
	     
	}else{
		System.out.println(index+"로그인실패!");
	}
*/
ChatDAO dao = (ChatDAO) request.getAttribute("chatDAO");

check = dao.checkRoomIndex(user_no, index);

if (!check) {
%>
<script>alert('잘못된 접근입니다!'); history.go(-3);</script>
<%
}
List<ChatVO> chatList = dao.getChatList(index);
%>






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
<style>
.container {
	width: 500px;
}

#list {
	height: 300px;
	padding: 15px;
	overflow: auto;
}

</style>
<script>
		$(document).ready(function(){
			$('#list').scrollTop($('#list').prop('scrollHeight'));
		});

  	  function previewFile() {
		  //var preview = document.getElementById('preimg');
		  var preview = $('#msgTd');
		  var file = document.querySelector('input[type=file]').files[0];
		  var reader = new FileReader();
		
		  reader.addEventListener(
		    'load',
		    function () {
		      preview.append("<img src="+reader.result+" height='62px' class='preview_img_del' width='100%'/>");
		      preview.append("<button class='btn btn-danger preview_img_del' onclick='preview_del()'>이미지삭제</button>");
		      $('#msg').val('');
		      $('#msg').hide();
		    },false
		  );
		
		  if (file) {
		    reader.readAsDataURL(file);
		  }
		}
		
  	 	function imgPop(url){
  	 		
  	 	  window.open("URL", "팝업이름", "팝업 옵션");
  	 	  console.log('확인용');
  		  var img=new Image();
  		  img.src=url;
  		  var img_width=img.width;
  		  var win_width=img.width+25;
  		  var img_height=img.height;
  		  
  		  var OpenWindow=window.open('','_blank', 'width='+img_width+', height='+img_height+', menubars=no, scrollbars=auto');
  		  OpenWindow.document.write("<style>body{margin:0px;}</style><img src='"+url+"' width='"+win_width+"'>");
  		 }
  	  	
  	  

	</script>
</head>
<body>
	<c:set var="user" value="<%=user%>" />
	<div class="container">
		<h1 class="page-header">채팅방</h1>


		<table class="table table-bordered" style="background: #81DAF5;">

			<tr class="table-borderless">

				<td colspan="6">
					<ul id="list" style="list-style: none;">
						<c:forEach var="chat" items="<%=chatList%>">
							<c:choose>
								<c:when test="${chat.getUser_nick()!=user.getUser_nick() }">
									<c:choose>
										<c:when test="${chat.getFile()==null}">
											<li style="margin-bottom: 3px; clear: both;"
												id="chat_no_${chat.getChat_no() }">
												[${chat.getUser_nick() }] ${chat.getContent()} 
												<span style="font-size: 11px; color: #777;">${chat.getDate() }</span>
											</li>
										</c:when>
										<c:when test="${chat.getFile()!=null}">
											<li style="margin-bottom: 3px; overflow: hidden; clear: both;"
												id="chat_no_${chat.getChat_no() }" >
												[${chat.getUser_nick() }]
												<span ondblclick="imgPop('/img/${chat.getFile() }')">
												<img src="/img/${chat.getFile() }" width="200px" height="200px">
												<span style="font-size: 11px; color: #777;">${chat.getDate() }</span>
												</span>
											</li>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${chat.getUser_nick()==user.getUser_nick() }">
									<c:choose>
										<c:when test="${chat.getFile()==null}">
											<li style="margin-bottom: 3px; float: right;"
												id="chat_no_${chat.getChat_no() }">
												<span onmousedown="mouseDown(${chat.getChat_no()})" onmouseleave="mouseLeave()" onmouseup="mouseLeave()">${chat.getContent()}</span>
											</li>
										</c:when>
										<c:when test="${chat.getFile()!=null}">
											<li style="margin-bottom: 3px; float: right;"
												id="chat_no_${chat.getChat_no() }">
												<span style="overflow: hedden;" onmousedown="mouseDown(${chat.getChat_no()})" onmouseleave="mouseLeave()" onmouseup="mouseLeave()" ondblclick="imgPop('/img/${chat.getFile() }')">
												<img src="/img/${chat.getFile() }" width="200px" height="200px"></span>
											</li>
										</c:when>
									</c:choose>
									<li style="clear: both;"></li>
								</c:when>
							</c:choose>



						</c:forEach>
					</ul>
				</td>
			</tr>
			<tr class="table-borderless">
				<td colspan="5" id="msgTd" scroll=auto style="width: 376.5px; height:62px; overflow-x:hidden;"><textarea style="width: 100%;" type="text" name="msg" id="msg"
					placeholder="대화 내용을 입력하세요." class="form-control"></textarea>
					</td>
				<td colspan="1" style="text-align: rigth;"><button
						class="btn btn-success" style="width: 100px; height:62px;" id="chat_submit_btn">보내기</button></td>
			</tr>
			<tr>
				<th><input type="file" id="fileUpload" onchange="previewFile()"></th>
			</tr>
		</table>

	</div>
	<script>
//채팅 서버 주소
  		var url = "ws://localhost:8088/amigo/chatHandler.do?<%=index%>";
  		var index = "<%=index%>";
		
  // 웹 소켓
  		var ws = new WebSocket(url);
  		ws.binaryType = "arraybuffer";
  		
	  	var timeOut = 0;
		function mouseDown(chat_no){
			timeOut = setTimeout(() => chat_delete(chat_no), 1000); 
  		}
		
		function mouseLeave(){
			clearTimeout(timeOut);
		}
		function preview_del(){
			$('.preview_img_del').remove();
			$('#msg').show();
			$('#fileUpload').val('');
		}
	  	  function chat_delete(chat_no){
		  		let option ={
			  			no : "4",
			  			type: "message",
			  			chatNo : ""+chat_no+"",
			  			roomIndex : index
			  	}
		  		console.log(chat_no);
		  		if (confirm("삭제하시겠습니까?")) {
		  			ws.send(JSON.stringify(option));
		  			$('#chat_no_'+chat_no).remove();
		  		}
			
		  }
  		
  	   	// 소켓 이벤트 매핑
  	   	ws.onopen = function () {
  	   		console.log('서버 연결 성공');
  	   	 	let user_name = '<%=user.getUser_nick()%>';
	  		let ent ={
		  			no : "1",
		  			type: "message",
		  			userName : user_name,
		  			roomIndex : index
		  	}
  			ws.send(JSON.stringify(ent)); 
  			$('#msg').focus();
  			
  			ws.onmessage = function (evt) {
  			  	console.log(evt.data);
  			  	
  			  	if(typeof evt.data == "string"){
  	  			let msg = evt.data;
  	  			var jd = JSON.parse(msg);
  	  			let jdl = Object.keys(jd);
  	  			
  	  			let no;
  	  			let user;
  	  			let txt;
  	  			let roomIndex;
  	  			let chat_no;
  	  			let type;
  	  			
  	  			
  	  			if(jd.no=="4"){
  	  				let delete_no = jd.chatNo;	
  	  				roomIndex = jd.roomIndex;			
  	  				console.log(index+":"+roomIndex);
  			
  	  				if(parseInt(roomIndex)==index){
  	  					$('#chat_no_'+delete_no).remove();
	  				}
  	  					
  	  			}else if(jd.no=="1"){
  	  			    no = jd.no;
  	  			    user = jd.userName;
  	  			    roomIndex = jd.index;
  	  			}else if(jd.no=="2"){
  	  				no = jd.no;
  	  				user = jd.userName;
  	  				roomIndex = jd.roomIndex;			
  	  				chat_no = jd.chatNo;
  	  				type= jd.type;
  	  			}
  	  			
  	  			console.log('인덱스:'+index+'룸인덱스:'+roomIndex);		
  	  			if (no == '1') {
  	  				if(parseInt(roomIndex)==index){
  	  					print2(user);
  	  				}
  	  			} else if (jd.type == 'message' && jd.no== "2") {
  	  				txt = jd.msg;
  	  				if(parseInt(roomIndex)==index){
  	  					
  	  					if(user=='<%=user.getUser_nick()%>'){
  	  				
  	  						printMe(txt, chat_no);
  	  					}else{
  	  						console.log('설마?');
  	  						print(user, txt, chat_no);
  	  						
  	  					}
  	  					
  	  				}
  	  			}else if(jd.type=='file'){
  	  				let fileName = jd.fileName;
  	  				console.log(fileName);
	  				if(user=='<%=user.getUser_nick()%>') {
  	  					printImageMe(fileName, chat_no);
  	  				}else{
  	  					printImage(user, fileName, chat_no);
  	  						
  	  				}
  	  			}
  	  			else if (no == '3') {
  	  				if(parseInt(roomIndex)==index){
  	  					print3(user);
	  				}
  	  				
  	  			}
  			  	}
  			  	else{
  			  		console.log("비나리타입");
  			  		console.log(event.data.byteLength);
  			  			  		
  			  	}
  	  			$('#list').scrollTop($('#list').prop('scrollHeight'));
  	  		};
  	  	   			
  	  		ws.onclose = function (evt) {
  	  			console.log(evt.data);
  	  			console.log('소켓이 닫힙니다.');  	  			
  	  			//setTimeout(function(){connect();}, 1000);
  	  			
  	  		};

  	  		ws.onerror = function (evt) {
  	  			console.log(evt.data);
  	  		};
  	  		


  		
  	  		
    	  function printImage(user, fileName, chat_no) {
    	    	let temp = '';
    	    	
    	    	let realFile ="/img/"+fileName;
    	    	console.log(realFile);
    	    	temp += '<li style="margin-bottom:3px; clear: both;" id="chat_no_'+chat_no+'">';
    	    	temp += '[' + user + '] ';
    	   	  	temp += '<img width="200px" height="200px" src='+realFile+' ondblclick="imgPop('+"'"+realFile+"'"+')">';
    	   	  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
    	   	  	temp += '</li>';
    	   	  			
    	    	$('#list').append(temp);
    	    	$('#list').scrollTop($('#list').prop('scrollHeight'));
    	  }
  	  	  function printImageMe(fileName, chat_no){
	  		
  	    	let realFile ="/img/"+fileName;
	    	console.log(realFile);
  	  	  	let temp = '';
  	  	
  	  	  	temp += '<li style="margin-bottom:3px; float:right;" id="chat_no_'+chat_no+'">';
  	  		temp += '<span onmousedown="mouseDown('+chat_no+')" onmouseleave="mouseLeave()" onmouseup="mouseLeave()" ondblclick="imgPop('+"'"+realFile+"'"+')"><img width="200px" height="200px" src=' + realFile + '><span>';
  	  	  	temp += '</li>';
  	  	  	temp += '<li style="clear: both;"></li';
  	  	  
  	  	  			
  	  	  	$('#list').append(temp);
  	  	  	$('#list').scrollTop($('#list').prop('scrollHeight'));
  	  		}
 	  	  
  	  	  // 메세지 전송 및 아이디
  	  	  function print(user, txt, chat_no) {
  	  	  	let temp = '';
  	  	
  	  	  	temp += '<li style="margin-bottom:3px; clear: both;" id="chat_no_'+chat_no+'">';
  	  	  	temp += '[' + user + '] ';
  	  	  	temp += txt;
  	  	  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
  	  	  	temp += '</li>';
  	  	  			
  	  	  	$('#list').append(temp);
  	  	  	$('#list').scrollTop($('#list').prop('scrollHeight'));
  	  	  }
  	  	  function printMe(txt, chat_no) {
  	  		  	
  	  		  	console.log('확인용숫자'+chat_no);
    	  	  	let temp = '';
    	  	  	temp += '<li style="margin-bottom:3px; float:right;" id="chat_no_'+chat_no+'">';
    	  	  	temp += '<span onmousedown="mouseDown('+chat_no+')" onmouseleave="mouseLeave()" onmouseup="mouseLeave()">'+txt+'</span>';
    	  	  	temp += '</li>';
    	  	  	temp += '<li style="clear: both;"></li';
    	  	  			
    	  	  	$('#list').append(temp);
    	  	  	$('#list').scrollTop($('#list').prop('scrollHeight'));
    	  }
  	  	  		
  	  	  // 다른 client 접속		
  	  	  function print2(user) {
  	  	  	let temp = '';
  	  	  	temp += '<li style="margin-bottom:3px;">';
  	  	  	temp += "'" + user + "' 이(가) 입장했습니다." ;
  	  	  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
  	  	  	temp += '</li>';
  	  	  	$('#list').append(temp);
  	  	  }

  	  	  // client 접속 종료
  	  	  function print3(user) {
  	  	  	let temp = '';
  	  	  	temp += '<li style="margin-bottom:3px;">';
  	  	  	temp += "'" + user + "' 이(가) 종료했습니다." ;
  	  	  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
  	  	  	temp += '</li>';
  	  	  			
  	  	  	$('#list').append(temp);
  	  	  }
  	  	  $('#chat_submit_btn').click(function(){
  	  		  	console.log('입장확인');
  	  		  	let message = $('#msg').val();
  	  			let fileVal = $('#fileUpload').val();
  	  			
  	  			if(fileVal!=''){
  	  				sendFile();
  	  			}if(message!=''){
  	  				console.log(message);
  	  				send_text();
  	  			}  	  		
  	  	  		//printMe($('#msg').val()); //본인 대화창에
  	  	        $('#msg').val('');
  	  	    	preview_del();
  	  	  		$('#msg').focus();
  	  	  	}
  	  	  	);
  	  	  
  	  	  $('#msg').keydown(function() {
    	  	  	if (event.keyCode == 13) {	
      	  		  	console.log('입장확인');
      	  		  	let message = $('#msg').val();
      	  			let fileVal = $('#fileUpload').val();
      	  			
      	  			if(fileVal!=''){
      	  				sendFile();
      	  			}if(message!=''){
      	  				console.log(message);
      	  				send_text();
      	  			} 	  		
      	  	  		//printMe($('#msg').val()); //본인 대화창에
      	  	    	preview_del();
      	  	    	$('#msg').val('');
      	  	  		$('#msg').focus();
    	  	  	}
    	  });
  	  	  
  		  function send_text() {
	  		let option ={
	  			no : "2",
	  			type: "message",
	  			userName : user_name,
	  			msg :  $('#msg').val(),
	  			roomIndex : index
	  		}
	  		
	  		console.log(msg.value);
	  		ws.send(JSON.stringify(option));
	  		
  		  }
  		function sendFile(){
  			//let file = document.querySelector("#fileUpload").files[0];
  			let file = document.querySelector("#fileUpload").files[0];
  			let fileReader = new FileReader();
  			
  			fileReader.onload = function(e) {
  				let param = {
  					no : "2",
  					type: "fileUpload",
  					file: file.name,
  					roomIndex: index,
  					userName : user_name
  				}
  				ws.send(JSON.stringify(param)); //  보내기전 메시지를 보내서 파일을 보냄을 명시한다.
  			    rawData = e.target.result;
  			  	ws.send(rawData);
  				 //파일 소켓 전송
  			};
  			fileReader.readAsArrayBuffer(file);
  		}   	
  		};

  
  </script>

</body>
</html>