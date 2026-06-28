USE VeterinariaDB;
GO

------------------------------------------------------------
-- PERSONAS 
------------------------------------------------------------
INSERT INTO Personas (Nombre, Apellido, Telefono, Email, Dni, Activo) VALUES
('Laura', 'Gomez', '1122334455', 'laura.gomez@email.com', '30111222', 1),
('Martin', 'Perez', '1133445566', 'martin.perez@email.com', '29222333', 1),
('Camila', 'Lopez', '1144556677', 'camila.lopez@email.com', '31555444', 1),
('Sofia', 'Ramirez', '1155667788', 'sofia.ramirez@email.com', '32777888', 1),
('Nicolas', 'Torres', '1166778899', 'nicolas.torres@email.com', '33999111', 1),
('Agustina', 'Molina', '1177889900', 'agustina.molina@email.com', '34888111', 1),
('Valeria', 'Suarez', '1188990011', 'valeria.suarez@email.com', '28444555', 1),
('Diego', 'Fernandez', '1199001122', 'diego.fernandez@email.com', '27666777', 1),
('Florencia', 'Acosta', '1100112233', 'florencia.acosta@email.com', '35222333', 1),
('Walter', 'Benitez', '1111223344', 'walter.benitez@email.com', '36111444', 1),
('Mariana', 'Castro', '1122446688', 'mariana.castro@email.com', '34222111', 1);
GO

------------------------------------------------------------
-- ROLES
------------------------------------------------------------
INSERT INTO Roles (NombreRol, Descripcion, Activo) VALUES
('Administrador', 'Acceso completo al sistema', 1),
('Recepcionista', 'Gestiona clientes, turnos, ventas y cobros', 1),
('Veterinario', 'Realiza consultas, diagnósticos y atenciones', 1);
GO

------------------------------------------------------------
-- EMPLEADOS 
------------------------------------------------------------
INSERT INTO Empleados (IdPersona, FechaIngreso, Activo) VALUES
(7, '2026-01-27', 1),
(8, '2026-01-29', 1),
(9, '2026-01-29', 1),
(10, '2026-01-27', 1),
(11, '2026-01-29', 1);
GO

------------------------------------------------------------
-- CLIENTES 
------------------------------------------------------------
INSERT INTO Clientes (IdPersona) VALUES 
(1), 
(2),
(3), 
(4), 
(5), 
(6);
GO

------------------------------------------------------------
-- USUARIOS 
------------------------------------------------------------
INSERT INTO Usuarios (IdEmpleado, IdRol, NombreUsuario, [Password], Activo) VALUES
(1, 1, 'admin', 'admin123', 1),
(2, 2, 'recepcion1', 'recep123', 1),
(3, 3, 'veterinario1', 'vet123', 1),
(4, 3, 'veterinario2', 'vet123', 1),
(5, 2, 'recepcion2', 'recep123', 1);
GO

------------------------------------------------------------
-- ESPECIES 
------------------------------------------------------------
INSERT INTO Especies (Nombre, Activo) VALUES 
('Perro', 1), 
('Gato', 1), 
('Ave', 1), 
('Roedor', 1), 
('Reptil', 1);
GO

------------------------------------------------------------
-- RAZAS
------------------------------------------------------------
INSERT INTO Razas (IdEspecie, Nombre, Activo) VALUES
(1, 'Labrador Retriever', 1), 
(1, 'Golden Retriever', 1), 
(1, 'Caniche', 1),
(1, 'Bulldog Frances', 1), 
(1, 'Beagle', 1),
(1, 'Pastor Aleman', 1),
(1, 'Boxer', 1), 
(1, 'Salchicha', 1), 
(1, 'Mestizo', 1),
(2, 'Comun Europeo', 1), 
(2, 'Siames', 1), 
(2, 'Persa', 1),
(2, 'Maine Coon', 1), 
(2, 'Bengalí', 1), 
(2, 'British Shorthair', 1),
(3, 'Canario', 1), 
(3, 'Cacatúa', 1), 
(3, 'Loro', 1),
(4, 'Conejo Enano', 1),
(5, 'Tortuga Terrestre', 1)
GO

------------------------------------------------------------
-- VETERINARIOS 
------------------------------------------------------------
INSERT INTO Veterinarios (IdEmpleado, Matricula, Especialidad, Activo) VALUES
(3, 'MAT-12345', 'Clinica general', 1),
(4, 'MAT-67890', 'Cirugia', 1),
(1, 'MAT-17745', 'Clinica general', 1);
GO

