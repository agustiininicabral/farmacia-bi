# Revisión de calidad de datos

## Resultado de la inspección del archivo final

- 2.500 registros y 20 columnas originales.
- Periodo observado: 2024-01-01 a 2024-12-31.
- 2.500 identificadores de venta distintos; no se observaron IDs de venta duplicados.
- 2.160 identificadores de cliente distintos antes de seudonimizar.
- No se observaron valores nulos en los campos analizados.
- No se observaron valores negativos en precio unitario, cantidad, descuento o total.
- El total registrado suma 75.896.882 y las unidades suman 6.162.
- La fórmula `Precio_Unitario × Cantidad × (1 − Descuento_% / 100)` coincide con `Total_Venta` en todos los registros, con tolerancia de 0,02.

## Hallazgos que requieren atención

1. Los documentos de entregas anteriores describen 3.000 ventas; el archivo final contiene 2.500. La documentación pública se actualizó para reflejar el archivo efectivamente publicado.
2. El PDF del dashboard reporta 233 tickets, 547 unidades y aproximadamente 6,58 millones en ventas. Esos indicadores no coinciden con el dataset final inspeccionado (2.500 IDs de venta, 6.162 unidades y 75.896.882 de total). No deben presentarse como resultados de este CSV.
3. El campo `Medio_Pago` tenía dos variantes de espaciado para “Tarjeta Debito”; se normalizaron los espacios en el CSV público. No se modificaron importes ni descuentos.
4. Hay textos con problemas de codificación en algunos archivos Excel/documentos de origen. El CSV público se generó desde las celdas estructuradas del libro final y se exportó en UTF-8 con BOM.
5. Los archivos Power BI originales no se publican todavía: deben abrirse en Power BI Desktop, verificar origen y relaciones, revisar los datos importados y recalcular todas las medidas contra el CSV anonimizado.

## Alcance de la validación

Las comprobaciones se ejecutan sobre el CSV público mediante `scripts/validate_dataset.py`. No constituyen una auditoría del sistema de origen ni demuestran que los registros representen operaciones reales. El dataset se describe como simulado/de práctica según la documentación entregada.
