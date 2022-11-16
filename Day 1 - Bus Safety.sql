 SELECT * FROM LondonBusSafety

 
 --The top 5 Bus Lines with the most incidents in London

 SELECT top 5 operator, COUNT(*) as Incidents
 FROM LondonBusSafety
 GROUP BY operator
 ORDER BY COUNT(*) DESC


 --The top 5 most dangerous boroughs

 SELECT top 5 borough, COUNT(*) as Borough_Incidents
 FROM LondonBusSafety
 GROUP BY Borough
 ORDER BY COUNT(*) DESC

 
 -- Total number of injury severities 

 SELECT [Injury Result Description], COUNT(*) as TotalInjuries
 FROM LondonBusSafety
 GROUP BY [Injury Result Description]
 ORDER BY COUNT(*) DESC



  -- Total number of 'fatal injuries' by all operators 

 SELECT [Injury Result Description], COUNT(*)
 FROM LondonBusSafety
 WHERE [Injury Result Description] = 'fatal'
 GROUP BY [Injury Result Description]

 -- Total number of 'injuries treated on scene' by all operators 

 SELECT [Injury Result Description], COUNT(*)
 FROM LondonBusSafety
 WHERE [Injury Result Description] = 'Injuries treated on scene'
 GROUP BY [Injury Result Description]


 -- Total number of 'fatal injuries' by each operator

 SELECT operator, COUNT(*) as FatalIncidents
 FROM LondonBusSafety
 WHERE [Injury Result Description] = 'fatal'
 GROUP BY operator
 ORDER BY COUNT(*) DESC

 -- Total number of 'Injuries treated on scene' by each operator

 SELECT operator, COUNT(*)
 FROM LondonBusSafety
 WHERE [Injury Result Description] = 'Injuries treated on scene'
 GROUP BY operator
 ORDER BY COUNT(*) DESC



 -- The percentage of injuries that were 'treated on scene' by each bus line

 SELECT operator, CAST(((COUNT(*)/17336.0)*100) AS DECIMAL (10,2)) as percent_treated_on_scene
 FROM LondonBusSafety
 WHERE [Injury Result Description] = 'Injuries treated on scene'
 GROUP BY operator
 ORDER BY COUNT(*) DESC

 CREATE VIEW treated_on_scene AS
 SELECT operator, CAST(((COUNT(*)/17336.0)*100) AS DECIMAL (10,2)) as percent_treated_on_scene
 FROM LondonBusSafety
 WHERE [Injury Result Description] = 'Injuries treated on scene'
 GROUP BY operator

 SELECT * FROM treated_on_scene

 -- The percentage of injuries that were 'Taken to Hospital - Reported Serious Injury) by each bus line

 SELECT operator, CAST(((COUNT(*)/17336.0)*100) AS DECIMAL (10,2)) as percent_serious_injury
 FROM LondonBusSafety
 WHERE [Injury Result Description] LIKE 'Taken%'
 GROUP BY operator
 ORDER BY COUNT(*) DESC

 CREATE VIEW serious_injury AS
 SELECT operator, CAST(((COUNT(*)/17336.0)*100) AS DECIMAL (10,2)) as percent_serious_injury
 FROM LondonBusSafety
 WHERE [Injury Result Description] LIKE 'Taken%'
 GROUP BY operator

 SELECT * FROM serious_injury
 
  -- The percentage of injuries that were 'Fatal' by each bus line

 SELECT operator, CAST(((COUNT(*)/42.0)*100) AS DECIMAL (10,2)) as percent_fatal
 FROM LondonBusSafety
 WHERE [Injury Result Description] = 'fatal'
 GROUP BY operator
 ORDER BY COUNT(*) DESC

 CREATE VIEW fatal_injury AS
 SELECT operator, CAST(((COUNT(*)/42.0)*100) AS DECIMAL (10,2)) as percent_fatal
 FROM LondonBusSafety
 WHERE [Injury Result Description] = 'fatal'
 GROUP BY operator

 SELECT * FROM fatal_injury

  -- The percentage of injuries that were 'Reported as minor' by each bus line

 SELECT operator, CAST(((COUNT(*)/2786.0)*100) AS DECIMAL (10,2)) as percent_minor_injury
 FROM LondonBusSafety
 WHERE [Injury Result Description] LIKE 'Reported Minor%'
 GROUP BY operator
 ORDER BY COUNT(*) DESC

 CREATE VIEW minor_injury AS
 SELECT operator, CAST(((COUNT(*)/2786.0)*100) AS DECIMAL (10,2)) as percent_minor_injury
 FROM LondonBusSafety
 WHERE [Injury Result Description] LIKE 'Reported Minor%'
 GROUP BY operator

 SELECT * FROM minor_injury

 --------------------------------------------------------------------------------------------------

 -- Inner joining all tables (this will include 4 duplicate 'operator' columns)

 SELECT * FROM fatal_injury
 INNER JOIN minor_injury
 ON fatal_injury.operator = minor_injury.operator
 INNER JOIN treated_on_scene
 ON fatal_injury.operator = treated_on_scene.operator 
 INNER JOIN serious_injury
 ON fatal_injury.operator = serious_injury.operator

 -- Joining all tables without the duplicate 'operator' column 

 CREATE VIEW T1 AS
 SELECT treated_on_scene.operator, treated_on_scene.percent_treated_on_scene, serious_injury.percent_serious_injury
 FROM treated_on_scene
 JOIN serious_injury
 ON treated_on_scene.operator = serious_injury.operator

 CREATE VIEW T2 AS
 SELECT minor_injury.operator, minor_injury.percent_minor_injury, fatal_injury.percent_fatal
 FROM minor_injury
 JOIN fatal_injury
 ON minor_injury.operator = fatal_injury.operator 

 CREATE VIEW percent_injured_per_operator AS
 SELECT T1.operator, T1.percent_treated_on_scene, T1.percent_serious_injury, T2.percent_fatal, T2.percent_minor_injury
 FROM T1
 JOIN T2
 ON T1.operator = T2.operator

 SELECT * FROM percent_injured_per_operator

 -----------------------------------------------------------------------------------------------------------------



 







 