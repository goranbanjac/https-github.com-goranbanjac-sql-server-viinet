CREATE TABLE [dbo].[PersonPathwayDevice] (
    [PersonAssignmentId]  INT             NOT NULL,
    [PersonId]            BIGINT          NULL,
    [DeviceActivitiesMap] NVARCHAR (4000) NULL,
    [CreatedOn]           DATETIME        NULL,
    [EditedOn]            DATETIME        NULL,
    PRIMARY KEY NONCLUSTERED ([PersonAssignmentId] ASC)
);


GO
CREATE CLUSTERED INDEX [idx_PersonPathwayDevice_PersonId]
    ON [dbo].[PersonPathwayDevice]([PersonId] ASC);

