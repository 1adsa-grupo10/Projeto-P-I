create database projeto_pi;
use projeto_pi;

create table cadastro_cliente(
	id_cliente int primary key auto_increment,
	nome_razaoSocial varchar(100) not null,
	cpf_cnpj varchar(20) not null,
    tipo char(2),
    check (tipo = 'PF' or tipo = 'PJ'),
    telefone_celular varchar(20) not null,
    telefone_fixo varchar(30)
)auto_increment=100;

create table usuario(
	id_usuario int auto_increment,
	nome varchar(100) not null,
	senha varchar(99) not null,
	email varchar(100) not null,
    fk_cliente int,
    foreign key(fk_cliente) references cadastro_cliente(id_cliente),
    primary key (id_usuario,fk_cliente)
)auto_increment=1000;

create table estufa(
	id_estufa int auto_increment,
    nome_estufa varchar(30),
    tipo_cultura varchar(40),
    fk_cliente int,
    foreign key(fk_cliente) references cadastro_cliente(id_cliente),
    primary key(id_estufa, fk_cliente)
);

create table sensor(
	id_sensor int auto_increment,
    status_sensor varchar(10) default 'ativo',
    check(status_sensor = 'ativo' or status_sensor = 'inativo' or status_sensor = 'manutencao'),
    fk_estufa int,
    foreign key(fk_estufa) references estufa(id_estufa),
    primary key(id_sensor,fk_estufa)
    ) auto_increment 10;
    
create table dados_sensor( 
	id_dados_sensor int auto_increment,
	registro_umidade decimal,
	registro_temp decimal,
	registro_hora datetime not null,
    fk_sensor int,
    foreign key(fk_sensor) references sensor(id_sensor),
    primary key(id_dados_sensor,fk_sensor)
);
select * from cadastro_cliente;
select * from dados_sensor;
select * from estufa;
select * from sensor;
select * from usuario;
select * from cadastro_cliente, usuario, estufa, sensor, dados_sensor;


-- Inserção de dados
insert into cadastro_pessoa_fisica values
(null,'Miguel Nunes','84726352635','12344321','miguelnunes1477@gmail.com', '1194435352'),
(null,'Felipe Higa','48475304893','736w4e44we35','fe.higa@gmail.com', '1197456463'),
(null,'Vitória Souza','42442960850','ff7r7fr7d','vitoria.souzasantos@hotmail.com', '1197745453'),
(null,'Victor Veniti','49797642828','sorvetedebaunilha','victorveniti@hotmail.com', '11955536932'),
(null,'Larissa Lima','40896711838','larilari.iê', 'larissaellima@hotmail.com', '11955332235'),
(null, 'Julia Mello', '42345670987', 'venus51', 'juliamello@hotmail.com', '119655323677');


-- Inserção de dados na tabela sensor_proto -- Miguel
insert into sensor (registro_umidade,registro_temp,registro_hora, local_sensor, status_sensor,fk_pessoa_fisica) values
('70%','25ºC','2020-9-15 19:16:53', 'EstufaA',101),
('80%','24ºC','2020-9-15 19:29:36', 'EstufaB',100),
('69%','24ºC','2020-9-15 18:21:23', 'EstufaC',102),
('77%','27ºC','2020-9-15 17:32:36','EstufaD',103),
('73%','26ºC','2020-9-15 16:11:41','EstufaE',104),
('85%','23ºC','2020-9-15 13:45:36','EstufaF',105);


-- select * from cadastro_usuario;
-- select * from sensor;
-- select * from cadastro_usuario, sensor where fk_usuario=id_usuario;
