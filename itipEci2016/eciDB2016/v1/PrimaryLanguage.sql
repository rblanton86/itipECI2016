--Main Table: Holds information regarding spoken language
CREATE TABLE PrimaryLanguage (
	primaryLanguageID INT IDENTITY (1,1) PRIMARY KEY (primaryLanguageID),
	primaryLanguage VARCHAR(20),
	)