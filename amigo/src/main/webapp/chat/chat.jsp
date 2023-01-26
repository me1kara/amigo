<%@page import="com.lec.amigo.vo.ChatRoom"%>
<%@page import="org.springframework.web.servlet.tags.Param"%>
<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="java.util.List"%>
<%@page import="com.lec.amigo.dao.ChatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

<% 
	int index=Integer.parseInt(request.getParameter("index"));
	String name = request.getParameter("name");
	
	ChatRoom chatroom = new ChatRoom();
	
	int user_no = Integer.parseInt(request.getParameter("user_no")); 
			
	chatroom.setChat_index(index);
	chatroom.setUser_no(user_no);		
	
	System.out.println("유놈"+user_no + index);
	
	session.setAttribute("chatRoom", chatroom);
	
/*
	if((int)request.getAttribute("idCheck")>0){
		index = (int)request.getAttribute("idCheck");
	     System.out.println(index+"로그인성공!");
	     
	}else{
		System.out.println(index+"로그인실패!");
	}
*/
	
		
	ChatDAO dao = new ChatDAO();
	
	
%>


<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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

</head>
<body>
	


	<div class="container">
		<h1 class="page-header">Chat</h1>		
	
		<table class="table table-bordered">
		<tr>
			<td><input type="text" name="user" id="user" class="form-control" placeholder="유저명" required="required"></td>
			
			<td>
				<button type="button" class="btn btn-default" id="btnConnect">연결</button>
				<button type="button" class="btn btn-default" id="btnDisconnect" disabled>종료</button>
			</td>
		</tr>
		<tr>
		
		

			<td colspan="2"><div id="list">
					
					
					<c:forEach var="chat" items="<%= dao.getChatList(index)%>">			
					<div style="margin-bottom:3px;">
					[${chat.getUser() }] ${chat.getContent()} 
					<span style="font-size:11px;color:#777;">
					${chat.getDate() }
					</span>
					</div>
					</c:forEach>	
					 
			</div></td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="msg" id="msg" placeholder="대화 내용을 입력하세요." class="form-control" disabled></td>
			
		</tr>
		</table>
		
	</div>
	<script>
//채팅 서버 주소
<<<<<<< HEAD
  var url = "ws://localhost:8088/amigo/chatHandler.do?<%=index%>";
  var index = "<%=index%>";
=======
  var url = "ws://localhost:8088/amigo/chatHandler.do";
  let index = "<%=index%>";
