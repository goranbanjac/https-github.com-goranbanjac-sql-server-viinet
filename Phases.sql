CREATE TABLE [dbo].[Phases] (
    [Id]       INT           IDENTITY (1, 1) NOT NULL,
    [Title]    NVARCHAR (50) NULL,
    [Sequence] TINYINT       NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

