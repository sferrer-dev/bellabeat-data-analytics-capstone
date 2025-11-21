CREATE TABLE [dbo].[WeightLogInfo] (
    [WeightLogInfoId] BIGINT           IDENTITY (1, 1) NOT NULL,
    [Id]              BIGINT           NOT NULL,
    [Date]            DATETIME         NOT NULL,
    [WeightKg]        DECIMAL (19, 16) NOT NULL,
    [WeightPounds]    DECIMAL (19, 16) NOT NULL,
    [Fat]             INT              NULL,
    [BMI]             DECIMAL (18, 16) NOT NULL,
    [IsManualReport]  BIT              NOT NULL,
    [LogId]           BIGINT           NOT NULL,
    CONSTRAINT [PK_WeightLogInfo] PRIMARY KEY CLUSTERED ([WeightLogInfoId] ASC)
);

