CREATE TABLE [dbo].[MinuteMETsNarrow] (
    [Id]             BIGINT   NOT NULL,
    [ActivityMinute] DATETIME NOT NULL,
    [METs]           INT      NOT NULL,
    CONSTRAINT [PK_MinuteMETsNarrow] PRIMARY KEY CLUSTERED ([Id] ASC, [ActivityMinute] ASC)
);

