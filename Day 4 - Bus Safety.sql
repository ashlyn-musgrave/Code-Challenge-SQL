CREATE VIEW test2 AS
SELECT [Incident Event Type], [Victim Category], COUNT(*) as total_number
FROM LondonBusSafety
GROUP BY [Incident Event Type], [Victim Category]

SELECT * FROM test2

CREATE VIEW injury_vs_victim AS
SELECT [Incident Event Type] AS 'Incident_Event_Type',
[3rd Party driver / Occupant], [Bus Driver], [Conductor], [Contractor Staff], [Cyclist], [Insufficient Data], [Member of Public], [Motorcyclist], [Non-Operational Staff], [Operational Staff], [Operations Staff (other)], [Other], [Passenger], [Pedestrian], [TfL Staff]
FROM (
	SELECT [Incident Event Type], [Victim Category], [total_number] FROM test2
) AS SourceTable
PIVOT (
	MAX(total_number)
	FOR [Victim Category] IN ([3rd Party driver / Occupant], [Bus Driver], [Conductor], [Contractor Staff], [Cyclist], [Insufficient Data], [Member of Public], [Motorcyclist], [Non-Operational Staff], [Operational Staff], [Operations Staff (other)], [Other], [Passenger], [Pedestrian], [TfL Staff])
) AS PivotTable

-- Attempt to replace all NULL values with 0 (failed on account that you're trying to update a VIEW)

UPDATE [injury_vs_victim]
SET [3rd Party driver / Occupant], [Bus Driver], [Conductor], [Contractor Staff], [Cyclist], [Insufficient Data], [Member of Public], [Motorcyclist], [Non-Operational Staff], [Operational Staff], [Operations Staff (other)], [Other], [Passenger], [Pedestrian], [TfL Staff] = 0
WHERE [3rd Party driver / Occupant], [Bus Driver], [Conductor], [Contractor Staff], [Cyclist], [Insufficient Data], [Member of Public], [Motorcyclist], [Non-Operational Staff], [Operational Staff], [Operations Staff (other)], [Other], [Passenger], [Pedestrian], [TfL Staff] IS NULL;

UPDATE [injury_vs_victim]
SET [Bus Driver] = 0
WHERE [Bus Driver] IS NULL;

----------------------------------------------------------------------------------------------------------------------
-- Now that I've learned how to PIVOT, I'm going to go back and make the percent injured per operator cleaner.
-- Basically what this says is... Out of all the fatal injuries per bus line, 2.38% were because of Abellio London

SELECT * FROM percent_injured_per_operator

-- Using the severity of injury VIEWS I created on Day 1, I'm going to try and OUTER JOIN them together to give me all the data points

SELECT * FROM treated_on_scene
FULL OUTER JOIN serious_injury 
ON treated_on_scene.operator = serious_injury.operator
FULL OUTER JOIN fatal_injury
ON treated_on_scene.operator = fatal_injury.operator
FULL OUTER JOIN minor_injury
ON treated_on_scene.operator = minor_injury.operator

-- This at least gives me the data I'm looking for, but I want it to look cleaner, I don't want all of the operator columns 

SELECT * FROM treated_on_scene
RIGHT OUTER JOIN serious_injury
ON treated_on_scene.operator = serious_injury.operator 
