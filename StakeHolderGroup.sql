CREATE TABLE [dbo].[StakeHolderGroup] (
    [Id]                 INT           IDENTITY (1, 1) NOT NULL,
    [GroupName]          NVARCHAR (50) NULL,
    [StakeHoldersTypeId] TINYINT       NULL,
    [CreatedOn]          DATETIME      DEFAULT (getdate()) NULL,
    [OrganizationId]     INT           NOT NULL,
    [EditedOn]           DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_StakeholderGroup_StakeHoldersTypeId] FOREIGN KEY ([StakeHoldersTypeId]) REFERENCES [dbo].[StakeHolderType] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_StakeHolderGroup]
    ON [dbo].[StakeHolderGroup]([OrganizationId] ASC)
    INCLUDE([GroupName], [StakeHoldersTypeId]);

