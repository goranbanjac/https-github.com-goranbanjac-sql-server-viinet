CREATE TABLE [dbo].[SECU_User] (
    [SECU_User_ID]        INT             IDENTITY (1, 1) NOT NULL,
    [User_Login_ID]       NVARCHAR (50)   NOT NULL,
    [User_Pwd_Hash]       VARBINARY (64)  NULL,
    [User_Pwd_Salt]       VARBINARY (64)  NULL,
    [Pwd_Expiration_Date] DATETIME        NULL,
    [First_Name]          NVARCHAR (50)   NOT NULL,
    [Last_Name]           NVARCHAR (50)   NOT NULL,
    [Email]               NVARCHAR (150)  NULL,
    [Alt_Email]           NVARCHAR (150)  NULL,
    [Is_Sys_Admin]        BIT             NOT NULL,
    [Is_Locked]           BIT             NOT NULL,
    [Must_Change_Pwd]     BIT             NOT NULL,
    [Failed_Logins]       INT             NOT NULL,
    [Created_Date]        DATETIME        NOT NULL,
    [Valid_Date]          DATETIME        NOT NULL,
    [End_Date]            DATETIME        NULL,
    [Home_Org_ID]         INT             NOT NULL,
    [Home_Page]           NVARCHAR (250)  NULL,
    [NPI]                 NVARCHAR (50)   NULL,
    [User_Attributes]     NVARCHAR (2000) NULL,
    [Gender]              CHAR (1)        NULL,
    [EditedOn]            DATETIME        NULL,
    [Email_Token]         NVARCHAR (50)   NULL,
    CONSTRAINT [PK_SECU_User] PRIMARY KEY CLUSTERED ([SECU_User_ID] ASC),
    CONSTRAINT [FK_SECU_User_Org] FOREIGN KEY ([Home_Org_ID]) REFERENCES [dbo].[Organization] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_SECU_User_Email]
    ON [dbo].[SECU_User]([Email] ASC)
    INCLUDE([User_Login_ID], [User_Pwd_Hash], [User_Pwd_Salt], [Pwd_Expiration_Date], [First_Name], [Last_Name], [Alt_Email], [Is_Sys_Admin], [Is_Locked], [Must_Change_Pwd], [Valid_Date], [End_Date], [Home_Org_ID], [Home_Page], [NPI], [User_Attributes], [Gender], [Email_Token]);


GO
CREATE NONCLUSTERED INDEX [idx_SECU_User_Email_Token]
    ON [dbo].[SECU_User]([Email_Token] ASC)
    INCLUDE([User_Login_ID], [User_Pwd_Hash], [User_Pwd_Salt], [Pwd_Expiration_Date], [First_Name], [Last_Name], [Email], [Alt_Email], [Is_Sys_Admin], [Is_Locked], [Must_Change_Pwd], [Created_Date], [Valid_Date], [End_Date], [Home_Org_ID], [Home_Page], [NPI], [User_Attributes], [Gender]);


GO
CREATE NONCLUSTERED INDEX [idx_SECU_User_User_Login_ID]
    ON [dbo].[SECU_User]([User_Login_ID] ASC)
    INCLUDE([User_Pwd_Hash], [User_Pwd_Salt], [Pwd_Expiration_Date], [First_Name], [Last_Name], [Email], [Alt_Email], [Is_Sys_Admin], [Is_Locked], [Must_Change_Pwd], [Failed_Logins], [Created_Date], [Valid_Date], [End_Date], [Home_Page], [NPI], [User_Attributes], [Gender], [EditedOn], [Email_Token]);

