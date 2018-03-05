CREATE TABLE [dbo].[AnswerIconsReference] (
    [AnswerVersionChoiceId] INT NOT NULL,
    [IconsReferenceId]      INT NOT NULL,
    PRIMARY KEY CLUSTERED ([AnswerVersionChoiceId] ASC, [IconsReferenceId] ASC),
    CONSTRAINT [fk_AnswerIconsReference_IconsReferenceId] FOREIGN KEY ([IconsReferenceId]) REFERENCES [dbo].[IconsReference] ([Id])
);

