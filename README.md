# ProyectoTBD1
# Sistema de Gestión de Presupuesto Personal

---

## 1. Descripción General

El presente proyecto consiste en el desarrollo de un **Sistema de Gestión de Presupuesto Personal**, diseñado con el objetivo de ayudar a los usuarios a planificar, registrar y analizar sus finanzas personales de forma estructurada y organizada.

La aplicación permite llevar un control detallado de los **ingresos, gastos, ahorros y obligaciones financieras**, brindando al usuario una herramienta que facilita la administración de su dinero y mejora la toma de decisiones financieras.

A través del sistema es posible registrar diferentes tipos de movimientos financieros, clasificar gastos mediante categorías y subcategorías, establecer presupuestos con periodos específicos y analizar la información mediante reportes.

El sistema fue desarrollado aplicando los conceptos aprendidos en la asignatura **Teoría de Base de Datos I**, integrando el diseño de una base de datos relacional con una aplicación desarrollada en Java que permite interactuar con los datos almacenados.

---

## 2. Objetivo General

Aplicar los conocimientos adquiridos en la asignatura **Teoría de Base de Datos I**, mediante el diseño e implementación de un sistema de base de datos funcional que permita gestionar información financiera personal de manera estructurada, segura y eficiente.

---

## 3. Objetivos Específicos

- Diseñar una base de datos relacional para almacenar información financiera personal.
- Implementar tablas relacionadas que permitan representar correctamente las entidades del sistema.
- Crear procedimientos, funciones y triggers que automaticen procesos dentro de la base de datos.
- Desarrollar operaciones **CRUD (Create, Read, Update, Delete)** para la gestión de datos.
- Conectar la base de datos con una aplicación desarrollada en **Java utilizando JDBC**.
- Generar reportes que permitan visualizar y analizar la información financiera.

---

## 4. Alcance del Sistema

El sistema permite realizar las siguientes funciones:

- Gestión de usuarios y registro de información personal.
- Creación y administración de presupuestos con periodo de vigencia.
- Clasificación de ingresos, gastos y ahorros mediante categorías y subcategorías.
- Registro de obligaciones financieras fijas como renta, servicios o préstamos.
- Registro de transacciones financieras individuales.
- Visualización de datos financieros organizados.
- Generación de reportes que permitan analizar el comportamiento financiero del usuario.

Este sistema está orientado a facilitar la **organización financiera personal**, permitiendo al usuario llevar un mejor control de sus recursos económicos.

---

## 5. Tecnologías Utilizadas

| Capa | Tecnología |
|-----|-------------|
| Base de Datos | SQL Anywhere |
| Backend | Java |
| Interfaz Gráfica | Java Swing |
| Reportería | Metabase |
| Conexión BD | JDBC |
| Control de Versiones | GitHub |

---

## 6. Instalación de SQL Anywhere

Para la implementación del sistema se utilizó el gestor de base de datos **SQL Anywhere**, desarrollado por SAP.

El proceso de instalación se realizó de la siguiente manera:

1. Acceder al sitio oficial de SAP  
https://www.sap.com/products/data-cloud/sql-anywhere.html  

2. Descargar el instalador correspondiente al sistema operativo Windows.

3. Ejecutar el instalador siguiendo las instrucciones del asistente.

4. Una vez completada la instalación, verificar el funcionamiento mediante **SQL Central**, la herramienta utilizada para administrar la base de datos.

---

## 7. Creación de la Base de Datos

Para la creación de la base de datos se utilizó **SQL Central**.

Pasos realizados:

1. Abrir **SQL Central**.
2. Seleccionar **Tools**.
3. Elegir **SQL Anywhere**.
4. Hacer clic en **Create Database**.
5. Seleccionar la ubicación donde se guardará la base de datos.
6. Guardar el archivo con el nombre:

```
22441044_ProyectoTBD.db
```

Durante la configuración se activó la opción:

**JConnect Metadata Support**

Esto permite conectar posteriormente la base de datos con aplicaciones desarrolladas en Java.

También se configuraron opciones de **collation** relacionadas con idioma, manejo de acentos y sensibilidad de mayúsculas y minúsculas para asegurar compatibilidad con el idioma español.

---

## 8. Diseño de la Base de Datos

El modelo de datos del sistema fue diseñado utilizando **DBDiagram**.

Posteriormente se descargó el archivo SQL generado y se adaptó manualmente la sintaxis para que fuera compatible con **SQL Anywhere**, ya que la herramienta no genera automáticamente el formato adecuado para este gestor de base de datos.

Las tablas principales creadas en el sistema son:

- usuario
- presupuesto
- categoria
- subcategoria
- presupuesto_detalle
- obligacion_fija
- transaccion
- transacciones_obligacion_fija

Cada una de estas tablas representa una entidad importante dentro del sistema financiero.

