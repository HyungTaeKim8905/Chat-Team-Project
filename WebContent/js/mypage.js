			//사진 변경 버튼 클릭 후 사진을 변경하면 화면에 사진을 뿌려주는 함수.
			function readInputFile(input) {
				if(input.files && input.files[0]) { 	//파일이 선택된 상태라면
					var reader = new FileReader();		// 파일을 읽기 위해서 객체 생성
					reader.onload = function (e) {		// 파일을 읽어들이기를 성공했을때 호출되는 이벤트
						$("#imgfile").html("<img src='"+ event.target.result +"'>");	// event.target.result => 파일의 경로 + 이미지 이름
					}
					reader.readAsDataURL(input.files[0]);
				}
			}
			
			// 비밀번호 변경 버튼을 누르면 실행되는 함수.
			function PasswordChange()	{
				// chatlist.html?id=<%= id %> id를 파라미터로 붙인다.
				window.open("chatlist.html","비밀번호 변경","width=600px,height=400px");
			}
			
			// 회원탈퇴 버튼을 누르면 실행되는 함수.
			function Withdrawal()	{
				var check = confirm("정말 회원탈퇴를 하시겠습니까?");
				if(check == true)	{
					alert("확인 버튼 눌렀다.");
				}
				
				if(check == false)	{
					alert("취소 버튼 눌렀다.");
					return false;
				}
				
				alert("ajax 통신 한다 ?");
				$.ajax({
					url:"#",
					type:"POST", // data: "param1=aaaa&param2=zzzz,
					data:$("form").serialize(),		//data:"id=" + <%= id %>
					success:function(result)	{
						//회원탈퇴 처리 완료되면 무슨 페이지로 이동?
					}
				});
			}
			