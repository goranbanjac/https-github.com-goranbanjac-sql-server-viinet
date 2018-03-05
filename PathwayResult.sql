CREATE TABLE [dbo].[PathwayResult] (
    [Id]                  INT            IDENTITY (1, 1) NOT NULL,
    [Organizationid]      INT            NOT NULL,
    [PersonId]            BIGINT         NULL,
    [Gender]              NVARCHAR (5)   NULL,
    [DOB]                 DATETIME       NULL,
    [PathwayId]           INT            NOT NULL,
    [PathwayName]         NVARCHAR (255) NULL,
    [ActivityId]          INT            NOT NULL,
    [ActivityName]        NVARCHAR (255) NULL,
    [OrderSetId]          INT            NOT NULL,
    [OrderSetName]        NVARCHAR (255) NULL,
    [OrderId]             INT            NOT NULL,
    [OrderName]           NVARCHAR (255) NULL,
    [AnswerOptionGroupId] INT            NOT NULL,
    [AnswerVersionGroup]  NVARCHAR (100) NULL,
    [VersionChoicesName]  NVARCHAR (250) NULL,
    [Score]               INT            NULL,
    [CreatedOn]           DATETIME       DEFAULT (getdate()) NULL,
    [PathwaySpecialty]    NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

