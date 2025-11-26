CREATE VIEW [rpt].[vUserHourlyIntensitySummaryWithDeciles]
AS

WITH HourlyLabeled AS (
    SELECT
        Id,
        ActivityHour,
        TotalIntensity,
        AverageIntensity,

        -- Jour de la semaine (numéro + nom)
        DATEPART(WEEKDAY, ActivityHour) AS dow_number,
        DATENAME(WEEKDAY, ActivityHour) AS day_of_week,

        -- Weekday / Weekend (robuste)
        CASE
            WHEN FORMAT(ActivityHour, 'ddd', 'en-US') IN ('Sat', 'Sun')
                THEN 'Weekend'
            ELSE 'Weekday'
        END AS part_of_week,

        -- Tranche horaire (valeurs remplacées car DECLARE interdit dans une vue)
        CASE
            WHEN DATEPART(HOUR, ActivityHour) >= 6  AND DATEPART(HOUR, ActivityHour) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, ActivityHour) >= 12 AND DATEPART(HOUR, ActivityHour) < 18 THEN 'Afternoon'
            WHEN DATEPART(HOUR, ActivityHour) >= 18 AND DATEPART(HOUR, ActivityHour) < 21 THEN 'Evening'
            ELSE 'Night'
        END AS time_of_day
    FROM dbo.HourlyIntensities
),

user_dow_summary AS (
    SELECT
        Id,
        dow_number,
        day_of_week,
        part_of_week,
        time_of_day,
        SUM(TotalIntensity)   AS total_intensity,
        SUM(AverageIntensity) AS total_average_intensity,
        AVG(AverageIntensity) AS average_intensity,
        MAX(AverageIntensity) AS max_intensity,
        MIN(AverageIntensity) AS min_intensity
    FROM HourlyLabeled
    GROUP BY
        Id,
        dow_number,
        day_of_week,
        part_of_week,
        time_of_day
),

intensity_deciles AS (
    SELECT DISTINCT
        dow_number,
        day_of_week,
        part_of_week,
        time_of_day,
        CASE time_of_day
            WHEN 'Morning'   THEN 0
            WHEN 'Afternoon' THEN 1
            WHEN 'Evening'   THEN 2
            WHEN 'Night'     THEN 3
        END AS time_of_day_order,

        PERCENTILE_CONT(0.1) WITHIN GROUP (ORDER BY total_intensity)
            OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day) AS p10_total_intensity,

        PERCENTILE_CONT(0.2) WITHIN GROUP (ORDER BY total_intensity)
            OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day) AS p20_total_intensity,

        PERCENTILE_CONT(0.3) WITHIN GROUP (ORDER BY total_intensity)
            OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day) AS p30_total_intensity,

        PERCENTILE_CONT(0.4) WITHIN GROUP (ORDER BY total_intensity)
            OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day) AS p40_total_intensity,

        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_intensity)
            OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day) AS p50_total_intensity,

        PERCENTILE_CONT(0.6) WITHIN GROUP (ORDER BY total_intensity)
            OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day) AS p60_total_intensity,

        PERCENTILE_CONT(0.7) WITHIN GROUP (ORDER BY total_intensity)
            OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day) AS p70_total_intensity,

        PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY total_intensity)
            OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day) AS p80_total_intensity,

        PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY total_intensity)
            OVER (PARTITION BY dow_number, part_of_week, day_of_week, time_of_day) AS p90_total_intensity
    FROM user_dow_summary
)

SELECT
    u.Id,
    u.dow_number,
    u.day_of_week,
    u.part_of_week,
    u.time_of_day,
    u.total_intensity,
    u.total_average_intensity,
    u.average_intensity,
    u.max_intensity,
    u.min_intensity,
    d.p10_total_intensity,
    d.p20_total_intensity,
    d.p30_total_intensity,
    d.p40_total_intensity,
    d.p50_total_intensity,
    d.p60_total_intensity,
    d.p70_total_intensity,
    d.p80_total_intensity,
    d.p90_total_intensity
FROM user_dow_summary u
LEFT JOIN intensity_deciles d
    ON  u.dow_number   = d.dow_number
    AND u.day_of_week  = d.day_of_week
    AND u.part_of_week = d.part_of_week
    AND u.time_of_day  = d.time_of_day;
