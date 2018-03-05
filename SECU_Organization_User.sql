CREATE TABLE [dbo].[SECU_Organization_User] (
    [SECU_Organization_User_ID] INT      IDENTITY (1, 1) NOT NULL,
    [OrganizationId]            INT      NOT NULL,
    [SECU_User_ID]              INT      NOT NULL,
    [Created_Date]              DATETIME NOT NULL,
    [UserTypeId]                INT      NOT NULL,
    CONSTRAINT [PK_SECU_Organization_User] PRIMARY KEY CLUSTERED ([SECU_Organization_User_ID] ASC),
    CONSTRAINT [FK_SECU_Organization_User_Organization] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id]),
    CONSTRAINT [FK_SECU_Organization_User_SECU_User] FOREIGN KEY ([SECU_User_ID]) REFERENCES [dbo].[SECU_User] ([SECU_User_ID])
);


GO
CREATE NONCLUSTERED INDEX [idx_SECU_Organization_User]
    ON [dbo].[SECU_Organization_User]([OrganizationId] ASC, [SECU_User_ID] ASC, [UserTypeId] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_SECU_Organization_User_SECU_User_ID]
    ON [dbo].[SECU_Organization_User]([SECU_User_ID] ASC)
    INCLUDE([UserTypeId]);

