let buttonBlack= document.querySelector(".buttonBlack");
let modelLogin= document.querySelector(".modelLogin")

buttonBlack.onclick=function (event) {
    event.preventDefault();
    console.log("폼 전송 막음");
    modelLogin.style.display = "flex";
}

modelLogin.onclick=function (event){
    event.preventDefault();
    console.log("모달 화면 닫음");
    modelLogin.style.display = "none";
}