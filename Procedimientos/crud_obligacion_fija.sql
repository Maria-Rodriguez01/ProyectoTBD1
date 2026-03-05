CREATE OR REPLACE PROCEDURE sp_insertar_obligacion (
    p_id_usuario INT,
    p_id_subcategoria INT,
    p_nombre VARCHAR(300),
    p_descripcion VARCHAR(500),
    p_monto DECIMAL(10,2),
    p_dia_vencimiento INT,
    p_fecha_inicio DATE,
    p_fecha_fin DATE,
    p_creado_por VARCHAR(300)
)
AS
BEGIN

    IF p_dia_vencimiento < 1 OR p_dia_vencimiento > 31 
    BEGIN
        RAISERROR 17001 'Dia de vencimiento invalido (1-31)'
        RETURN
    END ;

    IF p_fecha_fin IS NOT NULL AND p_fecha_fin < p_fecha_inicio BEGIN
      RAISERROR 17001 'La fecha de finalizacion debe ser mayor que la fecha de inicio'
        RETURN
    END IF;

    INSERT INTO obligacion_fija (
        id_usuario,
        id_subcategoria,
        nombre,
        descripcion,
        monto_mensual,
        dia_vencimiento,
        vigente,
        fecha_inicio,
        fecha_finalizacion,
        creado_por,
        creado_en
    )
    VALUES (
        p_id_usuario,
        p_id_subcategoria,
        p_nombre,
        p_descripcion,
        p_monto,
        p_dia_vencimiento,
        1,
        p_fecha_inicio,
        p_fecha_fin,
        p_creado_por,
        CURRENT TIMESTAMP
    );
END;

CREATE OR REPLACE PROCEDURE sp_actualizar_obligacion( 
    p_id_obligacion INT,
    p_nombre VARCHAR(300),
    p_descripcion VARCHAR(500),
    p_monto DECIMAL(10,2),
    p_dia_vencimiento INT,
    p_fecha_fin DATE,
    p_activo BIT,
    p_modificado_por VARCHAR(300)
)
AS 
BEGIN
    IF p_dia_vencimiento < 1 OR p_dia_vencimiento > 31
    BEGIN
        RAISERROR 17001 'Dia de vencimiento invalido (1-31)'
        RETURN
    END

    UPDATE obligacion_fija
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        monto_mensual = p_monto_mensual,
        dia_vencimiento = p_dia_vencimiento,
        fecha_finalizacion = p_fecha_finalizacion,
        vigente = p_activo,
        modificado_por = p_modificado_por,
        modificado_en = CURRENT TIMESTAMP
    WHERE id_obligacion= p_id_obligacion;
END;

CREATE OR REPLACE PROCEDURE sp_eliminar_obligacion (
    p_id_obligacion INT
)
AS
BEGIN
    UPDATE obligacion_fija
    SET activo = 0,
        modificado_en = CURRENT TIMESTAMP
    WHERE id_obligacion = p_id_obligacion;
END;

CREATE OR REPLACE PROCEDURE sp_consultar_obligacion (
    p_id_obligacion INT
)
AS
BEGIN
    SELECT 
        o.id_obligacion,
        o.nombre,
        o.descripcion,
        o.monto_mensual,
        o.dia_vencimiento,
        o.vigente,
        o.fecha_inicio,
        o.fecha_finalizacion,
        s.id_subcategoria,
        s.nombre AS subcategoria
    FROM obligacion_fija o
    JOIN subcategoria s
        ON o.id_subcategoria = s.id_subcategoria
    WHERE o.id_obligacion = p_id_obligacion;
END;

CREATE OR REPLACE PROCEDURE sp_listar_obligaciones_usuario (
    p_id_usuario INT,
    p_activo BIT
)
AS
BEGIN
    SELECT *
    FROM obligacion_fija
    WHERE id_obligacion = p_id_obligacion
      AND activo = p_activo;
END;