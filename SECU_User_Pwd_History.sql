CREATE TABLE [dbo].[SECU_User_Pwd_History] (
    [SECU_User_Pwd_History_ID] INT         IDENTITY (1, 1) NOT NULL,
    [SECU_User_ID]             INT         NOT NULL,
    [User_Pwd_Hash]            BINARY (64) NOT NULL,
    [User_Pwd_Salt]            BINARY (64) NOT NULL,
    [Expiration_Date]          DATETIME    NOT NULL,
    CONSTRAINT [PK_SECU_User_Pwd_History] PRIMARY KEY CLUSTERED ([SECU_User_Pwd_History_ID] ASC),
    CONSTRAINT [FK_SECU_User_Pwd_History_SECU_User] FOREIGN KEY ([SECU_User_ID]) REFERENCES [dbo].[SECU_User] ([SECU_User_ID])
);

