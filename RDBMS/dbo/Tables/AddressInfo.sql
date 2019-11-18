CREATE TABLE [dbo].[AddressInfo] (
    [Id]             UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [PersonalInfoId] UNIQUEIDENTIFIER NOT NULL,
    [ZipCode]        NVARCHAR (64)    NULL,
    [StateName]      NVARCHAR (128)   NOT NULL,
    [CityName]       NVARCHAR (128)   NOT NULL,
    [Address]        NVARCHAR (256)   NOT NULL,
    [ext]            NVARCHAR (256)   NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_AddressInfo_PersonalInfo] FOREIGN KEY ([PersonalInfoId]) REFERENCES [dbo].[PersonalInfo] ([Id])
);

