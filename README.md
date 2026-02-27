# ProyectoTBD1

## 1. Descripcion General
En el proyecto a continuancion, se proyecta el desarrollo de un sistema completo de gestion
de presupuesto personal que permite a un usuario planificar, controlar y analizar sus finanzas 
de forma que sea facil y efectivo. Dentro del sistema se puede agregar datos como ingresos, 
gastos, obligaciones mensaules y metas de ahorro a traves de la aplicacion, de manera en que se
le facilita al usuario manejarlas.

## 2. Objetivo General
Aplicar conocimientos adquiridos a lo largo de la clase de Teoria de Base de Datos 1 para poder generar
mediante la implementacion de lo aprendido una gestion para el manejo financiero personal.

## 3. Alcance del Sistema
El sistema a continuacion debera permitir:
 - Gestionar usuarios con informacion basica
 - Definir presupuestos con vigencia temporal (fecha inicial a fecha limite )
 - Clasificar correctamente los ingresos, gastos y ahorros divididos en categorias y subcategorias
 - Registrar las obligaciones fijas mensuales(renta, servicios, seguros, prestamos, deudas)
 - Registrar transacciones individuales por categoria
 - Visualizar reportes analiticos de dicha informacion

## 4. Tecnologias/ Recursos utilizados en el proyecto
| Capa | Tecnologia |
|------|------------|
| Base de Datos | SQL Anywhere|
| Backend | Java |
| Frontend | Java (Swing) |
| Reporteria | Metabase |
| Control de Versiones | Github |

## 5. Instalacion de SQL Anywhere (base de datos utilizada)
Para hacer la instalacion, ingrese a https://www.sap.com/products/data-cloud/sql-anywhere.html,
donde se encuentra el instalador de la base de datos. Se descargo un archivo, y a partir de ello
comence el proceso de instalacion. En este caso yo elegi el instalador para Windows.

## 6.Creacion de base de datos en SQL Central (SQL Anywhere)
Para poder crear mi base de datos, entre al programa y le di click al boton de Tools, elegi SQL Anywhere(Adonde estare creando mi base de datos) y le di click al boton de Create Database. Despues, me aparecio la opcion de elegir adonde crearia yo la base de datos, yo elegi en mi computadora porque alli seria donde estaria trabajando. Por ultimo me aparecio la opcion de elegir adonde y como guardaria el proyecto, en mi caso, guarde el proyecto en la carpeta de la clase de la carrera y lo llame "22441044_ProyectoTBD.db". Tambien se me dio la opcion de instalar JConnect metadata support, lo instale ya que estare conectando la base de datos con Java. Despues me salieron configuracions ya sea para acentos, manejo de espacios e idioma.
