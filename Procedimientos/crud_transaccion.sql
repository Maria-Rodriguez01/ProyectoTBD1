CREATE OR REPLACE PROCEDURE sp_insertar_transaccion(
    p_id_usuario INT,
    p_id_presupuesto INT,
    p_anio INT,
    p_mes INT,
    p_id_subcategoria INT,
    p_id_obligacion INT,
    p_tipo VARCHAR(20),
    p_descripcion VARCHAR(500),
    p_monto DECIMAL(10,2),
    p_fecha DATE,
    p_metodo_pago VARCHAR(50),
    p_num_factura VARCHAR(100),
    p_observaciones VARCHAR(500),
    p_creado_por VARCHAR(300)
)
AS
BEGIN
    INSERT INTO transaccion(
        id_usuario,
        id_presupuesto,
        anio,
        mes,
        id_subcategoria,
        id_obligacion,
        tipo_transaccion,
        descripcion,
        monto,
        fecha,
        metodo_pago,
        num_factura,
        observaciones,
        creado_por,
        creado_en
    )
    VALUES(
        p_id_usuario,
        p_id_presupuesto,
        p_anio,
        p_mes,
        p_id_subcategoria,
        p_id_obligacion,
        p_tipo,
        p_descripcion,
        p_monto,
        p_fecha,
        p_metodo_pago,
        p_num_factura,
        p_observaciones,
        p_creado_por,
        CURRENT TIMESTAMP
    )
END;

CREATE OR REPLACE PROCEDURE sp_actualizar_transaccion(
    p_id_transaccion INT,
    p_anio INT,
    p_mes INT,
    p_descripcion VARCHAR(500),
    p_monto DECIMAL(10,2),
    p_fecha DATE,
    p_metodo_pago VARCHAR(50),
    p_num_factura VARCHAR(100),
    p_observaciones VARCHAR(500),
    p_modificado_por VARCHAR(300)
)
AS
BEGIN
    UPDATE transaccion
    SET year = p_anio,
        mes = p_mes,
        descripcion = p_descripcion,
        monto = p_monto,
        fecha = p_fecha,
        metodo_pago = p_metodo_pago,
        num_factura = p_num_factura,
        observaciones = p_observaciones,
        modificado_por = p_modificado_por,
        modificado_en = CURRENT TIMESTAMP
    WHERE id_transaccion = p_id_transaccion;
END;

CREATE OR REPLACE PROCEDURE sp_eliminar_transaccion(
    p_id_transaccion INT
)
AS
BEGIN
    DELETE FROM transaccion
    WHERE id_transaccion = p_id_transaccion
END;

CREATE OR REPLACE PROCEDURE sp_consultar_transaccion(
    p_id_transaccion INT
)
AS
BEGIN
    SELECT *
    FROM transaccion
    WHERE id_transaccion = p_id_transaccion
END;

CREATE OR REPLACE PROCEDURE sp_listar_transacciones_presupuesto(
    p_id_presupuesto INT,
    p_anio INT,
    p_mes INT,
    p_tipo VARCHAR(20)
)
AS
BEGIN
    SELECT *
    FROM transaccion
    WHERE id_presupuesto = p_id_presupuesto
    AND (p_anio IS NULL OR anio = p_anio)
    AND (p_mes IS NULL OR mes = p_mes)
    AND (p_tipo IS NULL OR tipo_transaccion = p_tipo)
END;