function atualizacaoPeriodica() {
    obterdadosporsensor(30000);
    obterdadosporsensor(30002);
    setTimeout(atualizacaoPeriodica, 2000);
}

function obterdadosporsensor(idSensor) {
    //aguardar();
    fetch(`/leituras/tempo-real/${idSensor}`)
        .then(resposta => {

            if (resposta.ok) {
                resposta.json().then(function (resposta) {

                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);

                    // aqui, após registro. use os nomes 
                    // dos atributos que vem no JSON 
                    var dados = {
                        temperatura: resposta.registroTemperatura,
                        umidade: resposta.registroUmidade
                    }

                    alertar(resposta.registroTemperatura, resposta.registroUmidade, idSensor);
                    atualizarTela(dados, idSensor);
                });
            } else {

                console.error('Nenhum dado encontrado ou erro na API');
            }
        })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados do sensor p/ gráfico: ${error.message}`);
        });
}

function alertar(temperatura, umidade, idSensor) {
    // padrão para meu alerta

    var tempsTomate = {
        tempMin: 12,
        tempMax: 35,
        umiMin: 42,
        umiMax: 78
    }

    var tempsAlface = {
        tempMin: 15,
        tempMax: 33,
        umiMin: 55,
        umiMax: 80
    }

    // zerar aviso de mensagem
    var mensagem_temperatura = '';
    var mensagem_umidade = '';
    
    // escolhendo qual alterar

    if (idSensor == 30000) { 
        
        /* Estufa de Tomate */

        div_alerta_temperatura.innerHTML = '';
        div_alerta_umidade.innerHTML = '';

        if (temperatura > tempsTomate.tempMax) {
            mensagem_temperatura = 'Temperatura do Tomate alta demais! <br>';
            div_alerta_temperatura.innerHTML = mensagem_temperatura;
        }
        if (temperatura < tempsTomate.tempMin) {
            mensagem_temperatura = 'Temperatura do Tomate baixa demais! <br>';
            div_alerta_temperatura.innerHTML = mensagem_temperatura;
        }
        if (umidade > tempsTomate.umiMax) {
            mensagem_umidade = 'Umidade do Tomate alta demais! <br>';
            div_alerta_umidade.innerHTML = mensagem_umidade;
        }
        if (umidade < tempsTomate.umiMin) {
            mensagem_umidade = 'Umidade do Tomate baixa demais! <br>';
            div_alerta_umidade.innerHTML = mensagem_umidade;
        }

    } else if (idSensor == 30002) { 
        /* Estufa de Alface */

        div_alerta_temperatura2.innerHTML = '';
        div_alerta_umidade2.innerHTML = '';

        if(temperatura > tempsAlface.tempMax){
            mensagem_temperatura = 'Temperatura do Alface alta demais! <br>';
            div_alerta_temperatura2.innerHTML = mensagem_temperatura
        }
        if(temperatura < tempsAlface.tempMin){
            mensagem_temperatura = 'Temperatura do Alface baixa demais! <br>';
            div_alerta_temperatura2.innerHTML = mensagem_temperatura
        }
        if(umidade > tempsAlface.umiMax){
            mensagem_umidade = 'Umidade do Alface alta demais! <br>';
            div_alerta_umidade2.innerHTML = mensagem_umidade
        }
        if(umidade < tempsAlface.umiMin){
            mensagem_umidade = 'Umidade do Alface Baixa demais! <br>';
            div_alerta_umidade2.innerHTML = mensagem_umidade
        }

    } 
}

function atualizarTela(dados, idSensor) {
    console.log('iniciando atualização da tela...');

    // escolhendo qual alterar
    var div_temperatura_alterar
    var div_umidade_alterar

    if (idSensor == 30000) {
        div_temperatura_alterar = div_temperatura
        div_umidade_alterar = div_umidade
    } else if (idSensor == 30002) {
        div_temperatura_alterar = div_temperatura2
        div_umidade_alterar = div_umidade2
    }

    div_temperatura_alterar.innerHTML = `Temperatura: ${dados.temperatura}º`;

    div_umidade_alterar.innerHTML = `Umidade: ${dados.umidade}%`;



}

function sendData() {
        var http = new XMLHttpRequest();
        http.open('GET', 'http://localhost:9000/api/sendData', false);
        http.send(null);
    }

setInterval(() => {
    sendData();
}, 2000);

window.onload = atualizacaoPeriodica;