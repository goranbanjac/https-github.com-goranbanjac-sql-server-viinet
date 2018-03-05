CREATE TABLE [dbo].[SECU_Challenge] (
    [SECU_Challenge_ID] INT            IDENTITY (1, 1) NOT NULL,
    [Question]          NVARCHAR (250) NOT NULL,
    [Created_Date]      DATETIME       DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SECU_Challenge] PRIMARY KEY CLUSTERED ([SECU_Challenge_ID] ASC)
);

