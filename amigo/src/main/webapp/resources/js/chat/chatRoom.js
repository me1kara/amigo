	const MESSAGE_ENTER = "enter";
	const MESSAGE_SEND = "send";
	const MESSAGE_EXIT = "exit";
	const MESSAGE_DELETE = "delete";
	$(document).ready(function(){
		$('#list').scrollTop($('#list').prop('scrollHeight'));
	});
		
	 /* 이미지 미리보기 로직, 파일을 올릴때 발생, readAsDataURL 사용 */
  	  function previewFile() {
		  var preview = $('#msgTd');
		  var file = document.querySelector('input[type=file]').files[0];
		  var reader = new FileReader();
		  reader.addEventListener(
		    'load',
		    function () {
		      $('#photo').hide();
		   	  $('#msg').val('').hide();
		      preview.prepend("<img src="+reader.result+" height='62px' class='preview_img_del' width='100%'/>");
		      preview.append("<button class='btn btn-danger preview_img_del' onclick='preview_del()'>이미지삭제</button>");
		      
		    },false
		  );
		
		  if (file) {
		    reader.readAsDataURL(file);
		  }
		}
	 	//이미지 미리보기 삭제, 다른 파일로 교체시에도 발동
		function preview_del(){
			$('.preview_img_del').remove();
			$('#msg').show();
			$('#photo').show();
			$('#fileUpload').val('');
		}
		
	 	/* 이미지 클릭시 팝업창, 새 윈도우창을 엶 */
  	 	function imgPop(url){
  		  var img=new Image();
  		  img.src=url;
  		  var img_width=img.width;
  		  var win_width=img.width+25;
  		  var img_height=img.height;
  		  
  		  var OpenWindow=window.open('','_blank', 'width='+img_width+', height='+img_height+', menubars=no, scrollbars=auto');
  		  OpenWindow.document.write("<style>body{margin:0px;}</style><img src='"+url+"' width='"+win_width+"'>");
  		 }
	 	
  		//1초 누르고있으면 chat_delete 메서드를 호출, 마우스를 떼버리면 초기화, 1초 눌렀을때 여부 판독하기 위해서 settimeout사용, 
	  	var timeOut = 0;
		function mouseDown(chat_no){
			timeOut = setTimeout(() => chat_delete(chat_no), 1000); 
  		}
		function mouseLeave(){
			clearTimeout(timeOut);
		}
  	    function chat_delete(chat_no){
	  		let option ={
		  			order : MESSAGE_DELETE,
		  			type: "message",
		  			chatNo : ""+chat_no+"",
		  			roomIndex : index
		  	}
	  		if (confirm("삭제하시겠습니까?")) {
	  			ws.send(JSON.stringify(option));
	  			$('#chat_no_'+chat_no).remove();
	  		}
		
	    }