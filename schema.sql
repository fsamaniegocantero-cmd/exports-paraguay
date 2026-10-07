CREATE TABLE exportaciones (
    Fecha TEXT,
    Producto TEXT,
    Valor_miles_USD REAL,
    Toneladas REAL
);

CREATE TABLE destinos (
    Fecha TEXT,
    Destino TEXT,
    Valor_miles_USD REAL
);

CREATE TABLE precios (
    Fecha TEXT,
    Producto TEXT,
    Precio_USD_ton REAL
);

CREATE TABLE dim_producto (
    Producto TEXT PRIMARY KEY AUTOINCREMENT,
    Producto_precios TEXT,
    Grupo TEXT
);

-- importar csv
.import --csv --skip 1 exportaciones.csv exportaciones
.import --csv --skip 1 exportaciones_destino.csv destinos
.import --csv --skip 1 precios_internacionales.csv precios
.import --csv --skip 1 dim_producto.csv dim_producto