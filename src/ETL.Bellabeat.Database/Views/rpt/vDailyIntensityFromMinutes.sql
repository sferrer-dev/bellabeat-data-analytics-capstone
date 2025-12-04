CREATE VIEW [rpt].[vDailyIntensityFromMinutes]
AS 

WITH MinuteAgg AS (
    SELECT
        mi.Id,
        CAST(mi.ActivityMinute AS date) AS ActivityDate,
-- Indicateurs globaux sur l’intensité
        SUM(mi.Intensity)      AS SumIntensity,
        AVG(CAST(mi.Intensity AS float)) AS AvgIntensity,
        MAX(mi.Intensity)      AS MaxIntensity,

-- Comptage du nombre de minutes dans chaque zone d’intensité
        SUM(CASE WHEN mi.Intensity = 0 THEN 1 ELSE 0 END) AS MinutesSedentary_Calc,
        SUM(CASE WHEN mi.Intensity = 1 THEN 1 ELSE 0 END) AS MinutesLight_Calc,
        SUM(CASE WHEN mi.Intensity = 2 THEN 1 ELSE 0 END) AS MinutesModerate_Calc,
        SUM(CASE WHEN mi.Intensity >= 3 THEN 1 ELSE 0 END) AS MinutesVery_Calc,

-- Nombre total de minutes observées ce jour-là
        COUNT(*) AS MinutesRecorded
    FROM dbo.MinuteIntensitiesNarrow AS mi
    GROUP BY
        mi.Id,
        CAST(mi.ActivityMinute AS date)
)
SELECT
    d.Id,
    d.ActivityDate,
-- Indicateurs quotidiens issus de DailyActivity (vue “macro”)
    d.TotalSteps,
    d.TotalDistance,
    d.SedentaryMinutes,
    d.LightlyActiveMinutes,
    d.FairlyActiveMinutes,
    d.VeryActiveMinutes,
    d.Calories,

-- Indicateurs calculés à partir des données minute (vue “micro” agrégée)
    m.MinutesRecorded,
    m.SumIntensity,
    m.AvgIntensity,
    m.MaxIntensity,
    m.MinutesSedentary_Calc,
    m.MinutesLight_Calc,
    m.MinutesModerate_Calc,
    m.MinutesVery_Calc

FROM dbo.DailyActivity AS d
LEFT JOIN MinuteAgg AS m
    ON  d.Id          = m.Id
    AND d.ActivityDate = m.ActivityDate;

