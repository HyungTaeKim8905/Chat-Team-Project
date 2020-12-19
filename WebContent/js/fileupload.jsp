<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
//수정
// 파일 체크

    

 function filecheck(frm){
        var maxfilesize = 5*1024*1024; //5MB 제한
        var filename = []; 
        var con = "다음 파일을 업로드합니다.\n";
        
        for(var i=0; i<frm.files.length; i++){
            //파일 개수 제한
            if(i>4){
                alert("파일은 5개까지만 업로드 가능합니다");
                //frm.outerHTML = frm.outerHTML;
                return false;
            }
            //파일 각각의 용량 제한
            var nowfilesize = frm.files[i].size;
            if(nowfilesize>maxfilesize){
                alert("파일의 용량은 5mb를 넘을 수 없습니다");
                //frm.outerHTML = frm.outerHTML;
                return false;
            }
            //확인창에 파일 이름 추가 
            con += "\n" + frm.files[i].name;
            //console.debug(frm.files[i]);                        
        }
        //파일 업로드 취소시 알림창 안뜨게
        if(frm.files.length>0){
        	//확인
	        if (confirm(con) == true){  
	        	
	        }else{   //취소
	            return;
	        }
	    }
        

	    //ajax로 파일 전송시 FormData객체 생성 후 form을 넣어줘야한다.
	    var filedata = document.getElementById("fileuploadform");    
	    var formData = new FormData(filedata);
		$.ajax({
			url:"fileuploadtest",
			type:"POST",
			enctype: "multipart/form-data",
			contentType : false,
			processData : false,
			data:formData+"&chatno="+chatno,
			success:function(result)	{
				var json = JSON.parse(result);
				if(json.length == 0)	{
					alert("받아온 제이슨 데이터가 0입니다.");
				}
			}
		});
	}

    
</script>
