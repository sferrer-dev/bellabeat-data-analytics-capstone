CREATE TABLE [dbo].[MinuteIntensitiesNarrow] (
    [Id]             BIGINT   NOT NULL,
    [ActivityMinute] DATETIME NOT NULL,
    [Intensity]      INT      NOT NULL,
    CONSTRAINT [PK_MinuteIntensitiesNarrow] PRIMARY KEY CLUSTERED ([Id] ASC, [ActivityMinute] ASC)
);

