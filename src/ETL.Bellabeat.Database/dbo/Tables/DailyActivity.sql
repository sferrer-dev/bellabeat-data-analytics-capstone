CREATE TABLE [dbo].[DailyActivity] (
    [Id]                       BIGINT          NOT NULL,
    [ActivityDate]             DATE            NOT NULL,
    [TotalSteps]               INT             NOT NULL,
    [TotalDistance]            DECIMAL (12, 6) NOT NULL,
    [TrackerDistance]          DECIMAL (12, 6) NOT NULL,
    [LoggedActivitiesDistance] DECIMAL (12, 6) NOT NULL,
    [VeryActiveDistance]       DECIMAL (12, 6) NOT NULL,
    [ModeratelyActiveDistance] DECIMAL (12, 6) NOT NULL,
    [LightActiveDistance]      DECIMAL (12, 6) NOT NULL,
    [SedentaryActiveDistance]  DECIMAL (12, 6) NOT NULL,
    [VeryActiveMinutes]        INT             NOT NULL,
    [FairlyActiveMinutes]      INT             NOT NULL,
    [LightlyActiveMinutes]     INT             NOT NULL,
    [SedentaryMinutes]         INT             NOT NULL,
    [Calories]                 INT             NOT NULL,
    CONSTRAINT [PK_DailyActivity] PRIMARY KEY CLUSTERED ([Id] ASC, [ActivityDate] ASC)
);

