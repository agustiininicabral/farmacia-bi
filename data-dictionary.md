# Diccionario de datos

Archivo: `data/sales_2024_anonymized.csv`. Una fila representa un registro de venta en el dataset de práctica.

| Campo | Descripción |
|---|---|
| `ID_Venta` | Identificador de la venta. |
| `Fecha` | Fecha de la operación (AAAA-MM-DD). |
| `Sucursal` | Sucursal asociada a la venta. |
| `Categoria` | Categoría del producto. |
| `Producto` | Nombre del producto. |
| `Marca` | Marca del producto. |
| `Precio_Unitario` | Precio unitario registrado. |
| `Cantidad` | Unidades registradas en la operación. |
| `Descuento_%` | Porcentaje de descuento aplicado. |
| `Medio_Pago` | Medio de pago registrado; se normalizaron espacios repetidos. |
| `Cliente_ID` | Código seudónimo estable generado para el proyecto; no es el identificador original. |
| `Edad` | Edad registrada para el cliente. |
| `Genero` | Género registrado en el dataset. |
| `Ciudad` | Ciudad/barrio registrado para el cliente. |
| `Stock_Disponible` | Stock disponible registrado en la fila. |
| `Total_Venta` | Importe total registrado para la venta. |

Se eliminaron las columnas `Nombre`, `Apellido`, `Email` y `Telefono`. El identificador original de cliente fue reemplazado por un código seudónimo.
