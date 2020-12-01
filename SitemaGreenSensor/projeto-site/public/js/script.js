let btnAbrirModalEditar = document.getElementById("editar_estufa");
let btnFecharModalEditar = document.querySelector(".modal-editar");

btnAbrirModalEditar.addEventListener('click', ()=>{
    document.querySelector("body").style.background = "rgba(0, 0, 0, 0.50)";
    document.querySelector(".modal-editar").style.top = "0";
})

btnFecharModalEditar.addEventListener('click', ()=>{
    document.querySelector("body").style.background = "none";
    document.querySelector(".modal-editar").style.top = "-100%";
})

function verificar(){
    editar_estufa.style.display = "block";
    excluir_estufa.style.display = "block";
}

function dash(){
    window.href="dashboard.html";
}