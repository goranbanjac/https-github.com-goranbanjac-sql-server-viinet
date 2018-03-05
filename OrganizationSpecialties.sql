CREATE TABLE [dbo].[OrganizationSpecialties] (
    [Id]             INT           IDENTITY (1, 1) NOT NULL,
    [OrganizationId] INT           NOT NULL,
    [Specialties]    NVARCHAR (50) NULL,
    CONSTRAINT [PK_OrganizationSpecialties] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_OrganizationSpecialties_Organization] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_OrganizationSpecialties_OrganizationId]
    ON [dbo].[OrganizationSpecialties]([OrganizationId] ASC)
    INCLUDE([Specialties]);

