CREATE OR REPLACE PROCEDURE sp_insertar_presupuesto_detalle(
    p_id_presupuesto INT,
    p_id_subcategoria INT,
    p_monto_mensual DECIMAL(10,2),
    p_observaciones VARCHAR(500),
    p_creado_por VARCHAR(300)
)
AS
BEGIN
    INSERT INTO presupuesto_detalle(
        id_presupuesto,
        id_subcategoria,
        monto_mensual,
        observaciones,
        creado_por,
        creado_en
    )
    VALUES(
        p_id_presupuesto,
        p_id_subcategoria,
        p_monto_mensual,
        p_observaciones,
        p_creado_por,
        CURRENT TIMESTAMP
    )
END;

CREATE OR REPLACE PROCEDURE sp_actualizar_presupuesto_detalle(
    p_id_detalle INT,
    p_monto_mensual DECIMAL(10,2),
    p_observaciones VARCHAR(500),
    p_modificado_por VARCHAR(300)
)
AS
BEGIN
    UPDATE presupuesto_detalle
    SET monto_mensual = p_monto_mensual,
        observaciones = p_observaciones,
        modificado_por = p_modificado_por,
        modificado_en = CURRENT TIMESTAMP
    WHERE id_presupuesto_detalle = p_id_detalle
END;

CREATE OR REPLACE PROCEDURE sp_eliminar_presupuesto_detalle(
    p_id_detalle INT
)
AS
BEGIN
    DELETE FROM presupuesto_detalle
    WHERE id_presupuesto_detalle = p_id_detalle
END;

CREATE OR REPLACE PROCEDURE sp_consultar_presupuesto_detalle(
    p_id_detalle INT
)
AS
BEGIN
    SELECT
        pd.id_presupuesto_detalle,
        pd.monto_mensual,
        pd.observaciones,
        s.id_subcategoria,
        s.nombre AS subcategoria,
        c.id_categoria,
        c.nombre AS categoria
    FROM presupuesto_detalle pd
    JOIN subcategoria s
        ON pd.id_subcategoria = s.id_subcategoria
    JOIN categoria c
        ON s.id_categoria = c.id_categoria
    WHERE pd.id_presupuesto_detalle = p_id_detalle
END;

CREATE OR REPLACE PROCEDURE sp_listar_detalles_presupuesto(
    p_id_presupuesto INT
)
AS
BEGIN
    SELECT
        pd.id_presupuesto_detalle,
        pd.monto_mensual,
        s.nombre AS subcategoria
    FROM presupuesto_detalle pd
    JOIN subcategoria s
        ON pd.id_subcategoria = s.id_subcategoria
    WHERE pd.id_presupuesto = p_id_presupuesto
END;
