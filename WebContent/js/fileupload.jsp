<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script>
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
</script>
