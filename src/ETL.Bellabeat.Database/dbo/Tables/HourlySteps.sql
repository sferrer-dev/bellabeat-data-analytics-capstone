CREATE TABLE [dbo].[HourlySteps] (
    [Id]           BIGINT   NOT NULL,
    [ActivityHour] DATETIME NOT NULL,
    [StepTotal]    INT      NOT NULL,
    CONSTRAINT [PK_HourlySteps] PRIMARY KEY CLUSTERED ([Id] ASC, [ActivityHour] ASC)
);

