/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

/*
Pre-Script
--------------------------------------------------------------------------------------
insert into [PhoneInfo] ([Id],[PersonalInfoId],[PhonenNumber], areaCode)
select Id,Id,clientNumber, '084' from PersonalInfo
--------------------------------------------------------------------------------------
*/

USE dbHotel;
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER TRIGGER PersonalInfo_Update
   ON  PersonalInfo
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
    --select * from inserted
    --union all
    --select * from deleted

    /* fires only if we add EGN in SET list */
    IF(UPDATE(egn))
        UPDATE
            PersonalInfo
        SET
            clientNumber = O.EGN
        FROM
            PersonalInfo O -- original table
            /* update only "Inserted/Updated" records */
            inner join
            inserted N -- new data
            ON
                N.id = O.Id
        WHERE
            /* updates only changed EGN records */
            O.clientNumber != O.EGN

------------------------------------------------------
-- select * from   PersonalInfo where egn = '00000000'
-- UPDATE top (1)  PersonalInfo set   egn = '00000000'
-- UPDATE top (1)  PersonalInfo set   egn = newid()
-- UPDATE top (10) PersonalInfo set   egn = '00000000'
-- UPDATE top (10) PersonalInfo set   FirstName = 'ivan'
END
GO