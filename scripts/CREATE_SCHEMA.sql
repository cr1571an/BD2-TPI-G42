IF DB_ID('VeterinariaDB') IS NULL
BEGIN
    CREATE DATABASE VeterinariaDB;
END
GO

USE VeterinariaDB;
GO

CREATE TABLE Personas (
    IdPersona INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Nombre VARCHAR(55) NOT NULL,
    Apellido VARCHAR(55) NOT NULL,
    Telefono VARCHAR(20) NOT NULL, 
    Email VARCHAR(255) NOT NULL UNIQUE,
    Dni INT NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Empleados (
    IdEmpleado INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdPersona INT NOT NULL UNIQUE REFERENCES Personas(IdPersona),
    FechaIngreso DATE NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Clientes (
    IdCliente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdPersona INT NOT NULL UNIQUE REFERENCES Personas(IdPersona),
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Roles (
    IdRol INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NombreRol VARCHAR(55) NOT NULL UNIQUE,
    Descripcion VARCHAR(255) NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Usuarios (
    IdUsuario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdEmpleado INT NOT NULL UNIQUE REFERENCES Empleados(IdEmpleado),
    IdRol INT NOT NULL REFERENCES Roles(IdRol),
    NombreUsuario VARCHAR(55) NOT NULL UNIQUE,
    [Password] VARCHAR(255) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Especies (
    IdEspecie INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Nombre VARCHAR(55) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Razas (
    IdRaza INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdEspecie INT NOT NULL REFERENCES Especies(IdEspecie),
    Nombre VARCHAR(55) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Veterinarios (
    IdVeterinario INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdEmpleado INT NOT NULL UNIQUE REFERENCES Empleados(IdEmpleado),
    Matricula VARCHAR(255) NOT NULL UNIQUE,
    Especialidad VARCHAR(55) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE MediosPago (
    IdMedioPago INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Nombre VARCHAR(55) NOT NULL UNIQUE,
    Descripcion VARCHAR(255) NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Alicuotas (
    IdIva INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Porcentaje DECIMAL(5,2) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Categorias (
    IdCategoria INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    Nombre VARCHAR(60) NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Proveedores (
    IdProveedor INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Nombre VARCHAR(60) NOT NULL,
    Telefono VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Cuit VARCHAR(14) NOT NULL UNIQUE,
    Domicilio VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
); 
GO

CREATE TABLE ServiciosVeterinarios (
    IdServicio INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdIva INT NOT NULL REFERENCES Alicuotas(IdIva),
    Nombre VARCHAR(55) NOT NULL UNIQUE,
    Descripcion VARCHAR(255) NULL,
    Precio MONEY NOT NULL CHECK (Precio >= 0), 
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Articulos (
    IdArticulo INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdCategoria INT NOT NULL REFERENCES Categorias(IdCategoria),
    IdIva INT NOT NULL REFERENCES Alicuotas(IdIva),
    Nombre VARCHAR(60) NOT NULL,
    Descripcion VARCHAR(255) NULL,
    FechaVencimiento DATE NULL,
    PrecioUnitario MONEY NOT NULL CHECK (PrecioUnitario > 0),
    PorcentajeGanancia DECIMAL(5,2) NOT NULL CHECK (PorcentajeGanancia >= 0),
    StockMinimo SMALLINT NOT NULL CHECK (StockMinimo >= 0),
    Stock SMALLINT NOT NULL CHECK (Stock >= 0),
    Url VARCHAR(255) NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Animales (
    IdAnimal INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdCliente INT NOT NULL REFERENCES Clientes(IdCliente),
    IdRaza INT NOT NULL REFERENCES Razas(IdRaza),
    Nombre VARCHAR(55) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo VARCHAR(6) NOT NULL,
    Peso DECIMAL(5,2) NOT NULL CHECK (Peso > 0),
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Turnos (
    IdTurno INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdAnimal INT NOT NULL REFERENCES Animales(IdAnimal),
    IdVeterinario INT NOT NULL REFERENCES Veterinarios(IdVeterinario),
    IdServicio INT NOT NULL REFERENCES ServiciosVeterinarios(IdServicio),
    EstadoTurno VARCHAR(12) NOT NULL DEFAULT 'programado' CHECK (EstadoTurno IN ('programado', 'cancelado', 'ausente', 'atendido')),
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    FechaAlta DATETIME NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Atenciones (
    IdAtencion INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdAnimal INT NOT NULL REFERENCES Animales(IdAnimal),
    IdVeterinario INT NOT NULL REFERENCES Veterinarios(IdVeterinario),
    IdTurno INT NULL REFERENCES Turnos(IdTurno),
    FechaIngreso DATETIME NOT NULL,
    FechaAtencion DATETIME NULL,
    TipoAtencion VARCHAR(15) NOT NULL,
    Estado VARCHAR(15) NOT NULL DEFAULT 'en_espera' CHECK (Estado IN ('en_espera', 'atendiendo', 'finalizado', 'cancelado')),
    Motivo VARCHAR(255) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE HistorialClinico (
    IdHistorial INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdAtencion INT NOT NULL UNIQUE REFERENCES Atenciones(IdAtencion),
    Diagnostico VARCHAR(300) NOT NULL,
    Tratamiento VARCHAR(255) NOT NULL,
    Observaciones VARCHAR(255) NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE AtencionServicios (
    IdAtencion INT NOT NULL REFERENCES Atenciones(IdAtencion),
    IdServicio INT NOT NULL REFERENCES ServiciosVeterinarios(IdServicio),
    PRIMARY KEY (IdAtencion, IdServicio)
);
GO

CREATE TABLE Compras (
    IdCompra INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdProveedor INT NOT NULL REFERENCES Proveedores(IdProveedor),
    IdMedioPago INT NOT NULL REFERENCES MediosPago(IdMedioPago),
    IdUsuario INT NOT NULL REFERENCES Usuarios(IdUsuario),
    FechaCompra DATETIME NOT NULL,
    NumeroFactura VARCHAR(30) NOT NULL,
    Observaciones VARCHAR(255) NULL,
    Subtotal MONEY NOT NULL CHECK (Subtotal >= 0),
    ImporteTotal MONEY NOT NULL CHECK (ImporteTotal >= 0),
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE DetallesCompra (
    IdDetalleCompra INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdCompra INT NOT NULL REFERENCES Compras(IdCompra),
    IdArticulo INT NOT NULL REFERENCES Articulos(IdArticulo),
    Cantidad SMALLINT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario MONEY NOT NULL CHECK (PrecioUnitario > 0),
    Bonificacion DECIMAL(5,2) NOT NULL DEFAULT 0 CHECK (Bonificacion >= 0),
    Subtotal MONEY NOT NULL CHECK (Subtotal > 0),
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE ArticulosProveedores (
    IdArticulo INT NOT NULL REFERENCES Articulos(IdArticulo),
    IdProveedor INT NOT NULL REFERENCES Proveedores(IdProveedor),
    Activo BIT NOT NULL DEFAULT 1,
    PRIMARY KEY (IdArticulo, IdProveedor)
);
GO

CREATE TABLE Ventas (
    IdVenta INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdAtencion INT NULL REFERENCES Atenciones(IdAtencion),
    IdCliente INT NOT NULL REFERENCES Clientes(IdCliente),
    IdUsuario INT NOT NULL REFERENCES Usuarios(IdUsuario),
    IdMedioPago INT NOT NULL REFERENCES MediosPago(IdMedioPago),
    Fecha DATETIME NOT NULL,
    PuntoVenta INT NOT NULL,
    NumeroFactura INT NOT NULL,
    SubtotalBruto MONEY NOT NULL CHECK (SubtotalBruto >= 0), 
    ImporteTotal MONEY NOT NULL CHECK (ImporteTotal >= 0),
    ImportePagado MONEY NOT NULL CHECK (ImportePagado >= 0),
    Vuelto MONEY NOT NULL DEFAULT 0 CHECK (Vuelto >= 0),
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE DetallesVenta (
    IdDetalleVenta INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdVenta INT NOT NULL REFERENCES Ventas(IdVenta),
    IdArticulo INT NOT NULL REFERENCES Articulos(IdArticulo),
    Cantidad SMALLINT NOT NULL CHECK (Cantidad > 0), 
    PrecioUnitario MONEY NOT NULL CHECK (PrecioUnitario >= 0), 
    Bonificacion DECIMAL(5,2) NOT NULL DEFAULT 0 CHECK (Bonificacion >= 0),
    Subtotal MONEY NOT NULL CHECK (Subtotal >= 0),
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Envios (
    IdEnvio INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdVenta INT NOT NULL UNIQUE REFERENCES Ventas(IdVenta),
    DireccionesEntrega VARCHAR(255) NOT NULL,
    EstadoEnvio VARCHAR(20) NOT NULL DEFAULT 'pendiente' CHECK (EstadoEnvio IN ('pendiente', 'cancelado', 'entregado')),
    FechaDespacho DATETIME NULL,
    FechaEntregaReal DATETIME NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO