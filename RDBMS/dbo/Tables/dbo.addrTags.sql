CREATE TABLE [dbo].[addrTags] (
    [Id]        UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [AddressId] UNIQUEIDENTIFIER NOT NULL,
    [TagName]   NVARCHAR (128)   NOT NULL,
    [TagValue]  NVARCHAR (128)   NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_addrTags_AddressInfo] FOREIGN KEY ([AddressId]) REFERENCES [dbo].[AddressInfo] ([Id])
);

