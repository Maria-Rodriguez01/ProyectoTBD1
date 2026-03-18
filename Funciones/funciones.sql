CREATE OR REPLACE FUNCTION fn_calcular_monto_ejecutado(
    p_id_subcategoria INT,
    p_anio INT,
    p_mes INT
)
RETURNS DECIMAL(10,2)
BEGIN

    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(monto),0)
    INTO v_total
    FROM transaccion
    WHERE id_subcategoria = p_id_subcategoria
      AND anio = p_anio
      AND mes = p_mes;

    RETURN v_total;

END;

CREATE OR REPLACE FUNCTION fn_calcular_porcentaje_ejecutado(
    p_id_subcategoria INT,
    p_id_presupuesto INT,
    p_anio INT,
    p_mes INT
)
RETURNS DECIMAL(10,2)
BEGIN

    DECLARE v_ejecutado DECIMAL(10,2);
    DECLARE v_presupuestado DECIMAL(10,2);

    SELECT COALESCE(SUM(monto),0)
    INTO v_ejecutado
    FROM transaccion
    WHERE id_subcategoria = p_id_subcategoria
    AND anio = p_anio
    AND mes = p_mes;

    SELECT monto_mensual
    INTO v_presupuestado
    FROM presupuesto_detalle
    WHERE id_subcategoria = p_id_subcategoria
    AND id_presupuesto = p_id_presupuesto;

    RETURN (v_ejecutado / v_presupuestado) * 100

END;

CREATE FUNCTION fn_obtener_balance_subcategoria(
    p_id_presupuesto INT,
    p_id_subcategoria INT,
    p_anio INT,
    p_mes INT
)
RETURNS DECIMAL(10,2)
BEGIN

    DECLARE v_presupuestado DECIMAL(10,2);
    DECLARE v_ejecutado DECIMAL(10,2);

    SELECT monto_mensual
    INTO v_presupuestado
    FROM presupuesto_detalle
    WHERE id_presupuesto = p_id_presupuesto
    AND id_subcategoria = p_id_subcategoria;

    SELECT COALESCE(SUM(monto),0)
    INTO v_ejecutado
    FROM transaccion
    WHERE id_subcategoria = p_id_subcategoria
    AND anio = p_anio
    AND mes = p_mes;

    RETURN v_presupuestado - v_ejecutado

END;

CREATE OR REPLACE FUNCTION fn_obtener_total_categoria_mes(
    p_id_categoria INT,
    p_id_presupuesto INT,
    p_anio INT,
    p_mes INT
)
RETURNS DECIMAL(10,2)
BEGIN

    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(pd.monto_mensual),0)
    INTO v_total
    FROM presupuesto_detalle pd
    INNER JOIN subcategoria s
        ON pd.id_subcategoria = s.id_subcategoria
    WHERE s.id_categoria = p_id_categoria
      AND pd.id_presupuesto = p_id_presupuesto;

    RETURN v_total;

END;

CREATE OR REPLACE FUNCTION fn_obtener_total_ejecutado_categoria_mes(
    p_id_categoria INT,
    p_anio INT,
    p_mes INT
)
RETURNS DECIMAL(10,2)
BEGIN

    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(t.monto),0)
    INTO v_total
    FROM transaccion t
    INNER JOIN subcategoria s
        ON t.id_subcategoria = s.id_subcategoria
    WHERE s.id_categoria = p_id_categoria
      AND t.anio = p_anio
      AND t.mes = p_mes;

    RETURN v_total;

END;