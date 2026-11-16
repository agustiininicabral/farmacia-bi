-- Consultas clave para KPIs y análisis (Cremas - Agustín Cabral)

-- 1) Ventas por categoría y mes (táctico)
SELECT c.anio, c.mes, cat.nombre AS categoria,
       SUM(dv.subtotal_neto) AS ventas_netas
FROM Venta v
JOIN DetalleVenta dv ON v.id_venta = dv.id_venta
JOIN Producto p ON dv.id_producto = p.id_producto
JOIN Categoria cat ON p.id_categoria = cat.id_categoria
JOIN Calendario c ON v.fecha = c.fecha
GROUP BY c.anio, c.mes, cat.nombre
ORDER BY c.anio, c.mes, ventas_netas DESC;

-- 2) Ticket promedio por sucursal (operativo)
SELECT s.nombre AS sucursal,
       AVG(v.total_neto) AS ticket_promedio
FROM Venta v
JOIN Sucursal s ON v.id_sucursal = s.id_sucursal
GROUP BY s.nombre
ORDER BY ticket_promedio DESC;

-- 3) Top 10 productos por margen (estratégico)
-- Suponiendo que precio_lista ~ costo base * factor; aquí ejemplo simple
SELECT p.nombre,
       SUM(dv.subtotal_neto) AS ventas_netas,
       SUM(dv.subtotal_neto - (dv.cantidad * p.precio_lista * 0.6)) AS margen_aprox
FROM DetalleVenta dv
JOIN Producto p ON dv.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY margen_aprox DESC
LIMIT 10;

-- 4) Participación de medios de pago
SELECT mp.nombre AS medio_pago,
       COUNT(*) AS cant_ventas,
       SUM(v.total_neto) AS monto
FROM Venta v
JOIN MedioPago mp ON v.id_medio_pago = mp.id_medio_pago
GROUP BY mp.nombre
ORDER BY monto DESC;

-- 5) Efecto de promociones sobre el ticket
SELECT COALESCE(promo.nombre, 'Sin promoción') AS promo,
       COUNT(*) AS cant_ventas,
       AVG(v.total_neto) AS ticket_promedio
FROM Venta v
LEFT JOIN Promocion promo ON v.id_promocion = promo.id_promocion
GROUP BY COALESCE(promo.nombre, 'Sin promoción')
ORDER BY ticket_promedio DESC;

-- 6) Estacionalidad: invierno vs verano
SELECT CASE WHEN c.mes IN (6,7,8) THEN 'Invierno'
            WHEN c.mes IN (12,1,2) THEN 'Verano'
            ELSE 'Resto' END AS estacion,
       SUM(dv.subtotal_neto) AS ventas_netas
FROM Venta v
JOIN DetalleVenta dv ON v.id_venta = dv.id_venta
JOIN Calendario c ON v.fecha = c.fecha
GROUP BY 1
ORDER BY ventas_netas DESC;

-- 7) Cohortes simples por mes de primera compra
WITH primera_compra AS (
  SELECT id_cliente, MIN(fecha) AS primera_fecha
  FROM Venta GROUP BY id_cliente
)
SELECT EXTRACT(YEAR FROM pc.primera_fecha) AS anio,
       EXTRACT(MONTH FROM pc.primera_fecha) AS mes,
       COUNT(*) AS nuevos_clientes
FROM primera_compra pc
GROUP BY 1,2
ORDER BY 1,2;