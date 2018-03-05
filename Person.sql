CREATE TABLE [dbo].[Person] (
    [Id]                  BIGINT          IDENTITY (1, 1) NOT NULL,
    [CreatedOn]           DATETIME        CONSTRAINT [DF_Person_CreatedOn] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           NVARCHAR (50)   CONSTRAINT [DF_Person_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [EditedOn]            DATETIME        NULL,
    [FirstName]           NVARCHAR (50)   NULL,
    [LastName]            NVARCHAR (50)   NULL,
    [Gender]              NVARCHAR (50)   NULL,
    [DateOfBirth]         DATETIME        NULL,
    [MiddleName]          NVARCHAR (50)   NULL,
    [PersonAttributes]    NVARCHAR (2000) NULL,
    [PrimaryEmailAddress] NVARCHAR (100)  NULL,
    CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_Person_LName]
    ON [dbo].[Person]([LastName] ASC)
    INCLUDE([FirstName], [Gender], [DateOfBirth], [PersonAttributes]);

