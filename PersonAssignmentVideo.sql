CREATE TABLE [dbo].[PersonAssignmentVideo] (
    [Id]                 UNIQUEIDENTIFIER NOT NULL,
    [PersonAssignmentId] BIGINT           NULL,
    [VideoFileName]      NVARCHAR (500)   NULL,
    [CreatedOn]          DATETIME         DEFAULT (getdate()) NULL,
    [EditedOn]           DATETIME         NULL,
    CONSTRAINT [PK_PersonAssignmentVideo_Id] PRIMARY KEY NONCLUSTERED ([Id] ASC),
    CONSTRAINT [fk_PersonAssignmentVideo_PersonAssignmentId] FOREIGN KEY ([PersonAssignmentId]) REFERENCES [dbo].[PersonAssignment] ([Id])
);


GO
CREATE CLUSTERED INDEX [cl_idx_PersonAssignmentVideo_PersonAssignmentId]
    ON [dbo].[PersonAssignmentVideo]([PersonAssignmentId] ASC);

