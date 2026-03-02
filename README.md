# ProyectoTBD1  
## Sistema de Gestión de Presupuesto Personal  

---

## 1. Descripción General  

El presente proyecto consiste en el desarrollo de un sistema integral de gestión de presupuesto personal, cuyo propósito es permitir al usuario planificar, controlar y analizar sus finanzas de manera eficiente y organizada.

El sistema permite registrar información financiera relevante como ingresos, gastos, obligaciones mensuales y metas de ahorro. A través de la aplicación, el usuario podrá administrar sus recursos económicos de forma estructurada, facilitando la toma de decisiones financieras responsables.

---

## 2. Objetivo General  

Aplicar los conocimientos adquiridos en la asignatura **Teoría de Base de Datos I**, mediante el diseño e implementación de una base de datos funcional que permita la gestión estructurada de información financiera personal.

---

## 3. Alcance del Sistema  

El sistema deberá permitir:

- Gestionar usuarios con información básica.  
- Definir presupuestos con vigencia temporal (fecha inicial y fecha límite).  
- Clasificar ingresos, gastos y ahorros mediante categorías y subcategorías.  
- Registrar obligaciones fijas mensuales (renta, servicios, seguros, préstamos y deudas).  
- Registrar transacciones individuales asociadas a una categoría específica.  
- Generar y visualizar reportes analíticos para el análisis financiero.  

---

## 4. Tecnologías y Recursos Utilizados  

| Capa | Tecnología |
|------|------------|
| Base de Datos | SQL Anywhere |
| Backend | Java |
| Frontend | Java (Swing) |
| Reportería | Metabase |
| Control de Versiones | GitHub |

---

## 5. Instalación de SQL Anywhere  

Para la instalación de la base de datos, se accedió al sitio oficial de SAP:

https://www.sap.com/products/data-cloud/sql-anywhere.html  

Desde allí se descargó el instalador correspondiente al sistema operativo Windows. Posteriormente, se ejecutó el proceso de instalación siguiendo las instrucciones del asistente hasta completar correctamente la instalación.

---

## 6. Creación de la Base de Datos en SQL Central  

Para la creación de la base de datos se realizaron los siguientes pasos:

1. Se abrió el programa **SQL Central**.  
2. Se seleccionó la opción **Tools**.  
3. Se eligió **SQL Anywhere**.  
4. Se hizo clic en **Create Database**.  
5. Se seleccionó la ubicación local en el equipo.  
6. Se guardó el archivo con el nombre
    22441044_ProyectoTBD.db

8. Se activó la opción **JConnect metadata support**, debido a que la base de datos será conectada posteriormente con una aplicación desarrollada en Java.  
9. Se configuraron las opciones de collation relacionadas con idioma, manejo de acentos y sensibilidad de mayúsculas/minúsculas, asegurando compatibilidad con el idioma español.

---

## 7. Creación de la Tablas dentro de la Base de Datos
Para crear las tablas de las diferentes entidades, hice uso de el .sql ya creado de el dbml creado inicialmente:
---
CREATE TABLE "usuario" (
  "id_usuario" int PRIMARY KEY,
  "nombre" varchar(300),
  "apellido" varchar(300),
  "correo" varchar(300),
  "password" varchar(300),
  "fecha_registro" date,
  "salario_mensual" double,
  "estado" BIT,
  "creado_por" varchar(300),
  "modificado_por" varchar(300),
  "creado_en" timestamp,
  "modificado_en" timestamp
);

CREATE TABLE "presupuesto" (
  "id_presupuesto" int PRIMARY KEY,
  "id_usuario" int,
  "usuario" varchar(300),
  "nombre" varchar(300),
  "year_inicio" int,
  "mes_inicio" int,
  "year_fin" int,
  "mes_fin" int,
  "total_ingresos" double,
  "total_gastos" double,
  "total_ahorro" double,
  "fecha_hora_creacion" date,
  "estado" BIT,
  "creado_por" varchar(300),
  "modificado_por" varchar(300),
  "creado_en" timestamp,
  "modificado_en" timestamp
);

