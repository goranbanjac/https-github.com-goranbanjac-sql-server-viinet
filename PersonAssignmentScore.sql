CREATE TABLE [dbo].[PersonAssignmentScore] (
    [Id]                 INT             IDENTITY (1, 1) NOT NULL,
    [PersonAssignmentId] BIGINT          NULL,
    [ActivityId]         INT             NOT NULL,
    [OrderSetId]         INT             NOT NULL,
    [Section]            NVARCHAR (50)   NULL,
    [OutcomeScore]       DECIMAL (10, 2) NULL,
    [OrderSetName]       NVARCHAR (500)  NULL,
    [CreatedOn]          DATETIME        DEFAULT (getdate()) NULL,
    [EditedOn]           DATETIME        NULL,
    CONSTRAINT [PK_PersonAssignmentScore_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC),
    CONSTRAINT [fk_PersonAssignment_PersonAssignmentId] FOREIGN KEY ([PersonAssignmentId]) REFERENCES [dbo].[PersonAssignment] ([Id])
);


GO
CREATE CLUSTERED INDEX [cl_idx_PersonAssignmentScore_PersonAssignmentId]
    ON [dbo].[PersonAssignmentScore]([PersonAssignmentId] ASC);

