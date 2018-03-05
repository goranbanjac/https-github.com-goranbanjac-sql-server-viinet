CREATE TABLE [dbo].[AnswerVersionChoice] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [AnswerVersionGroupId] INT            NULL,
    [VersionChoicesName]   NVARCHAR (250) NULL,
    [SortOrder]            INT            NULL,
    [Score]                TINYINT        NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_AnswerVersionGroup_Id] FOREIGN KEY ([AnswerVersionGroupId]) REFERENCES [dbo].[AnswerOptionGroup] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_AnswerVersionChoice]
    ON [dbo].[AnswerVersionChoice]([AnswerVersionGroupId] ASC)
    INCLUDE([SortOrder], [VersionChoicesName], [Score]);