CREATE TABLE "categoria" (
  "id_categoria" int PRIMARY KEY,
  "id_usuario" int,
  "nombre" varchar(300),
  "descripcion" varchar(300),
  "tipo" varchar(300),
  "creado_por" varchar(300),
  "modificado_por" varchar(300),
  "creado_en" timestamp,
  "modificado_en" timestamp
);

CREATE TABLE "subcategoria" (
  "id_subcategoria" int PRIMARY KEY,
  "id_categoria" int,
  "categoria" varchar(300),
  "nombre" varchar(300),
  "descripcion" varchar(300),
  "indicador_activa" BIT,
  "indicador_subcategoria" varchar(300),
  "creado_por" varchar(300),
  "modificado_por" varchar(300),
  "creado_en" timestamp,
  "modificado_en" timestamp
);

CREATE TABLE "presupuesto_detalle" (
  "id_presupuesto_detalle" int PRIMARY KEY,
  "id_presupuesto" int,
  "id_subcategoria" int,
  "monto_mensual" double,
  "observaciones" varchar(500),
  "creado_por" varchar(300),
  "modificado_por" varchar(300),
  "creado_en" timestamp,
  "modificado_en" timestamp
);

CREATE TABLE "obligacion_fija" (
  "id_obligacion" int PRIMARY KEY,
  "id_subcategoria" int,
  "nombre" varchar(300),
  "descripcion" varchar(500),
  "monto_mensual" double,
  "dia_vencimiento" int,
  "vigente" BIT,
  "fecha_inicio" date,
  "fecha_finalizacion" date,
  "creado_por" varchar(300),
  "modificado_por" varchar(300),
  "creado_en" timestamp,
  "modificado_en" timestamp
);

CREATE TABLE "transaccion" (
  "id_transaccion" int PRIMARY KEY,
  "id_presupuesto" int,
  "year" int,
  "mes" int,
  "id_obligacion" int,
  "tipo_transaccion" varchar(300),
  "descripcion" varchar,
  "monto" double,
  "fecha" date,
  "metodo_pago" varchar,
  "fecha_registro" datetime,
  "num_factura" varchar,
  "observaciones" varchar,
  "creado_por" varchar(300),
  "modificado_por" varchar(300),
  "creado_en" timestamp,
  "modificado_en" timestamp
);

CREATE TABLE "transacciones_obligacion_fija" (
  "id_transaccion" int PRIMARY KEY,
  "id_obligacion" int
);

ALTER TABLE "presupuesto" ADD FOREIGN KEY ("id_usuario") REFERENCES "usuario" ("id_usuario");

ALTER TABLE "subcategoria" ADD FOREIGN KEY ("id_categoria") REFERENCES "categoria" ("id_categoria");

ALTER TABLE "presupuesto_detalle" ADD FOREIGN KEY ("id_presupuesto") REFERENCES "presupuesto" ("id_presupuesto");

ALTER TABLE "presupuesto_detalle" ADD FOREIGN KEY ("id_subcategoria") REFERENCES "subcategoria" ("id_subcategoria");

ALTER TABLE "obligacion_fija" ADD FOREIGN KEY ("id_subcategoria") REFERENCES "subcategoria" ("id_subcategoria");

ALTER TABLE "transaccion" ADD FOREIGN KEY ("id_presupuesto") REFERENCES "presupuesto" ("id_presupuesto");

ALTER TABLE "transacciones_obligacion_fija" ADD FOREIGN KEY ("id_transaccion") REFERENCES "transaccion" ("id_transaccion");

ALTER TABLE "transacciones_obligacion_fija" ADD FOREIGN KEY ("id_obligacion") REFERENCES "obligacion_fija" ("id_obligacion");
---
Se crearon las siguientes tablas: usuario, transaccion, obligacion fija, presupuesto, categoria, subcategoria, presupuesto-detalle y transacciones-obligacion fija.
    
