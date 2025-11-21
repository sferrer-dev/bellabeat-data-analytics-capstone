CREATE TABLE [dbo].[MinuteStepsNarrow] (
    [Id]             BIGINT   NOT NULL,
    [ActivityMinute] DATETIME NOT NULL,
    [Steps]          INT      NOT NULL,
    CONSTRAINT [PK_MinuteStepsNarrow] PRIMARY KEY CLUSTERED ([Id] ASC, [ActivityMinute] ASC)
);

