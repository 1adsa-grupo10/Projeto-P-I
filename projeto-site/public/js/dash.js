var idSensor = sessionStorage.getItem('idSensor');
var tempMax = sessionStorage.getItem('tempMax');
var umiMax = sessionStorage.getItem('umiMax');
var tipoCultura = sessionStorage.getItem('tipoCultura');

temperaturaMaxima.innerHTML = `Temperatura Máxima: ${tempMax}`;
umidadeMaxima.innerHTML = `Umidade Máxima: ${umiMax}`;
tipoCulturaTitulo.innerHTML = tipoCultura;

let proximaAtualizacao;


function configurarGraficoTemperatura(){
    var configuracoesTemp = {
        responsive: true,
        animation: { duration: 500 },
        hoverMode: 'index',
        stacked: false,
        title:{
            display: true,
            text: 'Histórico recente de Temperatura',
        },
        scales: {
            yAxes: [{
                type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                display: true,
                position: 'left',
                id: 'y-temperatura',
            }],
        }
    };
    return configuracoesTemp;
}


function configurarGraficoUmidade(){
    var configuracoesUmi = {
        responsive: true,
        animation: { duration: 500 },
        hoverMode: 'index',
        stacked: false,
        title:{
            display: true,
            text: 'Histórico recente de Umidade',
        },
        scales: {
            yAxes: [{
                type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                display: true,
                position: 'left',
                id: 'y-umidade',
            }],
        }
    };
    return configuracoesUmi;
}

function addGraficoPagina(dadosTemp, dadosUmi, idSensor){

    Chart.defaults.global.defaultFontFamily = "Montserrat";
    var contentGrafico = document.getElementById("graficoChartTemperature").getContext("2d");
    contentGrafico.canvas.width = "100%";
    contentGrafico.canvas.height = "100%";


    var contentGraficoUmi = document.getElementById("graficoChartHumity").getContext("2d");
    contentGraficoUmi.canvas.width = "100%";
    contentGraficoUmi.canvas.height = "100%";

    window.graficoLinhaTemp = Chart.Line(contentGrafico, {
        data: dadosTemp,
        options: configurarGraficoTemperatura()
    })

    window.graficoLinhaUmi = Chart.Line(contentGraficoUmi, {
        data: dadosUmi,
        options: configurarGraficoUmidade()
    })
    setTimeout(() => atualizarGrafico(idSensor, dadosTemp, dadosUmi), 4000);
}


function retornarUltimosDados(idSensor){

    if (proximaAtualizacao!=undefined) {
        clearTimeout(proximaAtualizacao);
    }

    fetch(`/leituras/ultimas/${idSensor}`, { cache: 'no-store' }).then((response) =>{
        if(response.ok){
            response.json().then((resposta)=>{
                console.log(`Dados Recebidos: ${JSON.stringify(resposta)}`);
                resposta.reverse();

                var dadosTemp = {
                    labels: [],
                    datasets: [
                        {
                            yAxisID: 'y-temperatura',
                            label: 'Temperatura',
                            borderColor: window.chartColors.red,
                            backgroundColor: window.chartColors.red,
                            fill: false,
                            data: []
                        },
                    ]
                }

                var dadosUmi = {
                    labels: [],
                    datasets: [
                        {
                            yAxisID: 'y-umidade',
                            label: 'Umidade',
                            borderColor: window.chartColors.blue,
                            backgroundColor: window.chartColors.blue,
                            fill: false,
                            data: []
                        }
                    ]
                }

                for(var i = 0; i < resposta.length; i++){
                    var registro = resposta[i];
                    dadosTemp.labels.push(registro.momento_grafico);
                    dadosUmi.labels.push(registro.momento_grafico);
                    dadosTemp.datasets[0].data.push(registro.registroTemperatura);
                    dadosUmi.datasets[0].data.push(registro.registroUmidade);
                    currentUmitity.innerHTML = `${registro.registroUmidade}%`;
                    currentTemperature.innerHTML = `${registro.registroTemperatura}ºC`;
                }
                
                console.log(JSON.stringify(dadosTemp));
                console.log(JSON.stringify(dadosUmi));
                addGraficoPagina(dadosTemp, dadosUmi, idSensor);

            })
        }else{
            console.log('Nenhum Dado encontrado ou erro na API');
        }
    }).catch((error) =>{
        console.error(`Erro na obtenção dos graficos p/ sensor: ${error.message}`);
    });
}

function atualizarGrafico(idSensor, dadosTemp, dadosUmi){
    fetch(`/leituras/tempo-real/${idSensor}`, {cache: 'no-store'}).then((response) =>{
        console.log(`Estou tentando pegar idSensor = ${idSensor}`);
        if(response.ok){
            response.json().then((novoRegistro) =>{
                console.log(`Dados recebidos: ${JSON.stringify(novoRegistro)}`);
                console.log(`Dados Atuais do grafico Temperatura : ${dadosTemp}`);
                console.log(`Dados Atuais do grafico Umidade: ${dadosUmi}`);

                dadosTemp.labels.shift();
                dadosTemp.labels.push(novoRegistro.momento_grafico);
                dadosTemp.datasets[0].data.shift();
                dadosTemp.datasets[0].data.push(novoRegistro.registroTemperatura);

                dadosUmi.labels.shift();
                dadosUmi.labels.push(novoRegistro.momento_grafico);
                dadosUmi.datasets[0].data.shift();
                dadosUmi.datasets[0].data.push(novoRegistro.registroUmidade);

                currentUmitity.innerHTML = `${novoRegistro.registroUmidade}%`;
                currentTemperature.innerHTML = `${novoRegistro.registroTemperatura}ºC`;

                window.graficoLinhaTemp.update();
                window.graficoLinhaUmi.update();

                proximaAtualizacao = setTimeout(() => atualizarGrafico(idSensor, dadosTemp, dadosUmi), 4000);                

            })
        }else{
            console.error("Nenhum dado encontrado ou erro na API");
            proximaAtualizacao = setTimeout(() => atualizarGrafico(idSensor, dadosTemp, dadosUmi), 4000);
        }
    }).catch((error) =>{
        console.error(`Erro na obtenção dos dados p/ sensor ${error.message}`);
    });
}

function sendData() {
    var http = new XMLHttpRequest();
    http.open('GET', 'http://localhost:9000/api/sendData', false);
    http.send(null);
}

setInterval(() => {
    sendData();
}, 4000);

window.onload = retornarUltimosDados(idSensor);

/* retornarUltimosDados(1); */
/* http://localhost:3000/dashboard.html */