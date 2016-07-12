/****************************************************************************
Description: Alter Diagnosis table.

Author: Jennifer M Graves

Date: 06-23-2016

Change History:
	06-23-2016 -- jmg -- Drops icd9Code and icd10Code and adds the following columns:
			diagnosisType VARCHAR(15),
			diagnosisCode VARCHAR(15),
			diagnosis VARCHAR(100),
	06-30-2016 -- jmg -- Added diagnosisFrom and diagnosisTo columns, which were missing.
			Corrected if statement
	07-05-2016 -- jmg: Added deleted bit column to table.
	07-12-2016 -- JMG: restructured Table to include references to new DiagnosisType and DiagnosisCode tables.
****************************************************************************/

-- Declares the table variable for Diagnosis
DECLARE @dx INT = 0

-- Assigns the system table ID to @dx variable for later use.
SELECT @dx = (
	SELECT OBJECT_ID
	FROM sys.tables
	WHERE name = 'Diagnosis'
)

SELECT @dx

-- Checks if table exists.
IF ISNULL(@dx, 0) = 0
	BEGIN
		--Creates Diagnosis table if it doesn't exist.
		CREATE TABLE Diagnosis (
			diagnosisID INT IDENTITY(1,1) PRIMARY KEY(DiagnosisID),
			clientID INT CONSTRAINT FK_diagnosis_client FOREIGN KEY REFERENCES Client(clientID),
			diagnosisCodeID INT CONSTRAINT FK_diagnosis_diagnosisCode FOREIGN KEY REFERENCES DiagnosisCode(diagnosisCodeID),
			diagnosisTypeID INT CONSTRAINT FK_diagnosis_diagnosisType FOREIGN KEY REFERENCES DiagnosisType(diagnosisTypeID),
			isPrimary BIT,
			diagnosis_From DATE,
			diagnosis_To DATE,
			deleted BIT
		)

		PRINT 'Added Diagnosis table to database.'
	END
ELSE
	BEGIN
		-- Checks if deleted column exists.
		IF EXISTS (SELECT * FROM sys.columns WHERE @dx = OBJECT_ID AND name = 'deleted')
			BEGIN
				-- Advises DBA no column added, as already exists.
				PRINT 'Unneeded: deleted column exists.'
			END
		ELSE
			BEGIN
				-- Creates column, advises DBA.
				ALTER TABLE Diagnosis
					ADD deleted BIT
				PRINT 'Added deleted column on Diagnosis table.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'diagnosisType')
			BEGIN
				ALTER TABLE Diagnosis
					DROP COLUMN diagnosisType

				PRINT 'Dropped DiagnosisType column'
			END
		ELSE
			BEGIN
				PRINT 'Did not drop DiagnosisType column: does not exist.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'diagnosisCode')
			BEGIN
				ALTER TABLE Diagnosis
					DROP COLUMN diagnosisCode

				PRINT 'Dropped DiagnosisCode column'
			END
		ELSE
			BEGIN
				PRINT 'Did not drop DiagnosisCode column: does not exist.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'diagnosis')
			BEGIN
				ALTER TABLE Diagnosis
					DROP COLUMN diagnosis

				PRINT 'Dropped Diagnosis column'
			END
		ELSE
			BEGIN
				PRINT 'Did not drop Diagnosis column: does not exist.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'diagnosis_From')
			BEGIN
				PRINT 'diagnosis_From Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD diagnosis_From DATE
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'diagnosisFrom')
			BEGIN
				ALTER TABLE Diagnosis
					DROP COLUMN diagnosisFrom
			END
		ELSE
			BEGIN
				
				PRINT 'Dropped diagnosisFrom column.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'diagnosis_To')
			BEGIN
				PRINT 'diagnosis_To Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD diagnosis_To DATE
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'diagnosisTo')
			BEGIN
				ALTER TABLE Diagnosis
					DROP COLUMN diagnosisTo
			END
		ELSE
			BEGIN
				
				PRINT 'Dropped diagnosisTo column.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'icd10Code')
			BEGIN
				ALTER TABLE Diagnosis
					DROP COLUMN icd10Code
			END
		ELSE
			BEGIN
				PRINT 'icd10Code Column does not exist.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'icd9Code')
			BEGIN
				ALTER TABLE Diagnosis
					DROP COLUMN icd9Code
			END
		ELSE
			BEGIN
				PRINT 'icd9Code Column does not exist.'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'diagnosisCodeID')
			BEGIN
				PRINT 'Did not add diagnosisCodeID column: already exists'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD diagnosisCodeID INT CONSTRAINT FK_diagnosis_diagnosisCode FOREIGN KEY REFERENCES DiagnosisCode(diagnosisCodeID)
				PRINT 'Added diagnosisCodeID foreign key column on Diagnosis table'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'diagnosisTypeID')
			BEGIN
				PRINT 'Did not add diagnosisTypeID column: already exists'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD diagnosisTypeID INT CONSTRAINT FK_diagnosis_diagnosisType FOREIGN KEY REFERENCES DiagnosisType(diagnosisTypeID)
				PRINT 'Added diagnosisTypeID foreign key column on Diagnosis table'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'clientID')
			BEGIN
				PRINT 'Did not add clientID column: already exists'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD clientID INT CONSTRAINT FK_diagnosis_client FOREIGN KEY REFERENCES Clients(clientID)
				PRINT 'Added clientID foreign key column on Diagnosis table'
			END

		IF EXISTS (SELECT * FROM sys.columns WHERE OBJECT_ID = @dx AND name = 'isPrimary')
			BEGIN
				PRINT 'isPrimary Column exists.'
			END
		ELSE
			BEGIN
				ALTER TABLE Diagnosis
					ADD isPrimary BIT
			END

	END