------------------------------------------------------------
-- MEDIOS DE PAGO
------------------------------------------------------------
INSERT INTO MediosPago (Nombre, Descripcion, Activo) VALUES
('Efectivo', 'Pago en efectivo', 1),
('Tarjeta Debito', 'Pago mediante tarjeta de debito', 1),
('Transferencia', 'Pago mediante transferencia bancaria', 1);
GO

------------------------------------------------------------
-- ALICUOTAS 
------------------------------------------------------------
INSERT INTO Alicuotas (Porcentaje, Activo) VALUES 
(0.00, 1), 
(10.50, 1), 
(21.00, 1);
GO

------------------------------------------------------------
-- CATEGORIAS 
------------------------------------------------------------
INSERT INTO Categorias (Nombre, Activo) VALUES
('Alimentos', 1), 
('Inyecciones', 1), 
('Accesorios', 1), 
('Higiene', 1), 
('Juguetes', 1);
GO

------------------------------------------------------------
-- PROVEEDORES
------------------------------------------------------------
INSERT INTO Proveedores (Nombre, Telefono, Email, Cuit, Domicilio, Activo) VALUES
('Pet Food SRL', '1122223333', 'ventas@petfood.com', '30-11111111-1', 'Av. San Martin 1200', 1),
('Vet Pharma SA', '1133334444', 'contacto@vetpharma.com', '30-22222222-2', 'Av. Rivadavia 4500', 1),
('Accesorios Mascotas', '1144445555', 'info@accesoriosmascotas.com', '30-33333333-3', 'Calle Mitre 850', 1);
GO

------------------------------------------------------------
-- SERVICIOS VETERINARIOS 
------------------------------------------------------------
INSERT INTO ServiciosVeterinarios (IdIva, Nombre, Descripcion, Precio, Activo) VALUES
(3, 'Consulta general', 'Atencion clinica general', 18000.00, 1),
(3, 'Vacunacion', 'Aplicacion de vacuna segun calendario', 25000.00, 1),
(3, 'Castración', 'Cirugía de esterilización', 95000.00, 1),
(3, 'Curación de Heridas', 'Limpieza y tratamiento de heridas', 30000.00, 1),
(3, 'Baño sanitario', 'Baño con corte de uñas', 22000.00, 1);
GO

------------------------------------------------------------
-- ARTICULOS
------------------------------------------------------------
INSERT INTO Articulos (IdCategoria, IdIva, Nombre, Descripcion, FechaVencimiento, PrecioUnitario, PorcentajeGanancia, StockMinimo, Stock, Url, Activo) VALUES
(1, 3, 'Alimento balanceado perro adulto', 'Bolsa de 15 kg', '2026-12-31', 68000.00, 65.00, 10, 8, NULL, 1), 
(1, 3, 'Alimento balanceado gato adulto', 'Bolsa de 7 kg', '2026-11-15', 45000.00, 65.00, 10, 6, NULL, 1), 
(2, 3, 'Vacuna Antirrábica', 'Dosis para perros y gatos', '2027-01-10', 22000.00, 70.00, 5, 12, NULL, 1), 
(2, 3, 'Vacuna Séxtuple Canina', 'Protección contra seis enfermedades', '2026-08-22', 28000.00, 70.00, 5, 8, NULL, 1), 
(2, 3, 'Vacuna Triple Felina', 'Protección contra rinotraqueítis', '2026-09-05', 26000.00, 70.00, 5, 6, NULL, 1), 
(2, 3, 'Vacuna Leucemia Felina', 'Prevención de la leucemia felina', '2026-08-10', 29000.00, 70.00, 5, 3, NULL, 1), 
(3, 3, 'Collar regulable', 'Collar de nylon para perros', NULL, 7500.00, 85.00, 5, 15, NULL, 1), 
(3, 3, 'Correa reforzada', 'Correa de nylon con mosquetón', NULL, 11000.00, 85.00, 10, 4, NULL, 1), 
(3, 3, 'Transportadora mediana', 'Transportadora plástica', NULL, 48000.00, 75.00, 3, 4, NULL, 1), 
(4, 3, 'Shampoo hipoalergénico', 'Shampoo para pieles sensibles de perros y gatos', '2026-09-25', 12500.00, 80.00, 8, 12, NULL, 1),
(4, 3, 'Shampoo antipulgas', 'Shampoo para el control de pulgas y garrapatas', '2026-07-18', 14000.00, 80.00, 8, 10, NULL, 1),
(5, 3, 'Pelota de goma', 'Juguete resistente para perros', NULL, 6800.00, 90.00, 5, 20, NULL, 1), 
(5, 3, 'Hueso de goma', 'Mordillo para perros', NULL, 8500.00, 90.00, 5, 15, NULL, 1), 
(5, 3, 'Ratón de juguete', 'Juguete para gatos con cascabel', NULL, 5000.00, 85.00, 5, 18, NULL, 1);
GO
------------------------------------------------------------
-- ARTICULOS PROVEEDORES
------------------------------------------------------------
INSERT INTO ArticulosProveedores (IdArticulo, IdProveedor, Activo) VALUES
(1, 1, 1), 
(2, 1, 1), 
(3, 2, 1), 
(4, 2, 1), 
(5, 2, 1), 
(6, 2, 1),
(7, 3, 1), 
(8, 3, 1), 
(9, 3, 1), 
(10, 2, 1), 
(11, 2, 1), 
(12, 3, 1), 
(13, 3, 1), 
(14, 3, 1);
GO

