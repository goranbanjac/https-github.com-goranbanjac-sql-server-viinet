CREATE TABLE [dbo].[OrderAction] (
    [Id]               INT      IDENTITY (1, 1) NOT NULL,
    [OrderCatalogId]   INT      NOT NULL,
    [AssignedActionId] INT      NOT NULL,
    [CreatedOn]        DATETIME NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

