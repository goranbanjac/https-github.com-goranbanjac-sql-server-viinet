CREATE TABLE [dbo].[SECU_User_Challenge] (
    [SECU_User_Challenge_ID] INT           IDENTITY (1, 1) NOT NULL,
    [SECU_User_ID]           INT           NOT NULL,
    [Display_Order]          INT           NOT NULL,
    [SECU_Challenge_ID]      INT           NOT NULL,
    [Answer]                 NVARCHAR (50) NOT NULL,
    [Created_Date]           DATETIME      NOT NULL,
    CONSTRAINT [PK_SECU_User_Challenge] PRIMARY KEY CLUSTERED ([SECU_User_Challenge_ID] ASC),
    CONSTRAINT [FK_SECU_User_Challenge_SECU_Challenge] FOREIGN KEY ([SECU_Challenge_ID]) REFERENCES [dbo].[SECU_Challenge] ([SECU_Challenge_ID]),
    CONSTRAINT [FK_SECU_User_Challenge_SECU_User] FOREIGN KEY ([SECU_User_ID]) REFERENCES [dbo].[SECU_User] ([SECU_User_ID])
);

