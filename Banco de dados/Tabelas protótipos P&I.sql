create database projeto_pi;
use projeto_pi;

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

	-- Alterações - Felipe
-- Renomeação do campo id_usuario da tabela sensor_proto
alter table sensor_proto rename column id_usuario to fkUsuario;

-- Modificação de campo da tabela sensor_proto para chave estrangeira
alter table sensor_proto modify column fkUsuario int;
alter table sensor_proto add foreign key (fkUsuario) references cadastro(id_usuario);

-- Verificação das atualizações da coluna fkUsuario
desc sensor_proto;

-- Inserção de dados na tabela sensor_proto
insert into sensor_proto (registro_umidade,registro_temp,registro_hora, fkUsuario) values
('70%','25ºC','2020-9-15 19:16:53',101),
('80%','24ºC','2020-9-15 19:29:36',100);

-- Verificação do cruzamendo de dados entre as tabelas sensor_proto e castro
Select * from cadastro, sensor_proto where fkUsuario=id_usuario;

-- Inserção de dados na tabela sensor_proto -- Miguel
insert into sensor_proto (registro_umidade,registro_temp,registro_hora, fkUsuario) values
('69%','24ºC','2020-9-15 18:21:23',102),
('77%','27ºC','2020-9-15 17:32:36',103),
('73%','26ºC','2020-9-15 16:11:41',104),
('85%','23ºC','2020-9-15 13:45:36',105);

-- Verificação do cruzamendo de dados entre as tabelas sensor_proto e castro -- Miguel
Select * from cadastro, sensor_proto where fkUsuario=id_usuario;


 

