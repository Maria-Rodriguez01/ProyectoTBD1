CREATE TABLE usuario (
    id_usuario      INTEGER NOT NULL DEFAULT AUTOINCREMENT,
    nombre          VARCHAR(100) NOT NULL,
    apellido        VARCHAR(100),
    correo          VARCHAR(100) UNIQUE,
    fecha_registro  DATE DEFAULT CURRENT DATE,
    salario_mensual NUMERIC(15, 2),
    estado          BIT DEFAULT 1,
    PRIMARY KEY (id_usuario)
);

CREATE TABLE presupuesto (
    id_presupuesto  INTEGER NOT NULL DEFAULT AUTOINCREMENT,
    id_usuario      INTEGER NOT NULL,
    nombre          VARCHAR(100),
    year_inicio     INTEGER,
    mes_inicio      INTEGER,
    year_fin        INTEGER,
    mes_fin         INTEGER,
    total_ingresos  NUMERIC(15, 2) DEFAULT 0,
    total_gastos    NUMERIC(15, 2) DEFAULT 0,
    total_ahorro    NUMERIC(15, 2) DEFAULT 0,
    estado          BIT DEFAULT 1,
    PRIMARY KEY (id_presupuesto),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE categoria (
    id_categoria    INTEGER NOT NULL DEFAULT AUTOINCREMENT,
    id_usuario      INTEGER, 
    nombre          VARCHAR(100) NOT NULL,
    tipo            VARCHAR(50), 
    PRIMARY KEY (id_categoria),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE subcategoria (
    id_subcategoria INTEGER NOT NULL DEFAULT AUTOINCREMENT,
    id_categoria    INTEGER NOT NULL,
    nombre          VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_subcategoria),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE presupuesto_detalle (
    id_presupuesto_detalle INTEGER NOT NULL DEFAULT AUTOINCREMENT,
    id_presupuesto          INTEGER NOT NULL,
    id_subcategoria         INTEGER NOT NULL,
    monto_mensual           NUMERIC(15, 2) NOT NULL,
    PRIMARY KEY (id_presupuesto_detalle),
    FOREIGN KEY (id_presupuesto) REFERENCES presupuesto(id_presupuesto),
    FOREIGN KEY (id_subcategoria) REFERENCES subcategoria(id_subcategoria)
);

CREATE TABLE obligacion_fija (
    id_obligacion   INTEGER NOT NULL DEFAULT AUTOINCREMENT,
    id_usuario      INTEGER NOT NULL,
    id_subcategoria INTEGER,
    nombre          VARCHAR(100),
    monto_mensual   NUMERIC(15, 2),
    dia_vencimiento INTEGER CHECK (dia_vencimiento BETWEEN 1 AND 31),
    PRIMARY KEY (id_obligacion),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_subcategoria) REFERENCES subcategoria(id_subcategoria)
);

CREATE TABLE transaccion (
    id_transaccion  INTEGER NOT NULL DEFAULT AUTOINCREMENT,
    id_usuario      INTEGER NOT NULL,
    id_presupuesto  INTEGER,
    id_subcategoria INTEGER,
    id_obligacion   INTEGER,
    tipo_transaccion VARCHAR(50), 
    monto           NUMERIC(15, 2) NOT NULL,
    fecha           DATE DEFAULT CURRENT DATE,
    PRIMARY KEY (id_transaccion),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_presupuesto) REFERENCES presupuesto(id_presupuesto),
    FOREIGN KEY (id_subcategoria) REFERENCES subcategoria(id_subcategoria),
    FOREIGN KEY (id_obligacion) REFERENCES obligacion_fija(id_obligacion)
);