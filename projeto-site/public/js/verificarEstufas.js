var id_usuario = sessionStorage.idUsuario;
    
fetch(`/estufas/estufas-usuario/${id_usuario}`).then(resposta =>{
    if(resposta.ok){
        resposta.json().then(json =>{
            /* alert("Foram encontrados "+json); */

            if(json.length > 0){

                document.querySelector(".nao-encontrado").style.display = "none";
                document.querySelector(".estufas").style.display = "flex";
                document.getElementById("title-contem").style.display = "block";
                document.getElementById("desc-contem").style.display = "block";
                document.getElementById("title-naoContem").style.display = "none";
                document.getElementById("desc-naoContem").style.display = "none";

                for(var contador = 0; contador < json.length; contador++){
                    
                    var divEstufas = document.querySelector(".estufas");

                    var itemEstufa = document.createElement("div");
                    itemEstufa.classList.add("item-estufas");

                    var imgEstufa = document.createElement("img");
                    imgEstufa.src = "imagens/greenhouse2.svg";

                    var tituloCultura = document.createElement("p");
                    tituloCultura.innerHTML = "Tipo Cultura:"

                    var tipoCultura = document.createElement("p");
                    tipoCultura.innerHTML = json[contador].tipoCultura;

                    itemEstufa.append(imgEstufa);
                    itemEstufa.append(tituloCultura);
                    itemEstufa.append(tipoCultura);
                    divEstufas.append(itemEstufa);

                }

            }else{

                document.querySelector(".nao-encontrado").style.display = "flex";
                document.querySelector(".estufas").style.display = "none";
                document.getElementById("title-naoContem").style.display = "block";
                document.getElementById("desc-naoContem").style.display = "block";
                document.getElementById("title-contem").style.display = "none";
                document.getElementById("desc-contem").style.display = "none";
                
            }

            console.log(json);
        })
    }else{
        console.log("Erro recuperar!");
        
        resposta.text().then(texto =>{
            console.error(texto);
        })
    }
});

function verificar(){
    editar_estufa.style.display = "block";
    excluir_estufa.style.display = "block";
}