>>>>>>> e77bbd4558ffe14921e3ceb90c3f41e30343f44f
  // 웹 소켓
  var ws;
	
  // 연결하기
  $('#btnConnect').click(function connect() {
	  
  	// 유저명 확인
     	if ($('#user').val().trim() != '') {
     		// 연결 	
  	   	ws = new WebSocket(url);
   
  	   	// 소켓 이벤트 매핑
  	   	ws.onopen = function () {
  	   		console.log('서버 연결 성공');
  	   		//print($('#user').val(), '입장했습니다.');
  			
  	   		// 현재 사용자가 입장했다고 서버에게 통지(유저명 전달)
  	   		// -> 1#유저명
  			ws.send('1#' + $('#user').val() + '#' + index); //이게 서버에 msg로 가는모양인가보다
  			$('#user').attr('readonly', true);
  			$('#btnConnect').attr('disabled', true);
  			$('#btnDisconnect').attr('disabled', false);
  			$('#msg').attr('disabled', false); //디스에이블 풀어주는 용도
  			$('#msg').focus();
<<<<<<< HEAD
  			
  			ws.onmessage = function (evt) {
  			  	console.log(evt.data);
  			  	
  			  	if(typeof evt.data == "string"){
  	  			let msg = evt.data;
  	  			var jd = JSON.parse(msg);
  	  			
  	  			console.log(jd);
  	  			
  	  			let jdl = Object.keys(jd);
  	  			
  	  			let no;
  	  			let user;
  	  			let txt;
  	  			let roomIndex;
  	  			let chat_no;
  	  			
  	  			
  	  			if(jd.no=="4"){
  	  				let delete_no = jd.chatNo;	
  	  				roomIndex = jd.roomIndex;			
  	  				console.log(index+":"+roomIndex);
  			
  	  				if(parseInt(roomIndex)==index){
  	  					console.log('여기 들어와짐?'+delete_no);
  	  					$('.chat_no_'+delete_no).remove();
	  				}
  	  					
  	  			}else if(jd.no=="1"){
  	  			    no = jd.no;
  	  			    user = jd.userName;
  	  			    roomIndex = jd.index;
  	  			}else if(jd.no=="2"){
  	  				no = jd.no;
  	  				user = jd.userName;
  	  				txt = jd.msg;
  	  				roomIndex = jd.roomIndex;
  	  				chat_no = jd.chatNo;
  	  			}
  	  			
  	  			console.log('인덱스:'+index+'룸인덱스:'+roomIndex);		
  	  			if (no == '1') {
  	  				if(parseInt(roomIndex)==index){
  	  					print2(user);
  	  				}
  	  			} else if (no == '2') {
  	  				if(parseInt(roomIndex)==index){
  	  					
  	  					if(user=='<%=user.getUser_nick()%>'){
  	  				
  	  						printMe(txt, chat_no);
  	  					}else{
  	  						print(user, txt, chat_no);
  	  						
  	  					}
  	  					
  	  				}
  	  			} else if (no == '3') {
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
  	  	  // 메세지 전송 및 아이디
  	  	  function print(user, txt, chat_no) {
  	  	  	let temp = '';
  	  	
  	  	  	temp += '<li style="margin-bottom:3px; clear: both;" class="chat_no_'+chat_no+'">';
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
    	  	  	temp += '<li style="margin-bottom:3px; float:right;" class="chat_no_'+chat_no+'">';
    	  	  	temp += '<span>'+txt+'</span>';
    	  	  	temp += '</li>';
    	  	  	temp += '<li class="chat_option_item chat_no_'+chat_no+'">';
    	  	  	temp += '<button onclick="chat_delete('+chat_no+')">삭제</button>';
    	  	  	temp += '</li>';
    	  	  
    	  	  			
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
	  	  		console.log($(this));
	  	  		send_text();
  	  	  		//printMe($('#msg').val()); //본인 대화창에
  	  	        $('#msg').val('');
  	  	  		$('#msg').focus();
  	  	  	}
  	  	  	);
  	  	  $('#msg').keydown(function() {
  	  	  	if (event.keyCode == 13) {	
  	  	  		//서버에게 메시지 전달
  	  	  		//2#유저명#메시지	  		
  	  	  		console.log($(this));
  	  	  		//ws.send('2#' + user_name + '#' + $(this).val() + '#'+index); //서버에게	  		
  	  	  		send_text();
  	  	  		//printMe($(this).val()); //본인 대화창에
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
	  		ws.send(JSON.stringify(option));
	  		
  		  }
  		$('#sendFileBtn').click(function(){
  			var file = document.querySelector("#fileUpload").files[0];
  			var fileReader = new FileReader();
  			
  			fileReader.onload = function(e) {
  				let param = {
  					no : "2",
  					type: "fileUpload",
  					file: file.name,
  					roomIndex: index,
  					userName : user_name
  				}
  				console.log(param);
  				ws.send(JSON.stringify(param)); //파일 보내기전 메시지를 보내서 파일을 보냄을 명시한다.
  			    rawData = e.target.result;
  			  	setTimeout(() => ws.send(rawData), 500);
  				 //파일 소켓 전송
  			};
  			fileReader.readAsArrayBuffer(file);
  		}
  		)
  	    	
=======
>>>>>>> e77bbd4558ffe14921e3ceb90c3f41e30343f44f
  		};
          
  		ws.onmessage = function (evt) {
  			// print('', evt.data);
  			
		  	console.log(evt.data);	
  			let index = evt.data.indexOf("#", 2);
  			let no = evt.data.substring(0, 1); 
  			let user = evt.data.substring(2, index);
  			let txt = evt.data.substring(index + 1);
  	   				
  			if (no == '1') {
  				print2(user);
  			} else if (no == '2') {
  				print(user, txt);
  			} else if (no == '3') {
  				print3(user);
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
  	} else {
  		alert('유저명을 입력하세요.');
  		$('#user').focus();
  	}
  });

  // 메세지 전송 및 아이디
  function print(user, txt) {
  	let temp = '';
  	temp += '<div style="margin-bottom:3px;">';
  	temp += '[' + user + '] ';
  	temp += txt;
  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
  	temp += '</div>';
  			
  	$('#list').append(temp);
  	$('#list').scrollTop($('#list').prop('scrollHeight'));
  }
  		
  // 다른 client 접속		
  function print2(user) {
  	let temp = '';
  	temp += '<div style="margin-bottom:3px;">';
  	temp += "'" + user + "' 이(가) 접속했습니다." ;
  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
  	temp += '</div>';
  	$('#list').append(temp);
  }

  // client 접속 종료
  function print3(user) {
  	let temp = '';
  	temp += '<div style="margin-bottom:3px;">';
  	temp += "'" + user + "' 이(가) 종료했습니다." ;
  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
  	temp += '</div>';
  			
  	$('#list').append(temp);
  }

  $('#user').keydown(function() {
  	if (event.keyCode == 13) {
  		$('#btnConnect').click();
  	}
  });
  		
  		
  		
  $('#msg').keydown(function() {
  	if (event.keyCode == 13) {	
  		//서버에게 메시지 전달
  		//2#유저명#메시지
  		
  		console.log($(this));
  		
  		ws.send('2#' + $('#user').val() + '#' + $(this).val() + '#'+index); //서버에게
  		
  		print($('#user').val(), $(this).val()); //본인 대화창에
  		
         $('#msg').val('');
  		$('#msg').focus();
  				
  	}
  });
  		
  $('#btnDisconnect').click(function() {
  	ws.send('3#' + $('#user').val() + '#');
  	ws.close();
  			
  	$('#user').attr('readonly', false);
      $('#user').val('');
  			
  	$('#btnConnect').attr('disabled', false);
  	$('#btnDisconnect').attr('disabled', true);
  			
  	$('#msg').val('');
  	$('#msg').attr('disabled', true);
  });
  
  </script>
</body>
</html>