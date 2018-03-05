CREATE TABLE [dbo].[AnswerOptionGroup] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [AnswerVersionGroup] NVARCHAR (100) NULL,
    [LanguageId]         TINYINT        NOT NULL,
    CONSTRAINT [PK_AnswerVersionGroup_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_AnswerVersionGroup_Language] FOREIGN KEY ([LanguageId]) REFERENCES [dbo].[Language] ([Id])
);

