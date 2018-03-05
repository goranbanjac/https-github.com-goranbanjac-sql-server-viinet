CREATE TABLE [dbo].[PathwayActionTime] (
    [PersonAssignmentId] INT             NOT NULL,
    [ActionDateTime]     DATETIME        NOT NULL,
    [ActivityJson]       NVARCHAR (1000) NULL,
    [TriggerTypeId]      INT             NOT NULL
);


GO
CREATE CLUSTERED INDEX [cl_idx_PathwayActionTime]
    ON [dbo].[PathwayActionTime]([ActionDateTime] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_PathwayActionTime]
    ON [dbo].[PathwayActionTime]([PersonAssignmentId] ASC);

