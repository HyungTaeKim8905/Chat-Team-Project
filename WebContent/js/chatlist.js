    /* 유저가 버튼을 클릭했을 때
    드롭다운의 컨텐츠가 숨김, 보임 상태를 번갈아 보인다 */
    function searchfn() {
      document.getElementById("searchfm").classList.toggle("show");
      document.getElementById("friendfm").classList.remove("show");
    }
    function friendfn() {
      document.getElementById("friendfm").classList.toggle("show");
      document.getElementById("searchfm").classList.remove("show");
    }
    
    
    /////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  		function submit(){
  			var fromID = '<%=userID%>';
			var toID = '<%=toID%>';
			var inputmessage = $("#inputmessage").val();
			alert(inputmessage);
			$.ajax({
				url:"ChatSubmit",
				type:"POST",
				data:{
					fromID:encodeURIComponent(fromID),
					toID:encodeURIComponent(toID),
					content:encodeURIComponent(inputmessage)
				},
				success:function(result){
					if(result == 1){
						alert("메세지를 보냈다.");
					} else if(result == 0){
						alert("오류");
					} else{
						alert("오류");
					}
				}
			});
			$('#inputmessage').val('');
		}