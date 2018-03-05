CREATE TABLE [dbo].[SECU_Access_Control_Entity] (
    [SECU_Access_Control_Entity_ID] INT            IDENTITY (1, 1) NOT NULL,
    [Category]                      NVARCHAR (50)  NOT NULL,
    [Name]                          NVARCHAR (50)  NOT NULL,
    [Description]                   NVARCHAR (500) NULL,
    CONSTRAINT [PK_SECU_Access_Control_Entity] PRIMARY KEY CLUSTERED ([SECU_Access_Control_Entity_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_SECU_Access_Control_Entity_category_Name]
    ON [dbo].[SECU_Access_Control_Entity]([Category] ASC, [Name] ASC);

