CREATE OR REPLACE PROCEDURE sp_insertar_usuario (
    p_nombre VARCHAR(300),
    p_apellido VARCHAR(300),
    p_correo VARCHAR(300),
    p_password VARCHAR(300),
    p_salario DECIMAL(10,2),
    p_creado_por VARCHAR(300)
)
BEGIN
    INSERT INTO usuario (
        nombre,
        apellido,
        correo,
        password,
        fecha_registro,
        salario_mensual,
        estado,
        creado_por,
        creado_en
    )
    VALUES (
        p_nombre,
        p_apellido,
        p_correo,
        p_password,
        CURRENT DATE,
        p_salario,
        1,
        p_creado_por,
        CURRENT TIMESTAMP
    );
END;


--Actualizar
CREATE OR REPLACE PROCEDURE sp_actualizar_usuario (
    p_id_usuario INT,
    p_nombre VARCHAR(300),
    p_apellido VARCHAR(300),
    p_salario_mensual DECIMAL(10,2),
    p_modificado_por VARCHAR(300)
)
AS
BEGIN
    UPDATE usuario
    SET nombre = p_nombre,
        apellido = p_apellido,
        salario_mensual = p_salario_mensual,
        modificado_por = p_modificado_por,
        modificado_en = CURRENT TIMESTAMP
    WHERE id_usuario = p_id_usuario;
END;

--Eliminar
CREATE OR REPLACE PROCEDURE sp_eliminar_usuario (
    p_id_usuario INT
)
AS
BEGIN
    UPDATE usuario
    SET estado = 0,
        modificado_en = CURRENT TIMESTAMP
    WHERE id_usuario = p_id_usuario;
END;

--Consultar usuario
CREATE OR REPLACE PROCEDURE sp_consultar_usuario (
    p_id_usuario INT
)
AS
BEGIN
    SELECT *
    FROM usuario
    WHERE id_usuario = p_id_usuario;
END;

--Listar Usuario
CREATE OR REPLACE PROCEDURE sp_listar_usuarios ()
AS
BEGIN
    SELECT id_usuario,
           nombre,
           apellido,
           correo,
           salario_mensual,
           estado,
           fecha_registro
    FROM usuario;
END;