------------------------------------------------------------
-- ANIMALES 
------------------------------------------------------------
INSERT INTO Animales (IdCliente, IdRaza, Nombre, FechaNacimiento, Sexo, Peso, Activo) VALUES
(1, 1, 'Toby', '2023-05-12', 'Macho', 18.5, 1),
(1, 2, 'Luna', '2024-08-21', 'Hembra', 12.3, 1),
(2, 3, 'Rocky', '2025-03-10', 'Macho', 28.0, 1),
(2, 4, 'Mora', '2022-11-02', 'Hembra', 9.8, 1),
(3, 5, 'Simba', '2025-06-18', 'Macho', 24.5, 1),
(3, 6, 'Nala', '2025-02-14', 'Hembra', 11.2, 1),
(4, 7, 'Max', '2024-09-30', 'Macho', 32.0, 1),
(5, 8, 'Lola', '2025-12-05', 'Hembra', 14.6, 1),
(4, 10, 'Mishi', '2024-07-11', 'Hembra', 4.2, 1),
(5, 11, 'Tom', '2015-01-25', 'Macho', 5.1, 1),
(6, 12, 'Luna', '2024-10-10', 'Hembra', 3.8, 1),
(2, 13, 'Felix', '2015-04-14', 'Macho', 4.9, 1),
(1, 14, 'Mora', '2025-06-01', 'Hembra', 3.5, 1),
(3, 16, 'Piolin', '2025-01-10', 'Macho', 0.04, 1),
(5, 19, 'Bunny', '2025-09-05', 'Hembra', 2.2, 1),
(6, 20, 'Shelly', '2024-03-20', 'Hembra', 4.8, 1);
GO

------------------------------------------------------------
-- TURNOS 
------------------------------------------------------------
INSERT INTO Turnos (IdAnimal, IdVeterinario, IdServicio, EstadoTurno, Fecha, Hora, FechaAlta, Activo) VALUES
(1, 1, 2, 'atendido', '2026-02-03', '09:00', '2026-02-01', 1),
(2, 2, 2, 'atendido', '2026-02-08', '10:00', '2026-02-05', 1),
(1, 1, 5, 'atendido', '2026-02-18', '11:00', '2026-02-13', 1),
(1, 2, 1, 'programado', '2026-07-03', '10:00', '2026-06-27', 1),
(3, 2, 2, 'atendido', '2026-02-23', '09:00', '2026-02-18', 1),
(4, 1, 2, 'atendido', '2026-03-10', '10:00', '2026-03-05', 1),
(3, 2, 5, 'atendido', '2026-03-15', '12:00', '2026-03-13', 1),
(3, 1, 1, 'programado', '2026-09-29', '09:30', '2026-06-27', 1),
(5, 2, 2, 'atendido', '2026-03-25', '10:00', '2026-03-20', 1),
(6, 1, 2, 'atendido', '2026-04-04', '11:00', '2026-03-30', 1),
(5, 2, 5, 'atendido', '2026-04-14', '10:30', '2026-04-12', 1),
(5, 1, 2, 'programado', '2026-07-01', '11:00', '2026-06-27', 1),
(7, 1, 2, 'atendido', '2026-04-24', '09:00', '2026-04-19', 1),
(8, 2, 2, 'atendido', '2026-05-04', '10:00', '2026-04-29', 1),
(7, 1, 5, 'atendido', '2026-05-14', '12:00', '2026-05-09', 1),
(7, 2, 1, 'programado', '2026-07-05', '10:30', '2026-06-27', 1),
(9, 1, 2, 'atendido', '2026-02-06', '09:00', '2026-02-04', 1),
(10, 2, 2, 'atendido', '2026-02-11', '10:00', '2026-02-09', 1),
(9, 1, 5, 'atendido', '2026-02-21', '11:00', '2026-02-17', 1),
(9, 2, 2, 'programado', '2026-07-08', '09:30', '2026-06-27', 1),
(11, 2, 2, 'atendido', '2026-02-28', '09:00', '2026-02-23', 1),
(12, 1, 2, 'atendido', '2026-03-13', '10:00', '2026-03-10', 1),
(11, 2, 1, 'programado', '2026-07-13', '11:00', '2026-06-27', 1),
(13, 1, 2, 'atendido', '2026-03-23', '09:00', '2026-03-19', 1),
(13, 2, 5, 'atendido', '2026-04-02', '10:00', '2026-03-30', 1),
(12, 1, 1, 'programado', '2026-07-18', '10:30', '2026-06-27', 1),
(1, 2, 2, 'atendido', '2026-06-13', '09:00', '2026-06-08', 1),
(2, 1, 2, 'programado', '2026-07-23', '10:00', '2026-06-27', 1),
(3, 2, 2, 'programado', '2026-08-02', '11:00', '2026-06-27', 1),
(13, 1, 2, 'programado', '2026-08-12', '09:00', '2026-06-27', 1),
(15, 2, 1, 'programado', '2026-08-27', '13:00', '2026-06-27', 1);
GO

