CREATE TABLE [dbo].[OrderSet] (
    [id]         INT      IDENTITY (1, 1) NOT NULL,
    [OrderSetId] INT      NULL,
    [OrderId]    INT      NULL,
    [CreatedOn]  DATETIME DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_OrderId]
    ON [dbo].[OrderSet]([OrderId] ASC)
    INCLUDE([OrderSetId]);


GO
CREATE NONCLUSTERED INDEX [idx_OrderSet]
    ON [dbo].[OrderSet]([OrderSetId] ASC)
    INCLUDE([OrderId]);

