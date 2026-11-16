-- =========================================================
-- Proyecto: Farmacia BI (Entrega 1) - Creacion de esquema
-- Autor: Agustin Cabral
-- Motor: MySQL 8.x
-- Archivo: Fama_Data_Cabral
-- =========================================================
-- Nota:
-- 1) Este script crea la base de datos y sus tablas principales.
-- 2) Incluye claves primarias, foraneas, unicas e indices basicos.
-- 3) Disenado para escalar en entregas posteriores (BI / Power BI).
-- =========================================================

DROP DATABASE IF EXISTS farmacia_bi;
CREATE DATABASE farmacia_bi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE farmacia_bi;

-- =========================
-- Entidad: cliente
-- =========================
CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(100) NOT NULL,
  apellido    VARCHAR(100) NOT NULL,
  dni         VARCHAR(20)  NOT NULL,
  email       VARCHAR(150) NULL,
  telefono    VARCHAR(30)  NULL,
  fecha_alta  DATE         NOT NULL,
  CONSTRAINT uq_cliente_dni UNIQUE (dni),
  INDEX idx_cliente_apellido (apellido),
  INDEX idx_cliente_email (email)
) ENGINE=InnoDB;

-- =========================
-- Entidad: proveedor
-- =========================
CREATE TABLE proveedor (
  id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(150) NOT NULL,
  contacto     VARCHAR(100) NULL,
  telefono     VARCHAR(30)  NULL,
  email        VARCHAR(150) NULL,
  cuit         VARCHAR(20)  NULL,
  INDEX idx_proveedor_nombre (nombre),
  INDEX idx_proveedor_cuit (cuit)
) ENGINE=InnoDB;

-- =========================
-- Entidad: producto
-- =========================
CREATE TABLE producto (
  id_producto  INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(150) NOT NULL,
  categoria    VARCHAR(100) NOT NULL,
  marca        VARCHAR(100) NULL,
  precio       DECIMAL(10,2) NOT NULL,
  costo        DECIMAL(10,2) NULL,
  activo       TINYINT(1) NOT NULL DEFAULT 1,
  id_proveedor INT NOT NULL,
  CONSTRAINT fk_producto_proveedor
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  INDEX idx_producto_categoria (categoria),
  INDEX idx_producto_nombre (nombre),
  INDEX idx_producto_proveedor (id_proveedor)
) ENGINE=InnoDB;

-- =========================
-- Entidad: sucursal
-- =========================
CREATE TABLE sucursal (
  id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(100) NOT NULL,
  direccion   VARCHAR(200) NOT NULL,
  barrio      VARCHAR(100) NULL,
  ciudad      VARCHAR(100) NULL,
  provincia   VARCHAR(100) NULL,
  INDEX idx_sucursal_nombre (nombre)
) ENGINE=InnoDB;

-- =========================
-- Entidad: stock (por sucursal y producto)
-- =========================
CREATE TABLE stock (
  id_stock    INT AUTO_INCREMENT PRIMARY KEY,
  id_producto INT NOT NULL,
  id_sucursal INT NOT NULL,
  cantidad    INT NOT NULL DEFAULT 0,
  stock_minimo INT NOT NULL DEFAULT 0,
  CONSTRAINT fk_stock_producto
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_stock_sucursal
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT uq_stock_prod_suc UNIQUE (id_producto, id_sucursal),
  INDEX idx_stock_sucursal (id_sucursal)
) ENGINE=InnoDB;

-- =========================
-- Entidad: medio_pago
-- =========================
CREATE TABLE medio_pago (
  id_medio_pago INT AUTO_INCREMENT PRIMARY KEY,
  descripcion   VARCHAR(100) NOT NULL,
  CONSTRAINT uq_medio_pago_desc UNIQUE (descripcion)
) ENGINE=InnoDB;

-- =========================
-- Entidad: venta
-- =========================
CREATE TABLE venta (
  id_venta    INT AUTO_INCREMENT PRIMARY KEY,
  fecha       DATETIME NOT NULL,
  id_cliente  INT NOT NULL,
  id_sucursal INT NOT NULL,
  id_medio_pago INT NOT NULL,
  total       DECIMAL(12,2) NOT NULL,
  CONSTRAINT fk_venta_cliente
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_venta_sucursal
    FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_venta_medio_pago
    FOREIGN KEY (id_medio_pago) REFERENCES medio_pago(id_medio_pago)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  INDEX idx_venta_fecha (fecha),
  INDEX idx_venta_cliente (id_cliente),
  INDEX idx_venta_sucursal (id_sucursal)
) ENGINE=InnoDB;

-- =========================
-- Entidad: detalle_venta
-- =========================
CREATE TABLE detalle_venta (
  id_detalle      INT AUTO_INCREMENT PRIMARY KEY,
  id_venta        INT NOT NULL,
  id_producto     INT NOT NULL,
  cantidad        INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  subtotal        DECIMAL(12,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
  CONSTRAINT fk_detalle_venta
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_detalle_producto
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  INDEX idx_detalle_venta (id_venta),
  INDEX idx_detalle_producto (id_producto)
) ENGINE=InnoDB;

-- =========================================================
-- Fin del script - Entrega 1
-- =========================================================
