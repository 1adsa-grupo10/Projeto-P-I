create database ProjetoPI;

use ProjetoPI;

create table cliente(
idCliente int primary key auto_increment,
tipoCliente char (2),
check (tipoCliente = 'pf' or tipoCliente = 'pj'),
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
idLocalEstufa int primary key auto_increment,
logradouroLocal varchar (50),
cidadeLocal varchar (40),
bairroLocal  varchar (30),
cepLocal varchar (15),
complementoLocal varchar (25),
numeroLocal varchar (10),
fkUsuario int,
foreign key (fkusuario) references usuario(idusuario)
);

select * from LocalEstufa;

create table Estufa (
idEstufa int primary key auto_increment,
tipoCultura varchar (30),
temperaturaMaxima decimal (3,1),
temperaturaMinima decimal (3,1),
umidadeMaxima int,
umidadeMinima int,
fklocalEstufa int,
foreign key (fklocalEstufa) references LocalEstufa(idLocalEstufa)
);

select * from Estufa;

create table Sensor(
idSensor int primary key auto_increment,
statusSensor varchar (40),
check(statusSensor = 'Ativo' or statusSensor = 'Inativo' or statusSensor = 'Em manutenção'),
fkestufa int,
foreign key (fkestufa) references estufa(idEstufa)
);

select * from Sensor;

create table dadosSensor (
idDadosSensor int primary key auto_increment,
registroUmidade decimal (3,1),
registroTemperatura decimal (3,1),
fksensor int,
foreign key (fksensor) references Sensor(idSensor)
);

select * from dadosSensor;

create table acesso(
	fkUsuario int,
    foreign key (fkUsuario) references usuario(idusuario),
    fkestufa int,
    foreign key (fkestufa) references estufa(idestufa),
    cargo varchar(45)
);
select * from cliente;

















