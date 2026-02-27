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
6. Se guardó el archivo con el nombre:

    22441044_ProyectoTBD.db

7. Se activó la opción **JConnect metadata support**, debido a que la base de datos será conectada posteriormente con una aplicación desarrollada en Java.  
8. Se configuraron las opciones de collation relacionadas con idioma, manejo de acentos y sensibilidad de mayúsculas/minúsculas, asegurando compatibilidad con el idioma español.
