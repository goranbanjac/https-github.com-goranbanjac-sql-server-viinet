CREATE TABLE [dbo].[Organization] (
    [Id]                     INT            IDENTITY (1, 1) NOT NULL,
    [OrganizationTypeId]     INT            NOT NULL,
    [OrganizationName]       NVARCHAR (150) NULL,
    [CreatedOn]              DATETIME       CONSTRAINT [DF_Organization_CreatedOn] DEFAULT (getdate()) NOT NULL,
    [EditedOn]               DATETIME       NULL,
    [OrganizationIdentifier] NVARCHAR (50)  NULL,
    [Address1]               NVARCHAR (250) NULL,
    [City]                   NVARCHAR (50)  NULL,
    [State]                  NVARCHAR (5)   NULL,
    [ZipCode]                NVARCHAR (5)   NULL,
    [OfficePhone]            NVARCHAR (15)  NULL,
    [OfficeEmail]            NVARCHAR (50)  NULL,
    [ParentOrganizationId]   INT            NULL,
    [OwnedOrAffiliated]      TINYINT        NULL,
    [Address2]               NVARCHAR (250) NULL,
    CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Organization_OrganizationTypeId] FOREIGN KEY ([OrganizationTypeId]) REFERENCES [dbo].[OrganizationType] ([Id]),
    CONSTRAINT [FK_Organization_ParentOrganizationId] FOREIGN KEY ([ParentOrganizationId]) REFERENCES [dbo].[Organization] ([Id])
);

