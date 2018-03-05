CREATE TABLE [dbo].[OrderOrganization] (
    [OrganizationId]        INT             NOT NULL,
    [OrderId]               INT             NOT NULL,
    [Id]                    INT             IDENTITY (1, 1) NOT NULL,
    [CreatedOn]             DATETIME        DEFAULT (getdate()) NULL,
    [OrderTypeId]           INT             NULL,
    [OrderVersionAttribute] NVARCHAR (MAX)  NULL,
    [EditedOn]              DATETIME        NULL,
    [OrderDescription]      NVARCHAR (1000) NULL,
    [OrderNickname]         NVARCHAR (1000) NULL,
    [OrderConfiguration]    NVARCHAR (MAX)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_OrderOrganization_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[OrderCatalog] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_OrderOrganization_OrganizationId]
    ON [dbo].[OrderOrganization]([OrganizationId] ASC, [OrderTypeId] ASC)
    INCLUDE([OrderDescription], [OrderNickname], [OrderId], [OrderConfiguration], [OrderVersionAttribute]);

