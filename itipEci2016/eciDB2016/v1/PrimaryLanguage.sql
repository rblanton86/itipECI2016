/************************************************
Description: 
	Creates main language table which holds information
	regarding client or family spoken language.
Author: 
	Jennifer M. Graves
Date: 
	06/20/2016
Change history:

**************************************************/

CREATE TABLE PrimaryLanguage (
	primaryLanguageID INT IDENTITY (1,1) PRIMARY KEY (primaryLanguageID),
	primaryLanguage VARCHAR(20),
	)