CREATE TABLE [dbo].[StakeholderToGroup] (
    [Id]                 INT      IDENTITY (1, 1) NOT NULL,
    [PersonId]           BIGINT   NULL,
    [OrganizationId]     INT      NULL,
    [StakeHolderGroupId] INT      NULL,
    [CreatedOn]          DATETIME DEFAULT (getdate()) NULL,
    CONSTRAINT [FK_StakeholderToGroup_OrganizationId] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id]),
    CONSTRAINT [FK_StakeholderToGroup_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id]),
    CONSTRAINT [FK_StakeholderToGroup_StakeHolderGroupId] FOREIGN KEY ([StakeHolderGroupId]) REFERENCES [dbo].[StakeHolderGroup] ([Id])
);

