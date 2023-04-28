/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     4/27/2023 11:53:21 PM                        */
/*==============================================================*/


drop table CLIENTE;

drop table FACTURA;

drop table FACTURA_DETALLE;

drop table PRODUCTO;

drop table PRODUCTO_UNIDAD;

drop table TIPO_DOCUMENTO;

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   ID_CLIENTE           SERIAL not null,
   NOMBRE               varchar(30)          not null,
   APELLIDOS            varchar(30)          not null,
   ID_TIPO_DOCUMENTO    varchar(2)           not null,
   DOCUMENTO            varchar(20)          not null,
   FECHA_NACIMIENTO     date                 not null,
   ESTADO               numeric(1)           null,
   constraint PK_CLIENTE primary key (ID_CLIENTE)
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   ID_MAESTRO           SERIAL               not null,
   REFERENCIA           CHAR(10)             not null,
   ID_CLIENTE           INT10                null,
   VALOR_NETO           DECIMAL(15,2)        null,
   constraint PK_FACTURA primary key (ID_MAESTRO)
);

/*==============================================================*/
/* Table: FACTURA_DETALLE                                       */
/*==============================================================*/
create table FACTURA_DETALLE (
   ID                   NUMERIC(20)          not null,
   ID_MAESTRO           INT4                 null,
   ID_PRODUCTO          varchar(10)          not null,
   CANTIDAD             NUMERIC(0)           not null,
   VALOR_TOTAL          DECIMAL(15,2)        null,
   constraint PK_FACTURA_DETALLE primary key (ID)
);

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   ID_PRODUCTO          varchar(10)          not null,
   ID_PRODUCTO_UNIDAD   VARCHAR(5)           null,
   NOMBRE               varchar(30)          not null,
   VALOR_UNITARIO       DECIMAL(15,2)        not null,
   STOCK_ACTUAL         numeric(10)          not null,
   constraint PK_PRODUCTO primary key (ID_PRODUCTO)
);

/*==============================================================*/
/* Table: PRODUCTO_UNIDAD                                       */
/*==============================================================*/
create table PRODUCTO_UNIDAD (
   ID_PRODUCTO_UNIDAD   VARCHAR(5)           not null,
   NOMBRE               varchar(30)          not null,
   constraint PK_PRODUCTO_UNIDAD primary key (ID_PRODUCTO_UNIDAD)
);

/*==============================================================*/
/* Table: TIPO_DOCUMENTO                                        */
/*==============================================================*/
create table TIPO_DOCUMENTO (
   ID_TIPO_DOCUMENTO    varchar(2)           not null,
   NOMBRE               varchar(20)          not null,
   ESTADO               numeric(1)           null,
   constraint PK_TIPO_DOCUMENTO primary key (ID_TIPO_DOCUMENTO)
);

alter table CLIENTE
   add constraint FK_CLIENTE_REFERENCE_TIPO_DOC foreign key (ID_TIPO_DOCUMENTO)
      references TIPO_DOCUMENTO (ID_TIPO_DOCUMENTO)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_REFERENCE_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE)
      on delete restrict on update restrict;

alter table FACTURA_DETALLE
   add constraint FK_FACTURA__REFERENCE_FACTURA foreign key (ID_MAESTRO)
      references FACTURA (ID_MAESTRO)
      on delete restrict on update restrict;

alter table FACTURA_DETALLE
   add constraint FK_FACTURA__REFERENCE_PRODUCTO foreign key (ID_PRODUCTO)
      references PRODUCTO (ID_PRODUCTO)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_REFERENCE_PRODUCTO foreign key (ID_PRODUCTO_UNIDAD)
      references PRODUCTO_UNIDAD (ID_PRODUCTO_UNIDAD)
      on delete restrict on update restrict;

