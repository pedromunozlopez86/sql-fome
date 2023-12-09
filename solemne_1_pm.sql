-- Iniciar en consola Mysql
mysql - u peter - p / / peter es mi usuario -- # Creacion DB
create database pm_solemne_1;

--  Seleccion DB
use pm_solemne_1;

-- # crear tabla cliente
CREATE TABLE cliente (
    id_cliente int auto_increment not null PRIMARY KEY,
    rut varchar(10) unique not null,
    nombre varchar(30) not null,
    apellido varchar(30) not null,
    direccion varchar(100) not null,
    telefono varchar(30) not null,
    correo varchar(50) not null,
    sexo ENUM ('M', 'F')
);

-- # tabla previsión
CREATE TABLE prevision (
    id_prevision int auto_increment not null PRIMARY KEY,
    nombre_prevision varchar(50) not null,
    id_cliente int,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) on update cascade on delete cascade
) ENGINE = INNODB;

-- #tabla cuenta
CREATE TABLE cuenta (
    id_cuenta int auto_increment not null PRIMARY KEY,
    numero_cuenta int not null,
    id_cl int,
    FOREIGN KEY (id_cl) REFERENCES cliente (id_cliente) on update cascade on delete cascade
) ENGINE = INNODB;

-- #tabla tipo_cuenta
CREATE TABLE tipo_cuenta (
    id_tipo int auto_increment not null PRIMARY KEY,
    tipo varchar(20) not null,
    interes int not null,
    saldo int not null,
    id_cuenta int,
    FOREIGN KEY (id_cuenta) REFERENCES cuenta (id_cuenta) on update cascade on delete cascade
) ENGINE = INNODB;

-- #tabla medico
CREATE TABLE medico (
    id_med int auto_increment not null PRIMARY KEY,
    nombre_med varchar(50) not null,
    apellido varchar(50) not null,
    direccion varchar(100) not null,
    telefono varchar(30) not null,
    correo varchar(30) not null
);

-- #tabla pais
CREATE TABLE pais (
    id_pais int auto_increment not null PRIMARY KEY,
    nombre varchar(30) not null
);

-- #tabla region
CREATE TABLE region (
    id_region int auto_increment not null PRIMARY KEY,
    nombre_region varchar(30) not null,
    id_pais int,
    FOREIGN KEY (id_pais) REFERENCES pais (id_pais) on update cascade on delete cascade
) ENGINE = INNODB;

--  #tabla sucursal
CREATE TABLE sucursal (
    id_sucursal int auto_increment not null PRIMARY KEY,
    nombre_sucursal varchar(50) not null,
    direccion varchar(100) not null,
    telefono varchar(30) not null,
    rut varchar(10) not null,
    id_cliente int,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) on update cascade on delete cascade
) ENGINE = INNODB;

-- #tabla comuna
CREATE TABLE comuna (
    id_comuna int auto_increment not null PRIMARY KEY,
    nombre_comuna varchar(30) not null,
    id_region int,
    FOREIGN KEY (id_region) REFERENCES region (id_region) on update cascade on delete cascade,
    id_sucursal int,
    FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal) on update cascade on delete cascade
) ENGINE = INNODB;

-- #tabla especialidad
CREATE TABLE especialidad (
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

-- agregando FK's para relaciones faltantes
ALTER TABLE
    cliente
ADD
    COLUMN id_prevision INT,
ADD
    FOREIGN KEY (id_prevision) REFERENCES prevision (id_prevision);

ALTER TABLE
    cliente
ADD
    COLUMN id_sucursal INT,
ADD
    FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal);

ALTER TABLE
    medico
ADD
    COLUMN id_sucursal INT,
ADD
    FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal);

ALTER TABLE
    medico
ADD
    COLUMN id_especialidad INT,
ADD
    FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad);

ALTER TABLE
    sucursal
ADD
    COLUMN id_comuna int,
ADD
    FOREIGN KEY (id_comuna) REFERENCES comuna (id_comuna);

-- Insertar 5 registros en cada tabla.
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
    comuna (nombre_comuna, id_region)
VALUES
    ('Las Condes', 1),
    ('Vitacura', 1),
    ('Recoleta', 1),
    ('La Florida', 1),
    ('Providencia', 1);

INSERT INTO
    prevision (nombre_prevision)
VALUES
    ('Fonasa'),
    ('Cruz Blanca'),
    ('Colmena'),
    ('Banmedica'),
    ('Consalud');

INSERT INTO
    especialidad (nombre_especialidad)
VALUES
    ('Oftalmologia'),
    ('Medicina General'),
    ('Ginecologia'),
    ('Urologia'),
    ('Psicologia');

INSERT INTO
    sucursal (
        nombre_sucursal,
        direccion,
        telefono,
        rut,
        id_comuna
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
    cliente (
        rut,
        nombre,
        apellido,
        direccion,
        telefono,
        correo,
        sexo,
        id_prevision,
        id_sucursal
    )
VALUES
    (
        '104255329',
        'Marisa',
        'Lopez',
        'Vicuña Mackenna 6839',
        '56977708923',
        'marylo41@hotmail.com',
        'F',
        1,
        5
    ),
    (
        '185436843',
        'Pedro',
        'Muñoz',
        'Martin de Zamora 5509',
        '56999989345',
        'pmunoz@gmail.com',
        'M',
        2,
        4
    ),
    (
        '224325469',
        'Jose',
        'Perez',
        'Alameda 323',
        '56945608923',
        'jperez@gmail.com',
        'M',
        3,
        3
    ),
    (
        '303214567',
        'Juan',
        'Mecanico',
        '10 de Julio 556',
        '56986456789',
        'jmecanic@yahoo.com',
        'M',
        4,
        2
    ),
    (
        '85735551',
        'Lucia',
        'Sanchez',
        'Amapolas 5589',
        '5694456543',
        'lsanchez@gmail.com',
        'F',
        5,
        1
    );

INSERT INTO
    medico (
        nombre_med,
        apellido,
        direccion,
        telefono,
        correo,
        id_sucursal,
        id_especialidad
    )
VALUES
    (
        'Manuel',
        'Rodriguez',
        'Consistorial 555',
        '56945454567',
        'mrodriguez@gmail.com',
        1,
        5
    ),
    (
        'Ma. Luisa',
        'Cordero',
        'Alameda 3332',
        '56998674534',
        'maluisacord@gmail.com',
        2,
        4
    ),
    (
        'Josefa',
        'Perez',
        'Calle larga 333',
        '56932437687',
        'jperez@gmail.com',
        3,
        3
    ),
    (
        'Patricio',
        'Artaza',
        'Matta 123',
        '56943675489',
        'partaza@gmail.com',
        4,
        2
    ),
    (
        'Armando',
        'Casas',
        'Gran. Avenida 10555',
        '56976897654',
        'acasas@gmail.com',
        5,
        1
    );

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

-- Después de haber creado la tabla Médico, agregar el campo sexo donde acepte valores F o M.
ALTER TABLE
    medico
ADD
    COLUMN sexo ENUM ('M', 'F');

-- Después de crear el campo Dirección en la tabla cliente, modificar la longitud del campo Dirección con varchar(180), 
-- independiente de la longitud que le han asignado
ALTER TABLE
    cliente
MODIFY
    COLUMN direccion varchar(180);

-- En la tabla país, cambiar el nombre del campo a nombre_país.
ALTER TABLE
    pais CHANGE nombre nombre_pais varchar(30);

-- En la tabla Sucursal, después de insertar los registros para el id_sucursal=4, cambie nombre_sucursal por ‘Clinica Alemena’,
update
    sucursal
SET
    nombre_sucursal = 'Clinica Alemena'
WHERE
    id_sucursal = 4;

-- Crear vista para la siguiente consulta: nombre cliente, apellido cliente,
--  nombre previsión, nombre sucursal, nombre médico, nombre especialidad, 
-- nombre comuna. Utilice Join
CREATE VIEW vista_uno AS
SELECT
    c.nombre as nombre_cliente,
    c.apellido as apellido_cliente,
    p.nombre_prevision as nombre_prevision,
    s.nombre_sucursal as nombre_sucursal,
    m.nombre_med as nombre_medico,
    e.nombre_especialidad as nombre_especialidad,
    co.nombre_comuna as nombre_comuna
FROM
    cliente c
    JOIN prevision p on c.id_prevision = p.id_prevision
    JOIN sucursal s on c.id_sucursal = s.id_sucursal
    JOIN medico m on m.id_sucursal = s.id_sucursal
    JOIN especialidad e on m.id_especialidad = e.id_especialidad
    JOIN comuna co on s.id_comuna = co.id_comuna;

-- ver vista 
select
    *
from
    vista_uno;

-- Crear vista para la siguiente consulta: nombre cliente, apellido cliente,
--  tipo cuenta, saldo, nombre sucursal, nombre comuna, nombre región, de aquellos 
--  clientes cuyo saldo de cuenta se encuentre entre 3000000 y 5890000, 
--  agrupados por tipo de cuenta y ordenados en forma descendente. Use join
CREATE VIEW vista_dos AS
SELECT
    c.nombre as nombre_cliente,
    c.apellido as apellido_cliente,
    tc.tipo as tipo_cuenta,
    tc.saldo as saldo,
    s.nombre_sucursal as nombre_sucursal,
    co.nombre_comuna as nombre_comuna,
    r.nombre_region as nombre_region
FROM
    cliente c
    JOIN cuenta cu ON c.id_cliente = cu.id_cl
    JOIN tipo_cuenta tc ON cu.id_cuenta = tc.id_cuenta
    JOIN sucursal s ON c.id_sucursal = s.id_sucursal
    JOIN comuna co ON s.id_comuna = co.id_comuna
    JOIN region r ON co.id_region = r.id_region
WHERE
    tc.saldo BETWEEN 3000000
    and 5890000
ORDER BY
    tc.saldo DESC;

-- ver vista 
select
    *
from
    vista_dos;

-- Crear vista para la siguiente consulta: nombre país, nombre región, 
-- nombre comuna, nombre sucursal, dirección sucursal. Use Left join
CREATE VIEW vista_tres AS
SELECT
    p.nombre_pais as nombre_pais,
    r.nombre_region as nombre_region,
    co.nombre_comuna as nombre_comuna,
    s.nombre_sucursal as nombre_sucursal,
    s.direccion as direccion_sucursal
FROM
    pais p
    LEFT JOIN region r ON p.id_pais = r.id_pais
    LEFT JOIN comuna co ON r.id_region = co.id_region
    LEFT JOIN sucursal s ON co.id_comuna = s.id_comuna;

-- ver vista 
select
    *
from
    vista_tres;