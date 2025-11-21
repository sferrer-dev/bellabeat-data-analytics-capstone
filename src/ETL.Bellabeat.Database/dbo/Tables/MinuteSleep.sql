CREATE TABLE [dbo].[MinuteSleep] (
    [Id]    BIGINT   NOT NULL,
    [Date]  DATETIME NOT NULL,
    [Value] INT      NOT NULL,
    [LogId] BIGINT   NOT NULL,
    CONSTRAINT [PK_MinuteSleep] PRIMARY KEY CLUSTERED ([Id] ASC, [Date] ASC, [LogId] ASC)
);

