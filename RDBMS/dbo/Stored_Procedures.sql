/*
    line numbers
*/

USE [dbHotel]
GO

set ansi_nulls on;
go

set quoted_identifier on;
go

create or alter dbo.allPInfo
as
begin
	select *
	from PersonalInfo
end
go

create or alter dbo.getPInfo
-- delcare
	@id			[uniqueidentifier]
as
begin
	select *
	from PersonalInfo
    where id = @id
end
go

create or alter dbo.newPInfo
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

create or alter dbo.setPInfo
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

create or alter dbo.setPInfo
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
