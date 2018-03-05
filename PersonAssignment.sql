CREATE TABLE [dbo].[PersonAssignment] (
    [Id]                   BIGINT         IDENTITY (1, 1) NOT NULL,
    [OrganizationId]       INT            NOT NULL,
    [PathwayId]            INT            NOT NULL,
    [PersonId]             BIGINT         NOT NULL,
    [EncounterId]          NVARCHAR (50)  NULL,
    [IsCompleted]          BIT            NOT NULL,
    [CreatedOn]            DATETIME       DEFAULT (getdate()) NULL,
    [EditedOn]             DATETIME       NULL,
    [AssignmentAttributes] NVARCHAR (MAX) NULL,
    [Activities]           NVARCHAR (MAX) NULL,
    [AnswerGroups]         NVARCHAR (MAX) NULL,
    [Results]              NVARCHAR (MAX) NULL,
    [Pathways]             NVARCHAR (MAX) NULL,
    [Progress]             NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);




GO
CREATE NONCLUSTERED INDEX [idx_PersonAssignment]
    ON [dbo].[PersonAssignment]([OrganizationId] ASC, [PersonId] ASC)
    INCLUDE([PathwayId], [EncounterId], [IsCompleted], [AssignmentAttributes], [Activities], [AnswerGroups], [Results], [Pathways], [Progress]);

