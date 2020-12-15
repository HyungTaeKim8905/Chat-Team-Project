// 파일 체크
    function filecheck(frm){
        var maxfilesize = 5*1024*1024; //5MB 제한
        var filename = []; 
        var con = "다음 파일을 업로드합니다.\n\n"
        
        for(var i=0; i<frm.files.length; i++){
            //파일 개수 제한
            if(i>4){
                alert("파일은 5개까지만 업로드 가능합니다");
                frm.outerHTML = frm.outerHTML;
                return false;
            }
            //파일 용량 제한
            var nowfilesize = frm.files[i].size;
            if(nowfilesize>maxfilesize){
                alert("파일의 용량은 5mb를 넘을 수 없습니다");
                frm.outerHTML = frm.outerHTML;
                return false;
            }
            con += frm.files[i].name + "\n";
        }
        
        if (confirm(con) == true){    //확인
            //파일 업로드 나중에 추가
        }else{   //취소
            return;
        }
        
        function drop(event){
        	event.preventDefault();
        }

    }