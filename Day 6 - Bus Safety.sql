SELECT * FROM Injury_Severity

-----------------------------------------------------------
--Today's purpose: Trying to convert nvarchar(255) to float
-----------------------------------------------------------

--First Attempt

UPDATE Injury_Severity
set percent_fatal = convert(float, percent_fatal)
where percent_fatal is not NULL;

-----------------------------------------------------------
--Second Attempt

exec sp_rename 'InjurySeverity.percentage_fatal', 'percent_fatal'

go

ALTER TABLE InjurySeverity add percentage_fatal FLOAT;

go

update InjurySeverity
SET percentage_fatal = CONVERT(float, percent_fatal)
WHERE percent_fatal is not null; 

go

alter table InjurySeverity drop column percent_fatal

------------------------------------------------------------
--Third Attempt (replace the non numeric values to Null and then try to alter the type)

UPDATE Injury_Severity SET percent_fatal = case ISNUMERIC(percent_fatal) when 1 then percent_fatal else null end
ALTER TABLE Injury_Severity ALTER COLUMN percent_fatal FLOAT

-- IT WORKED!!

-- Below I'm going to re-update the new table

SELECT * FROM Injury_Severity

UPDATE [Injury_Severity]
SET [percent_serious_injury] = 0 
WHERE [percent_serious_injury] is NULL;

UPDATE [Injury_Severity]
SET [percent_fatal] = 0 
WHERE [percent_fatal] is NULL;

UPDATE [Injury_Severity]
SET [percent_minor_injury] = 0 
WHERE [percent_minor_injury] is NULL;

SELECT * FROM Injury_Severity



