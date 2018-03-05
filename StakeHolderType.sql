CREATE TABLE [dbo].[StakeHolderType] (
    [Id]              TINYINT       IDENTITY (1, 1) NOT NULL,
    [StakeHolderType] NVARCHAR (50) NULL,
    [CreatedOn]       DATETIME      NULL,
    CONSTRAINT [PK_BitMaskId] PRIMARY KEY CLUSTERED ([Id] ASC)
);

