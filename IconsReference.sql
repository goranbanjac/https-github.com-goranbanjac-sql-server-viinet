CREATE TABLE [dbo].[IconsReference] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [IconsReference] NVARCHAR (250) NULL,
    [CreatedOn]      DATETIME       DEFAULT (getdate()) NOT NULL,
    [CreatedBy]      VARCHAR (50)   DEFAULT (suser_sname()) NOT NULL,
    [EditedOn]       DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

