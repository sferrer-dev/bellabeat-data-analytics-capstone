CREATE VIEW [rpt].[vDailyActivity_Insights]
	AS

SELECT
    Id,
    ActivityDate,
-- Activité — mesures principales
    TotalSteps,
    TotalDistance,
    VeryActiveMinutes,
    FairlyActiveMinutes,
    LightlyActiveMinutes,
    SedentaryMinutes,
-- Activité combinée (utile pour des graphiques)
    VeryActiveMinutes 
        + FairlyActiveMinutes 
        + LightlyActiveMinutes AS TotalActiveMinutes,
-- Calories
    Calories,
-- Jour de la semaine
    DATENAME(WEEKDAY, ActivityDate) AS DayOfWeek,
    DATEPART(WEEKDAY, ActivityDate) AS DayOfWeekNumber,
-- Semaine vs week-end
    CASE 
        -- Weekday / Weekend (robuste)
        WHEN FORMAT(ActivityDate, 'ddd', 'en-US') IN ('Sat', 'Sun')
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS PartOfWeek
FROM dbo.DailyActivity;
