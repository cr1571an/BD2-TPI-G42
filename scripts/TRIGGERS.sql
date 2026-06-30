USE VeterinariaDB;
GO


-- tr_CancelarTurnosVeterinarioInactivo: Cancela automáticamente los turnos programados de un veterinario cuando pasa a estado inactivo.

CREATE TRIGGER tr_CancelarTurnosVeterinarioInactivo
ON Veterinarios
AFTER UPDATE
AS
BEGIN   
    BEGIN TRY
        BEGIN TRANSACTION
            DECLARE @IdVeterinario INT

            SELECT @IdVeterinario = i.IdVeterinario
            FROM inserted i
            INNER JOIN deleted d
                ON i.IdVeterinario = d.IdVeterinario
            WHERE d.Activo = 1
            AND i.Activo = 0

            IF @IdVeterinario IS NOT NULL
            BEGIN        
                UPDATE Turnos 
                SET EstadoTurno = 'cancelado', Activo = 0
                WHERE IdVeterinario = @IdVeterinario AND EstadoTurno = 'programado'        
            END 

        COMMIT TRANSACTION
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END
GO


-- tr_Turnos_EvitarSuperposicionVeterinario: Evita registrar turnos superpuestos para un mismo veterinario o animal en la misma fecha y horario.

CREATE TRIGGER tr_Turnos_EvitarSuperposicionVeterinario
ON Turnos
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Turnos t
            ON t.IdVeterinario = i.IdVeterinario
           AND t.Fecha = i.Fecha
           AND t.Hora = i.Hora
           AND t.EstadoTurno = 'programado'
           AND t.Activo = 1
    )
    BEGIN
        RAISERROR('EL VETERINARIO YA TIENE UN TURNO PROGRAMADO EN ESA FECHA Y HORARIO.', 16, 1);
        RETURN;
    END;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN Turnos t
            ON t.IdAnimal = i.IdAnimal
           AND t.Fecha = i.Fecha
           AND t.Hora = i.Hora
           AND t.EstadoTurno = 'programado'
           AND t.Activo = 1
    )
    BEGIN
        RAISERROR('EL ANIMAL YA TIENE UN TURNO PROGRAMADO EN ESA FECHA Y HORARIO.', 16, 1);
        RETURN;
    END;

    INSERT INTO Turnos
    (IdAnimal, IdVeterinario, IdServicio, EstadoTurno, Fecha, Hora, FechaAlta, Activo)
    SELECT
    IdAnimal, IdVeterinario, IdServicio, EstadoTurno, Fecha, Hora, FechaAlta, Activo
    FROM inserted;
END
GO


-- Actualiza el stock y el precio de un artículo al registrar un detalle de compra.

CREATE TRIGGER  tr_ActualizarStockYPrecioArticulo
ON DetallesCompra
AFTER INSERT
AS
BEGIN
    UPDATE A
    SET
        A.Stock = A.Stock + I.Cantidad,
        A.PrecioUnitario =
            I.PrecioUnitario *
            (1 + A.PorcentajeGanancia / 100.0)
    FROM Articulos A
    INNER JOIN inserted I
        ON A.IdArticulo = I.IdArticulo;
END;