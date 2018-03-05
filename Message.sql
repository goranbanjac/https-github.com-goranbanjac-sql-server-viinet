CREATE TABLE [dbo].[Message] (
    [Id]             INT             IDENTITY (1, 1) NOT NULL,
    [OrganizationId] INT             NOT NULL,
    [MessageName]    NVARCHAR (250)  NULL,
    [TitleSubject]   NVARCHAR (100)  NULL,
    [SenderEmail]    NVARCHAR (50)   NULL,
    [SenderTitle]    NVARCHAR (100)  NULL,
    [Text]           NVARCHAR (4000) NULL,
    [IsActive]       BIT             NULL,
    [CreatedOn]      DATETIME        DEFAULT (getdate()) NOT NULL,
    [EditedOn]       DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Message_OrganizationId] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_Message_OrganizationId]
    ON [dbo].[Message]([OrganizationId] ASC, [MessageName] ASC)
    INCLUDE([TitleSubject], [SenderEmail], [SenderTitle], [Text], [IsActive]);

