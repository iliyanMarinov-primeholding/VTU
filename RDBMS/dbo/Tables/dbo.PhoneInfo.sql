CREATE TABLE [dbo].[PhoneInfo] (
    [Id]             UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [PersonalInfoId] UNIQUEIDENTIFIER NOT NULL,
    [AreaCode]       NVARCHAR (64)    NOT NULL,
    [PhonenNumber]   NVARCHAR (128)   NOT NULL,
    [ext]            NVARCHAR (64)    NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_PhoneInfo_Phone_Len] CHECK (len(Trim((' ,.<>/?;'':"[]\{}|`~!@#$%^&*()_+-='+char((10)))+char((13)) FROM [PhonenNumber]))>(0)),
    CONSTRAINT [FK_PhoneInfo_PersonalInfo] FOREIGN KEY ([PersonalInfoId]) REFERENCES [dbo].[PersonalInfo] ([Id])
);

