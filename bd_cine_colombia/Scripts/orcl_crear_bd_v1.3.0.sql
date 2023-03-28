/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     3/27/2023 7:58:51 PM                         */
/*==============================================================*/


ALTER TABLE CINE
   DROP CONSTRAINT FK_CINE_REFERENCE_CIUDAD;

ALTER TABLE CINE_CARTELERAS
   DROP CONSTRAINT FK_CINE_CAR_REFERENCE_CINE;

ALTER TABLE CINE_SALAS
   DROP CONSTRAINT FK_CINE_SAL_REFERENCE_CINE;

ALTER TABLE CIUDAD
   DROP CONSTRAINT FK_CIUDAD_REFERENCE_DEPARTAM;

ALTER TABLE CLIENTE
   DROP CONSTRAINT FK_CLIENTE_REFERENCE_TIPO_DOC;

ALTER TABLE CLIENTE_DIRECCIONES
   DROP CONSTRAINT FK_CLIENTE__REFERENCE_CIUDAD;

ALTER TABLE CLIENTE_DIRECCIONES
   DROP CONSTRAINT FK_CLIENTE_DIR_REF_CLIENTE;

ALTER TABLE CLIENTE_EMAILS
   DROP CONSTRAINT FK_CLIENTE_EMAILS_REF_CLIENTE;

ALTER TABLE CLIENTE_REDES
   DROP CONSTRAINT FK_CLIENTE__REFERENCE_RED_SOCI;

ALTER TABLE CLIENTE_REDES
   DROP CONSTRAINT FK_CLIENTE_REDES_REF_CLIENTE;

ALTER TABLE CLIENTE_TELEFONOS
   DROP CONSTRAINT FK_CLIENTE__REFERENCE_PAIS;

ALTER TABLE CLIENTE_TELEFONOS
   DROP CONSTRAINT FK_CLIENTE_TEL_REF_CLIENTE;

ALTER TABLE DEPARTAMENTO
   DROP CONSTRAINT FK_DEPARTAM_REFERENCE_PAIS;

ALTER TABLE PELICULA_CARTELERA
   DROP CONSTRAINT FK_PELICULA_REFERENCE_CINE_CAR;

ALTER TABLE PELICULA_CARTELERA
   DROP CONSTRAINT FK_PELICULA_REFERENCE_PELICULA;

ALTER TABLE USUARIO
   DROP CONSTRAINT FK_USUARIO_REFERENCE_TIPO_USU;

ALTER TABLE USUARIO
   DROP CONSTRAINT FK_USUARIO_REFERENCE_TIPO_ALG;

ALTER TABLE USUARIO_CINE
   DROP CONSTRAINT FK_USUARIO__REFERENCE_USUARIO;

ALTER TABLE USUARIO_CINE
   DROP CONSTRAINT FK_USUARIO__REFERENCE_CINE;

DROP TABLE CINE CASCADE CONSTRAINTS;

DROP TABLE CINE_CARTELERAS CASCADE CONSTRAINTS;

DROP TABLE CINE_SALAS CASCADE CONSTRAINTS;

DROP TABLE CIUDAD CASCADE CONSTRAINTS;

DROP TABLE CLIENTE CASCADE CONSTRAINTS;

DROP TABLE CLIENTE_DIRECCIONES CASCADE CONSTRAINTS;

DROP TABLE CLIENTE_EMAILS CASCADE CONSTRAINTS;

DROP TABLE CLIENTE_REDES CASCADE CONSTRAINTS;

DROP TABLE CLIENTE_TELEFONOS CASCADE CONSTRAINTS;

DROP TABLE DEPARTAMENTO CASCADE CONSTRAINTS;

DROP TABLE PAIS CASCADE CONSTRAINTS;

DROP TABLE PELICULA CASCADE CONSTRAINTS;

DROP TABLE PELICULA_CARTELERA CASCADE CONSTRAINTS;

DROP TABLE RED_SOCIAL CASCADE CONSTRAINTS;

DROP TABLE TIPO_ALGORITMO CASCADE CONSTRAINTS;

DROP TABLE TIPO_DOCUMENTO CASCADE CONSTRAINTS;

DROP TABLE TIPO_USUARIO CASCADE CONSTRAINTS;

