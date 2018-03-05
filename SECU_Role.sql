CREATE TABLE [dbo].[SECU_Role] (
    [SECU_Role_ID]     INT            IDENTITY (1, 1) NOT NULL,
    [OrganizationId]   INT            NOT NULL,
    [Role_Name]        NVARCHAR (50)  NOT NULL,
    [Description]      NVARCHAR (500) NULL,
    [Create_Date]      DATETIME       NOT NULL,
    [Propagate]        BIT            NULL,
    [EditedOn]         DATETIME       NULL,
    [PropagatedRoleId] INT            NULL,
    CONSTRAINT [PK_SECU_Role] PRIMARY KEY CLUSTERED ([SECU_Role_ID] ASC),
    CONSTRAINT [FK_SECU_Role_Organization] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idx_SECU_Role_OrganizationId]
    ON [dbo].[SECU_Role]([OrganizationId] ASC, [Role_Name] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_SECU_Role_PropagatedRoleId]
    ON [dbo].[SECU_Role]([PropagatedRoleId] ASC);

