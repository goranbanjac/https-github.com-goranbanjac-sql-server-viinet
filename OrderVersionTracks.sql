CREATE TABLE [dbo].[OrderVersionTracks] (
    [Id]                BIGINT          IDENTITY (1, 1) NOT NULL,
    [PathwayVersionId]  INT             NULL,
    [OrderVersionId]    INT             NOT NULL,
    [ConditionOrderIds] NVARCHAR (1000) NULL,
    [Expression]        NVARCHAR (1000) NULL,
    [TrackItem]         NVARCHAR (4000) NULL,
    [CreatedOn]         DATETIME        CONSTRAINT [DF_OrderVerzionTracks_CreatedOn] DEFAULT (getdate()) NULL,
    [EditedOn]          DATETIME        NULL,
    [Actions]           NVARCHAR (4000) NULL,
    PRIMARY KEY NONCLUSTERED ([Id] ASC)
);


GO
CREATE CLUSTERED INDEX [cl_idx_OrderVerzionTracks_OrderVersionId]
    ON [dbo].[OrderVersionTracks]([PathwayVersionId] ASC, [OrderVersionId] ASC);

