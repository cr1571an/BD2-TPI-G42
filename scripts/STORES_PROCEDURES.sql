USE VeterinariaDB;
GO


-- sp_ActualizarListaPrecios: Actualiza el precio unitario de los artículos según una categoría, proveedor y porcentaje indicado.

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
END;
GO


-- sp_CerrarAtencionClinica: Cierra una atención veterinaria, registra su historial clínico y actualiza su estado a finalizado.

CREATE PROCEDURE sp_CerrarAtencionClinica
    @IdAtencion INT,
    @Diagnostico VARCHAR(300),
    @Tratamiento VARCHAR(255),
    @Observaciones VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @AtencionActivo BIT;
    DECLARE @AtencionEstado VARCHAR(15);

    SELECT
        @AtencionActivo = Activo,
        @AtencionEstado = Estado
    FROM Atenciones
    WHERE IdAtencion = @IdAtencion;

    IF @AtencionActivo IS NULL
    BEGIN
        RAISERROR('La atencion indicada no existe.', 16, 1);
        RETURN;
    END;

    IF @AtencionActivo = 0
    BEGIN
        RAISERROR('La atencion no se encuentra activa.', 16, 1);
        RETURN;
    END;

    IF @AtencionEstado NOT IN ('atendiendo')
    BEGIN
        RAISERROR('Solo se puede cerrar una atencion que se encuentra en estado atendiendo.', 16, 1);
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM HistorialClinico
        WHERE IdAtencion = @IdAtencion
    )
    BEGIN
        RAISERROR('La atencion ya tiene historial clinico cargado.', 16, 1);
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO HistorialClinico
        (IdAtencion, Diagnostico, Tratamiento, Observaciones, Activo)
        VALUES
        (@IdAtencion, @Diagnostico, @Tratamiento, @Observaciones, 1);

        UPDATE Atenciones
        SET Estado = 'finalizado',
            FechaAtencion = GETDATE()
        WHERE IdAtencion = @IdAtencion;

        COMMIT TRANSACTION;

        PRINT 'Atencion clinica cerrada correctamente.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        RAISERROR('Error al cerrar la atencion clinica.', 16, 1);
    END CATCH
END;
GO


--Asocia un artículo a una venta, actualiza sus importes y descuenta el stock correspondiente.

CREATE PROCEDURE sp_AsociarArticuloAVenta
    @IdVenta INT,
    @IdArticulo INT,
    @Cantidad SMALLINT,
    @Bonificacion DECIMAL(5,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @PrecioUnitario MONEY;
        DECLARE @ImporteBruto MONEY;
        DECLARE @ImporteNeto MONEY;

        SELECT @PrecioUnitario = PrecioUnitario
        FROM Articulos
        WHERE IdArticulo = @IdArticulo AND Activo = 1;

        SET @ImporteBruto = @Cantidad * @PrecioUnitario;

        SET @ImporteNeto = @ImporteBruto * (1 - (@Bonificacion / 100.0));

        INSERT INTO DetallesVenta
        (IdVenta, IdArticulo, Cantidad, PrecioUnitario, Bonificacion, Subtotal, Activo)
        VALUES
        ( @IdVenta, @IdArticulo, @Cantidad, @PrecioUnitario, @Bonificacion, @ImporteNeto, 1);

        UPDATE Ventas
        SET
            SubtotalBruto = ISNULL(SubtotalBruto, 0) + @ImporteBruto,
            ImporteTotal = ISNULL(ImporteTotal, 0) + @ImporteNeto
        WHERE IdVenta = @IdVenta AND Activo = 1;

        UPDATE Articulos
        SET Stock = Stock - @Cantidad
        WHERE IdArticulo = @IdArticulo;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        DECLARE @Error NVARCHAR(4000);
        SET @Error = 'sp_AsociarArticuloAVenta: ' + ERROR_MESSAGE();
        RAISERROR(@Error, 16, 1);
    END CATCH
END;