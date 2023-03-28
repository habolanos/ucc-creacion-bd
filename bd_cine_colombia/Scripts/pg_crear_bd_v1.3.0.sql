/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     3/27/2023 8:10:49 PM                         */
/*==============================================================*/


DROP TABLE CINE;

DROP TABLE CINE_CARTELERAS;

DROP TABLE CINE_SALAS;

DROP TABLE CIUDAD;

DROP TABLE CLIENTE;

DROP TABLE CLIENTE_DIRECCIONES;

DROP TABLE CLIENTE_EMAILS;

DROP TABLE CLIENTE_REDES;

DROP TABLE CLIENTE_TELEFONOS;

DROP TABLE DEPARTAMENTO;

DROP TABLE PAIS;

DROP TABLE PELICULA;

DROP TABLE PELICULA_CARTELERA;

DROP TABLE RED_SOCIAL;

DROP TABLE TIPO_ALGORITMO;

DROP TABLE TIPO_DOCUMENTO;

DROP TABLE TIPO_USUARIO;

DROP TABLE USUARIO;

DROP TABLE USUARIO_CINE;

/*==============================================================*/
/* Table: CINE                                                  */
/*==============================================================*/
CREATE TABLE CINE (
   ID_CINE              VARCHAR(5)           NOT NULL,
   ID_CIUDAD            VARCHAR(5)           NOT NULL,
   NOMBRE               VARCHAR(40)          NOT NULL,
   DIRECCION            VARCHAR(50)          NOT NULL,
   TELEFONO_ADMIN       VARCHAR(30)          NULL,
   TELEFONO_CLIENTES    VARCHAR(30)          NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CINE CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_CINE PRIMARY KEY (ID_CINE)
);

/*==============================================================*/
/* Table: CINE_CARTELERAS                                       */
/*==============================================================*/
CREATE TABLE CINE_CARTELERAS (
   ID_CARTELERA         VARCHAR(10)          NOT NULL,
   ID_CINE              VARCHAR(5)           NOT NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CINE_CAR CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_CINE_CARTELERAS PRIMARY KEY (ID_CARTELERA)
);

/*==============================================================*/
/* Table: CINE_SALAS                                            */
/*==============================================================*/
CREATE TABLE CINE_SALAS (
   ID_SALA              VARCHAR(5)           NOT NULL,
   ID_CINE              VARCHAR(5)           NOT NULL,
   NOMBRE               VARCHAR(30)          NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CINE_SAL CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_CINE_SALAS PRIMARY KEY (ID_SALA)
);

