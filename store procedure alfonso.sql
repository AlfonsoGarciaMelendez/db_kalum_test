USE [kalum_test]
GO
/****** Object:  StoredProcedure [dbo].[sp_EnrollmentProcess]    Script Date: 7/05/2022 08:26:16 ******/
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

ALTER procedure [dbo].[sp_EnrollmentProcess] @NoExpediente varchar(12), @Ciclo varchar(4), @MesInicioPago int, @CarreraId varchar(128)
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









