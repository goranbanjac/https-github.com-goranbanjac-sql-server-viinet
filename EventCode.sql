CREATE TABLE [dbo].[EventCode] (
    [Id]              INT            IDENTITY (1, 1) NOT NULL,
    [EventSubGroupId] INT            NULL,
    [EventName]       NVARCHAR (250) NULL,
    [EventCode]       NVARCHAR (10)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_EventCode_EventSubGroupId] FOREIGN KEY ([EventSubGroupId]) REFERENCES [dbo].[EventSubGroup] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [idx_EventCode_EventCode]
    ON [dbo].[EventCode]([EventCode] ASC);


GO
CREATE NONCLUSTERED INDEX [idx_EventCode_EventSubGroupId]
    ON [dbo].[EventCode]([EventSubGroupId] ASC)
    INCLUDE([EventName], [EventCode]);

