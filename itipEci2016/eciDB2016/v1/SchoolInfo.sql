/************************************************
Description: 
	Creates School Information table that contains
	school informaiton, which can be linked from Clients
	table.
Author: 
	Jennifer M. Graves
Date: 
	06/20/2016
Change history:

**************************************************/

CREATE TABLE SchoolInformation (
	schoolInfoID INT IDENTITY (1,1) PRIMARY KEY (schoolInfoID),
	isd int,
	)
	 