------------------------------------------------------------
-- ATENCIONES
------------------------------------------------------------
INSERT INTO Atenciones (IdAnimal, IdVeterinario, IdTurno, FechaIngreso, FechaAtencion, TipoAtencion, Estado, Motivo, Activo) VALUES
(1, 1, 1, '2026-02-03 09:05', '2026-02-03 09:25', 'vacuna', 'finalizado', 'Vacuna antirrábica Toby', 1),
(2, 2, 2, '2026-02-08 10:05', '2026-02-08 10:30', 'vacuna', 'finalizado', 'Vacuna séxtuple Luna', 1),
(1, 1, 3, '2026-02-18 11:05', '2026-02-18 11:45', 'higiene', 'finalizado', 'Baño sanitario Toby', 1),
(3, 2, 5, '2026-02-23 09:05', '2026-02-23 09:30', 'vacuna', 'finalizado', 'Vacuna antirrábica Rocky', 1),
(4, 1, 6, '2026-03-10 10:05', '2026-03-10 10:35', 'vacuna', 'finalizado', 'Vacuna séxtuple Mora', 1),
(3, 2, 7, '2026-03-15 12:05', '2026-03-15 12:40', 'higiene', 'finalizado', 'Baño sanitario Rocky', 1),
(5, 2, 9, '2026-03-25 10:05', '2026-03-25 10:35', 'vacuna', 'finalizado', 'Vacuna antirrábica Simba', 1),
(6, 1, 10, '2026-04-04 11:05', '2026-04-04 11:35', 'vacuna', 'finalizado', 'Vacuna séxtuple Nala', 1),
(5, 2, 11, '2026-04-14 10:35', '2026-04-14 11:10', 'higiene', 'finalizado', 'Baño sanitario Simba', 1),
(7, 1, 13, '2026-04-24 09:05', '2026-04-24 09:30', 'vacuna', 'finalizado', 'Vacuna antirrábica Max', 1),
(8, 2, 14, '2026-05-04 10:05', '2026-05-04 10:35', 'vacuna', 'finalizado', 'Vacuna séxtuple Lola', 1),
(7, 1, 15, '2026-05-14 12:05', '2026-05-14 12:40', 'higiene', 'finalizado', 'Baño sanitario Max', 1),
(9, 1, 17, '2026-02-06 09:05', '2026-02-06 09:30', 'vacuna', 'finalizado', 'Vacuna antirrábica Mishi', 1),
(10, 2, 18, '2026-02-11 10:05', '2026-02-11 10:35', 'vacuna', 'finalizado', 'Vacuna triple felina Tom', 1),
(9, 1, 19, '2026-02-21 11:05', '2026-02-21 11:40', 'higiene', 'finalizado', 'Baño sanitario Mishi', 1),
(11, 2, 21, '2026-02-28 09:05', '2026-02-28 09:30', 'vacuna', 'finalizado', 'Vacuna antirrábica Luna G', 1),
(12, 1, 22, '2026-03-13 10:05', '2026-03-13 10:35', 'vacuna', 'finalizado', 'Vacuna antirrábica Felix', 1),
(13, 1, 24, '2026-03-23 09:05', '2026-03-23 09:30', 'vacuna', 'finalizado', 'Vacuna triple felina Mora G', 1),
(13, 2, 25, '2026-04-02 10:05', '2026-04-02 10:35', 'higiene', 'finalizado', 'Baño sanitario Mora G', 1),
(1, 2, 27, '2026-06-13 09:05', '2026-06-13 09:40', 'vacuna', 'finalizado', 'Refuerzo Anual Antirrábica Toby', 1),
(1, 2, NULL, '2026-02-25 11:10', '2026-02-25 11:40', 'consulta', 'finalizado', 'Decaimiento general', 1),
(3, 2, NULL, '2026-03-17 10:20', '2026-03-17 10:50', 'consulta', 'finalizado', 'Herida en pata', 1),
(5, 1, NULL, '2026-04-16 09:40', '2026-04-16 10:10', 'consulta', 'finalizado', 'Problema digestivo', 1),
(9, 2, NULL, '2026-04-26 12:15', '2026-04-26 12:45', 'consulta', 'finalizado', 'Caída leve', 1),
(15, 2, NULL, '2026-06-05 09:20', '2026-06-05 09:45', 'consulta', 'finalizado', 'Control caparazón Shelly', 1),
(2, 1, NULL, '2026-03-06 14:00', '2026-03-06 14:30', 'consulta', 'finalizado', 'Chequeo general de rutina', 1),
(14, 2, NULL, '2026-02-24 16:15', '2026-02-24 16:45', 'consulta', 'finalizado', 'Control de plumas Piolín', 1),
(4, 1, NULL, '2026-03-28 10:00', NULL, 'consulta', 'atendiendo', 'Control por picazón en la piel', 1),
(6, 2, NULL, '2026-05-04 11:00', NULL, 'consulta', 'atendiendo', 'Consulta por decaimiento general', 1);
GO

