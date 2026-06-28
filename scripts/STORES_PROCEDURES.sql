USE VeterinariaDB;
GO

CREATE PROCEDURE sp_ActualizarListaPrecios
		@IdCategoria INT,
        @IdProveedor INT,
        @Porcentaje DECIMAL (5,2)
AS
BEGIN
	IF NOT EXISTS (
		SELECT 1
		FROM Categorias
		WHERE IdCategoria = @IdCategoria
	)

	BEGIN
		RAISERROR('Categoria inexistente', 16, 1)
		RETURN
	END
	ELSE IF NOT EXISTS (
		SELECT 1
		FROM Proveedores
		WHERE IdProveedor = @IdProveedor
	)
	BEGIN
		RAISERROR('Proveedor inexistente', 16, 1)
		RETURN;
	END
	ELSE IF @Porcentaje < -90.00 OR @Porcentaje > 100.00
	BEGIN
		RAISERROR('El porcentaje debe estar entre -90.00 y 100.00', 16, 1)
		RETURN;
	END

	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE a
			SET a.PrecioUnitario = a.PrecioUnitario + (a.PrecioUnitario * @Porcentaje / 100)
			FROM Articulos a
			INNER JOIN ArticulosProveedores ap ON a.IdArticulo = ap.IdArticulo
			WHERE a.IdCategoria = @IdCategoria AND ap.IdProveedor = @IdProveedor
			
			DECLARE @FilasAfectadas INT = @@ROWCOUNT

			IF @FilasAfectadas = 0
			BEGIN
				ROLLBACK TRANSACTION
				RAISERROR('No se encontraron articulos para actualizar para la categoria y proveedor indicados.',16,1)
			END

		COMMIT TRANSACTION

			PRINT 'Lista de precios actualizada correctamente.'
			PRINT 'Articulos actualizados: ' + CAST(@FilasAfectadas AS VARCHAR(10))
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 
		BEGIN
			ROLLBACK TRANSACTION        
		END
		PRINT 'Error durante la actualizacion de precios: ' + ERROR_MESSAGE()
	END CATCH
END