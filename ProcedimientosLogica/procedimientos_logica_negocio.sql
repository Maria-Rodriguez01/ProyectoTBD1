CREATE OR REPLACE PROCEDURE sp_registrar_transaccion_completa(
    IN p_id_usuario INT,
    IN p_id_presupuesto INT,
    IN p_anio INT,
    IN p_mes INT,
    IN p_id_subcategoria INT,
    IN p_tipo VARCHAR(50),
    IN p_descripcion VARCHAR(300),
    IN p_monto DECIMAL(10,2),
    IN p_fecha DATE,
    IN p_metodo_pago VARCHAR(50),
    IN p_creado_por VARCHAR(300)
)
BEGIN

INSERT INTO transaccion(
    id_presupuesto,
    year,
    mes,
    id_subcategoria,
    tipo_transaccion,
    descripcion,
    monto,
    fecha,
    metodo_pago,
    creado_por,
    creado_en
)
VALUES(
    p_id_presupuesto,
    p_anio,
    p_mes,
    p_id_subcategoria,
    p_tipo,
    p_descripcion,
    p_monto,
    p_fecha,
    p_metodo_pago,
    p_creado_por,
    CURRENT TIMESTAMP
);

END;

CREATE OR REPLACE PROCEDURE sp_procesar_obligaciones_mes(
    IN p_id_usuario INT,
    IN p_anio INT,
    IN p_mes INT,
    IN p_id_presupuesto INT
)
BEGIN

SELECT
    nombre,
    monto_mensual,
    dia_vencimiento
FROM obligacion_fija
WHERE vigente = 1;

END;

CREATE OR REPLACE PROCEDURE sp_calcular_balance_mensual(
    IN p_id_usuario INT,
    IN p_id_presupuesto INT,
    IN p_anio INT,
    IN p_mes INT,
    OUT p_total_ingresos DECIMAL(10,2),
    OUT p_total_gastos DECIMAL(10,2),
    OUT p_total_ahorros DECIMAL(10,2),
    OUT p_balance_final DECIMAL(10,2)
)
BEGIN

SELECT COALESCE(SUM(monto),0)
INTO p_total_ingresos
FROM transaccion
WHERE tipo_transaccion='ingreso'
AND year=p_anio
AND mes=p_mes
AND id_presupuesto=p_id_presupuesto;

SELECT COALESCE(SUM(monto),0)
INTO p_total_gastos
FROM transaccion
WHERE tipo_transaccion='gasto'
AND year=p_anio
AND mes=p_mes
AND id_presupuesto=p_id_presupuesto;

SELECT COALESCE(SUM(monto),0)
INTO p_total_ahorros
FROM transaccion
WHERE tipo_transaccion='ahorro'
AND year=p_anio
AND mes=p_mes
AND id_presupuesto=p_id_presupuesto;

SET p_balance_final =
    p_total_ingresos - p_total_gastos - p_total_ahorros;

END;

CREATE OR REPLACE PROCEDURE sp_calcular_monto_ejecutado_mes(
    IN p_id_subcategoria INT,
    IN p_id_presupuesto INT,
    IN p_anio INT,
    IN p_mes INT,
    OUT p_monto_ejecutado DECIMAL(10,2)
)
BEGIN

SELECT COALESCE(SUM(monto),0)
INTO p_monto_ejecutado
FROM transaccion
WHERE id_subcategoria=p_id_subcategoria
AND id_presupuesto=p_id_presupuesto
AND year=p_anio
AND mes=p_mes;

END;

CREATE OR REPLACE PROCEDURE sp_calcular_porcentaje_ejecucion_mes(
    IN p_id_subcategoria INT,
    IN p_id_presupuesto INT,
    IN p_anio INT,
    IN p_mes INT,
    OUT p_porcentaje DECIMAL(10,2)
)
BEGIN

DECLARE v_ejecutado DECIMAL(10,2);
DECLARE v_presupuestado DECIMAL(10,2);

SELECT COALESCE(SUM(monto),0)
INTO v_ejecutado
FROM transaccion
WHERE id_subcategoria=p_id_subcategoria
AND id_presupuesto=p_id_presupuesto
AND year=p_anio
AND mes=p_mes;

SELECT monto_mensual
INTO v_presupuestado
FROM presupuesto_detalle
WHERE id_subcategoria=p_id_subcategoria
AND id_presupuesto=p_id_presupuesto;

SET p_porcentaje = (v_ejecutado / v_presupuestado) * 100;

END;

CREATE OR REPLACE PROCEDURE sp_cerrar_presupuesto(
    IN p_id_presupuesto INT,
    IN p_modificado_por VARCHAR(300)
)
BEGIN

UPDATE presupuesto
SET estado = 0,
    modificado_por = p_modificado_por,
    modificado_en = CURRENT TIMESTAMP
WHERE id_presupuesto = p_id_presupuesto;

END;

CREATE OR REPLACE PROCEDURE sp_obtener_resumen_categoria_mes(
    IN p_id_categoria INT,
    IN p_id_presupuesto INT,
    IN p_anio INT,
    IN p_mes INT,
    OUT p_monto_presupuestado DECIMAL(10,2),
    OUT p_monto_ejecutado DECIMAL(10,2),
    OUT p_porcentaje DECIMAL(10,2)
)
BEGIN

SELECT COALESCE(SUM(pd.monto_mensual),0)
INTO p_monto_presupuestado
FROM presupuesto_detalle pd
JOIN subcategoria s
ON pd.id_subcategoria = s.id_subcategoria
WHERE s.id_categoria = p_id_categoria
AND pd.id_presupuesto = p_id_presupuesto;

SELECT COALESCE(SUM(t.monto),0)
INTO p_monto_ejecutado
FROM transaccion t
JOIN subcategoria s
ON t.id_subcategoria = s.id_subcategoria
WHERE s.id_categoria = p_id_categoria
AND t.year = p_anio
AND t.mes = p_mes;

SET p_porcentaje =
(p_monto_ejecutado / p_monto_presupuestado) * 100;

END;