CREATE TABLE [dbo].[SECU_Role_Access_Privilege] (
    [SECU_Role_Access_Privilege_ID] INT      IDENTITY (1, 1) NOT NULL,
    [SECU_Role_ID]                  INT      NOT NULL,
    [SECU_Access_Control_Entity_ID] INT      NOT NULL,
    [Privilege]                     INT      NOT NULL,
    [CreatedOn]                     DATETIME NULL,
    [EditedOn]                      DATETIME NULL,
    CONSTRAINT [PK_SECU_Role_Access_Privilege] PRIMARY KEY CLUSTERED ([SECU_Role_Access_Privilege_ID] ASC),
    CONSTRAINT [FK_SECU_Role_Access_Privilege_SECU_Role] FOREIGN KEY ([SECU_Role_ID]) REFERENCES [dbo].[SECU_Role] ([SECU_Role_ID]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [idx_SECU_Role_Access_Privilege]
    ON [dbo].[SECU_Role_Access_Privilege]([SECU_Role_ID] ASC, [SECU_Access_Control_Entity_ID] ASC)
    INCLUDE([Privilege]);

