CREATE OR REPLACE PROCEDURE sp_insertar_categoria(
    p_nombre        VARCHAR(300),
    p_descripcion   VARCHAR(300),
    p_tipo          VARCHAR(20),
    p_id_usuario    INT,
    p_creado_por    VARCHAR(300)
)
AS
BEGIN
    IF p_tipo NOT IN ('ingreso','gasto','ahorro')
    BEGIN
        RAISERROR 17001 'Tipo de categoria invalido'
        RETURN
    END

    INSERT INTO categoria
    (
        id_usuario,
        nombre,
        descripcion,
        tipo,
        creado_por,
        creado_en
    )
    VALUES
    (
        p_id_usuario,
        p_nombre,
        p_descripcion,
        p_tipo,
        p_creado_por,
        CURRENT TIMESTAMP
    )
END;

CREATE OR REPLACE PROCEDURE sp_actualizar_categoria (
    p_id_categoria INT,
    p_nombre VARCHAR(300),
    p_descripcion VARCHAR(300),
    p_modificado_por VARCHAR(300)
)
AS
BEGIN
    UPDATE categoria
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        modificado_por = p_modificado_por,
        modificado_en = CURRENT TIMESTAMP
    WHERE id_categoria = p_id_categoria;

END;

CREATE OR REPLACE PROCEDURE sp_eliminar_categoria(
    p_id_categoria INT
)
AS
BEGIN
    IF EXISTS(
        SELECT 1
        FROM subcategoria
        WHERE id_categoria = p_id_categoria
        AND indicador_activa = 1
    )
    BEGIN
        RAISERROR 17002 'No se puede eliminar porque aun existen subcategorias activas'
        RETURN
    END

    DELETE FROM categoria
    WHERE id_categoria = p_id_categoria
END;

CREATE OR REPLACE PROCEDURE sp_consultar_categoria (
    p_id_categoria INT
)
AS
BEGIN
    SELECT *
    FROM categoria
    WHERE id_categoria = p_id_categoria;
END;

CREATE OR REPLACE PROCEDURE sp_listar_categorias(
    p_id_usuario INT,
    p_tipo VARCHAR(20)
)
AS
BEGIN
    IF p_tipo IS NULL
    BEGIN
        SELECT *
        FROM categoria
        WHERE id_usuario = p_id_usuario
    END
    ELSE
    BEGIN
        SELECT *
        FROM categoria
        WHERE id_usuario = p_id_usuario
        AND tipo = p_tipo
    END
END;