------------------------------------------------------------
-- HISTORIAL CLINICO
------------------------------------------------------------
INSERT INTO HistorialClinico (IdAtencion, Diagnostico, Tratamiento, Observaciones, Activo) VALUES
(1, 'Paciente sano', 'Aplicación de vacuna antirrábica', 'Sin reacciones adversas', 1),
(2, 'Paciente sano', 'Aplicación de vacuna séxtuple', 'Control anual correcto', 1),
(3, 'Estado dermatológico normal', 'Baño sanitario completo', 'Piel sin lesiones', 1),
(4, 'Paciente sano', 'Vacuna antirrábica aplicada', 'Sin complicaciones', 1),
(5, 'Control general normal', 'Vacuna séxtuple aplicada', 'Buen estado general', 1),
(6, 'Dermatitis leve por suciedad', 'Baño terapéutico', 'Revisar higiene domiciliaria', 1),
(7, 'Estado clínico estable', 'Vacuna antirrábica', 'Sin signos de alarma', 1),
(8, 'Paciente inmunizado', 'Vacuna séxtuple aplicada', 'Correcta respuesta inmunológica', 1),
(9, 'Piel con presencia de pulgas', 'Baño sanitario profundo', 'Se sugiere pipeta', 1),
(10, 'Paciente sano', 'Vacuna antirrábica', 'Sin efectos secundarios', 1),
(11, 'Estado general óptimo', 'Vacuna séxtuple', 'Seguimiento anual', 1),
(12, 'Piel limpia', 'Baño sanitario', 'Buen estado higiénico', 1),
(13, 'Control rutinario', 'Vacuna antirrábica', 'Sin novedades', 1),
(14, 'Estado general sano', 'Vacuna triple felina', 'Buen apetito', 1),
(15, 'Pelaje enmarañado', 'Baño sanitario + corte', 'Correcto', 1),
(16, 'Control preventivo', 'Vacuna antirrábica', 'Todo normal', 1),
(17, 'Vacunación correcta', 'Vacuna séxtuple', 'Sin reacción', 1),
(18, 'Paciente sano', 'Vacuna antirrábica', 'Estado óptimo', 1),
(19, 'Estado general normal', 'Vacuna triple felina', 'Sin hallazgos', 1),
(20, 'Inmunización completa', 'Vacuna antirrábica', 'Correcta respuesta', 1),
(21, 'Leve decaimiento general', 'Control clínico + observación 48hs', 'Mejoría progresiva', 1),
(22, 'Herida en pata', 'Antibiótico tópico + curaciones', 'Evolución favorable', 1),
(23, 'Gastroenteritis leve', 'Dieta blanda + medicación', 'Control en 3 días', 1),
(24, 'Caída leve sin lesiones graves', 'Observación y reposo', 'No requiere medicación', 1),
(25, 'Control', 'Evaluación de caparazón', 'Estado estable', 1),
(26, 'Chequeo general preventivo', 'Ninguno', 'Excelente salud general', 1),
(27, 'Falsa alarma de muda', 'Recomendación alimenticia', 'Nada que reportar', 1);
GO

