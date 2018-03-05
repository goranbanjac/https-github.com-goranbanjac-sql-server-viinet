CREATE TABLE [dbo].[PersonRelationship] (
    [Id]                   BIGINT   IDENTITY (1, 1) NOT NULL,
    [PersonId]             BIGINT   NOT NULL,
    [PersonRelationshipId] BIGINT   NOT NULL,
    [CreatedOn]            DATETIME CONSTRAINT [DF_PersonRelationship_CreatedOn] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PersonRelationship] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_PersonRelationship_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id]),
    CONSTRAINT [FK_PersonRelationship_PersonRelationshipId] FOREIGN KEY ([PersonRelationshipId]) REFERENCES [dbo].[Person] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_PersonRelationship_PersonId]
    ON [dbo].[PersonRelationship]([PersonId] ASC)
    INCLUDE([PersonRelationshipId]);


GO
CREATE NONCLUSTERED INDEX [idx_PersonRelationship_PersonRelationshipIdon]
    ON [dbo].[PersonRelationship]([PersonRelationshipId] ASC)
    INCLUDE([PersonId]);

