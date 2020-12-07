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