------------------------------------------------------------
-- ATENCION SERVICIOS
------------------------------------------------------------
INSERT INTO AtencionServicios (IdAtencion, IdServicio) VALUES
(1, 2), 
(2, 2), 
(3, 5), 
(4, 2), 
(5, 2), 
(6, 5), 
(7, 2), 
(8, 2), 
(9, 5), 
(10, 2),
(11, 2), 
(12, 5), 
(13, 2), 
(14, 2), 
(15, 5), 
(16, 2), 
(17, 2), 
(18, 2), 
(19, 5), 
(20, 2),
(21, 1), 
(22, 1), 
(23, 1), 
(24, 1), 
(25, 1), 
(26, 1), 
(27, 1);
GO

------------------------------------------------------------
-- COMPRAS
------------------------------------------------------------
INSERT INTO Compras (IdProveedor, IdMedioPago, IdUsuario, FechaCompra, NumeroFactura, Subtotal, ImporteTotal, Observaciones, Activo) VALUES
(1, 2, 1, '2026-01-27 08:00', 'A-0001', 50000.00, 60500.00, 'Compra trimestral Alimentos Invierno', 1),
(1, 1, 2, '2026-02-26 11:30', 'A-0002', 60000.00, 72600.00, 'Compra trimestral Alimentos Primavera', 1),
(1, 2, 1, '2026-03-28 09:15', 'A-0003', 55000.00, 66550.00, 'Compra trimestral Alimentos Otoño', 1),
(2, 2, 1, '2026-01-27 09:00', 'B-0001', 90000.00, 108900.00, 'Lote Vacunas Semestre 1', 1),
(2, 1, 2, '2026-03-08 14:00', 'B-0002', 80000.00, 96800.00, 'Refuerzo stock Medicamentos', 1),
(2, 3, 1, '2026-04-17 10:30', 'B-0003', 95000.00, 114950.00, 'Lote Vacunas Semestre 2', 1),
(3, 1, 2, '2026-01-27 10:00', 'C-0001', 30000.00, 36300.00, 'Collares, correas y pelotas', 1),
(3, 2, 1, '2026-03-13 16:00', 'C-0002', 25000.00, 30250.00, 'Reposición accesorios', 1),
(3, 1, 2, '2026-04-27 11:00', 'C-0003', 28000.00, 33880.00, 'Stock de juguetes y transportadoras', 1);
GO

------------------------------------------------------------
-- DETALLES COMPRA
------------------------------------------------------------
INSERT INTO DetallesCompra (IdCompra, IdArticulo, Cantidad, PrecioUnitario, Bonificacion, Subtotal, Activo) VALUES
(1, 1, 5, 10000.00, 0, 50000.00, 1),
(2, 2, 5, 12000.00, 0, 60000.00, 1),
(3, 1, 5, 11000.00, 0, 55000.00, 1),
(4, 3, 10, 9000.00, 0, 90000.00, 1),
(5, 4, 10, 8000.00, 0, 80000.00, 1),
(6, 5, 10, 9500.00, 0, 95000.00, 1),
(7, 7, 12, 2500.00, 0, 30000.00, 1),
(8, 12, 10, 2500.00, 0, 25000.00, 1),
(9, 8, 8, 3500.00, 0, 28000.00, 1);
GO

