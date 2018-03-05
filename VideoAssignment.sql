CREATE TABLE [dbo].[VideoAssignment] (
    [Id]                INT             IDENTITY (1, 1) NOT NULL,
    [OrganizationId]    INT             NOT NULL,
    [PathwayId]         INT             NOT NULL,
    [PatientPersonId]   BIGINT          NOT NULL,
    [PhysicianPersonId] BIGINT          NOT NULL,
    [VideoName]         NVARCHAR (250)  NULL,
    [VideoLocation]     NVARCHAR (250)  NULL,
    [VideoAttribute]    NVARCHAR (4000) NULL,
    [CreatedOn]         DATETIME        DEFAULT (getdate()) NULL,
    [EditedOn]          DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

