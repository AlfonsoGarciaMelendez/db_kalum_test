USE [kalum_test]
GO
/****** Object:  StoredProcedure [dbo].[sp_EnrollmentProcess]    Script Date: 8/07/2022 22:53:48 ******/
DROP PROCEDURE [dbo].[sp_EnrollmentProcess]
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision] DROP CONSTRAINT [FK_RESULTADO_EXAMEN_ADMISION_ASPIRANTE]
GO
ALTER TABLE [dbo].[InversionCarreraTecnica] DROP CONSTRAINT [FK_INVERSION_CARRERA_TECNICA_CARRERATECNICA]
GO
ALTER TABLE [dbo].[InscripcionPago] DROP CONSTRAINT [FK_INSCRIPCION_PAGO_ASPIRANTE]
GO
ALTER TABLE [dbo].[Inscripcion] DROP CONSTRAINT [FK_INSCRIPCION_JORNADA]
GO
ALTER TABLE [dbo].[Inscripcion] DROP CONSTRAINT [FK_INSCRIPCION_CARRERA_TECNICA]
GO
ALTER TABLE [dbo].[Inscripcion] DROP CONSTRAINT [FK_Inscripcion_Alumno]
GO
ALTER TABLE [dbo].[CuentaporCobrar] DROP CONSTRAINT [FK_CuentaporCobrar_Cargo]
GO
ALTER TABLE [dbo].[CuentaporCobrar] DROP CONSTRAINT [FK_CUENTA_POR_COBRAR_ALUMNO]
GO
ALTER TABLE [dbo].[Aspirante] DROP CONSTRAINT [FK_ASPIRANTE_JORNADA]
GO
ALTER TABLE [dbo].[Aspirante] DROP CONSTRAINT [FK_ASPIRANTE_EXAMEN_ADMISION]
GO
ALTER TABLE [dbo].[Aspirante] DROP CONSTRAINT [FK_ASPIRANTE_CARRERA_TECNICA]
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision] DROP CONSTRAINT [DF__ResultadoE__Nota__30F848ED]
GO
ALTER TABLE [dbo].[Cargo] DROP CONSTRAINT [DF__Cargo__Porcentaj__4222D4EF]
GO
ALTER TABLE [dbo].[Cargo] DROP CONSTRAINT [DF__Cargo__GeneraMor__412EB0B6]
GO
ALTER TABLE [dbo].[Aspirante] DROP CONSTRAINT [DF__Aspirante__Estat__2B3F6F97]
GO
/****** Object:  Table [dbo].[ResultadoExamenAdmision]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResultadoExamenAdmision]') AND type in (N'U'))
DROP TABLE [dbo].[ResultadoExamenAdmision]
GO
/****** Object:  Table [dbo].[Jornada]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Jornada]') AND type in (N'U'))
DROP TABLE [dbo].[Jornada]
GO
/****** Object:  Table [dbo].[InversionCarreraTecnica]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InversionCarreraTecnica]') AND type in (N'U'))
DROP TABLE [dbo].[InversionCarreraTecnica]
GO
/****** Object:  Table [dbo].[InscripcionPago]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InscripcionPago]') AND type in (N'U'))
DROP TABLE [dbo].[InscripcionPago]
GO
/****** Object:  Table [dbo].[Inscripcion]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Inscripcion]') AND type in (N'U'))
DROP TABLE [dbo].[Inscripcion]
GO
/****** Object:  Table [dbo].[CuentaporCobrar]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CuentaporCobrar]') AND type in (N'U'))
DROP TABLE [dbo].[CuentaporCobrar]
GO
/****** Object:  Table [dbo].[Cargo]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cargo]') AND type in (N'U'))
DROP TABLE [dbo].[Cargo]
GO
/****** Object:  Table [dbo].[Alumno]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Alumno]') AND type in (N'U'))
DROP TABLE [dbo].[Alumno]
GO
/****** Object:  View [dbo].[vw_ListarAspirantesPorFechaExamen]    Script Date: 8/07/2022 22:53:48 ******/
DROP VIEW [dbo].[vw_ListarAspirantesPorFechaExamen]
GO
/****** Object:  Table [dbo].[Aspirante]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Aspirante]') AND type in (N'U'))
DROP TABLE [dbo].[Aspirante]
GO
/****** Object:  Table [dbo].[CarreraTecnica]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CarreraTecnica]') AND type in (N'U'))
DROP TABLE [dbo].[CarreraTecnica]
GO
/****** Object:  Table [dbo].[ExamenAdmision]    Script Date: 8/07/2022 22:53:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExamenAdmision]') AND type in (N'U'))
DROP TABLE [dbo].[ExamenAdmision]
GO
/****** Object:  UserDefinedFunction [dbo].[RPAD]    Script Date: 8/07/2022 22:53:48 ******/
DROP FUNCTION [dbo].[RPAD]
GO
/****** Object:  UserDefinedFunction [dbo].[LPAD]    Script Date: 8/07/2022 22:53:48 ******/
DROP FUNCTION [dbo].[LPAD]
GO
/****** Object:  UserDefinedFunction [dbo].[LPAD]    Script Date: 8/07/2022 22:53:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[LPAD]
(
	@string varchar(MAX),
	@length int,
	@pad char
)
returns varchar(MAX)
as
begin
	return replicate(@pad, @length - len(@string)) + @string
end
GO
/****** Object:  UserDefinedFunction [dbo].[RPAD]    Script Date: 8/07/2022 22:53:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Creacion de funciones
create function [dbo].[RPAD]
(
	@string varchar(MAX), -- Cadena inicial
	@length int, -- Tamaño del string final
	@pad char -- Caracter que se utilizara para el reemplazo
)
returns varchar(MAX)
as
begin
	return @string + replicate(@pad, @length - len(@string))
end
GO
/****** Object:  Table [dbo].[ExamenAdmision]    Script Date: 8/07/2022 22:53:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamenAdmision](
	[ExamenId] [varchar](128) NOT NULL,
	[FechaExamen] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CarreraTecnica]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarreraTecnica](
	[CarreraId] [varchar](128) NOT NULL,
	[Nombre] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CarreraId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Aspirante]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aspirante](
	[NoExpediente] [varchar](128) NOT NULL,
	[Apellidos] [varchar](128) NOT NULL,
	[Nombres] [varchar](128) NOT NULL,
	[Direccion] [varchar](128) NOT NULL,
	[Telefono] [varchar](64) NOT NULL,
	[Email] [varchar](128) NOT NULL,
	[Estatus] [varchar](32) NULL,
	[CarreraId] [varchar](128) NOT NULL,
	[ExamenId] [varchar](128) NOT NULL,
	[JornadaId] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NoExpediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ListarAspirantesPorFechaExamen]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create view [dbo].[vw_ListarAspirantesPorFechaExamen]
 as
 select
 	NoExpediente,
 	Apellidos,
 	Nombres,
 	FechaExamen,
 	CarreraTecnica,
 	estatus
 from Aspirante a
 inner join ExamenAdmision ea on a.ExamenId = ea.ExamenId
 inner join CarreraTecnica ct on a.CarreraId = ct.CarreraId
GO
/****** Object:  Table [dbo].[Alumno]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alumno](
	[Carne] [varchar](8) NOT NULL,
	[Apellidos] [varchar](128) NOT NULL,
	[Nombres] [varchar](128) NOT NULL,
	[Direccion] [char](250) NULL,
	[Telefono] [varchar](84) NOT NULL,
	[Email] [varchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Carne] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cargo]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cargo](
	[CargoId] [varchar](128) NOT NULL,
	[descripcion] [varchar](128) NOT NULL,
	[prefijo] [varchar](64) NOT NULL,
	[monto] [decimal](10, 2) NOT NULL,
	[GeneraMora] [bit] NOT NULL,
	[PorcentajeMora] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CargoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaporCobrar]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaporCobrar](
	[Codigo] [varchar](128) NOT NULL,
	[Anio] [varchar](4) NOT NULL,
	[Carne] [varchar](8) NOT NULL,
	[CargoId] [varchar](128) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
	[FechaCargo] [datetime] NOT NULL,
	[FechaAplica] [datetime] NOT NULL,
	[Monto] [decimal](10, 2) NOT NULL,
	[Mora] [decimal](10, 2) NOT NULL,
	[Descuento] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inscripcion]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inscripcion](
	[InscripcionId] [varchar](128) NOT NULL,
	[Carne] [varchar](8) NOT NULL,
	[CarreraId] [varchar](128) NOT NULL,
	[JornadaId] [varchar](128) NOT NULL,
	[Ciclo] [varchar](4) NOT NULL,
	[FechaInscripcion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InscripcionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InscripcionPago]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InscripcionPago](
	[BoletaPago] [varchar](128) NOT NULL,
	[NoExpediente] [varchar](128) NOT NULL,
	[Anio] [varchar](4) NOT NULL,
	[FechaPago] [datetime] NOT NULL,
	[monto] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BoletaPago] ASC,
	[NoExpediente] ASC,
	[Anio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InversionCarreraTecnica]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InversionCarreraTecnica](
	[InversionId] [varchar](128) NOT NULL,
	[CarreraId] [varchar](128) NOT NULL,
	[MontoInscripcion] [decimal](10, 2) NOT NULL,
	[NumeroPagos] [int] NOT NULL,
	[MontoPagos] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InversionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jornada]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jornada](
	[JornadaId] [varchar](128) NOT NULL,
	[NombreCorto] [varchar](2) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[JornadaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResultadoExamenAdmision]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultadoExamenAdmision](
	[NoExpediente] [varchar](128) NOT NULL,
	[Anio] [varchar](4) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
	[Nota] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[NoExpediente] ASC,
	[Anio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Aspirante] ADD  DEFAULT ('NO ASIGNADO') FOR [Estatus]
GO
ALTER TABLE [dbo].[Cargo] ADD  DEFAULT ((1)) FOR [GeneraMora]
GO
ALTER TABLE [dbo].[Cargo] ADD  DEFAULT ((0)) FOR [PorcentajeMora]
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision] ADD  DEFAULT ((0)) FOR [Nota]
GO
ALTER TABLE [dbo].[Aspirante]  WITH CHECK ADD  CONSTRAINT [FK_ASPIRANTE_CARRERA_TECNICA] FOREIGN KEY([CarreraId])
REFERENCES [dbo].[CarreraTecnica] ([CarreraId])
GO
ALTER TABLE [dbo].[Aspirante] CHECK CONSTRAINT [FK_ASPIRANTE_CARRERA_TECNICA]
GO
ALTER TABLE [dbo].[Aspirante]  WITH CHECK ADD  CONSTRAINT [FK_ASPIRANTE_EXAMEN_ADMISION] FOREIGN KEY([ExamenId])
REFERENCES [dbo].[ExamenAdmision] ([ExamenId])
GO
ALTER TABLE [dbo].[Aspirante] CHECK CONSTRAINT [FK_ASPIRANTE_EXAMEN_ADMISION]
GO
ALTER TABLE [dbo].[Aspirante]  WITH CHECK ADD  CONSTRAINT [FK_ASPIRANTE_JORNADA] FOREIGN KEY([JornadaId])
REFERENCES [dbo].[Jornada] ([JornadaId])
GO
ALTER TABLE [dbo].[Aspirante] CHECK CONSTRAINT [FK_ASPIRANTE_JORNADA]
GO
ALTER TABLE [dbo].[CuentaporCobrar]  WITH CHECK ADD  CONSTRAINT [FK_CUENTA_POR_COBRAR_ALUMNO] FOREIGN KEY([Carne])
REFERENCES [dbo].[Alumno] ([Carne])
GO
ALTER TABLE [dbo].[CuentaporCobrar] CHECK CONSTRAINT [FK_CUENTA_POR_COBRAR_ALUMNO]
GO
ALTER TABLE [dbo].[CuentaporCobrar]  WITH CHECK ADD  CONSTRAINT [FK_CuentaporCobrar_Cargo] FOREIGN KEY([CargoId])
REFERENCES [dbo].[Cargo] ([CargoId])
GO
ALTER TABLE [dbo].[CuentaporCobrar] CHECK CONSTRAINT [FK_CuentaporCobrar_Cargo]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Inscripcion_Alumno] FOREIGN KEY([Carne])
REFERENCES [dbo].[Alumno] ([Carne])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_Inscripcion_Alumno]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_INSCRIPCION_CARRERA_TECNICA] FOREIGN KEY([CarreraId])
REFERENCES [dbo].[CarreraTecnica] ([CarreraId])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_INSCRIPCION_CARRERA_TECNICA]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_INSCRIPCION_JORNADA] FOREIGN KEY([JornadaId])
REFERENCES [dbo].[Jornada] ([JornadaId])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_INSCRIPCION_JORNADA]
GO
ALTER TABLE [dbo].[InscripcionPago]  WITH CHECK ADD  CONSTRAINT [FK_INSCRIPCION_PAGO_ASPIRANTE] FOREIGN KEY([NoExpediente])
REFERENCES [dbo].[Aspirante] ([NoExpediente])
GO
ALTER TABLE [dbo].[InscripcionPago] CHECK CONSTRAINT [FK_INSCRIPCION_PAGO_ASPIRANTE]
GO
ALTER TABLE [dbo].[InversionCarreraTecnica]  WITH CHECK ADD  CONSTRAINT [FK_INVERSION_CARRERA_TECNICA_CARRERATECNICA] FOREIGN KEY([CarreraId])
REFERENCES [dbo].[CarreraTecnica] ([CarreraId])
GO
ALTER TABLE [dbo].[InversionCarreraTecnica] CHECK CONSTRAINT [FK_INVERSION_CARRERA_TECNICA_CARRERATECNICA]
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision]  WITH CHECK ADD  CONSTRAINT [FK_RESULTADO_EXAMEN_ADMISION_ASPIRANTE] FOREIGN KEY([NoExpediente])
REFERENCES [dbo].[Aspirante] ([NoExpediente])
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision] CHECK CONSTRAINT [FK_RESULTADO_EXAMEN_ADMISION_ASPIRANTE]
GO
/****** Object:  StoredProcedure [dbo].[sp_EnrollmentProcess]    Script Date: 8/07/2022 22:53:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--[sp_EnrollmentProcess] 'EXP-20220001','2022',1,'88CE52CD-3342-486A-BCEF-2A166B6F1D15'

-- delete from alumno
-- delete from incripcion
--select * From carreratecnica
--select * from CuentaporCobrar
--select * from Cargo

CREATE procedure [dbo].[sp_EnrollmentProcess] @NoExpediente varchar(12), @Ciclo varchar(4), @MesInicioPago int, @CarreraId varchar(128)
as
begin
	-- Variables para información de aspirantes
	declare @Apellidos varchar(128)
	declare @Nombres varchar(128)
	declare @Direccion varchar(128)
	declare @Telefono varchar(64)
	declare @Email varchar(64)
	declare @JornadaId varchar(128)
	-- Variables para generar número de carné
	declare @Exists int
	declare @Carne varchar(12)
	-- Variables para el proceso de pago
	declare @MontoInscripcion numeric(10,2)
	declare @NumeroPagos int
	declare @MontoPago numeric(10,2) -- 1000000.00
	declare @Descripcion varchar(128)
	declare @Prefijo varchar(6)
	declare @CargoId varchar(128)
	declare @Monto numeric(10,2)
	declare @CorrelativoPagos int
	-- Inicio de transacción
	begin transaction
	begin try
		select @Apellidos = Apellidos, @Nombres = Nombres, @Direccion = Direccion, @Telefono = Telefono, @Email = Email, @JornadaId = JornadaId
			from Aspirante where NoExpediente = @NoExpediente
		
		set @Exists = (select top 1 a.carne from alumno a where SUBSTRING(a.carne,1,4) = @Ciclo order by a.carne desc)
		if @Exists is null
		begin
			set @Carne = (@Ciclo *1000)+1
		end
		else
		begin
			set @Carne = (select top 1 a.carne from alumno a where SUBSTRING(a.carne,1,4) = @Ciclo order by a.carne desc) + 1
		end
		-- Proceso de Inscripcion
		insert into alumno values (@Carne,	@Apellidos,	@Nombres,	@Direccion,	@Telefono,	@Email)
		insert into incripcion values (newid(),	@Carne,	@CarreraId,	@JornadaId,	@Ciclo,	getdate())
		update aspirante set estatus = 'INSCRITO CICLO ' + @Ciclo WHERE NoExpediente=@NoExpediente	
		--Proceso de cargos
		--Ciclo de inscripcion
		select @MontoInscripcion = MontoInscripcion, @NumeroPagos=NumeroPagos,@MontoPago=montopagos from InversionCarreraTecnica 
		where CarreraId=@CarreraId

		select @CargoId=CargoId,@Descripcion=Descripcion,@Prefijo=Prefijo from cargo
		where cargoid = '32C2FE00-5C69-4422-87B3-8BAED99936CD'

		insert into CuentaporCobrar 
		values (concat(@Prefijo,SUBSTRING(@Ciclo,3,2),dbo.lpad('1','2','0')),@Ciclo,@Carne,@CargoId,@Descripcion,GETDATE(),GETDATE(),@MontoInscripcion,0,0)
		-- cargo de pago de carnet
		select @CargoId=CargoId,@Descripcion=Descripcion,@Prefijo=Prefijo from cargo
		where cargoid = '3DCEF5A5-F846-456C-AEB5-1A7FEF5A763E'

		insert into CuentaporCobrar 
		values (concat(@Prefijo,SUBSTRING(@Ciclo,3,2),dbo.lpad('1','2','0')),@Ciclo,@Carne,@CargoId,@Descripcion,GETDATE(),GETDATE(),@MontoInscripcion,0,0)
	
		set @CorrelativoPagos = 1

		select @CargoId=CargoId,@Descripcion=Descripcion,@Prefijo=Prefijo,@Monto=monto from cargo
		where cargoid = '820A5764-359A-4F26-9466-58A148A1F267'

		while(@CorrelativoPagos<=@NumeroPagos)
		begin
			insert into CuentaporCobrar 
			values (concat(@Prefijo,SUBSTRING(@Ciclo,3,2),dbo.lpad(@CorrelativoPagos,'2','0')),@Ciclo,@Carne,@CargoId,@Descripcion,GETDATE(),GETDATE(),@Monto,0,0)
			set @CorrelativoPagos = @CorrelativoPagos + 1
			set @MesInicioPago = @MesInicioPago + 1 
		end

		commit transaction
		select 'TRANSACTION SUCCCESS' as status
	end try
	
	begin catch
	
		select
		ERROR_NUMBER() as ErrorNumber,
		ERROR_SEVERITY() as ErrorSeverity,
		ERROR_STATE() as ErrorState,
		ERROR_PROCEDURE() as ErrorProcedure,
		ERROR_LINE() as errorLine,
		ERROR_MESSAGE() as ErrorMessage
	
	
		rollback transaction
		select 'TRANSACTION ERROR' as status
	end catch
	
end









GO
