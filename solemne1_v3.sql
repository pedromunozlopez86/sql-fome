# Comando para macOS
/usr/local/mysql/bin/mysql -u root -p


# Creacion DB
CREATE DATABASE IF NOT EXISTS solemne1;
USE solemne1;

# pais
CREATE TABLE solemne1.pais (
	id_pais int auto_increment NOT NULL,
	nombre varchar(100) NOT NULL,
	CONSTRAINT pais_PK PRIMARY KEY (id_pais)
)
ENGINE=InnoDB;

# region
CREATE TABLE solemne1.region (
	id_region int auto_increment NOT NULL,
	nombre_region varchar(100) NOT NULL,
	id_pais int,
	CONSTRAINT region_PK PRIMARY KEY (id_region),
	CONSTRAINT region_pais_FK FOREIGN KEY (id_pais) REFERENCES solemne1.pais(id_pais) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB;

# comuna
CREATE TABLE solemne1.comuna (
	id_comuna int auto_increment NOT NULL,
	nombre_comuna varchar(100) NOT NULL,
	id_region int,
	CONSTRAINT comuna_PK PRIMARY KEY (id_comuna),
	CONSTRAINT comuna_region_FK FOREIGN KEY (id_region) REFERENCES solemne1.region(id_region) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB;

# previsión
CREATE TABLE IF NOT EXISTS solemne1.prevision (
	id_prevision int auto_increment NOT NULL,
	nombre_prevision varchar(100) NOT NULL,
	CONSTRAINT prevision_PK PRIMARY KEY (id_prevision)
)
ENGINE=InnoDB;

# especialidad
CREATE TABLE solemne1.especialidad (
	id_especialidad int auto_increment NOT NULL,
	nombre_especialidad varchar(100) NOT NULL,
	CONSTRAINT especialidad_PK PRIMARY KEY (id_especialidad)
)
ENGINE=InnoDB;

# sucursal
CREATE TABLE solemne1.sucursal (
	id_sucursal int auto_increment NOT NULL,
	nombre_sucursal varchar(100) NOT NULL,
	direccion varchar(100) NOT NULL,
	telefono varchar(100) NULL,
	rut varchar(100) NOT NULL,
	id_comuna int,
	CONSTRAINT sucursal_PK PRIMARY KEY (id_sucursal),
	CONSTRAINT sucursall_comuna_FK FOREIGN KEY (id_comuna) REFERENCES solemne1.comuna(id_comuna) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB;

# cliente 
# Se crea la tabla de acuerdo a lo solicitado en documento
# Se han fijado los campos como not null de acuerdo a inferencia desde el texto
# id cliente como llave auto incrementable
# rut con unique constraint
# Para los valores del campo sexo se usó el tipo ENUM
# https://stackoverflow.com/questions/21201898/restricting-a-column-to-accept-only-2-values
CREATE TABLE IF NOT EXISTS solemne1.cliente (
	id_cliente int auto_increment NOT NULL,
	rut varchar(100) NOT NULL,
	nombre varchar(100) NOT NULL,
	apellido varchar(100) NOT NULL,
	direccion varchar(100) NOT NULL,
	telefono varchar(100) NULL,
	correo varchar(100) NOT NULL,
	sexo ENUM ('F','M'),
	id_prevision int,
	id_sucursal int,
	CONSTRAINT cliente_PK PRIMARY KEY (id_cliente),
	CONSTRAINT cliente_rut_unique UNIQUE KEY (rut),
	CONSTRAINT cliente_prevision_FK FOREIGN KEY (id_prevision) REFERENCES solemne1.prevision(id_prevision) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT cliente_sucursal_FK FOREIGN KEY (id_sucursal) REFERENCES solemne1.sucursal(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB;

# medico
CREATE TABLE solemne1.medico (
	id_med int auto_increment NOT NULL,
	nombre_med varchar(100) NOT NULL,
	apellido varchar(100) NOT NULL,
	direccion varchar(100) NOT NULL,
	telefono varchar(100) NULL,
	correo varchar(100) NOT NULL,
	id_especialidad int,
	id_sucursal int,
	CONSTRAINT medico_PK PRIMARY KEY (id_med),
	CONSTRAINT medico_especialidad_FK FOREIGN KEY (id_especialidad) REFERENCES solemne1.especialidad(id_especialidad) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT medico_sucursal_FK FOREIGN KEY (id_sucursal) REFERENCES solemne1.sucursal(id_sucursal) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB;


# cuenta
CREATE TABLE solemne1.cuenta (
	id_cuenta int auto_increment NOT NULL,
	numero_cuenta int NOT NULL,
	id_cliente int,
	CONSTRAINT cuenta_PK PRIMARY KEY (id_cuenta),
	CONSTRAINT cuenta_cliente_FK FOREIGN KEY (id_cliente) REFERENCES solemne1.cliente(id_cliente) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB;


# tipo_cuenta
CREATE TABLE solemne1.tipo_cuenta (
	id_tipo int auto_increment NOT NULL,
	tipo varchar(100) NOT NULL,
	interes float,
	saldo float,
	id_cuenta int,
	CONSTRAINT tipo_cuenta_PK PRIMARY KEY (id_tipo),
	CONSTRAINT tipo_cuenta_FK FOREIGN KEY (id_cuenta) REFERENCES solemne1.cuenta(id_cuenta) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB;



##########################################################################
##################### inserts ############################################
##########################################################################
# Pais
INSERT INTO solemne1.pais (nombre)
VALUES
  ('Chile'),
  ('Argentina'),
  ('Brasil'),
  ('Perú'),
  ('México');

# Obtener id Chile
select id_pais from pais WHERE nombre = 'Chile'; #1

# Region
INSERT INTO solemne1.region
(nombre_region, id_pais)
VALUES
('Region Metropolitana', 1),
('I Region', 1),
('IV Region', 1),
('V Region', 1),
('VI Region', 1);

# Comuna
# Obtener id de regiones
select id_region, nombre_region from region WHERE id_pais = 1;

# Output
| id_region | nombre_region        |
+-----------+----------------------+
|         1 | Region Metropolitana |
|         2 | I Region             |
|         3 | IV Region            |
|         4 | V Region             |
|         5 | VI Region            |
+-----------+----------------------+
####################################

INSERT INTO solemne1.comuna
(nombre_comuna, id_region)
VALUES
('San Bernardo', 1),
('Renca', 1),
('Valparaiso', 4),
('Viña del Mar', 4),
('Talca', 5);

# Prevision
INSERT INTO solemne1.prevision
(nombre_prevision)
VALUES
('FONASA'),
('Isapre'),
('DIPRECA'),
('Particular'),
('Otros');

# Especialidad
INSERT INTO solemne1.especialidad
(nombre_especialidad)
VALUES
('Medicina general'),
('Gastroenterologia'),
('Inmunologia'),
('Ginecoligia'),
('Cardiologia');

# sucursal
select id_comuna, nombre_comuna from comuna;
+-----------+---------------+
| id_comuna | nombre_comuna |
+-----------+---------------+
|         1 | San Bernardo  |
|         2 | Renca         |
|         3 | Valparaiso    |
|         4 | Viña del Mar  |
|         5 | Talca         |
+-----------+---------------+
###################################
INSERT INTO solemne1.sucursal
(nombre_sucursal, direccion, telefono, rut, id_comuna)
VALUES
('Clinica San Bernardo', 'O Higgins 750', '+562222222', '11111111-1', 1),
('Centro Salud Renca', 'Arturo Prat 200', '+562222222', '11111111-1', 2),
('Clinica Valparaiso', 'Puerto Viejo 15', '+562222222', '11111111-1', 3),
('Clinica Viña', 'Miraflores 30', '+562222222', '11111111-1', 4),
('Clinica Mall Marina', '5 Norte 75', '+562222222', '11111111-1', 4);

# Cliente
mysql> select nombre_prevision, id_prevision from prevision;
+------------------+--------------+
| nombre_prevision | id_prevision |
+------------------+--------------+
| FONASA           |            1 |
| Isapre           |            2 |
| DIPRECA          |            3 |
| Particular       |            4 |
| Otros            |            5 |
+------------------+--------------+

 mysql> select nombre_sucursal, id_sucursal from sucursal;
+----------------------+-------------+
| nombre_sucursal      | id_sucursal |
+----------------------+-------------+
| Clinica San Bernardo |           1 |
| Centro Salud Renca   |           2 |
| Clinica Valparaiso   |           3 |
| Clinica Viña         |           4 |
| Clinica Mall Marina  |           5 |
+----------------------+-------------+

 ###############################################

INSERT INTO solemne1.cliente
(rut, nombre, apellido, direccion, telefono, correo, sexo, id_prevision, id_sucursal)
VALUES
('9668701-k', 'Eros', 'Perez', 'Moneda 76', '+569999999', 'eperez@test.tt', 'M', 1, 2),
('19977160-4', 'Gladys', 'Marin', 'General Gana 1044 of 22', '+569999999', 'gmain@test.tt', 'F', 1, 3),
('20702273-k', 'David', 'Beckham', 'General Gana 980', '+569999999', 'dbeckham@test.tt', 'M', 4, 5),
('1496862-8', 'Luis', 'Figo', 'San Martin 132', '+569999999', 'lfigo@test.tt', 'M', 2, 1),
('18605867-4', 'Cecilio', 'Waterman', 'Cienfuegos 200 depto 3002', '+569999999', 'waterman@test.tt', 'M', 2, 5);

# Medico
mysql> select nombre_especialidad, id_especialidad from especialidad;
+---------------------+-----------------+
| nombre_especialidad | id_especialidad |
+---------------------+-----------------+
| Medicina general    |               1 |
| Gastroenterologia   |               2 |
| Inmunologia         |               3 |
| Ginecoligia         |               4 |
| Cardiologia         |               5 |
+---------------------+-----------------+

 mysql> select nombre_sucursal, id_sucursal from sucursal;
+----------------------+-------------+
| nombre_sucursal      | id_sucursal |
+----------------------+-------------+
| Clinica San Bernardo |           1 |
| Centro Salud Renca   |           2 |
| Clinica Valparaiso   |           3 |
| Clinica Viña         |           4 |
| Clinica Mall Marina  |           5 |
+----------------------+-------------+

################################################################

INSERT INTO solemne1.medico
(nombre_med, apellido, direccion, telefono, correo, id_especialidad, id_sucursal)
VALUES
('Charlie', 'Zaa', 'Camino el Alba 600', '+5622222222', 'czaa@test.tt', 4, 1),
('Camila', 'Moreno', 'Alcalde Castillo Velasco 390', '+5622222222', 'cmoreno@test.tt', 1, 5),
('Andres', 'De Leon', 'San Jose 540', '+5622222222', 'adl@test.tt', 3, 4),
('Andres', 'Calamaro', 'Camino el Alba 600', '+5622222222', 'acalamaro@test.tt', 1, 1),
('Rene', 'De la Vega', 'Av Bernardo O Higgins 1100 of 202', '+5622222222', 'dlvg@test.tt', 5, 2);

# Cuenta
| id_cliente | nombre  | apellido | rut        |
+------------+---------+----------+------------+
|          1 | Eros    | Perez    | 9668701-k  |
|          2 | Gladys  | Marin    | 19977160-4 |
|          3 | David   | Beckham  | 20702273-k |
|          4 | Luis    | Figo     | 1496862-8  |
|          5 | Cecilio | Waterman | 18605867-4 |
+------------+---------+----------+------------+

INSERT INTO solemne1.cuenta
(numero_cuenta, id_cliente)
VALUES
(101, 1),
(201, 2),
(301, 3),
(401, 4),
(501, 5);

# Tipo cuenta
INSERT INTO solemne1.tipo_cuenta
(tipo, interes, saldo, id_cuenta)
VALUES
('cliente', 5.5, 10000000, 1),
('invitado', 7, 0, 2),
('cliente', 5.5, 5700000, 3),
('invitado', 7, 2000000, 4),
('cliente', 5.5, 0, 5);

# Añadir campo sexo a medico
ALTER TABLE solemne1.medico
ADD COLUMN sexo ENUM ('F','M');

# Cambiar extensión dirección cliente
ALTER TABLE solemne1.cliente
MODIFY COLUMN direccion varchar(180)

# Cambiar nombre de columna en país
ALTER TABLE solemne1.pais
CHANGE COLUMN nombre nombre_pais varchar(100);

# Cambiar el nombre de clinica id 4
#Clinica Alemena
UPDATE solemne1.sucursal
SET nombre_sucursal = 'Clinica Alemana'
WHERE id_sucursal = 4;

# Vista
CREATE VIEW pacientes_medicos_sucursal AS
SELECT 
	c.nombre nombre_cliente, 
	c.apellido apellido_cliente,
	p.nombre_prevision,
	s.nombre_sucursal,
	m.nombre_med nombre_medico,
	m.apellido apellido_medico,
	e.nombre_especialidad,
	co.nombre_comuna 
FROM 
	solemne1.cliente c 
JOIN
	solemne1.prevision p on c.id_prevision  = p.id_prevision
JOIN
	solemne1.sucursal s ON c.id_sucursal = s.id_sucursal
JOIN
	solemne1.medico m ON m.id_sucursal = s.id_sucursal
JOIN
	solemne1.especialidad e ON m.id_especialidad = e.id_especialidad
JOIN
	solemne1.comuna co ON s.id_comuna = co.id_comuna;


# Vista 2
CREATE VIEW clientes_cuentas AS
SELECT 
	c.nombre nombre_cliente, 
	c.apellido apellido_cliente,
	tc.tipo tipo_cuenta,
	tc.saldo,
	s.nombre_sucursal,
	c3.nombre_comuna,
	r.nombre_region 
FROM 
	solemne1.cliente c 
LEFT JOIN
	solemne1.cuenta c2 ON c.id_cliente = c2.id_cliente
LEFT JOIN 
	solemne1.tipo_cuenta tc ON c2.id_cuenta  = tc.id_cuenta
LEFT JOIN 
	solemne1.sucursal s ON c.id_sucursal = s.id_sucursal
LEFT JOIN 
	solemne1.comuna c3 ON s.id_comuna = c3.id_comuna
LEFT JOIN 
	solemne1.region r ON c3.id_region = r.id_region
WHERE 
	tc.saldo BETWEEN 3000000  and 5890000
ORDER BY
    tc.saldo  DESC;

# Vista 3
CREATE VIEW sucursales_comuna_region_pais AS
SELECT 
	p.nombre_pais,
	r.nombre_region,
	c.nombre_comuna, 
	s.nombre_sucursal,
	s.direccion
FROM 
	solemne1.sucursal s
LEFT JOIN
	solemne1.comuna c ON c.id_comuna = s.id_comuna
LEFT JOIN 
	solemne1.region r ON c.id_region = r.id_region 
LEFT JOIN 
	solemne1.pais p ON r.id_pais = p.id_pais 