DROP TABLE USUARIO CASCADE CONSTRAINTS;

DROP TABLE USUARIO_CINE CASCADE CONSTRAINTS;

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
   DOCUMENTO            VARCHAR(20)           NOT NULL,
   NOMBRE               VARCHAR(30)           NOT NULL,
   APELLIDOS            VARCHAR(30)           NOT NULL,
   FECHA_NACIMIENTO     DATE,
   FECHA_VINCULACION    DATE,
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CLIENTE CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
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
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CLI_DIRS CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE,
   ID_USUARIO_LOG       VARCHAR(5)            NOT NULL,
   CONSTRAINT PK_CLIENTE_DIRECCIONES PRIMARY KEY (ID_CLIENTE_DIRECCION)
);

/*==============================================================*/
/* Table: CLIENTE_EMAILS                                        */
/*==============================================================*/
CREATE TABLE CLIENTE_EMAILS (
   ID_CLIENTE_EMAIL     NUMBER(15)            NOT NULL,
   ID_CLIENTE           NUMBER(20)            NOT NULL,
   EMAIL                VARCHAR(100),
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CLI_EMAILS CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE,
   ID_USUARIO_LOG       VARCHAR(5)            NOT NULL,
   CONSTRAINT PK_CLIENTE_EMAILS PRIMARY KEY (ID_CLIENTE_EMAIL)
);

/*==============================================================*/
/* Table: CLIENTE_REDES                                         */
/*==============================================================*/
CREATE TABLE CLIENTE_REDES (
   ID_CLIENTE_REDES     NUMBER(15)            NOT NULL,
   ID_CLIENTE           NUMBER(20)            NOT NULL,
   ID_RED_SOCIAL        VARCHAR(5),
   NOMBRE_PERFIL        VARCHAR(30),
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_REDES CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE,
   ID_USUARIO_LOG       VARCHAR(5)            NOT NULL,
   CONSTRAINT PK_CLIENTE_REDES PRIMARY KEY (ID_CLIENTE_REDES)
);

