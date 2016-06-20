/***********************************************************************************************************
Description: 
	 Creates Client Table and information relating to the client table
Author: 
	Tyrell Powers-Crane
Date: 
	6.20.2016
Change History:
	06-20-2016 - jmg - updated scripts with if statements
************************************************************************************************************/

-- Declaring variables to hold table IDs.
DECLARE @raceID INT = 0,
	@ethnicityID INT = 0,
	@clientStatusID INT = 0

-- Checking for the existence of foreign key columns.
SELECT @raceID = columnID
FROM Sys.Columns 
WHERE objectID = (
	SELECT objectID
	FROM Sys.Tables
	WHERE name = 'Race')

SELECT @ethnicityID = columnID 
FROM Sys.Columns 
WHERE objectID = (
	SELECT objectID
	FROM Sys.Tables
	WHERE name = 'Ethnicity'
	)

SELECT @clientStatusID = columnID
FROM Sys.Columns
WHERE objectID = (
	SELECT objectID
	FROM Sys.Tables
	WHERE name = 'ClientStatus'
	)

-- Creates table if it does not already exist.
IF @raceID = 0
BEGIN
	--identifies race of patient
	CREATE TABLE Race (
		raceID INT IDENTITY (1,1),
		race VARCHAR(25),
	)
END

IF @ethnicityID = 0
BEGIN
	--identifies ethnicity of patient
	CREATE TABLE Ethnicity (
		ethnicityID INT IDENTITY (1,1),
		ethnicity VARCHAR(25),
	)
END

IF @clientStatusID = 0
BEGIN
	-- provides information regarding patient status
	CREATE TABLE ClientStatus (
		clientStatusID INT IDENTITY (1,1),
		clientStatus VARCHAR(25),
		initialDate INT,
		dismissedDate INT,
		dismissalReason VARCHAR(100),
	)
END

IF
(SELECT object_id FROM sys.tables WHERE name = 'Clients') > 0
BEGIN
	CREATE TABLE Clients ( 
		clientID INT IDENTITY (1,1) PRIMARY KEY (clientID),
		raceID INT FOREIGN KEY REFERENCES Race(raceID),
		ethnicityID INT FOREIGN KEY REFERENCES Ethnicity(ethnicityID),
		clientStatusID INT FOREIGN KEY REFERENCES ClientStatus(clientStatusID),
		firstName VARCHAR(25),
		lastName VARCHAR(25),
		dob INT,
		ssn INT,
		referralSource VARCHAR(50),
	)
END