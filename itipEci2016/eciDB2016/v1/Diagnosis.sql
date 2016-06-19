--Main Table: Holds the diagnosis icd-10 code
CREATE TABLE Diagnosis (
	diagnosisID INT IDENTITY (1,1) PRIMARY KEY (diagnosisID),
	diagnosisTypeID INT FOREIGN KEY REFERENCES DiagnosisType(diagnosisTypeID),
	icd_10_Code VARCHAR(15), 
	)
--Type Table: Provides description of diagnosis (i.e. Primary)
CREATE TABLE DiagnosisType (
	diagnosisTypeID INT IDENTITY (1,1) PRIMARY KEY (diagnosisTYPEID),
	isPrimary BIT,
	diagnosisType VARCHAR(25)
	)