------------------------------------------------------------
-- VENTAS
------------------------------------------------------------
INSERT INTO Ventas (IdAtencion, IdCliente, IdUsuario, IdMedioPago, Fecha, PuntoVenta, NumeroFactura, SubtotalBruto, ImporteTotal, ImportePagado, Vuelto, Activo) VALUES
(1, 1, 2, 1, '2026-02-03 09:30', 1, 1001, 48000.00, 48000.00, 50000.00, 2000.00, 1),
(13, 4, 2, 1, '2026-02-06 09:35', 1, 1002, 52000.00, 52000.00, 52000.00, 0.00, 1),
(2, 1, 2, 2, '2026-02-08 10:40', 1, 1003, 54000.00, 54000.00, 54000.00, 0.00, 1),
(14, 4, 2, 3, '2026-02-11 10:45', 1, 1004, 52000.00, 52000.00, 52000.00, 0.00, 1),
(3, 1, 2, 1, '2026-02-18 11:50', 1, 1005, 22000.00, 22000.00, 22000.00, 0.00, 1),
(15, 4, 5, 1, '2026-02-21 11:45', 1, 1006, 22000.00, 22000.00, 25000.00, 3000.00, 1),
(4, 3, 5, 1, '2026-02-23 09:35', 1, 1007, 48000.00, 48000.00, 50000.00, 2000.00, 1),
(16, 6, 2, 1, '2026-02-28 09:35', 1, 1008, 48000.00, 48000.00, 48000.00, 0.00, 1),
(5, 3, 2, 3, '2026-03-10 10:40', 1, 1009, 54000.00, 54000.00, 54000.00, 0.00, 1),
(17, 6, 2, 2, '2026-03-13 10:40', 1, 1010, 48000.00, 48000.00, 48000.00, 0.00, 1),
(21, 1, 2, 1, '2026-02-25 11:45', 1, 1011, 18000.00, 18000.00, 20000.00, 2000.00, 1),
(6, 3, 5, 1, '2026-03-15 12:45', 1, 1012, 22000.00, 22000.00, 22000.00, 0.00, 1),
(18, 2, 2, 1, '2026-03-23 09:35', 1, 1013, 52000.00, 52000.00, 52000.00, 0.00, 1),
(22, 3, 2, 1, '2026-03-17 11:15', 1, 1014, 18000.00, 18000.00, 20000.00, 2000.00, 1),
(7, 2, 2, 1, '2026-03-25 10:40', 1, 1015, 48000.00, 48000.00, 50000.00, 2000.00, 1),
(19, 2, 2, 1, '2026-04-02 10:40', 1, 1016, 22000.00, 22000.00, 22000.00, 0.00, 1),
(8, 2, 2, 2, '2026-04-04 11:40', 1, 1017, 54000.00, 54000.00, 54000.00, 0.00, 1),
(27, 5, 2, 1, '2026-02-24 17:05', 1, 1018, 18000.00, 18000.00, 18000.00, 0.00, 1),
(9, 2, 5, 1, '2026-04-14 11:20', 1, 1019, 22000.00, 22000.00, 22000.00, 0.00, 1),
(26, 2, 1, 1, '2026-03-06 14:35', 1, 1020, 18000.00, 18000.00, 20000.00, 2000.00, 1),
(10, 4, 2, 1, '2026-04-24 09:35', 1, 1021, 48000.00, 48000.00, 50000.00, 2000.00, 1),
(23, 5, 1, 2, '2026-04-16 10:15', 1, 1022, 18000.00, 18000.00, 18000.00, 0.00, 1),
(11, 4, 2, 1, '2026-05-04 10:40', 1, 1023, 54000.00, 54000.00, 55000.00, 0.00, 1),
(24, 4, 2, 1, '2026-04-26 12:55', 1, 1024, 18000.00, 18000.00, 18000.00, 0.00, 1),
(12, 4, 5, 2, '2026-05-14 12:45', 1, 1025, 22000.00, 22000.00, 22000.00, 0.00, 1),
(20, 1, 2, 1, '2026-06-13 09:45', 1, 1026, 48000.00, 48000.00, 48000.00, 0.00, 1),
(25, 6, 2, 1, '2026-06-05 09:50', 1, 1027, 18000.00, 18000.00, 20000.00, 2000.00, 1),
(NULL, 1, 2, 1, '2026-01-28 15:00', 1, 1028, 101800.00, 101800.00, 102000.00, 200.00, 1),
(NULL, 2, 5, 2, '2026-01-29 18:15', 1, 1029, 98000.00, 98000.00, 98000.00, 0.00, 1),
(NULL, 4, 2, 1, '2026-01-30 11:00', 1, 1030, 30300.00, 30300.00, 31000.00, 700.00, 1),
(NULL, 5, 2, 1, '2026-01-31 15:40', 1, 1031, 51300.00, 51300.00, 52000.00, 700.00, 1),
(NULL, 3, 5, 3, '2026-02-02 10:15', 1, 1032, 48000.00, 48000.00, 48000.00, 0.00, 1),
(NULL, 6, 2, 1, '2026-02-04 17:20', 1, 1033, 46800.00, 46800.00, 47000.00, 200.00, 1),
(NULL, 2, 2, 2, '2026-02-07 12:00', 1, 1034, 7500.00, 7500.00, 7500.00, 0.00, 1),
(NULL, 4, 5, 1, '2026-02-09 18:10', 1, 1035, 68000.00, 68000.00, 70000.00, 2000.00, 1),
(NULL, 1, 2, 3, '2026-02-10 16:30', 1, 1036, 11000.00, 11000.00, 11000.00, 0.00, 1),
(NULL, 5, 2, 1, '2026-02-12 11:45', 1, 1037, 77300.00, 77300.00, 80000.00, 2700.00, 1);
GO

