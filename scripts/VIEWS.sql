USE VeterinariaDB;
GO

-- vw_ProductosAVencer: Vista que muestra los artículos activos próximos a vencer dentro de los próximos 90 días.

CREATE VIEW vw_ProductosAVencer AS
SELECT
    a.Nombre,
    c.Nombre AS Categoria,
    a.Stock,
    a.PrecioUnitario,
    a.FechaVencimiento,
    (a.Stock * a.PrecioUnitario) AS Valorizacion
FROM Articulos a
INNER JOIN Categorias c ON a.IdCategoria = c.IdCategoria
WHERE a.Activo = 1
  AND c.Activo = 1
  AND a.FechaVencimiento BETWEEN CAST(GETDATE() AS DATE)
  AND DATEADD(DAY, 90, CAST(GETDATE() AS DATE));
GO


-- vw_ProductosAReponer: Vista que muestra los artículos cuyo stock se encuentra por debajo o igual al stock mínimo y calcula una cantidad sugerida de reposición.

CREATE VIEW vw_ProductosAReponer AS
SELECT
    a.Nombre,
    c.Nombre AS Categoria,
    a.Stock,
    a.StockMinimo,
    ((a.StockMinimo * 2) - a.Stock) AS CantidadSugeridaCompra,
    p.Nombre AS Proveedor
FROM Articulos a
INNER JOIN Categorias c 
    ON a.IdCategoria = c.IdCategoria
LEFT JOIN ArticulosProveedores ap   
    ON a.IdArticulo = ap.IdArticulo
    AND ap.Activo = 1
LEFT JOIN Proveedores p   
    ON ap.IdProveedor = p.IdProveedor
    AND p.Activo = 1
WHERE a.Activo = 1
  AND c.Activo = 1
  AND a.Stock <= a.StockMinimo;
GO


-- Muestra los 10 productos con mayor ganancia, mostrando el nombre, la categoría, las unidades vendidas y los ingresos generados.

CREATE VIEW vw_Top10Productos AS
SELECT TOP 10 
    a.Nombre Productos,
    c.Nombre Categoria,
    SUM(dv.Cantidad) UnidadesVendidas, 
    CONVERT(INT, SUM(dv.Subtotal)) IngresoTotal,
    CONVERT(INT, SUM(dv.Subtotal) - SUM(dv.Cantidad *(a.PrecioUnitario/(1+(a.PorcentajeGanancia/100))))) Ganancia
FROM DetallesVenta dv
INNER JOIN Articulos a ON dv.IdArticulo = a.IdArticulo
INNER JOIN Categorias c ON a.IdCategoria = c.IdCategoria
INNER JOIN Ventas v ON dv.IdVenta = v.IdVenta
GROUP BY a.IdArticulo, a.Nombre, c.Nombre, a.PrecioUnitario, a.PorcentajeGanancia
ORDER BY Ganancia DESC;
GO