CREATE TABLE [dbo].[OrganizationType] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (50)  NULL,
    [Description] NVARCHAR (100) NULL,
    CONSTRAINT [PK_OrganizationType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

