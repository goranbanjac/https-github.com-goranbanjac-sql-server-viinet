CREATE TABLE [dbo].[EmailGroup] (
    [Id]        INT           IDENTITY (1, 1) NOT NULL,
    [GroupName] NVARCHAR (50) NULL,
    [CreatedOn] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

