CREATE TABLE [dbo].[EventSubGroup] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [EventGroupId]      INT            NULL,
    [EventSubGroupName] NVARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_EventSubGroup_Language] FOREIGN KEY ([EventGroupId]) REFERENCES [dbo].[EventGroup] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_EventSubGroup_EventGroupId]
    ON [dbo].[EventSubGroup]([EventGroupId] ASC)
    INCLUDE([EventSubGroupName]);

