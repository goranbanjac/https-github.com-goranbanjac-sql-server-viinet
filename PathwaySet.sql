CREATE TABLE [dbo].[PathwaySet] (
    [Id]         INT      IDENTITY (1, 1) NOT NULL,
    [PathwayId]  INT      NULL,
    [ActivityId] INT      NULL,
    [CreatedOn]  DATETIME DEFAULT (getdate()) NULL,
    [EditedOn]   DATETIME NULL
);


GO
CREATE NONCLUSTERED INDEX [idx_ActivityId]
    ON [dbo].[PathwaySet]([ActivityId] ASC)
    INCLUDE([PathwayId]);


GO
CREATE NONCLUSTERED INDEX [idx_PathwaySet]
    ON [dbo].[PathwaySet]([PathwayId] ASC)
    INCLUDE([ActivityId]);

