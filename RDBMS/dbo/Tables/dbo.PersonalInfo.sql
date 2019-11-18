CREATE TABLE [dbo].[PersonalInfo] (
    [Id]           UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [FirstName]    NVARCHAR (256)   NOT NULL,
    [MiddleName]   NVARCHAR (128)   NULL,
    [LastName]     NVARCHAR (128)   NULL,
    [EGN]          NVARCHAR (16)    NULL,
    [clientNumber] NVARCHAR (16)    NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

