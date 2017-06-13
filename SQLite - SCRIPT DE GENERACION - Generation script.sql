﻿PRAGMA FOREIGN_KEYS = ON;


-- CREATE TABLES SECTION -------------------------------------------------


-- TABLE CLIENTE

CREATE TABLE CLIENTE(
  CLIENTE_ID INTEGER NOT NULL PRIMARY KEY,
  NOMBRE VARCHAR2(30 ) NOT NULL,
  APELLIDO1 VARCHAR2(30 ) NOT NULL,
  APELLIDO2 VARCHAR2(30 ),
  EMAIL VARCHAR2(30 ) NOT NULL,
  TELEFONO CHAR(9 ) NOT NULL
        CONSTRAINT CHECK_CONSTRAINT_TELEFONO 
	CHECK ((SUBSTR(TELEFONO,0,2) LIKE 6) or (SUBSTR(TELEFONO,0,2) LIKE 9)),
  DNI CHAR(9 ) NOT NULL,
CONSTRAINT DNI UNIQUE (DNI),
CONSTRAINT EMAIL UNIQUE (EMAIL),
CONSTRAINT TELEFONO UNIQUE (TELEFONO)
);



-- CREATE TRIGGERS FOR TABLE CLIENTE


CREATE TRIGGER TALLER_ABIERTO_CLIENTE_INSERT
  AFTER INSERT ON CLIENTE
    FOR EACH ROW
BEGIN
    SELECT CASE WHEN (SELECT strftime('%H','now') BETWEEN 22 AND 8 ) 
    THEN RAISE (ABORT, 'EL TALLER ESTá CERRANDO ENTRE LAS 22:00 Y LAS 08:00')
    END;
END;

CREATE TRIGGER TALLER_ABIERTO_CLIENTE_UPDATE
  AFTER UPDATE ON CLIENTE
    FOR EACH ROW
BEGIN
    SELECT CASE WHEN (SELECT strftime('%H','now') BETWEEN 22 AND 8 ) 
    THEN RAISE (ABORT, 'EL TALLER ESTá CERRANDO ENTRE LAS 22:00 Y LAS 08:00')
    END;
END;






CREATE TRIGGER CAMPO_VACIO_CLIENTE_INSERT
AFTER INSERT 
    ON CLIENTE
BEGIN 
  SELECT CASE WHEN (NEW.NOMBRE = '')
  THEN
  RAISE (ABORT, 'EL CAMPO NOMBRE NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.APELLIDO1 = '')
  THEN
  RAISE (ABORT, 'EL CAMPO APELLIDO1 NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.APELLIDO2 = '')
  THEN
  RAISE (ABORT, 'EL CAMPO APELLIDO2 NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.EMAIL = '')
  THEN
  RAISE (ABORT, 'EL CAMPO EMAIL NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.TELEFONO = '')
  THEN
  RAISE (ABORT, 'EL CAMPO TELEFONO NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.DNI = '')
  THEN
  RAISE (ABORT, 'EL CAMPO DNI NO PUEDE ESTAR VACIO')
  END;
END;



CREATE TRIGGER CAMPO_VACIO_CLIENTE_UPDATE
AFTER UPDATE
    ON CLIENTE
BEGIN 
  SELECT CASE WHEN (NEW.NOMBRE = '')
  THEN
  RAISE (ABORT, 'EL CAMPO NOMBRE NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.APELLIDO1 = '')
  THEN
  RAISE (ABORT, 'EL CAMPO APELLIDO1 NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.APELLIDO2 = '')
  THEN
  RAISE (ABORT, 'EL CAMPO APELLIDO2 NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.EMAIL = '')
  THEN
  RAISE (ABORT, 'EL CAMPO EMAIL NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.TELEFONO = '')
  THEN
  RAISE (ABORT, 'EL CAMPO TELEFONO NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.DNI = '')
  THEN
  RAISE (ABORT, 'EL CAMPO DNI NO PUEDE ESTAR VACIO')
  END;
END;


-- TABLE COCHE


CREATE TABLE COCHE(
  COCHE_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  MARCA VARCHAR2(30 ) NOT NULL,
  MODELO VARCHAR2(30 ) NOT NULL,
  MATRICULA CHAR(8 ) NOT NULL,
  ITV DATE NOT NULL,
  CLIENTE_ID INTEGER NOT NULL,
CONSTRAINT MATRICULA UNIQUE (MATRICULA),
CONSTRAINT RELATIONSHIP1 FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTE (CLIENTE_ID) ON DELETE SET NULL ON UPDATE SET NULL
);



-- CREATE TRIGGERS FOR TABLE COCHE


CREATE TRIGGER ITV_PASADA_INSERT
  BEFORE INSERT ON COCHE
    FOR EACH ROW
BEGIN
SELECT CASE WHEN (NEW.ITV < (SELECT CURRENT_TIMESTAMP))
  THEN
    RAISE (ABORT, 'EL COCHE TIENE QUE TENER PASADA LA ITV')
END;
END;


CREATE TRIGGER ITV_PASADA_UPDATE
  BEFORE UPDATE ON COCHE
    FOR EACH ROW
BEGIN
SELECT CASE WHEN (NEW.ITV < (SELECT CURRENT_TIMESTAMP))
  THEN
    RAISE (ABORT, 'EL COCHE TIENE QUE TENER PASADA LA ITV')
END;
END;

CREATE TRIGGER CAMPO_VACIO_COCHE_INSERT
AFTER INSERT 
    ON COCHE
BEGIN 
  SELECT CASE WHEN (NEW.MARCA = '')
  THEN
  RAISE (ABORT, 'EL CAMPO MARCA NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.MODELO = '')
  THEN
  RAISE (ABORT, 'EL CAMPO MODELO NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.MATRICULA = '')
  THEN
  RAISE (ABORT, 'EL CAMPO MATRICULA NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.ITV = '')
  THEN
  RAISE (ABORT, 'EL CAMPO ITV NO PUEDE ESTAR VACIO')
  END;
END;


CREATE TRIGGER CAMPO_VACIO_COCHE_UPDATE
AFTER UPDATE
    ON COCHE
BEGIN 
  SELECT CASE WHEN (NEW.MARCA = '')
  THEN
  RAISE (ABORT, 'EL CAMPO MARCA NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.MODELO = '')
  THEN
  RAISE (ABORT, 'EL CAMPO MODELO NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.MATRICULA = '')
  THEN
  RAISE (ABORT, 'EL CAMPO MATRICULA NO PUEDE ESTAR VACIO')
  END;
  SELECT CASE WHEN (NEW.ITV = '')
  THEN
  RAISE (ABORT, 'EL CAMPO ITV NO PUEDE ESTAR VACIO')
  END;
END;



CREATE VIEW VW_CLIENTE AS
SELECT CLIENTE_ID, NOMBRE, APELLIDO1, APELLIDO2, EMAIL, TELEFONO, DNI
FROM CLIENTE;


CREATE VIEW VW_COCHE AS
SELECT COCHE_ID, MARCA, MODELO, MATRICULA, ITV, APELLIDO2, CLIENTE.CLIENTE_ID, NOMBRE, APELLIDO1, EMAIL, TELEFONO, DNI
FROM COCHE, CLIENTE
WHERE CLIENTE.CLIENTE_ID=COCHE.CLIENTE_ID;