------------------------------------------------------------
-- DETALLES VENTA 
------------------------------------------------------------
INSERT INTO DetallesVenta (IdVenta, IdArticulo, Cantidad, PrecioUnitario, Bonificacion, Subtotal, Activo) VALUES
(1, 3, 1, 22000.00, 0, 22000.00, 1),
(2, 3, 1, 22000.00, 0, 22000.00, 1),
(3, 4, 1, 28000.00, 0, 28000.00, 1),
(4, 5, 1, 26000.00, 0, 26000.00, 1),
(7, 3, 1, 22000.00, 0, 22000.00, 1),
(8, 3, 1, 22000.00, 0, 22000.00, 1),
(9, 4, 1, 28000.00, 0, 28000.00, 1),
(10, 3, 1, 22000.00, 0, 22000.00, 1),
(13, 5, 1, 26000.00, 0, 26000.00, 1),
(15, 3, 1, 22000.00, 0, 22000.00, 1),
(17, 4, 1, 28000.00, 0, 28000.00, 1),
(21, 3, 1, 22000.00, 0, 22000.00, 1),
(23, 4, 1, 28000.00, 0, 28000.00, 1),
(26, 3, 1, 22000.00, 0, 22000.00, 1), 
(28, 1, 1, 68000.00, 0, 68000.00, 1),
(28, 7, 1, 7500.00,  0, 7500.00,  1),
(28, 8, 1, 11000.00, 0, 11000.00, 1),
(28, 12,1, 6800.00,  0, 6800.00,  1),
(28, 13,1, 8500.00,  0, 8500.00,  1),
(29, 2, 1, 45000.00, 0, 45000.00, 1),
(29, 9, 1, 48000.00, 0, 48000.00, 1),
(29, 14,1, 5000.00,  0, 5000.00,  1),
(30, 7, 1, 7500.00,  0, 7500.00,  1),
(30, 8, 1, 11000.00, 0, 11000.00, 1),
(30, 14,1, 5000.00,  0, 5000.00,  1),
(30, 12,1, 6800.00,  0, 6800.00,  1),
(31, 10,1, 12500.00, 0, 12500.00, 1),
(31, 12,1, 6800.00,  0, 6800.00,  1),
(31, 13,1, 8500.00,  0, 8500.00,  1),
(31, 14,1, 5000.00,  0, 5000.00,  1),
(31, 7, 1, 7500.00,  0, 7500.00,  1),
(31, 8, 1, 11000.00, 0, 11000.00, 1),
(32, 9, 1, 48000.00, 0, 48000.00, 1),
(33, 10,1, 12500.00, 0, 12500.00, 1),
(33, 11,1, 14000.00, 0, 14000.00, 1),
(33, 12,1, 6800.00,  0, 6800.00,  1),
(33, 13,1, 8500.00,  0, 8500.00,  1),
(33, 14,1, 5000.00,  0, 5000.00,  1),
(34, 7, 1, 7500.00,  0, 7500.00,  1),
(35, 1, 1, 68000.00, 0, 68000.00, 1),
(36, 8, 1, 11000.00, 0, 11000.00, 1),
(37, 2, 1, 45000.00, 0, 45000.00, 1),
(37, 7, 1, 7500.00,  0, 7500.00,  1),
(37, 8, 1, 11000.00, 0, 11000.00, 1),
(37, 14,1, 5000.00,  0, 5000.00,  1),
(37, 12,1, 6800.00,  0, 6800.00,  1);
GO

------------------------------------------------------------
-- ENVIOS 
------------------------------------------------------------
INSERT INTO Envios (IdVenta, DireccionesEntrega, EstadoEnvio, FechaDespacho, FechaEntregaReal, Activo) VALUES
(1, 'Av. San Martín 1200 - Dpto 2', 'entregado', '2026-02-04 09:00', '2026-02-04 14:30', 1);
GO