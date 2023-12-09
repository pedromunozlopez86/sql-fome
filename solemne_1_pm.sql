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

-- •	Insertar 5 registros en cada tabla.
INSERT INTO
    cliente (
        rut,
        nombre,
        apellido,
        direccion,
        telefono,
        correo,
        sexo
    )
VALUES
    (
        '104255329',
        'Marisa',
        'Lopez',
        'Vicuña Mackenna 6839',
        '56977708923',
        'marylo41@hotmail.com',
        'F'
    ),
    (
        '185436843',
        'Pedro',
        'Muñoz',
        'Martin de Zamora 5509',
        '56999989345',
        'pmunoz@gmail.com',
        'M'
    ),
    (
        '224325469',
        'Jose',
        'Perez',
        'Alameda 323',
        '56945608923',
        'jperez@gmail.com',
        'M'
    ),
    (
        '303214567',
        'Juan',
        'Mecanico',
        '10 de Julio 556',
        '56986456789',
        'jmecanic@yahoo.com',
        'M'
    ),
    (
        '85735551',
        'Lucia',
        'Sanchez',
        'Amapolas 5589',
        '5694456543',
        'lsanchez@gmail.com',
        'F'
    );

INSERT INTO
    pais (nombre)
VALUES
    ('Chile'),
    ('Argentina'),
    ('Brasil'),
    ('Ecuador'),
    ('Uruguay');

INSERT INTO
    region (nombre_region, id_pais)
VALUES
    ('Metropolitana', 1),
    ('Bariloche', 2),
    ('De los Ríos', 1),
    ('Brasilia', 3),
    ('Coquimbo', 1);

INSERT INTO
    sucursal (
        nombre_sucursal,
        direccion,
        telefono,
        rut,
        id_cliente
    )
VALUES
    (
        'Clinica Las Condes',
        'Avda. Las condes 755',
        '+56223344556',
        '76123321k',
        1
    ),
    (
        'Clinica Alemana',
        'Avda. Manquehue 1005',
        '+56232334444',
        '78654123k',
        2
    ),
    (
        'Clinica Davila',
        'Avda. Recoleta 554',
        '+56277665454',
        '76123321k',
        3
    ),
    (
        'Clinica Bupa',
        'Avda. Americo Vespucio 10755',
        '+56298877676',
        '76123321k',
        4
    ),
    (
        'Clinica Indisa',
        'Avda. Providencia 123',
        '+56255454566',
        '76123321k',
        5
    );

INSERT INTO
    comuna (nombre_comuna, id_region, id_sucursal)
VALUES
    ('Las Condes', 1, 6),
    ('Vitacura', 1, 7),
    ('Recoleta', 1, 8),
    ('La Florida', 1, 9),
    ('Providencia', 1, 10);

INSERT INTO
    cuenta (numero_cuenta, id_cl)
VALUES
    (45567, 1),
    (12345, 2),
    (22875, 3),
    (44556, 4),
    (89765, 5);

INSERT INTO
    tipo_cuenta (tipo, interes, saldo, id_cuenta)
VALUES
    ('corriente', 30, 4000000, 1),
    ('vista', 30, 6000000, 2),
    ('rut', 30, 2000000, 3),
    ('corriente', 30, 3500000, 4),
    ('corriente', 30, 7500000, 5);

INSERT INTO
    medico (nombre_med, apellido, direccion, telefono, correo)
VALUES
    (
        'Manuel',
        'Rodriguez',
        'Consistorial 555',
        '56945454567',
        'mrodriguez@gmail.com'
    ),
    (
        'Ma. Luisa',
        'Cordero',
        'Alameda 3332',
        '56998674534',
        'maluisacord@gmail.com'
    ),
    (
        'Josefa',
        'Perez',
        'Calle larga 333',
        '56932437687',
        'jperez@gmail.com'
    ),
    (
        'Patricio',
        'Artaza',
        'Matta 123',
        '56943675489',
        'partaza@gmail.com'
    ),
    (
        'Armando',
        'Casas',
        'Gran. Avenida 10555',
        '56976897654',
        'acasas@gmail.com'
    );

INSERT INTO
    especialidad (
        nombre_especialidad,
        id_sucursal,
        id_med,
        id_cliente
    )
VALUES
    ('Oftalmologia', 7, 1, 5),
    ('Medicina General', 6, 2, 4),
    ('Ginecologia', 10, 3, 3),
    ('Urologia', 9, 4, 2),
    ('Psicologia', 8, 5, 1);

INSERT INTO
    prevision (nombre_prevision, id_cliente)
VALUES
    ('Fonasa', 1),
    ('Cruz Blanca', 2),
    ('Colmena', 3),
    ('Banmedica', 4),
    ('Consalud', 5);

