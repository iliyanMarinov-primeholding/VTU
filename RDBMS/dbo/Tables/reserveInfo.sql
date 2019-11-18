CREATE TABLE [dbo].[reserveInfo] (
    [Id]             UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [roomId]         UNIQUEIDENTIFIER NOT NULL,
    [personalInfoId] UNIQUEIDENTIFIER NOT NULL,
    [dateFrom]       DATETIME         NULL,
    [dateTo]         DATETIME         NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_reserveInfo_PersonalInfo] FOREIGN KEY ([personalInfoId]) REFERENCES [dbo].[PersonalInfo] ([Id]),
    CONSTRAINT [FK_reserveInfo_rooms] FOREIGN KEY ([roomId]) REFERENCES [dbo].[rooms] ([id])
);

