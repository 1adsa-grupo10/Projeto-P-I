create database ProjetoPI;

use ProjetoPI;

create table cliente(
idCliente int primary key auto_increment,
tipoCliente char (2),
nome_RazaoSocial varchar (100),
cpf_cnpj varchar (14),
telefoneFixo varchar (30),
telefoneCelular varchar (20)
)auto_increment = 100;

select * from cliente;

create table Usuario(
idUsuario int primary key auto_increment,
nomeUsuario varchar (50),
emailusuario varchar (100),
senhaUsuario varchar (100),
fkcliente int,
foreign key (fkcliente) references cliente(idcliente)
) auto_increment = 1000;

select * from Usuario;

create table LocalEstufa (
idLocalEstufa int ,
logradouroLocal varchar (50),
cidadeLocal varchar (40),
bairroLocal  varchar (30),
cepLocal varchar (15),
complementoLocal varchar (25),
numeroLocal varchar (10),
fkcliente int,
foreign key (fkcliente) references cliente(idcliente),
primary key (idLocalEstufa, fkcliente));

select * from LocalEstufa;

create table Estufa (
idEstufa int,
tipoCultura varchar (30),
temperaturaMaxima decimal (3,1),
temperaturaMinima decimal (3,1),
umidadeMaxima int,
umidadeMinima int,
fklocalEstufa int,
fkcliente int,
foreign key (fklocalEstufa) references LocalEstufa(idLocalEstufa),
foreign key (fkcliente) references cliente(idCliente),
primary key (idEstufa, fklocalEstufa, fkcliente));

select * from Estufa;

create table Sensor(
idSensor int,
statusSensor varchar (40),
fkestufa int,
fklocalEstufa int,
fkcliente int,
foreign key (fkestufa) references estufa(idEstufa),
foreign key (fklocalEstufa) references LocalEstufa(idLocalEstufa),
foreign key (fkcliente) references cliente(idCliente),
primary key (idSensor, fkestufa, fklocalEstufa, fkcliente));

select * from Sensor;

create table dadosSensor (
idDadosSensor int,
registroUmidade decimal (3,1),
registroTemperatura decimal (3,1),
fksensor int,
foreign key (fksensor) references Sensor(idSensor),
primary key (idDadosSensor, fksensor));

select * from dadosSensor;