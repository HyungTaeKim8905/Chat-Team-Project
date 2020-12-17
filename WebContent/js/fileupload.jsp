<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
//수정
// 파일 체크

    function filecheck(frm){
        var maxfilesize = 5*1024*1024; //5MB 제한
        var filename = []; 
        var con = "다음 파일을 업로드합니다.\n"
        
        for(var i=0; i<frm.files.length; i++){
            //파일 개수 제한
            if(i>4){
                alert("파일은 5개까지만 업로드 가능합니다");
                frm.outerHTML = frm.outerHTML;
                return false;
            }
            //파일 각각의 용량 제한
            var nowfilesize = frm.files[i].size;
            if(nowfilesize>maxfilesize){
                alert("파일의 용량은 5mb를 넘을 수 없습니다");
                frm.outerHTML = frm.outerHTML;
                return false;
            }
            //확인창에 파일 이름 추가 
            con += "\n" + frm.files[i].name ;
        }
        //파일 업로드 취소시 알림창 안뜨게
        if(frm.files.length>0){
        	//확인
	        if (confirm(con) == true){  
	        	//파일 업로드 실제 구현 구간
	        	var sendsize = 1024;
	        	var pos = 0;
				for(var i=0; i<frm.files.length; i++){
					$.ajax({
						type : 'POST',
						dataType : 'json',
						data : {
						filename : frm.files[i].name,
						filelength : frm.files[i].length,
						},
						url : '/Upload',
						success : function(data) {
						// 전체가 전송될 때까지
						if (pos < filelength) {
						// 재귀
						setTimeout(upload, 1);
						}
						pos = pos + sendsize;
						if (pos > filelength) {
						pos = filelength;
						}
						},
						error : function(jqXHR, textStatus, errorThrown) {
						},
						complete : function(jqXHR, textStatus) {
						}
						});
				}
	        }else{   //취소
	            return;
	        }
	    }
    }
    /*
    var form = new FormData($("#fileuld")[0]);
    form.append("fileupload", form);
    var data = new FormData(form);	//ajax로 파일 전송시 FormData객체 생성 후 form을 넣어줘야한다.
	$.ajax({
		url:"fileupload",
		type:"POST", // data: "param1=aaaa&param2=zzzz,
		enctype: "multipart/form-data",
		contentType : false,
		processData : false,
		data:data,	
		success:function(result)	{
			var json = JSON.parse(result);
			if(json.length == 0)	{
				alert("받아온 제이슨 데이터가 0입니다.");
			}
		}
	});*/
    //첫번째 ajax 성공하면 배열로 파일이름 받아오고 그다음 함수를 실행시켜 ajax 실행
    //그 후 통신 성공하면 배열로 파일이름을 받아오고 다시 함수 실행..... 반복
    //마지막 filecheck2() 함수에서 출력시켜줌.

    
</script>
