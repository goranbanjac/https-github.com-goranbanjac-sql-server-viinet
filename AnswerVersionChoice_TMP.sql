CREATE TABLE [dbo].[AnswerVersionChoice_TMP] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [AnswerVersionGroupId] INT            NOT NULL,
    [VersionChoicesName]   NVARCHAR (250) NULL,
    [SortOrder]            TINYINT        NULL,
    [Score]                TINYINT        NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

