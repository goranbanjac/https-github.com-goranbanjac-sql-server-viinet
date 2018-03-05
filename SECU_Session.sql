CREATE TABLE [dbo].[SECU_Session] (
    [OrganizationId] INT              NOT NULL,
    [SECU_User_ID]   INT              NOT NULL,
    [Token]          UNIQUEIDENTIFIER NOT NULL,
    [Created_Date]   DATETIME         NOT NULL,
    [Expire_Date]    DATETIME         NOT NULL,
    CONSTRAINT [PK_SECU_Session] PRIMARY KEY NONCLUSTERED ([Token] ASC),
    CONSTRAINT [FK_SECU_Session_SECU_User] FOREIGN KEY ([SECU_User_ID]) REFERENCES [dbo].[SECU_User] ([SECU_User_ID])
);


GO
CREATE NONCLUSTERED INDEX [idx_SECU_Session_Expire_Date]
    ON [dbo].[SECU_Session]([Expire_Date] ASC)
    INCLUDE([Token]);

