CREATE VIEW [rpt].[vHeartrate_DailyBiologicalRhythm] 
AS
    SELECT
        hs.Id,
        CAST(hs.[Time] AS date) AS ActivityDate,

-- Time of day classification
        CASE
            WHEN DATEPART(HOUR, hs.[Time]) >= 6  AND DATEPART(HOUR, hs.[Time]) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, hs.[Time]) >= 12 AND DATEPART(HOUR, hs.[Time]) < 18 THEN 'Afternoon'
            WHEN DATEPART(HOUR, hs.[Time]) >= 18 AND DATEPART(HOUR, hs.[Time]) < 21 THEN 'Evening'
            ELSE 'Night'
        END AS TimeOfDay,

-- Day of week number (1 = Monday, ..., 7 = Sunday)
        ((DATEPART(WEEKDAY, hs.[Time]) + @@DATEFIRST - 2) % 7) + 1 AS DayOfWeekNumber,

-- Day of week name (depends on server language)
        DATENAME(WEEKDAY, hs.[Time]) AS DayOfWeekName,

-- Heart rate aggregations
        AVG(CAST(hs.[Value] AS decimal(10,2))) AS AvgHeartRate,
        MIN(hs.[Value])                        AS MinHeartRate,
        MAX(hs.[Value])                        AS MaxHeartRate,
        COUNT(*)                               AS NbSeconds
    FROM dbo.HeartrateSeconds AS hs
    GROUP BY
        hs.Id,
        CAST(hs.[Time] AS date),
        CASE
            WHEN DATEPART(HOUR, hs.[Time]) >= 6  AND DATEPART(HOUR, hs.[Time]) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, hs.[Time]) >= 12 AND DATEPART(HOUR, hs.[Time]) < 18 THEN 'Afternoon'
            WHEN DATEPART(HOUR, hs.[Time]) >= 18 AND DATEPART(HOUR, hs.[Time]) < 21 THEN 'Evening'
            ELSE 'Night'
        END,
        ((DATEPART(WEEKDAY, hs.[Time]) + @@DATEFIRST - 2) % 7) + 1,
        DATENAME(WEEKDAY, hs.[Time]);
