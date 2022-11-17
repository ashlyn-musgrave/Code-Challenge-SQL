-- What are the top 5 safest boroughs? Which are the most dangerous? 

CREATE VIEW top_dangerous_boroughs AS
SELECT TOP 5 Borough, COUNT(*) as dangerous_boroughs
FROM LondonBusSafety
GROUP BY Borough
ORDER BY COUNT(*) DESC

CREATE VIEW top_safest_boroughs AS
SELECT TOP 5 Borough, COUNT(*) as safest_boroughs
FROM LondonBusSafety
GROUP BY Borough
ORDER BY COUNT(*) ASC

SELECT * FROM top_dangerous_boroughs
FULL OUTER JOIN top_safest_boroughs
ON top_dangerous_boroughs.Borough = top_safest_boroughs.Borough

SELECT Borough, dangerous_boroughs FROM top_dangerous_boroughs
UNION
SELECT Borough, safest_boroughs FROM top_safest_boroughs

----------------------------------------------------------------------------------------------

SELECT * FROM LondonBusSafety

-- Below is the total number of different incident events

SELECT [Incident Event Type], [Victim Category], COUNT(*) as total_number
FROM LondonBusSafety
GROUP BY [Incident Event Type], [Victim Category]
ORDER BY [Victim Category]

CREATE VIEW victim_injuries_total  AS
SELECT [Incident Event Type], [Victim Category], COUNT(*) as total_number
FROM LondonBusSafety
GROUP BY [Incident Event Type], [Victim Category]
	
SELECT [Victim Category], COUNT(*) as onboard_injuries 
FROM LondonBusSafety 
WHERE [Incident Event Type] LIKE 'Onboard%'
GROUP BY [Victim Category]

SELECT [Victim Category], COUNT(*) as assault_injuries 
FROM LondonBusSafety 
WHERE [Incident Event Type] = 'Assault'
GROUP BY [Victim Category]


SELECT * FROM victim_injuries_total


SELECT [Victim Category], [Incident Event Type]
FROM victim_injuries_total
PIVOT
(
	MAX(total_number)
	FOR [Incident Event Type] in ([3rd Party driver / Occupant], [Bus Driver], Conductor, [Contractor Staff])
)
	AS did_this_just_work




