CREATE TABLE [dbo].[MinuteSleep] (
    [Id]    BIGINT   NOT NULL,
    [Date]  DATETIME NOT NULL,
    [LogId] BIGINT   NOT NULL, 
    [Value] INT      NOT NULL
    CONSTRAINT [PK_MinuteSleep] PRIMARY KEY ([Id], [Date])
);

