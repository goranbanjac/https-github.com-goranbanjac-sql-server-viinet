CREATE TABLE [dbo].[SECU_User_Role] (
    [SECU_User_Role_ID] INT      IDENTITY (1, 1) NOT NULL,
    [SECU_User_ID]      INT      NOT NULL,
    [SECU_Role_ID]      INT      NOT NULL,
    [Created_Date]      DATETIME NOT NULL,
    CONSTRAINT [PK_SECU_User_Role] PRIMARY KEY CLUSTERED ([SECU_User_Role_ID] ASC),
    CONSTRAINT [FK_SECU_User_Role_SECU_Role] FOREIGN KEY ([SECU_Role_ID]) REFERENCES [dbo].[SECU_Role] ([SECU_Role_ID]),
    CONSTRAINT [FK_SECU_User_Role_SECU_User] FOREIGN KEY ([SECU_User_ID]) REFERENCES [dbo].[SECU_User] ([SECU_User_ID])
);


GO
CREATE NONCLUSTERED INDEX [idx_SECU_User_Role_SECU_User_ID]
    ON [dbo].[SECU_User_Role]([SECU_User_ID] ASC)
    INCLUDE([SECU_Role_ID]);

