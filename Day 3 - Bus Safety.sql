SELECT * FROM LondonBusSafety

SELECT TOP 5 [Incident Event Type], COUNT(*) as total_number
FROM LondonBusSafety
GROUP BY [Incident Event Type]
ORDER BY [Incident Event Type]

CREATE VIEW test1 AS
SELECT TOP 5 [Victim Category], COUNT(*) as total_victims
FROM LondonBusSafety
GROUP BY [Victim Category]


SELECT [Member of Public], [Conductor], [Operations staff (other)], [3rd Party driver / Occupant], [Operational Staff]
FROM (
	SELECT [Victim Category], [total_victims] FROM test1
) AS SourceTable
PIVOT (
	MAX(total_victims)
	FOR [Victim Category] IN  ([Member of Public], [Conductor], [Operations staff (other)], [3rd Party driver / Occupant], [Operational Staff])
) AS PivotTable


----------------------------------------------------------------------------------------------

CREATE VIEW test2 AS
SELECT [Incident Event Type], [Victim Category], COUNT(*) as total_number
FROM LondonBusSafety
GROUP BY [Incident Event Type], [Victim Category]

SELECT * FROM test2


SELECT [3rd Party driver / Occupant], [Bus Driver], [Conductor], [Contractor Staff], [Cyclist], [Insufficient Data], [Member of Public], [Motorcyclist], [Non-Operational Staff], [Operational Staff], [Operations Staff (other)], [Other], [Passenger], [Pedestrian], [TfL Staff]
FROM (
	SELECT [Incident Event Type], [Victim Category], [total_number] FROM test2
) AS SourceTable
PIVOT (
	MAX(total_number)
	FOR [Victim Category] IN ([3rd Party driver / Occupant], [Bus Driver], [Conductor], [Contractor Staff], [Cyclist], [Insufficient Data], [Member of Public], [Motorcyclist], [Non-Operational Staff], [Operational Staff], [Operations Staff (other)], [Other], [Passenger], [Pedestrian], [TfL Staff])
) AS PivotTable
