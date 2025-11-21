CREATE TABLE [dbo].[HeartrateSeconds] (
    [Id]    BIGINT   NOT NULL,
    [Time]  DATETIME NOT NULL,
    [Value] INT      NOT NULL,
    CONSTRAINT [PK_heartrate_seconds] PRIMARY KEY CLUSTERED ([Id] ASC, [Time] ASC)
);

