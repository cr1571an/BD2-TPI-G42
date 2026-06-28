USE VeterinariaDB;
GO

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