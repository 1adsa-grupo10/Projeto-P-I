create database projeto_pi;
use projeto_pi;

create table cadastro_usuario(
	id_usuario int primary key auto_increment,
	nome_completo varchar(100) not null,
	cpf char(11) not null,
	senha varchar(99) not null,
	email varchar(100) not null,
    telefone_celular varchar(20) not null,
    telefone_fixo varchar(30),
    cpnj char(18)
)auto_increment=100;

create table sensor( 
	id_sensor int primary key auto_increment,
	registro_umidade decimal,
	registro_temp decimal,
	registro_hora datetime not null,
    local_sensor varchar(30),
    status_sensor varchar(30) default 'Inativo',
    check (status_sensor = 'Ativo' or status_sensor = 'Inativo' or status_sensor = 'Manutenção'),
	fk_usuario int,
    foreign key (fkusuario) references cadastroUsuario(id_usuario)
);

-- Inserção de dados
insert into cadastro_usuario values
(null,'Miguel Nunes','84726352635','12344321','miguelnunes1477@gmail.com', '1194435352'),
(null,'Felipe Higa','48475304893','736w4e44we35','fe.higa@gmail.com', '1197456463'),
(null,'Vitória Souza','42442960850','ff7r7fr7d','vitoria.souzasantos@hotmail.com', '1197745453'),
(null,'Victor Veniti','49797642828','sorvetedebaunilha','victorveniti@hotmail.com', '11955536932'),
(null,'Larissa Lima','40896711838','larilari.iê', 'larissaellima@hotmail.com', '11955332235'),
(null, 'Julia Mello', '42345670987', 'venus51', 'juliamello@hotmail.com', '119655323677');


-- Inserção de dados na tabela sensor_proto -- Miguel
insert into sensor (registro_umidade,registro_temp,registro_hora, local_sensor, status_sensor,fk_usuario) values
('70%','25ºC','2020-9-15 19:16:53', 'EstufaA',101),
('80%','24ºC','2020-9-15 19:29:36', 'EstufaB',100),
('69%','24ºC','2020-9-15 18:21:23', 'EstufaC',102),
('77%','27ºC','2020-9-15 17:32:36','EstufaD',103),
('73%','26ºC','2020-9-15 16:11:41','EstufaE',104),
('85%','23ºC','2020-9-15 13:45:36','EstufaF',105);


select * from cadastro_usuario;
select * from sensor;
select * from cadastro_usuario, sensor where fk_usuario=id_usuario;
