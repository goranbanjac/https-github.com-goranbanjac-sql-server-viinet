CREATE TABLE [dbo].[ProviderAssignment] (
    [Id]                 BIGINT          IDENTITY (1, 1) NOT NULL,
    [PersonId]           BIGINT          NULL,
    [PersonAssignmentId] BIGINT          NULL,
    [PersonAttribute]    NVARCHAR (1000) NULL,
    [RiskLevel]          INT             NULL,
    [ActivityStatus]     NVARCHAR (1000) NULL,
    [Notes]              NVARCHAR (MAX)  NULL,
    [CreatedOn]          DATETIME        NULL,
    [EditedOn]           DATETIME        NULL,
    [ProviderActivity]   NVARCHAR (MAX)  NULL,
    PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
CREATE CLUSTERED INDEX [cl_idx_ProviderAssignment_PersonId]
    ON [dbo].[ProviderAssignment]([PersonId] ASC, [PersonAssignmentId] ASC);

