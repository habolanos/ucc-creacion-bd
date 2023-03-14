/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     3/6/2023 8:05:11 PM                          */
/*==============================================================*/

/*==============================================================*/
/* Table: CINE                                                  */
/*==============================================================*/
CREATE TABLE CINE (
   ID_CINE              VARCHAR(5)            NOT NULL,
   ID_CIUDAD            VARCHAR(5)            NOT NULL,
   NOMBRE               VARCHAR(40)           NOT NULL,
   DIRECCION            VARCHAR(50)           NOT NULL,
   TELEFONO_ADMIN       VARCHAR(30),
   TELEFONO_CLIENTES    VARCHAR(30),
   ESTADO               VARCHAR(1)           DEFAULT 'A'
   CONSTRAINT CKC_ESTADO_CINE CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_CINE PRIMARY KEY (ID_CINE)
);

/*==============================================================*/
/* Table: CINE_CARTELERAS                                       */
/*==============================================================*/
CREATE TABLE CINE_CARTELERAS (
   ID_CARTELERA         VARCHAR(10)           NOT NULL,
   ID_CINE              VARCHAR(5)            NOT NULL,
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CINE_CAR CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_CINE_CARTELERAS PRIMARY KEY (ID_CARTELERA)
);

/*==============================================================*/
/* Table: CINE_SALAS                                            */
/*==============================================================*/
CREATE TABLE CINE_SALAS (
   ID_SALA              VARCHAR(5)            NOT NULL,
   ID_CINE              VARCHAR(5)            NOT NULL,
   NOMBRE               VARCHAR(30),
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CINE_SAL CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_CINE_SALAS PRIMARY KEY (ID_SALA)
);

/*==============================================================*/
/* Table: CIUDAD                                                */
/*==============================================================*/
CREATE TABLE CIUDAD (
   ID_CIUDAD            VARCHAR(5)            NOT NULL,
   ID_DEPTO             VARCHAR(2)            NOT NULL,
   NOMBRE               VARCHAR(20)           NOT NULL,
   CONSTRAINT PK_CIUDAD PRIMARY KEY (ID_CIUDAD)
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
CREATE TABLE CLIENTE (
   ID_CLIENTE           NUMBER(20)            NOT NULL,
   ID_TD                VARCHAR(2)            NOT NULL,
   NOMBRE               VARCHAR(30)           NOT NULL,
   APELLIDOS            VARCHAR(30)           NOT NULL,
   CONSTRAINT PK_CLIENTE PRIMARY KEY (ID_CLIENTE)
);

/*==============================================================*/
/* Table: CLIENTE_DIRECCIONES                                   */
/*==============================================================*/
CREATE TABLE CLIENTE_DIRECCIONES (
   ID_CLIENTE_DIRECCION NUMBER(15)            NOT NULL,
   ID_CLIENTE           NUMBER(20)            NOT NULL,
   ID_CIUDAD            VARCHAR(5)            NOT NULL,
   VIA_PRINCIPAL        VARCHAR(20)           NOT NULL,
   NOMENCLATURA         VARCHAR(20)           NOT NULL,
   COMPLEMENTO          VARCHAR(20),
   CONSTRAINT PK_CLIENTE_DIRECCIONES PRIMARY KEY (ID_CLIENTE_DIRECCION)
);

/*==============================================================*/
/* Table: DEPARTAMENTO                                          */
/*==============================================================*/
CREATE TABLE DEPARTAMENTO (
   ID_DEPTO             VARCHAR(2)            NOT NULL,
   ID_PAIS              VARCHAR(3)            NOT NULL,
   NOMBRE               VARCHAR(20)           NOT NULL,
   CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (ID_DEPTO)
);

/*==============================================================*/
/* Table: PAIS                                                  */
/*==============================================================*/
CREATE TABLE PAIS (
   ID_PAIS              VARCHAR(3)            NOT NULL,
   NOMBRE               VARCHAR(20)           NOT NULL,
   CONSTRAINT PK_PAIS PRIMARY KEY (ID_PAIS)
);

/*==============================================================*/
/* Table: PELICULA                                              */
/*==============================================================*/
CREATE TABLE PELICULA (
   ID_PELICULA          VARCHAR(10)           NOT NULL,
   NOMBRE               VARCHAR(100)          NOT NULL,
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_PELICULA CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_PELICULA PRIMARY KEY (ID_PELICULA)
);

/*==============================================================*/
/* Table: PELICULA_CARTELERA                                    */
/*==============================================================*/
CREATE TABLE PELICULA_CARTELERA (
   ID_CARTELERA         VARCHAR(10)           NOT NULL,
   ID_PELICULA          VARCHAR(10)           NOT NULL,
   CONSTRAINT PK_PELICULA_CARTELERA PRIMARY KEY (ID_CARTELERA, ID_PELICULA)
);

/*==============================================================*/
/* Table: TIPO_DOCUMENTO                                        */
/*==============================================================*/
CREATE TABLE TIPO_DOCUMENTO (
   ID_TD                VARCHAR(2)            NOT NULL,
   NOMBRE               VARCHAR(20)           NOT NULL,
   CONSTRAINT PK_TIPO_DOCUMENTO PRIMARY KEY (ID_TD)
);

ALTER TABLE CINE
   ADD CONSTRAINT FK_CINE_REFERENCE_CIUDAD FOREIGN KEY (ID_CIUDAD)
      REFERENCES CIUDAD (ID_CIUDAD);

ALTER TABLE CINE_CARTELERAS
   ADD CONSTRAINT FK_CINE_CAR_REFERENCE_CINE FOREIGN KEY (ID_CINE)
      REFERENCES CINE (ID_CINE);

ALTER TABLE CINE_SALAS
   ADD CONSTRAINT FK_CINE_SAL_REFERENCE_CINE FOREIGN KEY (ID_CINE)
      REFERENCES CINE (ID_CINE);

ALTER TABLE CIUDAD
   ADD CONSTRAINT FK_CIUDAD_REFERENCE_DEPARTAM FOREIGN KEY (ID_DEPTO)
      REFERENCES DEPARTAMENTO (ID_DEPTO);

ALTER TABLE CLIENTE
   ADD CONSTRAINT FK_CLIENTE_REFERENCE_TIPO_DOC FOREIGN KEY (ID_TD)
      REFERENCES TIPO_DOCUMENTO (ID_TD);

ALTER TABLE CLIENTE_DIRECCIONES
   ADD CONSTRAINT FK_CLIENTE__REFERENCE_CIUDAD FOREIGN KEY (ID_CIUDAD)
      REFERENCES CIUDAD (ID_CIUDAD);

ALTER TABLE CLIENTE_DIRECCIONES
   ADD CONSTRAINT FK_CLIENTE__REFERENCE_CLIENTE FOREIGN KEY (ID_CLIENTE)
      REFERENCES CLIENTE (ID_CLIENTE);

ALTER TABLE DEPARTAMENTO
   ADD CONSTRAINT FK_DEPARTAM_REFERENCE_PAIS FOREIGN KEY (ID_PAIS)
      REFERENCES PAIS (ID_PAIS);

ALTER TABLE PELICULA_CARTELERA
   ADD CONSTRAINT FK_PELICULA_REFERENCE_CINE_CAR FOREIGN KEY (ID_CARTELERA)
      REFERENCES CINE_CARTELERAS (ID_CARTELERA);

ALTER TABLE PELICULA_CARTELERA
   ADD CONSTRAINT FK_PELICULA_REFERENCE_PELICULA FOREIGN KEY (ID_PELICULA)
      REFERENCES PELICULA (ID_PELICULA);

