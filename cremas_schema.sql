/* Esquema: Proyecto Cremas - Autor: Agustín Cabral */
CREATE SCHEMA IF NOT EXISTS cremas;
SET search_path TO cremas;

-- Tabla: Cliente
CREATE TABLE IF NOT EXISTS Cliente (
  id_cliente INT NOT NULL,
  dni VARCHAR(20) NULL,
  nombre VARCHAR(80) NULL,
  apellido VARCHAR(80) NULL,
  genero VARCHAR(20) NULL,
  fecha_nacimiento DATE NULL,
  rango_edad VARCHAR(30) NULL,
  segmento_ml VARCHAR(30) NULL
);

-- Tabla: Sucursal
CREATE TABLE IF NOT EXISTS Sucursal (
  id_sucursal INT NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  barrio VARCHAR(80) NOT NULL,
  direccion VARCHAR(200) NULL
);

-- Tabla: Marca
CREATE TABLE IF NOT EXISTS Marca (
  id_marca INT NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  es_dermatologica BOOLEAN NOT NULL
);

-- Tabla: Categoria
CREATE TABLE IF NOT EXISTS Categoria (
  id_categoria INT NOT NULL,
  nombre VARCHAR(120) NOT NULL
);

-- Tabla: Producto
CREATE TABLE IF NOT EXISTS Producto (
  id_producto INT NOT NULL,
  nombre VARCHAR(160) NOT NULL,
  id_marca INT NOT NULL,
  id_categoria INT NOT NULL,
  contenido_ml DECIMAL(10,2) NULL,
  tipo_piel VARCHAR(40) NULL,
  precio_lista DECIMAL(10,2) NOT NULL
);

-- Tabla: MedioPago
CREATE TABLE IF NOT EXISTS MedioPago (
  id_medio_pago INT NOT NULL,
  nombre VARCHAR(80) NOT NULL,
  tipo VARCHAR(40) NULL
);

-- Tabla: Promocion
CREATE TABLE IF NOT EXISTS Promocion (
  id_promocion INT NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  tipo VARCHAR(60) NOT NULL,
  descuento_pct DECIMAL(5,2) NULL,
  fecha_inicio DATE NULL,
  fecha_fin DATE NULL
);

-- Tabla: Calendario
CREATE TABLE IF NOT EXISTS Calendario (
  fecha DATE NOT NULL,
  anio INT NOT NULL,
  mes INT NOT NULL,
  trimestre INT NOT NULL,
  semana_anio INT NOT NULL,
  dia_semana INT NOT NULL,
  es_feriado BOOLEAN NOT NULL
);

-- Tabla: Venta
CREATE TABLE IF NOT EXISTS Venta (
  id_venta INT NOT NULL,
  fecha DATE NOT NULL,
  id_sucursal INT NOT NULL,
  id_cliente INT NOT NULL,
  id_medio_pago INT NOT NULL,
  id_promocion INT NULL,
  total_bruto DECIMAL(12,2) NOT NULL,
  total_descuento DECIMAL(12,2) NOT NULL,
  total_neto DECIMAL(12,2) NOT NULL
);

-- Tabla: DetalleVenta
CREATE TABLE IF NOT EXISTS DetalleVenta (
  id_venta INT NOT NULL,
  item INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  descuento_pct DECIMAL(5,2) NULL,
  subtotal_neto DECIMAL(12,2) NOT NULL
);

-- Claves primarias
ALTER TABLE Cliente ADD PRIMARY KEY (id_cliente);
ALTER TABLE Sucursal ADD PRIMARY KEY (id_sucursal);
ALTER TABLE Marca ADD PRIMARY KEY (id_marca);
ALTER TABLE Categoria ADD PRIMARY KEY (id_categoria);
ALTER TABLE Producto ADD PRIMARY KEY (id_producto);
ALTER TABLE MedioPago ADD PRIMARY KEY (id_medio_pago);
ALTER TABLE Promocion ADD PRIMARY KEY (id_promocion);
ALTER TABLE Calendario ADD PRIMARY KEY (fecha);
ALTER TABLE Venta ADD PRIMARY KEY (id_venta);
ALTER TABLE DetalleVenta ADD PRIMARY KEY (id_venta, item);

-- Claves foráneas
ALTER TABLE Producto ADD CONSTRAINT fk_producto_marca FOREIGN KEY (id_marca) REFERENCES Marca(id_marca);
ALTER TABLE Producto ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria);
ALTER TABLE Venta ADD CONSTRAINT fk_venta_cal FOREIGN KEY (fecha) REFERENCES Calendario(fecha);
ALTER TABLE Venta ADD CONSTRAINT fk_venta_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal);
ALTER TABLE Venta ADD CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente);
ALTER TABLE Venta ADD CONSTRAINT fk_venta_mp FOREIGN KEY (id_medio_pago) REFERENCES MedioPago(id_medio_pago);
ALTER TABLE Venta ADD CONSTRAINT fk_venta_promo FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion);
ALTER TABLE DetalleVenta ADD CONSTRAINT fk_detalle_venta FOREIGN KEY (id_venta) REFERENCES Venta(id_venta);
ALTER TABLE DetalleVenta ADD CONSTRAINT fk_detalle_prod FOREIGN KEY (id_producto) REFERENCES Producto(id_producto);