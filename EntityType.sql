CREATE TABLE [dbo].[EntityType] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (50)  NULL,
    [Description] NVARCHAR (150) NULL,
    CONSTRAINT [PK_EntityType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

