USE dbHotel;
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
    scalar
*/

CREATE or ALTER FUNCTION FullName
(
	@FirstName   nvarchar(128),
	@MiddleName nvarchar(128),
	@LastName    nvarchar(128)
)
RETURNS nvarchar(512)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @FullName nvarchar(512)

    /*
        set every first letter to UPPER
        set all other letters to lower
    */
    SET @FirstName  = Concat(Upper(Left(@FirstName , 1)), lower(substring(@FirstName , 2, 8000)))
    SET @MiddleName = Concat(Upper(Left(@MiddleName, 1)), lower(substring(@MiddleName, 2, 8000)))
    SET @LastName   = Concat(Upper(Left(@LastName  , 1)), lower(substring(@LastName  , 2, 8000)))

	/*
        "glue" all the names together
    */
	SET
        @FullName = concat_ws(' ',
            @FirstName ,
            @MiddleName,
            @LastName  
        )

	-- Return the result of the function
	RETURN @FullName 
END
GO

--select
--    FirstName ,
--    MiddleName,
--    LastName  ,
--    dbo.FullName(
--        FirstName ,
--        MiddleName,
--        LastName  
--    )
--FROM
--    PersonalInfo

USE dbHotel;
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
    table-valued
*/

CREATE or ALTER FUNCTION dbo.GetFullDataByID
(
	-- Add the parameters for the function here
	@Id uniqueidentifier
)
RETURNS 
@FullDataByID TABLE 
(
	-- Add the column definitions for the TABLE variable here
	EGN          nvarchar(16),
    clientNumber nvarchar(16),
    FullName     nvarchar(512)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
    INSERT INTO
        @FullDataByID (
        EGN          ,
        clientNumber ,
        FullName     
    )

    SELECT
        EGN,
        clientNumber,
        dbo.FullName (
            FirstName ,
            MiddleName,
            LastName  
        )
    FROM
        PersonalInfo
    WHERE
        ID = @Id
	
	RETURN
END
GO

-- SELECT * FROM dbo.GetFullDataByID('00000000-0000-0000-0000-000000000000')

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
    scalar
*/
/*
pre-script
---------------------------------
INSERT INTO [dbo].[PhoneInfo] (
    [Id]
    ,[PersonalInfoId]
    ,[AreaCode]
    ,[PhonenNumber]
    ,[ext]
)
SELECT
    id, id, 1, egn, null
FROM
    personalInfo
union all
SELECT
    newid(), id, 2, left(id, 6), right(id, 4)
FROM
    personalInfo
---------------------------------
*/

CREATE or ALTER FUNCTION FullPhone
(
	@AreaCode    nvarchar(128),
	@PhoneNumber nvarchar(128),
	@Ext         nvarchar(128)
)
RETURNS nvarchar(512)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @FullPhone nvarchar(512)

	/*
        "glue" all the names together
    */
	SET
        @FullPhone = concat_ws('/',
            @AreaCode   ,
            @PhoneNumber,
            @Ext        
        )

	-- Return the result of the function
	RETURN @FullPhone 
END
GO

--SELECT 
--    AreaCode    ,
--    PhonenNumber,
--    ext         ,
--    dbo.FullPhone (
--        AreaCode    ,
--        PhonenNumber,
--        ext
--    )
--FROM
--    phoneInfo

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
    inline
*/

/*
Pre-Script
----------------------------------
INSERT INTO [dbo].[TagsPhone] (
    [Id]
    ,[PhoneId]
    ,[TagName]
    ,[TagValue]
)

--select newid(), id, 'type', 'main' from phoneInfo
select newid(), id, 'type', 'home' from phoneInfo

----------------------------------
*/

CREATE or ALTER FUNCTION dbo.Get_PhoneTags_byPhoneId
(	
	-- Add the parameters for the function here
	@PhoneId uniqueidentifier
)
RETURNS nVarChar(512)
AS
BEGIN
    RETURN (
	    -- Add the SELECT statement with parameter references here
	    SELECT
            AllTags = STRING_AGG(TagValue, ',')
                WITHIN GROUP (ORDER BY TagValue)
        FROM
            TagsPhone
        WHERE
            PhoneId = @PhoneId
        --GROUP BY
        --    TagValue
    )
END
GO

-- select top 100 *, dbo.Get_PhoneTags_byPhoneId(id) from phoneInfo

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER FUNCTION dbo.Get_PhoneTags_byPhoneId2
(	
	-- Add the parameters for the function here
	@PhoneId uniqueidentifier
)
RETURNS nVarChar(512)
AS
BEGIN
    declare @result nVarChar(512)

	SELECT
        @result = Concat_ws(@result , ',', TagValue)
    FROM
        TagsPhone
    WHERE
        TagName = 'type' and
        PhoneId = @PhoneId
    ORDER BY
        TagValue

    RETURN @result
END
GO

-- select top 100 *, dbo.Get_PhoneTags_byPhoneId2(id) from phoneInfo

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER FUNCTION dbo.Get_PhoneTags_byPhoneId3
(	
	-- Add the parameters for the function here
	@PhoneId uniqueidentifier
)
RETURNS nVarChar(512)
AS
BEGIN
    declare @result nVarChar(512)

	SELECT
        @result = Concat(@result + ',', TagValue)
    FROM
        TagsPhone
    WHERE
        TagName = 'type' and
        PhoneId = @PhoneId
    GROUP BY
        TagValue
    ORDER BY
        TagValue

    RETURN @result
END
GO

-- select top 100 *, dbo.Get_PhoneTags_byPhoneId3(id) from phoneInfo

/*
    inline table-valued
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER FUNCTION dbo.Get_Phone_FullData_ByPersonalId
(	
	-- Add the parameters for the function here
	@PersonalInfoId uniqueidentifier
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT
        FullPhone = dbo.FullPhone (
            AreaCode    ,
            PhonenNumber,
            ext
        ),
        tags = dbo.Get_PhoneTags_byPhoneId3(id)
    FROM
        PhoneInfo
    WHERE
        PersonalInfoId = @PersonalInfoId
)
GO

-- select * FROM dbo.Get_Phone_FullData_ByPersonalId('00000000-0000-0000-0000-000000000000')
