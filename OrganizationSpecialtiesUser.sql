CREATE TABLE [dbo].[OrganizationSpecialtiesUser] (
    [Id]                       INT IDENTITY (1, 1) NOT NULL,
    [OrganizationSpecialtieId] INT NOT NULL,
    [SECU_User_ID]             INT NOT NULL,
    CONSTRAINT [PK_OrganizationSpecialtiesUser] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_OrganizationSpecialtiesUser_OrganizationSpecialties] FOREIGN KEY ([OrganizationSpecialtieId]) REFERENCES [dbo].[OrganizationSpecialties] ([Id]),
    CONSTRAINT [FK_OrganizationSpecialtiesUser_SECU_User] FOREIGN KEY ([SECU_User_ID]) REFERENCES [dbo].[SECU_User] ([SECU_User_ID])
);


GO
CREATE NONCLUSTERED INDEX [idx_OrganizationSpecialtiesUser]
    ON [dbo].[OrganizationSpecialtiesUser]([SECU_User_ID] ASC)
    INCLUDE([OrganizationSpecialtieId]);

