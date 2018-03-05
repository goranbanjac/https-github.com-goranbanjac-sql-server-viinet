CREATE TABLE [dbo].[PersonOrganization] (
    [Id]             BIGINT   IDENTITY (1, 1) NOT NULL,
    [OrganizationId] INT      NOT NULL,
    [PersonId]       BIGINT   NOT NULL,
    [CreatedOn]      DATETIME CONSTRAINT [DF_OrganizationPersonRelationship_CreatedOn] DEFAULT (getdate()) NULL,
    [EditedOn]       DATETIME NULL,
    CONSTRAINT [PK_OrganizationPersonRelationship] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_OrganizationPersonRelationship_OrganizationId] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id]),
    CONSTRAINT [FK_OrganizationPersonRelationship_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_PersonOrganization_OrganizationId]
    ON [dbo].[PersonOrganization]([OrganizationId] ASC)
    INCLUDE([PersonId]);

