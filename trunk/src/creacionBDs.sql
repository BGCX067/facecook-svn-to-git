DROP TABLE if exists RECETA;

CREATE TABLE RECETA (
OID varchar(50) NOT NULL,
recetaOID varchar(50) NOT NULL,
menuOID varchar(50) NOT NULL,
usuarioOID varchar(50) NOT NULL, 
nombre varchar(50) NOT NULL,
descripcion varchar(250),
formato varchar(50),
visibilidad boolean,

  
PRIMARY KEY(OID));



DROP TABLE if exists USUARIO;

CREATE TABLE USUARIO (
  OID varchar(50) NOT NULL,
RegistroOID varchar(50) NOT NULL,  
PRIMARY KEY(OID));

DROP TABLE if exists MENU;

CREATE TABLE MENU (
  OID varchar(50) NOT NULL,
recetaOID varchar(50) NOT NULL,
menuOID varchar(50) NOT NULL, 
usuarioOID varchar(50) NOT NULL,
nombre varchar(50),
diario boolean,
PRIMARY KEY(OID));

DROP TABLE if exists USUARIO;

CREATE TABLE USUARIO (
 OID varchar(50) NOT NULL,
 menuOID varchar(50) NOT NULL, 
 usuarioOID varchar(50) NOT NULL,
registroOID varchar(50) NOT NULL,
login varchar(50),
password varchar(50),
degustacionOID varchar(50) NOT NULL,
PRIMARY KEY(OID));

DROP TABLE if exists REGISTRO;

CREATE TABLE REGISTRO (
  OID varchar(50) NOT NULL,
  interesOID varchar(50) NOT NULL,
  registroOID varchar(50) NOT NULL,
nombre varchar(50),
apellidos varchar(50),
dni varchar(50) NOT NULL,
telefono int,
email varchar(50),
PRIMARY KEY(OID));

DROP TABLE if exists DEGUSTACION;

CREATE TABLE DEGUSTACION (
  OID varchar(50) NOT NULL,
  usarioOID varchar(50) NOT NULL,
  degustacionOID varchar(50) NOT NULL,
nombre varchar(50),
lugar varchar(50),
fecha date,
hora int,
descripcion varchar(250),
PRIMARY KEY(OID));

DROP TABLE if exists INTERESES;

CREATE TABLE INTERESES (
  OID varchar(50) NOT NULL,
  registroOID  varchar(50) NOT NULL,
  interesOID varchar(50) NOT NULL,

PRIMARY KEY(OID));