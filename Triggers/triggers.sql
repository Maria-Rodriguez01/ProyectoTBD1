/*El alumno DEBE implementar triggers para automatizar procesos críticos del sistema. Los triggers son parte fundamental del proyecto y no son opcionales:

Triggers obligatorios a implementar:

Trigger para crear subcategoría por defecto al insertar una categoría:
Se activa cuando se inserta una nueva categoría

Crea automáticamente una subcategoría llamada “General” o con el mismo nombre de la categoría

Marca esta subcategoría como “por defecto”

Garantiza que toda categoría tenga al menos una subcategoría*/

CREATE TRIGGER tr_crear_subcategoria_por_defecto
AFTER INSERT ON categoria 
REFERENCING NEW AS ncategoria
FOR EACH ROW
BEGIN 
    INSERT INTO subcategoria(id_categoria, nombre, descripcion,indicador_activa,indicador_subcategoria, creado_por, creado_en)
    VALUES(ncategoria.id_categoria,'General','Subcategoria creada por defecto', 1, 'SI', ncategoria.creado_por, CURRENT TIMESTAMP);
END;