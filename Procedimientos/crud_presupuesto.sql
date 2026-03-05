CREATE OR REPLACE PROCEDURE sp_insertar_presupuesto(
    p_id_usuario INT,
    p_nombre VARCHAR(300),
    p_descripcion VARCHAR(500),
    p_periodo_inicio DATE,
    p_periodo_fin DATE,
    p_creado_por VARCHAR(300)
)
AS
BEGIN
    IF p_periodo_fin < p_periodo_inicio BEGIN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE STRING = 'La fecha final debe ser mayor que la fecha inicial';
    END;

    INSERT INTO presupuesto(
        id_usuario,
        nombre,
        descripcion,
        periodo_inicio,
        periodo_fin,
        estado,
        creado_por,
        creado_en
    )
    VALUES(
        p_id_usuario,
        p_nombre,
        p_descripcion,
        p_periodo_inicio,
        p_periodo_fin,
        1,
        p_creado_por,
        CURRENT TIMESTAMP
    );
END;

CREATE OR REPLACE PROCEDURE sp_actualizar_presupuesto(
    p_id_presupuesto INT,
    p_nombre VARCHAR(300),
    p_descripcion VARCHAR(500),
    p_periodo_inicio DATE,
    p_periodo_fin DATE,
    p_modificado_por VARCHAR(300)
)
AS
BEGIN
    IF p_periodo_fin < p_periodo_inicio
    BEGIN
        RAISERROR 17002 'La fecha final debe ser mayor que la fecha inicial'
        RETURN
    END
    UPDATE presupuesto
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        periodo_inicio = p_periodo_inicio,
        periodo_fin = p_periodo_fin,
        modificado_por = p_modificado_por,
        modificado_en = CURRENT TIMESTAMP
    WHERE id_presupuesto = p_id_presupuesto
END;

CREATE OR REPLACE PROCEDURE sp_eliminar_presupuesto(
    p_id_presupuesto INT
)
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM transaccion
        WHERE id_presupuesto = p_id_presupuesto
    )
    BEGIN
        RAISERROR 17003 'No se puede eliminar si el presupuesto tiene transacciones'
        RETURN
    END

    DELETE FROM presupuesto
    WHERE id_presupuesto = p_id_presupuesto;
END;

CREATE OR REPLACE PROCEDURE sp_consultar_presupuesto(
    p_id_presupuesto INT
)
AS
BEGIN
    SELECT *
    FROM presupuesto
    WHERE id_presupuesto = p_id_presupuesto;
END;

CREATE OR REPLACE PROCEDURE sp_listar_presupuestos_usuario(
    p_id_usuario INT,
    p_estado BIT
)
AS
BEGIN
    IF p_estado IS NULL
    BEGIN
        SELECT *
        FROM presupuesto
        WHERE id_usuario = p_id_usuario;
    END
    ELSE
    BEGIN
        SELECT *
        FROM presupuesto
        WHERE id_usuario = p_id_usuario
        AND estado = p_estado;
    END
END;