/*==============================================================*/
/* Table: CLIENTE_TELEFONOS                                     */
/*==============================================================*/
CREATE TABLE CLIENTE_TELEFONOS (
   ID_CLIENTE_TELEFONO  NUMBER(15)            NOT NULL,
   ID_CLIENTE           NUMBER(20)            NOT NULL,
   ID_PAIS              VARCHAR(3),
   TELEFONO             VARCHAR(30),
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CLI_TEL CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE,
   ID_USUARIO_LOG       VARCHAR(5)            NOT NULL,
   CONSTRAINT PK_CLIENTE_TELEFONOS PRIMARY KEY (ID_CLIENTE_TELEFONO)
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
   CODIGO_TELEFONICO    VARCHAR(10),
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
/* Table: RED_SOCIAL                                            */
/*==============================================================*/
CREATE TABLE RED_SOCIAL (
   ID_RED_SOCIAL        VARCHAR(5)            NOT NULL,
   NOMBRE               VARCHAR(20)           NOT NULL,
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_RED_SOCI CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_RED_SOCIAL PRIMARY KEY (ID_RED_SOCIAL)
);

/*==============================================================*/
/* Table: TIPO_ALGORITMO                                        */
/*==============================================================*/
CREATE TABLE TIPO_ALGORITMO (
   ID_TIPO_ALGORITMO    VARCHAR(2)            NOT NULL,
   NOMBRE               VARCHAR(20)           NOT NULL,
   SCRIPT_LINE          VARCHAR(200)          NOT NULL,
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_TIPO_ALG CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_TIPO_ALGORITMO PRIMARY KEY (ID_TIPO_ALGORITMO)
);

/*==============================================================*/
/* Table: TIPO_DOCUMENTO                                        */
/*==============================================================*/
CREATE TABLE TIPO_DOCUMENTO (
   ID_TD                VARCHAR(2)            NOT NULL,
   NOMBRE               VARCHAR(20)           NOT NULL,
   CONSTRAINT PK_TIPO_DOCUMENTO PRIMARY KEY (ID_TD)
);

/*==============================================================*/
/* Table: TIPO_USUARIO                                          */
/*==============================================================*/
CREATE TABLE TIPO_USUARIO (
   ID_TIPO_USUARIO      VARCHAR(2)            NOT NULL,
   NOMBRE               VARCHAR(20)           NOT NULL,
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_TIPO_USU CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_TIPO_USUARIO PRIMARY KEY (ID_TIPO_USUARIO)
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
CREATE TABLE USUARIO (
   ID_USUARIO           VARCHAR(5)            NOT NULL,
   ID_TIPO_USUARIO      VARCHAR(2)            NOT NULL,
   NOMBRE               VARCHAR(50)           NOT NULL,
   EMAIL                VARCHAR(100)          NOT NULL,
   PASS                 VARCHAR(100)          NOT NULL,
   ID_TIPO_ALGORITMO    VARCHAR(2),
   HORA_INICIAL         NUMERIC(2)            NOT NULL,
   HORA_FINAL           NUMERIC(2)            NOT NULL,
   ESTADO               VARCHAR(1)           DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_USUARIO CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE,
   CONSTRAINT PK_USUARIO PRIMARY KEY (ID_USUARIO)
);

/*==============================================================*/
/* Table: USUARIO_CINE                                          */
/*==============================================================*/
CREATE TABLE USUARIO_CINE (
   ID_USUARIO           VARCHAR(5)            NOT NULL,
   ID_CINE              VARCHAR(5)            NOT NULL,
   ESTADO               VARCHAR(1)           DEFAULT 'A'  NOT NULL
      CONSTRAINT CKC_ESTADO_USUARIO_ CHECK (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO)),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE  NOT NULL,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE,
   ID_USUARIO_LOG       VARCHAR(5)            NOT NULL,
   CONSTRAINT PK_USUARIO_CINE PRIMARY KEY (ID_USUARIO, ID_CINE)
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
   ADD CONSTRAINT FK_CLIENTE_DIR_REF_CLIENTE FOREIGN KEY (ID_CLIENTE)
      REFERENCES CLIENTE (ID_CLIENTE);

ALTER TABLE CLIENTE_EMAILS
   ADD CONSTRAINT FK_CLIENTE_EMAILS_REF_CLIENTE FOREIGN KEY (ID_CLIENTE)
      REFERENCES CLIENTE (ID_CLIENTE);

ALTER TABLE CLIENTE_REDES
   ADD CONSTRAINT FK_CLIENTE__REFERENCE_RED_SOCI FOREIGN KEY (ID_RED_SOCIAL)
      REFERENCES RED_SOCIAL (ID_RED_SOCIAL);

ALTER TABLE CLIENTE_REDES
   ADD CONSTRAINT FK_CLIENTE_REDES_REF_CLIENTE FOREIGN KEY (ID_CLIENTE)
      REFERENCES CLIENTE (ID_CLIENTE);

ALTER TABLE CLIENTE_TELEFONOS
   ADD CONSTRAINT FK_CLIENTE__REFERENCE_PAIS FOREIGN KEY (ID_PAIS)
      REFERENCES PAIS (ID_PAIS);

ALTER TABLE CLIENTE_TELEFONOS
   ADD CONSTRAINT FK_CLIENTE_TEL_REF_CLIENTE FOREIGN KEY (ID_CLIENTE)
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

ALTER TABLE USUARIO
   ADD CONSTRAINT FK_USUARIO_REFERENCE_TIPO_USU FOREIGN KEY (ID_TIPO_USUARIO)
      REFERENCES TIPO_USUARIO (ID_TIPO_USUARIO);

ALTER TABLE USUARIO
   ADD CONSTRAINT FK_USUARIO_REFERENCE_TIPO_ALG FOREIGN KEY (ID_TIPO_ALGORITMO)
      REFERENCES TIPO_ALGORITMO (ID_TIPO_ALGORITMO);

ALTER TABLE USUARIO_CINE
   ADD CONSTRAINT FK_USUARIO__REFERENCE_USUARIO FOREIGN KEY (ID_USUARIO)
      REFERENCES USUARIO (ID_USUARIO);

ALTER TABLE USUARIO_CINE
   ADD CONSTRAINT FK_USUARIO__REFERENCE_CINE FOREIGN KEY (ID_CINE)
      REFERENCES CINE (ID_CINE);

