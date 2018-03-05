CREATE TABLE [dbo].[ActivitySet] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [ActivitySetId] INT      NULL,
    [OrderSetId]    INT      NULL,
    [CreatedOn]     DATETIME DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_ActivitySet]
    ON [dbo].[ActivitySet]([ActivitySetId] ASC)
    INCLUDE([OrderSetId]);


GO
CREATE NONCLUSTERED INDEX [idx_OrderSetId]
    ON [dbo].[ActivitySet]([OrderSetId] ASC)
    INCLUDE([ActivitySetId]);

