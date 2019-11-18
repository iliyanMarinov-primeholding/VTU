CREATE TABLE [dbo].[PhoneInfo] (
    [Id]             UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [PersonalInfoId] UNIQUEIDENTIFIER NOT NULL,
    [AreaCode]       NVARCHAR (64)    NOT NULL,
    [PhonenNumber]   NVARCHAR (128)   NOT NULL,
    [ext]            NVARCHAR (64)    NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_PhoneInfo_PersonalInfo] FOREIGN KEY ([PersonalInfoId]) REFERENCES [dbo].[PersonalInfo] ([Id])
);

