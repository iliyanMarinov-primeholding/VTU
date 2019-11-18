CREATE TABLE [dbo].[TagsPhone] (
    [Id]       UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [PhoneId]  UNIQUEIDENTIFIER NOT NULL,
    [TagName]  NVARCHAR (128)   NOT NULL,
    [TagValue] NVARCHAR (256)   COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_TagsPhone_PhoneInfo] FOREIGN KEY ([PhoneId]) REFERENCES [dbo].[PhoneInfo] ([Id])
);

