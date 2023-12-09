-- Iniciar en consola Mysql
mysql - u peter - p / / peter es mi usuario -- # Creacion DB
create database pm_solemne_1;

--  Seleccion DB
use pm_solemne_1;

-- # crear tabla cliente
CREATE TABLE
    cliente (
        id_cliente int auto_increment not null PRIMARY KEY,
        rut varchar(10) unique not null,
        nombre varchar(30) not null,
        apellido varchar(30) not null,
        direccion varchar(100) not null,
        telefono varchar(30) not null,
        correo varchar(50) not null,
        sexo ENUM ('M', 'F'),
    );

-- # tabla previsión
CREATE TABLE
    prevision (
        id_prevision int auto_increment not null PRIMARY KEY,
        nombre_prevision varchar(50) not null,
        id_cliente int,
        index (id_cliente),
        FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) on update cascade on delete cascade
    ) ENGINE = INNODB
    -- #tabla cuenta
CREATE TABLE
    cuenta (
        id_cuenta int auto_increment not null PRIMARY KEY,
        numero_cuenta int not null,
        id_cl int,
        index (id_cl),
        FOREIGN KEY (id_cl) REFERENCES cliente (id_cliente) on update cascade on delete cascade
    ) ENGINE = INNODB;

-- #tabla tipo_cuenta
CREATE TABLE
    tipo_cuenta (
        id_tipo int auto_increment not null PRIMARY KEY,
        tipo varchar(20) not null,
        interes int not null,
        saldo int not null,
        id_cuenta int,
        index (id_cuenta),
        FOREIGN KEY (id_cuenta) REFERENCES cuenta (id_cuenta) on update cascade on delete cascade
    ) ENGINE = INNODB;

-- #tabla medico
CREATE TABLE
    medico (
        id_med int auto_increment not null PRIMARY KEY,
        nombre_med varchar(50) not null,
        apellido varchar(50) not null,
        direccion varchar(100) not null,
        telefono varchar(30) not null,
        correo varchar(30) not null
    );

-- #tabla pais
CREATE TABLE
    pais (
        id_pais int auto_increment not null PRIMARY KEY,
        nombre varchar(30) not null
    );

-- #tabla region
CREATE TABLE
    region (
        id_region int auto_increment not null PRIMARY KEY,
        nombre_region varchar(30) not null,
        id_pais int,
        index (id_pais),
        FOREIGN KEY (id_pais) REFERENCES pais (id_pais) on update cascade on delete cascade
    ) ENGINE = INNODB;

--  #tabla sucursal
CREATE TABLE
    sucursal (
        id_sucursal int auto_increment not null PRIMARY KEY,
        nombre_sucursal varchar(50) not null,
        direccion varchar(100) not null,
        telefono varchar(30) not null,
        rut varchar(10) not null,
        id_cliente int,
        index (id_cliente),
        FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) on update cascade on delete cascade
    ) ENGINE = INNODB;

-- #tabla comuna
CREATE TABLE
    comuna (
        id_comuna int auto_increment not null PRIMARY KEY,
        nombre_comuna varchar(30) not null,
        id_region int,
        index (id_region),
        FOREIGN KEY (id_region) REFERENCES region (id_region) on update cascade on delete cascade,
        id_sucursal int,
        index (id_sucursal),
        FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal) on update cascade on delete cascade
    ) ENGINE = INNODB;

-- #tabla especialidad
CREATE TABLE
    especialidad (
        id_especialidad int auto_increment not null PRIMARY KEY,
        nombre_especialidad varchar(50) not null,
        id_sucursal int,
        FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal) on update cascade on delete cascade,
        id_med int,
        index (id_med),
        FOREIGN KEY (id_med) REFERENCES medico (id_med) on update cascade on delete cascade,
        id_cliente int,
        FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) on update cascade on delete cascade
    ) ENGINE = INNODB;