---

## 9. Descripción de las Tablas

### Tabla Usuario

Almacena la información de los usuarios del sistema.

Campos principales:

- id_usuario
- nombre
- apellido
- correo
- password
- fecha_registro
- salario_mensual

---

### Tabla Presupuesto

Representa los presupuestos creados por los usuarios.

Incluye información como:

- periodo de inicio
- periodo de finalización
- total de ingresos
- total de gastos
- total de ahorro

---

### Tabla Categoría

Permite clasificar los diferentes tipos de movimientos financieros.

Ejemplos de categorías:

- alimentación
- transporte
- vivienda
- entretenimiento

---

### Tabla Subcategoría

Permite una clasificación más específica dentro de cada categoría.

Ejemplo:

Categoría: Transporte  

Subcategorías:
- gasolina
- transporte público
- mantenimiento del vehículo

---

### Tabla Presupuesto Detalle

Relaciona las subcategorías con un presupuesto específico y permite asignar montos mensuales para cada categoría.

---

### Tabla Obligación Fija

Permite registrar pagos recurrentes como:

- renta
- servicios
- préstamos
- seguros

Incluye información como el monto mensual y el día de vencimiento.

---

### Tabla Transacción

Registra cada movimiento financiero realizado por el usuario.

Campos importantes:

- monto
- fecha
- método de pago
- tipo de transacción
- descripción

---

### Tabla Transacciones Obligación Fija

Relaciona las transacciones con obligaciones fijas cuando corresponde.

---

## 10. Relaciones de la Base de Datos

Las tablas se encuentran relacionadas mediante **llaves foráneas (Foreign Keys)**.

Ejemplos:

- Un usuario puede tener múltiples presupuestos.
- Una categoría puede tener varias subcategorías.
- Un presupuesto puede tener múltiples transacciones.
- Una subcategoría puede tener obligaciones fijas.

Estas relaciones permiten mantener la **integridad y consistencia de los datos** dentro del sistema.

---

## 11. Implementación de CRUD

Para cada tabla se implementaron operaciones **CRUD**.

CRUD significa:

- **Create** → crear registros
- **Read** → consultar registros
- **Update** → actualizar registros
- **Delete** → eliminar registros

Estas operaciones permiten que el usuario pueda interactuar con la base de datos desde la aplicación.

---

## 12. Funciones, Procedimientos y Triggers

Además del CRUD, se implementaron elementos avanzados de bases de datos.

### Funciones

Permiten realizar cálculos o generar resultados a partir de los datos almacenados.

Ejemplo:

- cálculo de montos totales
- análisis de gastos por categoría

### Procedimientos Almacenados

Permiten ejecutar procesos dentro de la base de datos para automatizar operaciones y mejorar el rendimiento.

### Triggers

Los triggers permiten ejecutar acciones automáticamente cuando ocurre un evento en la base de datos.

Por ejemplo:

- ejecutar validaciones al insertar registros
- actualizar información relacionada automáticamente

---

## 13. Conexión de la Base de Datos con Java

Para la implementación de la interfaz visual se utilizó **Apache NetBeans**.

La conexión entre Java y SQL Anywhere se realizó mediante **JDBC (Java Database Connectivity)**.

Se agregó la librería:

```
sajdbc4.jar
```

Ubicada en:

```
C:\Program Files\SQL Anywhere 17\Java\sajdbc4.jar
```

La conexión se realiza mediante una cadena de conexión como la siguiente:

```java
String url = "jdbc:sqlanywhere:uid=Maria Rodriguez;pwd=********;"
        + "dbf=C:/Users/Maria Gabriela/OneDrive/Desktop/Ingenieria en Sistemas/TBD/22441044_ProyectoTBD.db";
```

Esto permite que la aplicación Java pueda ejecutar consultas SQL directamente en la base de datos.

---

## 14. Generación de Datos de Prueba

Para generar datos de prueba se utilizó la herramienta:

https://www.mockaroo.com

Esta herramienta permite crear grandes cantidades de datos simulados para poblar las tablas de la base de datos.

Los identificadores principales de las tablas se generan mediante **autoincremento**, por lo que no es necesario especificarlos manualmente al momento de insertar registros.

---

## 15. Conclusión

El desarrollo de este proyecto permitió aplicar de manera práctica los conocimientos adquiridos en la asignatura **Teoría de Base de Datos I**, integrando el diseño de una base de datos relacional con una aplicación funcional.

El sistema desarrollado permite gestionar información financiera personal mediante tecnologías como **SQL Anywhere, Java y JDBC**, demostrando la importancia de una correcta estructuración de datos y la implementación de procesos automatizados dentro de una base de datos.

Este tipo de sistemas representa la base de muchas aplicaciones utilizadas en organizaciones y empresas para la gestión de información financiera y administrativa.
