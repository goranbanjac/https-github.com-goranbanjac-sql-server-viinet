CREATE TABLE [dbo].[OrderCatalog] (
    [Id]                   INT             IDENTITY (1, 1) NOT NULL,
    [OrderCheckSum]        INT             NOT NULL,
    [Order]                NVARCHAR (1000) NULL,
    [IsReusable]           TINYINT         NOT NULL,
    [OrderTypeId]          INT             NOT NULL,
    [OrderCategoryId]      TINYINT         NULL,
    [AnswerInputTypeId]    TINYINT         NULL,
    [CreatedOn]            DATETIME        DEFAULT (getdate()) NULL,
    [EditedOn]             DATETIME        NULL,
    [AnswerVersionGroupId] INT             NULL,
    [IsRequired]           TINYINT         NULL,
    [SortOrder]            INT             NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_OrderCatalog_AnswerInputTypes] FOREIGN KEY ([AnswerInputTypeId]) REFERENCES [dbo].[AnswerInputType] ([Id]),
    CONSTRAINT [FK_OrderCatalog_AnswerVersionGroupId] FOREIGN KEY ([AnswerVersionGroupId]) REFERENCES [dbo].[AnswerOptionGroup] ([Id]),
    CONSTRAINT [FK_OrderCatalog_OrderCategoryId] FOREIGN KEY ([OrderCategoryId]) REFERENCES [dbo].[OrderCategory] ([Id]),
    CONSTRAINT [fk_OrderCatalog_OrderTypeId] FOREIGN KEY ([OrderTypeId]) REFERENCES [dbo].[OrderType] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_OrderCatalog_Order_OrderTypeId]
    ON [dbo].[OrderCatalog]([OrderCategoryId] ASC)
    INCLUDE([Order], [OrderTypeId]);

