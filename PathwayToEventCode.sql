CREATE TABLE [dbo].[PathwayToEventCode] (
    [Id]             INT           IDENTITY (1, 1) NOT NULL,
    [OrganizationId] INT           NULL,
    [PathwayId]      INT           NULL,
    [EventCode]      NVARCHAR (50) NULL,
    [CreatedOn]      DATETIME      CONSTRAINT [DF_PathwayToEventCode_CreatedOn] DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_PathwayToEventCode_EventCode]
    ON [dbo].[PathwayToEventCode]([EventCode] ASC)
    INCLUDE([PathwayId]);


GO
CREATE NONCLUSTERED INDEX [idx_PathwayToEventCode_OrganizationId]
    ON [dbo].[PathwayToEventCode]([OrganizationId] ASC, [PathwayId] ASC)
    INCLUDE([EventCode]);

