
--Funcion 1
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

--Funcion 3
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

--Funcion 3
CREATE OR REPLACE FUNCTION fn_obtener_balance_subcategoria(
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

--Funcion 4
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

--Funcion 5
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

--Funcion 6
CREATE OR REPLACE FUNCTION fn_dias_hasta_vencimiento(
    p_id_obligacion INT
)
RETURNS INT
BEGIN

    DECLARE v_dia INT;

    SELECT dia_vencimiento
    INTO v_dia
    FROM obligacion_fija
    WHERE id_obligacion = p_id_obligacion;

    RETURN v_dia - DAY(CURRENT DATE);

END;

--Funcion 7
--Esta funcion es para verificar si la fecha está
--dentro de la vigencia de el presupuesto
CREATE OR REPLACE FUNCTION fn_validar_vigencia_presupuesto(
    p_fecha DATE, 
    p_id_presupuesto INT
)
    RETURNS INT
    BEGIN
    DECLARE v_dentro_del_rango INT;
    DECLARE v_year_inicio INT;
    DECLARE v_year_fin INT;
    DECLARE v_mes_inicio INT;
    DECLARE v_mes_fin INT;

    SELECT year_inicio, mes_inicio, year_fin, mes_fin 
    INTO v_anio_inicio, v_mes_inicio, v_year_fin, v_mes_fin
    FROM presupuesto 
    WHERE id_presupuesto = p_id_presupuesto;
    IF((YEAR(p_fecha)>v_year_inicio OR (YEAR(p_fecha) = v_anio_inicio AND MONTH(p_fecha) >= v_mes_inicio) AND
    v_year_fin IS NULL OR (YEAR(p_fecha) < v_year_fin OR (YEAR(p_fecha) = v_year_fin AND MONTH(p_fecha) <= v_mes_fin))))
    THEN SET v_dentro_del_rango = 1;
    ELSE SET v_dentro_del_rango = 0;
    END IF;
    RETURN v_dentro_del_rango;
    END;

--Funcion 8
--Identificador padre de una subcategoria
CREATE OR REPLACE FUNCTION fn_obtener_categoria_por_subcategoria(
    p_id_subcategoria INT
)
    RETURNS INT
    BEGIN
    DECLARE v_categoria INT;

    SELECT id_categoria
    INTO v_categoria 
    FROM subcategoria
    WHERE p_id_subcategoria = id_subcategoria;

    RETURN v_categoria;
    END;

--Funcion 9 
--Proyecta el gasto final del mes basado en el comportamiento actual 
CREATE OR REPLACE FUNCTION fn_calcular_proyeccion_gasto_mensual(p_id_subcategoria INT , 
    p_anio INT , 
    p_mes INT 
    )
    RETURNS DECIMAL(10,2)
    BEGIN

--Funcion 10
CREATE OR REPLACE FUNCTION fn_obtener_promedio_gasto_subcategoria(p_id_usuario INT,
    p_id_subcategoria INT,
    p_cantidad_meses INT
)
    RETURNS DECIMAL(10,2)
    BEGIN

    DECLARE v_promedio DECIMAL(10,2)

    

