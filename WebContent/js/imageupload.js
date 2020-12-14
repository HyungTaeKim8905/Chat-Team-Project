// 이미지 체크
    function imagecheck(frm){
        var maxfilesize = 5*1024*1024; //5MB 제한

        for(var i=0; i<frm.files.length; i++){

            //이미지 개수 제한
            if(i>4){
                alert("파일은 5개까지만 업로드 가능합니다");
                frm.outerHTML = frm.outerHTML;
                return false;
            }

            //이미지 용량 제한
            var nowfilesize = frm.files[i].size;
            if(nowfilesize>maxfilesize){
                alert("파일의 용량은 5mb를 넘을 수 없습니다");
                frm.outerHTML = frm.outerHTML;
            }

            //이미지 확장자 제한
            var filename = frm.files[i].name.split('.').pop().toLowerCase();
            if(filename!="jpg"&&filename!="gif"&&filename!="jpeg"&&filename!="png"&&filename!="bmp"){
                alert("사진만 업로드 가능합니다");
                frm.outerHTML = frm.outerHTML;
            }
        }
    }