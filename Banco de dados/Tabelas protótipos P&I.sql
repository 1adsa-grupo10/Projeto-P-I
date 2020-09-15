create database projeto_pi;
use database projeto_pi;

create table sensor_proto (
id_info_sensor int primary key auto_increment,
registro_umidade varchar(10),
registro_temp varchar(10),
registro_hora datetime not null,
id_usuario varchar(10)
);

-- sensor_umidade e sensor_temp são os nomes dos sensores 
-- registro_umidade e registro_temp são as entradas dos dados
-- registro_hora é a data em que o registro foi alterado/adicionado
-- id_usuario será uma foreign key da tabela cadastro


create table cadastro(
id_usuario int primary key auto_increment,
nome_completo varchar(100) not null,
cpf char(11) not null,
telefone_celular varchar(20) not null,
senha varchar(99) not null,
email varchar(100) not null
)auto_increment=100;

-- Inserção de dados-Miguel
insert into cadastro values
(null,'Miguel Nunes','84726352635','11949015124','12344321','miguelnunes1477@gmail.com'),
(null,'Felipe Higa','48475304893','11958115575','736w4e44we35','fe.higa@gmail.com'),
(null,'Vitória Souza','42442960850','11997327321','ff7r7fr7d','vitoria.souzasantos@hotmail.com'),
(null,'Victor Veniti','49797642828','11975285232','sorvetedebaunilha','victorveniti@hotmail.com');

-- Inserção de dados-Larissa 
insert into cadastro values
(null,'Larissa Lima','40896711838','11958859656','larilari.iê', 'larissaellima@hotmail.com');
select * from cadastro;

-- Inserção de dados-Vitória
insert into cadastro values
(null, 'Julia Mello', '42345670987', '11956732145', 'venus51', 'juliamello@hotmail.com');



