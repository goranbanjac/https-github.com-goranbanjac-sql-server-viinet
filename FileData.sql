﻿CREATE TABLE [dbo].[FileData] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [FileName]         NVARCHAR (100) NULL,
    [Location]         NVARCHAR (100) NULL,
    [MimeType]         NVARCHAR (100) NULL,
    [Details]          NVARCHAR (100) NULL,
    [CreatedOn]        DATETIME       DEFAULT (getdate()) NULL,
    [LocationCheckSum] INT            NOT NULL,
    [EditedOn]         DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_FileData_LocationCheckSum]
    ON [dbo].[FileData]([LocationCheckSum] ASC);

