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





