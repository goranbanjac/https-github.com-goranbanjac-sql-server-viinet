CREATE TABLE [dbo].[OrderCategory] (
    [Id]       TINYINT       IDENTITY (1, 1) NOT NULL,
    [Category] NVARCHAR (50) NULL,
    CONSTRAINT [PK_OrderCategory_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

