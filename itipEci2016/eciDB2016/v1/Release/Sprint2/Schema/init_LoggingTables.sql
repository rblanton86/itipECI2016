/***********************************************************************************************************
Description: Creates initial logging tables to hold error messages and time of error
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
CREATE TABLE ErrorLog (
	errorLog int IDENTITY (1,1) PRIMARY KEY,
	errorTime datetime,
	errorMessage varchar (50),
	errorProcedure varchar (25)
	)