/*==============================================================*/
/* Table: CIUDAD                                                */
/*==============================================================*/
CREATE TABLE CIUDAD (
   ID_CIUDAD            VARCHAR(5)           NOT NULL,
   ID_DEPTO             VARCHAR(2)           NOT NULL,
   NOMBRE               VARCHAR(20)          NOT NULL,
   CONSTRAINT PK_CIUDAD PRIMARY KEY (ID_CIUDAD)
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
CREATE TABLE CLIENTE (
   ID_CLIENTE           NUMERIC(20)          NOT NULL,
   ID_TD                VARCHAR(2)           NOT NULL,
   DOCUMENTO            VARCHAR(20)          NOT NULL,
   NOMBRE               VARCHAR(30)          NOT NULL,
   APELLIDOS            VARCHAR(30)          NOT NULL,
   FECHA_NACIMIENTO     DATE                 NULL,
   FECHA_VINCULACION    DATE                 NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CLIENTE CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_CLIENTE PRIMARY KEY (ID_CLIENTE)
);

/*==============================================================*/
/* Table: CLIENTE_DIRECCIONES                                   */
/*==============================================================*/
CREATE TABLE CLIENTE_DIRECCIONES (
   ID_CLIENTE_DIRECCION NUMERIC(15)          NOT NULL,
   ID_CLIENTE           NUMERIC(20)          NOT NULL,
   ID_CIUDAD            VARCHAR(5)           NOT NULL,
   VIA_PRINCIPAL        VARCHAR(20)          NOT NULL,
   NOMENCLATURA         VARCHAR(20)          NOT NULL,
   COMPLEMENTO          VARCHAR(20)          NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CLI_DIRS CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE NULL,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE NULL,
   ID_USUARIO_LOG       VARCHAR(5)           NOT NULL,
   CONSTRAINT PK_CLIENTE_DIRECCIONES PRIMARY KEY (ID_CLIENTE_DIRECCION)
);

/*==============================================================*/
/* Table: CLIENTE_EMAILS                                        */
/*==============================================================*/
CREATE TABLE CLIENTE_EMAILS (
   ID_CLIENTE_EMAIL     NUMERIC(15)          NOT NULL,
   ID_CLIENTE           NUMERIC(20)          NOT NULL,
   EMAIL                VARCHAR(100)         NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CLI_EMAILS CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE NULL,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE NULL,
   ID_USUARIO_LOG       VARCHAR(5)           NOT NULL,
   CONSTRAINT PK_CLIENTE_EMAILS PRIMARY KEY (ID_CLIENTE_EMAIL)
);

/*==============================================================*/
/* Table: CLIENTE_REDES                                         */
/*==============================================================*/
CREATE TABLE CLIENTE_REDES (
   ID_CLIENTE_REDES     NUMERIC(15)          NOT NULL,
   ID_CLIENTE           NUMERIC(20)          NOT NULL,
   ID_RED_SOCIAL        VARCHAR(5)           NULL,
   NOMBRE_PERFIL        VARCHAR(30)          NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_REDES CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE NULL,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE NULL,
   ID_USUARIO_LOG       VARCHAR(5)           NOT NULL,
   CONSTRAINT PK_CLIENTE_REDES PRIMARY KEY (ID_CLIENTE_REDES)
);

/*==============================================================*/
/* Table: CLIENTE_TELEFONOS                                     */
/*==============================================================*/
CREATE TABLE CLIENTE_TELEFONOS (
   ID_CLIENTE_TELEFONO  NUMERIC(15)          NOT NULL,
   ID_CLIENTE           NUMERIC(20)          NOT NULL,
   ID_PAIS              VARCHAR(3)           NULL,
   TELEFONO             VARCHAR(30)          NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_CLI_TEL CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE NULL,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE NULL,
   ID_USUARIO_LOG       VARCHAR(5)           NOT NULL,
   CONSTRAINT PK_CLIENTE_TELEFONOS PRIMARY KEY (ID_CLIENTE_TELEFONO)
);

/*==============================================================*/
/* Table: DEPARTAMENTO                                          */
/*==============================================================*/
CREATE TABLE DEPARTAMENTO (
   ID_DEPTO             VARCHAR(2)           NOT NULL,
   ID_PAIS              VARCHAR(3)           NOT NULL,
   NOMBRE               VARCHAR(20)          NOT NULL,
   CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (ID_DEPTO)
);

/*==============================================================*/
/* Table: PAIS                                                  */
/*==============================================================*/
CREATE TABLE PAIS (
   ID_PAIS              VARCHAR(3)           NOT NULL,
   NOMBRE               VARCHAR(20)          NOT NULL,
   CODIGO_TELEFONICO    VARCHAR(10)          NULL,
   CONSTRAINT PK_PAIS PRIMARY KEY (ID_PAIS)
);

/*==============================================================*/
/* Table: PELICULA                                              */
/*==============================================================*/
CREATE TABLE PELICULA (
   ID_PELICULA          VARCHAR(10)          NOT NULL,
   NOMBRE               VARCHAR(100)         NOT NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_PELICULA CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_PELICULA PRIMARY KEY (ID_PELICULA)
);

/*==============================================================*/
/* Table: PELICULA_CARTELERA                                    */
/*==============================================================*/
CREATE TABLE PELICULA_CARTELERA (
   ID_CARTELERA         VARCHAR(10)          NOT NULL,
   ID_PELICULA          VARCHAR(10)          NOT NULL,
   CONSTRAINT PK_PELICULA_CARTELERA PRIMARY KEY (ID_CARTELERA, ID_PELICULA)
);

/*==============================================================*/
/* Table: RED_SOCIAL                                            */
/*==============================================================*/
CREATE TABLE RED_SOCIAL (
   ID_RED_SOCIAL        VARCHAR(5)           NOT NULL,
   NOMBRE               VARCHAR(20)          NOT NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_RED_SOCI CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_RED_SOCIAL PRIMARY KEY (ID_RED_SOCIAL)
);

/*==============================================================*/
/* Table: TIPO_ALGORITMO                                        */
/*==============================================================*/
CREATE TABLE TIPO_ALGORITMO (
   ID_TIPO_ALGORITMO    VARCHAR(2)           NOT NULL,
   NOMBRE               VARCHAR(20)          NOT NULL,
   SCRIPT_LINE          VARCHAR(200)         NOT NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_TIPO_ALG CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_TIPO_ALGORITMO PRIMARY KEY (ID_TIPO_ALGORITMO)
);

/*==============================================================*/
/* Table: TIPO_DOCUMENTO                                        */
/*==============================================================*/
CREATE TABLE TIPO_DOCUMENTO (
   ID_TD                VARCHAR(2)           NOT NULL,
   NOMBRE               VARCHAR(20)          NOT NULL,
   CONSTRAINT PK_TIPO_DOCUMENTO PRIMARY KEY (ID_TD)
);

/*==============================================================*/
/* Table: TIPO_USUARIO                                          */
/*==============================================================*/
CREATE TABLE TIPO_USUARIO (
   ID_TIPO_USUARIO      VARCHAR(2)           NOT NULL,
   NOMBRE               VARCHAR(20)          NOT NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_TIPO_USU CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   CONSTRAINT PK_TIPO_USUARIO PRIMARY KEY (ID_TIPO_USUARIO)
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
CREATE TABLE USUARIO (
   ID_USUARIO           VARCHAR(5)           NOT NULL,
   ID_TIPO_USUARIO      VARCHAR(2)           NOT NULL,
   NOMBRE               VARCHAR(50)          NOT NULL,
   EMAIL                VARCHAR(100)         NOT NULL,
   PASS                 VARCHAR(100)         NOT NULL,
   ID_TIPO_ALGORITMO    VARCHAR(2)           NULL,
   HORA_INICIAL         NUMERIC(2)           NOT NULL,
   HORA_FINAL           NUMERIC(2)           NOT NULL,
   ESTADO               VARCHAR(1)           NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_USUARIO CHECK (ESTADO IS NULL OR (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO))),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE NULL,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE NULL,
   CONSTRAINT PK_USUARIO PRIMARY KEY (ID_USUARIO)
);

/*==============================================================*/
/* Table: USUARIO_CINE                                          */
/*==============================================================*/
CREATE TABLE USUARIO_CINE (
   ID_USUARIO           VARCHAR(5)           NOT NULL,
   ID_CINE              VARCHAR(5)           NOT NULL,
   ESTADO               VARCHAR(1)           NOT NULL DEFAULT 'A'
      CONSTRAINT CKC_ESTADO_USUARIO_ CHECK (ESTADO IN ('A','I') AND ESTADO = UPPER(ESTADO)),
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE NOT NULL,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE NULL,
   ID_USUARIO_LOG       VARCHAR(5)           NOT NULL,
   CONSTRAINT PK_USUARIO_CINE PRIMARY KEY (ID_USUARIO, ID_CINE)
);

ALTER TABLE CINE
   ADD CONSTRAINT FK_CINE_REFERENCE_CIUDAD FOREIGN KEY (ID_CIUDAD)
      REFERENCES CIUDAD (ID_CIUDAD)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CINE_CARTELERAS
   ADD CONSTRAINT FK_CINE_CAR_REFERENCE_CINE FOREIGN KEY (ID_CINE)
      REFERENCES CINE (ID_CINE)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CINE_SALAS
   ADD CONSTRAINT FK_CINE_SAL_REFERENCE_CINE FOREIGN KEY (ID_CINE)
      REFERENCES CINE (ID_CINE)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CIUDAD
   ADD CONSTRAINT FK_CIUDAD_REFERENCE_DEPARTAM FOREIGN KEY (ID_DEPTO)
      REFERENCES DEPARTAMENTO (ID_DEPTO)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CLIENTE
   ADD CONSTRAINT FK_CLIENTE_REFERENCE_TIPO_DOC FOREIGN KEY (ID_TD)
      REFERENCES TIPO_DOCUMENTO (ID_TD)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CLIENTE_DIRECCIONES
   ADD CONSTRAINT FK_CLIENTE__REFERENCE_CIUDAD FOREIGN KEY (ID_CIUDAD)
      REFERENCES CIUDAD (ID_CIUDAD)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CLIENTE_DIRECCIONES
   ADD CONSTRAINT FK_CLIENTE_DIR_REF_CLIENTE FOREIGN KEY (ID_CLIENTE)
      REFERENCES CLIENTE (ID_CLIENTE)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CLIENTE_EMAILS
   ADD CONSTRAINT FK_CLIENTE_EMAILS_REF_CLIENTE FOREIGN KEY (ID_CLIENTE)
      REFERENCES CLIENTE (ID_CLIENTE)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CLIENTE_REDES
   ADD CONSTRAINT FK_CLIENTE__REFERENCE_RED_SOCI FOREIGN KEY (ID_RED_SOCIAL)
      REFERENCES RED_SOCIAL (ID_RED_SOCIAL)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CLIENTE_REDES
   ADD CONSTRAINT FK_CLIENTE_REDES_REF_CLIENTE FOREIGN KEY (ID_CLIENTE)
      REFERENCES CLIENTE (ID_CLIENTE)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CLIENTE_TELEFONOS
   ADD CONSTRAINT FK_CLIENTE__REFERENCE_PAIS FOREIGN KEY (ID_PAIS)
      REFERENCES PAIS (ID_PAIS)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE CLIENTE_TELEFONOS
   ADD CONSTRAINT FK_CLIENTE_TEL_REF_CLIENTE FOREIGN KEY (ID_CLIENTE)
      REFERENCES CLIENTE (ID_CLIENTE)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE DEPARTAMENTO
   ADD CONSTRAINT FK_DEPARTAM_REFERENCE_PAIS FOREIGN KEY (ID_PAIS)
      REFERENCES PAIS (ID_PAIS)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE PELICULA_CARTELERA
   ADD CONSTRAINT FK_PELICULA_REFERENCE_CINE_CAR FOREIGN KEY (ID_CARTELERA)
      REFERENCES CINE_CARTELERAS (ID_CARTELERA)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE PELICULA_CARTELERA
   ADD CONSTRAINT FK_PELICULA_REFERENCE_PELICULA FOREIGN KEY (ID_PELICULA)
      REFERENCES PELICULA (ID_PELICULA)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE USUARIO
   ADD CONSTRAINT FK_USUARIO_REFERENCE_TIPO_USU FOREIGN KEY (ID_TIPO_USUARIO)
      REFERENCES TIPO_USUARIO (ID_TIPO_USUARIO)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE USUARIO
   ADD CONSTRAINT FK_USUARIO_REFERENCE_TIPO_ALG FOREIGN KEY (ID_TIPO_ALGORITMO)
      REFERENCES TIPO_ALGORITMO (ID_TIPO_ALGORITMO)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE USUARIO_CINE
   ADD CONSTRAINT FK_USUARIO__REFERENCE_USUARIO FOREIGN KEY (ID_USUARIO)
      REFERENCES USUARIO (ID_USUARIO)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE USUARIO_CINE
   ADD CONSTRAINT FK_USUARIO__REFERENCE_CINE FOREIGN KEY (ID_CINE)
      REFERENCES CINE (ID_CINE)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

