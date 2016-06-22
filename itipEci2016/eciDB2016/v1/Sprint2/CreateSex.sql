/***********************************************************************************************************
Description: 
	Creates sex table; will hold vaules M(male), F(female) and O(other).
Author: 
	Jennifer M. Graves
Date: 
	06-22-2016
Change History:
	
************************************************************************************************************/
CREATE TABLE Sex (
	sexID INT IDENTITY (1,1) PRIMARY KEY,
	sex VARCHAR(25),
)