/*
	https://docs.microsoft.com/en-us/sql/relational-databases/tables/create-unique-constraints?view=sql-server-ver15
*/

USE [dbHotel]
GO

--ALTER TABLE [dbo].[PersonalInfo]
--ALTER COLUMN [EGN] [nvarchar](16) NOT NULL
--GO

ALTER TABLE [dbo].[PersonalInfo]
ADD CONSTRAINT AK_EGN UNIQUE([EGN])
GO 
