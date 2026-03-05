CREATE OR REPLACE PROCEDURE sp_insertar_subcategoria(
    p_id_categoria INT,
    p_nombre VARCHAR(300),
    p_descripcion VARCHAR(300),
    p_es_defecto BIT,
    p_creado_por VARCHAR(300)
)
AS
BEGIN
    INSERT INTO subcategoria(
        id_categoria,
        nombre,
        descripcion,
        indicador_activa,
        es_defecto,
        creado_por,
        creado_en
    )
    VALUES(
        p_id_categoria,
        p_nombre,
        p_descripcion,
        1,
        p_es_defecto,
        p_creado_por,
        CURRENT TIMESTAMP
    );
END;

CREATE OR REPLACE PROCEDURE sp_actualizar_subcategoria(p_id_subcategoria, 
    p_nombre, 
    p_descripcion, 
    p_modificado_por
)
AS 
BEGIN
    UPDATE subcategoria
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        modificado_por = p_modificado_por,
        modificado_en = CURRENT TIMESTAMP
    WHERE id_subcategoria = p_id_subcategoria;
END;

CREATE OR REPLACE PROCEDURE sp_eliminar_subcategoria(
    p_id_subcategoria INT
)
AS
BEGIN
    IF EXISTS(
        SELECT 1
        FROM presupuesto_detalle
        WHERE id_subcategoria = p_id_subcategoria
    )
    BEGIN
        RAISERROR 17001 'No se puede eliminar porque subcategoria esta siendo usada en presupuesto'
        RETURN
    END

    IF EXISTS(
        SELECT 1
        FROM transaccion
        WHERE id_subcategoria = p_id_subcategoria
    )
    BEGIN
        RAISERROR 17002 'No se puede eliminar porque la subcategoria esta siendo usada en transacciones'
        RETURN
    END

    DELETE FROM subcategoria
    WHERE id_subcategoria = p_id_subcategoria
END;

CREATE OR REPLACE PROCEDURE sp_consultar_subcategoria(
    p_id_subcategoria INT
)
AS
BEGIN
    SELECT
        s.id_subcategoria,
        s.nombre AS subcategoria,
        s.descripcion,
        s.indicador_activa,
        c.id_categoria,
        c.nombre AS categoria,
        c.tipo
    FROM subcategoria s
    JOIN categoria c
        ON s.id_categoria = c.id_categoria
    WHERE s.id_subcategoria = p_id_subcategoria
END;

CREATE OR REPLACE PROCEDURE sp_listar_subcategorias_por_categoria(
    p_id_categoria INT
)
AS
BEGIN
    SELECT *
    FROM subcategoria
    WHERE id_categoria = p_id_categoria
    AND indicador_activa = 1
END;