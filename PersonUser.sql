CREATE TABLE [dbo].[PersonUser] (
    [UserId]         INT      NOT NULL,
    [PersonId]       BIGINT   NOT NULL,
    [PersonTypeId]   INT      NOT NULL,
    [OrganizationId] INT      NOT NULL,
    [CreatedOn]      DATETIME CONSTRAINT [DF_PersonUser_CreatedOn] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_PersonUser] PRIMARY KEY CLUSTERED ([UserId] ASC, [PersonId] ASC),
    CONSTRAINT [FK_PersonUser_PersonId] FOREIGN KEY ([PersonId]) REFERENCES [dbo].[Person] ([Id]),
    CONSTRAINT [FK_PersonUser_PersonTypeId] FOREIGN KEY ([PersonTypeId]) REFERENCES [dbo].[PersonType] ([Id]),
    CONSTRAINT [FK_PersonUser_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[SECU_User] ([SECU_User_ID])
);


GO
CREATE NONCLUSTERED INDEX [idx_PersonUser_OrganizationId]
    ON [dbo].[PersonUser]([OrganizationId] ASC, [PersonTypeId] ASC);

