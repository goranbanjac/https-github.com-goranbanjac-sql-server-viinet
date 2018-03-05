CREATE TABLE [dbo].[EmailList] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [EmailGroupId] INT           NOT NULL,
    [EmailAddress] NVARCHAR (50) NULL,
    [CreatedOn]    DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);



