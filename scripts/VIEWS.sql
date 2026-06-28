USE VeterinariaDB;
GO

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