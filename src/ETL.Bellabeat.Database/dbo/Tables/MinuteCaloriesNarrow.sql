CREATE TABLE [dbo].[MinuteCaloriesNarrow] (
    [Id]             BIGINT           NOT NULL,
    [ActivityMinute] DATETIME         NOT NULL,
    [Calories]       DECIMAL (18, 16) NOT NULL,
    CONSTRAINT [PK_MinuteCaloriesNarrow] PRIMARY KEY CLUSTERED ([Id] ASC, [ActivityMinute] ASC)
);

