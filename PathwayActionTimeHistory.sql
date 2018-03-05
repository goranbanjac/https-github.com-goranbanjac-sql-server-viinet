CREATE TABLE [dbo].[PathwayActionTimeHistory] (
    [PersonAssignmentId] INT             NOT NULL,
    [ActionDateTime]     DATETIME        NOT NULL,
    [IsProcessed]        BIT             NOT NULL,
    [ServiceTime]        DATETIME        NOT NULL,
    [ActivityJson]       NVARCHAR (1000) NULL,
    [TriggerTypeId]      INT             NULL
);

