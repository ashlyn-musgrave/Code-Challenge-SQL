-- The percentage of injury severity per bus line 

SELECT treated_on_scene.percent_treated_on_scene, serious_injury.percent_serious_injury, fatal_injury.percent_fatal, minor_injury.percent_minor_injury
FROM treated_on_scene
FULL OUTER JOIN serious_injury 
ON treated_on_scene.operator = serious_injury.operator
FULL OUTER JOIN fatal_injury
ON treated_on_scene.operator = fatal_injury.operator
FULL OUTER JOIN minor_injury
ON treated_on_scene.operator = minor_injury.operator

-- Updating all the NULL values to zero

SELECT * FROM InjurySeverity

UPDATE [InjurySeverity]
SET [percent_serious_injury] = 0 
WHERE [percent_serious_injury] is NULL;

UPDATE [InjurySeverity]
SET [percent_fatal] = 0 
WHERE [percent_fatal] is NULL;

SELECT ISNULL(percent_fatal, 0) FROM InjurySeverity

UPDATE [InjurySeverity]
SET [percent_minor_injury] = 0 
WHERE [percent_minor_injury] is NULL;


-- The top 5 routes with the most accidents

SELECT TOP 5 [Route], Count(*) AS total_route_incidents
FROM LondonBusSafety
WHERE [Route] is NOT NULL
GROUP BY [Route]
ORDER BY COUNT(*) DESC





