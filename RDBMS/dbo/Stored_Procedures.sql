USE [dbHotel]
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

create or alter procedure dbo.allPInfo
as
begin
	select *
	from PersonalInfo
end
go

create or alter procedure dbo.getPInfo
-- delcare
	@id			[uniqueidentifier] = null
as
begin
	select *
	from PersonalInfo
    where id = @id
end
go

execute dbo.getPInfo
exec dbo.getPInfo

create or alter procedure dbo.getPInfo
-- delcare
	@id			[uniqueidentifier] = NULL
as
begin
    IF @id IS NULL
	    select *
	    from PersonalInfo
    else
	    select *
	    from PersonalInfo
        where id = @id
end
go

create or alter procedure dbo.newPInfo
-- delcare
	@FirstName  [nvarchar](256) = NULL,
	@MiddleName [nvarchar](128) = NULL,
	@LastName	[nvarchar](128) = NULL,
	@EGN		[nvarchar](16 ) = NULL,
	@id			[uniqueidentifier]
as
begin
	INSERT INTO
	    PersonalInfo (
		FirstName ,
		MiddleName,
		LastName  ,
		EGN		   
	)
	VALUES (
		@FirstName ,
		@MiddleName,
		@LastName  ,
		@EGN
	)
end
go

create or alter procedure dbo.setPInfo
-- delcare
	@FirstName  [nvarchar](256) = NULL,
	@MiddleName [nvarchar](128) = NULL,
	@LastName	[nvarchar](128) = NULL,
	@EGN		[nvarchar](16 ) = NULL,
	@id			[uniqueidentifier]
as
begin
	update
		PersonalInfo
	set 
		FirstName  = isNull(@FirstName , FirstName ),
		MiddleName = isNull(@MiddleName, MiddleName),
		LastName   = isNull(@LastName  , LastName  ),
		EGN		   = isNull(@EGN	   , EGN	   )
	where
		id = @id
end
go

create or alter procedure dbo.setPInfo
-- delcare
	@FirstName  [nvarchar](256) = NULL,
	@MiddleName [nvarchar](128) = NULL,
	@LastName	[nvarchar](128) = NULL,
	@EGN		[nvarchar](16 ) = NULL,
	@id			[uniqueidentifier] = NULL
as
begin
	update
		PersonalInfo
	set 
		FirstName  = isNull(@FirstName , FirstName ),
		MiddleName = isNull(@MiddleName, MiddleName),
		LastName   = isNull(@LastName  , LastName  ),
		EGN		   = isNull(@EGN	   , EGN	   )
	where
		id = @id

    IF @@ROWCOUNT = 0
        INSERT INTO
	    PersonalInfo (
		    FirstName ,
		    MiddleName,
		    LastName  ,
		    EGN		   
	    )
	    VALUES (
		    @FirstName ,
		    @MiddleName,
		    @LastName  ,
		    @EGN
	    )    
end
go

create or alter procedure dbo.delPInfo
-- delcare
	@id			[uniqueidentifier]
as
begin
	delete
		PersonalInfo
	where
		id = @id
end
go
