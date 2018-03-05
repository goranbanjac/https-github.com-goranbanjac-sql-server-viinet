CREATE TABLE [dbo].[PasswordPolicy] (
    [Id]                INT      IDENTITY (1, 1) NOT NULL,
    [OrganizationId]    INT      NULL,
    [MinLength]         INT      NULL,
    [MinUppercase]      TINYINT  NULL,
    [MinSymbol]         TINYINT  NULL,
    [MinNumber]         TINYINT  NULL,
    [NotPriorPasswords] TINYINT  NULL,
    [ExpireDays]        SMALLINT NULL,
    [MaxFailedLogin]    TINYINT  NULL,
    [Challanges]        TINYINT  NULL,
    [IdleMinutes]       TINYINT  NULL,
    [CreatedOn]         DATETIME CONSTRAINT [DF_PasswordPolicy_CreatedOn] DEFAULT (getdate()) NULL,
    [EditedOn]          DATETIME NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_PasswordPolicy_OrganizationId]
    ON [dbo].[PasswordPolicy]([OrganizationId] ASC)
    INCLUDE([MinLength], [MinUppercase], [MinSymbol], [MinNumber], [NotPriorPasswords], [ExpireDays], [MaxFailedLogin], [Challanges], [IdleMinutes]);

