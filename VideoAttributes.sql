CREATE TABLE [dbo].[VideoAttributes] (
    [Id]        INT             IDENTITY (1, 1) NOT NULL,
    [Fps]       DECIMAL (10, 2) NOT NULL,
    [Bitrate]   DECIMAL (10, 2) NOT NULL,
    [Size]      INT             NOT NULL,
    [Duration]  DECIMAL (10, 2) NOT NULL,
    [Width]     INT             NULL,
    [Height]    INT             NOT NULL,
    [Filename]  NVARCHAR (100)  NULL,
    [CreatedOn] DATETIME        DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idx_VideoAttributes_Filename]
    ON [dbo].[VideoAttributes]([Filename] ASC)
    INCLUDE([Fps], [Bitrate], [Size], [Duration], [Width], [Height]);

