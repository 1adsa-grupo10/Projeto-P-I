create database ProjetoPI;
use ProjetoPI;

-- Criação do Usuario
create table cliente(
	idCliente int primary key auto_increment,
	tipoCliente char (2),
	nome_RazaoSocial varchar (100),
	cpf_cnpj varchar (14),
	telefoneFixo varchar (30),
	telefoneCelular varchar (20),
    check (tipoCliente =  "pf" or tipoCliente = "pj")
)auto_increment=100;

insert into cliente (tipoCliente, nome_RazaoSocial, cpf_cnpj, telefoneFixo, telefoneCelular) 
values ('pj', 'Miguel Nunes', '49882643951', '11949014122', '22991121'), 
('pf', 'Igor Silva', '49366863876', '11951539754', '20540538'),
('pj', 'Vitoria Souza', '49277844622', '11977254795', '20598765'),
('pf', 'Evelyn Paz', '77654488309', '1198764589', '22667639'),
('pj', 'Lucas Nascimento', '888322455290', '11988766542', '20887393');

select * from cliente;

-- Criando Usuario do Cliente
create table usuario(
	idUsuario int primary key auto_increment,
	nomeUsuario varchar (50),
	emailusuario varchar (100),
	senhaUsuario varchar (100),
	fkcliente int,
	foreign key (fkcliente) references cliente(idcliente)
) auto_increment = 1000;

insert into usuario (nomeUsuario, emailusuario, senhaUsuario, fkcliente)
values ('miguel', 'miguel@gmail.com', '123', 100),
('arnaldo', 'arnaldo@gmail.com', '333', 100),
('igor', 'igor@gmail.com', '0612', 101),
('vitoria', 'vitoria@gmail.com', '222', 102),
('natalia', 'natalia@gmail.com', '202', 102),
('juliana', 'juliana@gmail.com', '203', 102),
('evelyn', 'evelyn@gmail.com', '300', 103),
('lucas', 'lucas@gmail.com', '888', 104);

select * from usuario;

-- Filtrando os usuarios com seus repectivos clientes
select cliente.nome_RazaoSocial ,usuario.nomeUsuario
from usuario
inner join cliente on fkcliente = idcliente;

-- Criando Local Estufa
create table localEstufa (
	idLocalEstufa int primary key auto_increment,
	logradouroLocal varchar (50),
	cidadeLocal varchar (40),
	bairroLocal  varchar (30),
	cepLocal varchar (15),
	complementoLocal varchar (25),
	numeroLocal varchar (10),
	fkUsuario int,
	foreign key (fkusuario) references usuario(idusuario)
)auto_increment=5000;

insert into localEstufa (logradouroLocal, cidadeLocal, bairroLocal, cepLocal, complementoLocal, 
numeroLocal, fkUsuario) 
values ('Avenida Fracisco de Paula', 'São Paulo', 'Vila das Flores', '003222020', null, 
'01', 1000), ('Rua dos Matos', 'São Paulo', 'Vila dos Leão', '0905050022', 'Fazenda', 
'09', 1001), ('Rua Jabar', 'São Jose dos Campos', 'Jd Carlos', '992742421', 'Fazenda', 
'2B', 1002);

select * from localEstufa;

-- Filtrando Local da Estufa, Usuarios com seus respectivos Clientes
select localEstufa.*, usuario.nomeUsuario, cliente.*
from localEstufa
inner join usuario on fkUsuario = idusuario
inner join cliente on fkcliente = idcliente;


-- Criando Estufa
create table estufa (
	idEstufa int primary key auto_increment,
	tipoCultura varchar (30),
	temperaturaMaxima decimal (3,1),
	temperaturaMinima decimal (3,1),
	umidadeMaxima int,
	umidadeMinima int,
	fklocalEstufa int,
	foreign key (fklocalEstufa) references localEstufa(idLocalEstufa)
)auto_increment=8000;

insert into estufa (tipoCultura, temperaturaMaxima, temperaturaMinima, umidadeMaxima, 
umidadeMinima, fklocalEstufa) 
values  ('tomate', 25.1, 22.2, 70, 60, 5000) , 
('alface', 29.3, 20.1, 80, 50, 5001);

select * from estufa;

-- Filtrando a Estufa, local, usuario e seus respectivos clientes
select estufa.*, localEstufa.*, usuario.nomeUsuario, cliente.* from estufa
inner join localEstufa on fklocalEstufa = idLocalEstufa
inner join usuario on fkUsuario = idusuario
inner join cliente on fkcliente = idcliente;

-- Criando Sensor
create table sensor(
	idSensor int primary key auto_increment,
	statusSensor varchar (40),
	fkestufa int,
	foreign key (fkestufa) references estufa(idEstufa),
    check (statusSensor = "Ativo" or statusSensor = "Inativo" or statusSensor = "Em manutenção") 
)auto_increment=30000;

insert into sensor (statusSensor,fkestufa)
values ('Ativo', 8000), ('Ativo', 8001);

select * from sensor;

-- Filtransdo sensor com a estufa, local da estufa , usuarios e seus respectivos clientes
select sensor.*, estufa.*, localEstufa.*, usuario.nomeUsuario, cliente.*
from sensor
inner join estufa on fkestufa = idEstufa
inner join localEstufa on fklocalEstufa = idLocalEstufa
inner join usuario on fkUsuario = idusuario
inner join cliente on fkcliente = idcliente;

-- Criando Dados do Sensor
create table dadosSensor (
	idDadosSensor int primary key auto_increment,
	registroUmidade decimal (3,1),
	registroTemperatura decimal (3,1),
	fksensor int,
	foreign key (fksensor) references sensor(idSensor)
)auto_increment=1;

insert into dadosSensor (registroUmidade, registroTemperatura, fksensor)
values (66, 24, 30000), (60, 28, 30000), (55, 30, 30000), (65, 22, 30001), 
(54, 28, 30001), (55, 17, 30001);

select * from dadosSensor;

select dadosSensor.*, sensor.*, estufa.*, localEstufa.*, usuario.*, cliente.*
from dadosSensor
inner join sensor on fksensor = idSensor
inner join estufa on fkestufa = idEstufa
inner join localEstufa on fklocalEstufa = idLocalEstufa
inner join usuario on fkUsuario = idusuario
inner join cliente on fkcliente = idcliente;


-- Criando tabela de Acesso
create table acesso(
    fkUsuario int,
    foreign key (fkUsuario) references usuario(idusuario),
    fkEstufa int,
    foreign key (fkEstufa) references estufa(idestufa),
    cargo varchar(45)
);

insert into acesso (fkUsuario, fkEstufa, cargo)
values (1000, 8000, 'Gestor'), (1001, 8001, 'Fazendeiro');

select * from acesso;