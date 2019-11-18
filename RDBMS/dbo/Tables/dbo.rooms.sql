CREATE TABLE [dbo].[rooms] (
    [id]          UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [roomNumber]  NVARCHAR (32)    NULL,
    [roomType]    NVARCHAR (32)    NULL,
    [bedNumber]   TINYINT          NULL,
    [floorNumber] TINYINT          NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

