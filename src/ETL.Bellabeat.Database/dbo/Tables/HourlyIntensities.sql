CREATE TABLE [dbo].[HourlyIntensities] (
    [Id]               BIGINT          NOT NULL,
    [ActivityHour]     DATETIME        NOT NULL,
    [TotalIntensity]   INT             NULL,
    [AverageIntensity] NUMERIC (10, 6) NULL,
    CONSTRAINT [PK_HourlyIntensities] PRIMARY KEY CLUSTERED ([Id] ASC, [ActivityHour] ASC)
);

