/***********************************************************************************************************
Description: Creates the Time Header Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.05.2016
Change History:
	
************************************************************************************************************/

CREATE TABLE TimeHeader (
	timeHeaderID int IDENTITY (1,1) PRIMARY KEY,
	staffID int FOREIGN KEY REFERENCES Staff(staffID),
	weekEnding Date,
	deleted bit
	)


